/// Token-2022 confidential transfers on Solana devnet (needs BU_NATIVE_LIB for ZK proofs).
library;

import 'dart:io';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/solana.dart';

import 'service_example/service_example.dart';

/// Devnet RPC endpoint.
const String rpcUrl = 'https://api.devnet.solana.com';

/// ZK ElGamal proof program (verifies all proofs on-chain).
const zkProofProgram = SolAddress.unchecked(
  'ZkE1Gama1Proof11111111111111111111111111111',
);

/// Token-2022 account sizes with the confidential extension.
///
/// TLV data for *both* mints and token accounts starts after
/// `Account::LEN` (165) + 1 account-type byte = 166, then 2-byte type +
/// 2-byte length per extension entry (see `type_and_tlv_indices` in
/// spl-token-2022-interface).
/// Mint: 166 + 4 + 65 (`ConfidentialTransferMint` = 32 + 1 + 32).
/// Token account: 166 + 4 + 295 (`ConfidentialTransferAccount`).
const int mintSpace = 235; // 166 + TLV header + 65-byte mint extension.
const int tokenAccountSpace = 465; // 166 + TLV header + 295-byte state.

const int mintDecimals = 6;

/// Proof-instruction discriminants (on-chain `ProofInstruction` enum order).
const int _discEq = 3; // VerifyCiphertextCommitmentEquality.
const int _discPubkeyValidity = 4; // VerifyPubkeyValidity.
const int _discRangeU64 = 6; // VerifyBatchedRangeProofU64.
const int _discRangeU128 = 7; // VerifyBatchedRangeProofU128.
const int _discBatchedValidity3 = 12; // VerifyBatchedGroupedCiphertext3Handles.

final SolanaQuickClient quick = DefaultSolanaQuickClient(
  provider: solanaRPC(rpcUrl),
);

SolanaPrivateKey demoSecretKey(int seedByte) =>
    SolanaPrivateKey.fromBytes(List<int>.filled(32, seedByte));

SolanaPrivateKey get faucetKey => demoSecretKey(12);
SolAddress get faucet => faucetKey.publicKey().toAddress();

SolanaPrivateKey get aliceKey => demoSecretKey(23);
SolAddress get alice => aliceKey.publicKey().toAddress();

/// v1 config for proof-heavy transactions (SIMD-0385, up to 4096 bytes).
/// Inline withdraw/transfer proofs exceed the 1232-byte legacy cap, so those
/// steps go out as v1. The 1.4M compute-unit cap covers Bulletproof/range
/// verification; the 64MiB loaded-accounts cap matches the legacy default
/// (the Token-2022 + ZK proof program binaries count toward it).
/// Offsets are unaffected (proofs stay adjacent to the Token-2022 ix).
const proofV1Config = TransactionV1Config(
  computeUnitLimit: 1400000,
  loadedAccountsDataSizeLimit: 64 * 1024 * 1024,
);

Future<void> ensureFunded(SolAddress address, {BigInt? minLamports}) async {
  final target = minLamports ?? SolanaUtils.toLamports('0.02');
  if (address == faucet) return;
  final balance = await quick.getAccountBalance(address);
  if (balance >= target) return;
  final deficit = target - balance;
  print('  [fund] sending $deficit lamports to ${address.address}');
  await quick.buildSignAndSendConfidential(
    feePayer: faucet,
    signers: [faucetKey],
    instructions: [
      SystemProgram.transfer(
        from: faucet,
        layout: SystemTransferLayout(lamports: deficit),
        to: address,
      ),
    ],
  );
}

/// Inline ZK proof instruction (proof bytes in data, no accounts).
TransactionInstruction zkProofIx(int discriminant, List<int> payload) {
  return TransactionInstruction(
    keys: const [],
    programId: zkProofProgram,
    data: [discriminant, ...payload],
  );
}

List<int> randomBytes(int n) => QuickCrypto.generateRandom(length: n);

/// Generate a fresh ElGamal secret, masked to 248 bits so it is always below
/// the curve order L (raw 32 random bytes would exceed L ~94% of the time
/// and be rejected by `Scalar::from_bytes_le`). Retries on the negligible
/// chance of sampling zero.
List<int> freshElGamalSecret(NativeSolanaZkApi zk) {
  for (var i = 0; i < 10; i++) {
    final secret = randomBytes(32);
    // Scalars are little-endian: clear the top 4 bits of the last byte so
    // the value is < 2^248 < L, hence always accepted.
    secret[31] &= 0x0f;
    if (secret.every((b) => b == 0)) continue;
    try {
      zk.pubkeyFromSecret(secret);
      return secret;
    } catch (_) {
      continue;
    }
  }
  throw StateError('could not sample an ElGamal secret');
}

Future<ConfidentialTransferAccount> readState(SolAddress token) async {
  final state = await quick.getConfidentialTransferState(token);
  if (state == null) throw StateError('account not found: ${token.address}');
  return state;
}

Future<void> main() async {
  final libPath = Platform.environment['BU_NATIVE_LIB'];
  blockchainUtils.setRustApi(libraryPath: libPath);
  if (!(blockchainUtils.backend?.backendInfo.has(BuBuildFeature.solanaZk) ??
      false)) {
    print('backend not exist! set BU_NATIVE_LIB.');
    return;
  }
  final bu = blockchainUtils.backend!;
  final zk = NativeSolanaZkApi(bu.solanaZk);
  final raw = bu.solanaZk;
  print('Solana confidential-transfer example (Devnet, live)');
  print('  native lib: $libPath');

  final faucetBalance = await quick.getAccountBalance(faucet);
  print('  faucet:  ${faucet.address} ($faucetBalance lamports)');
  if (faucetBalance < SolanaUtils.toLamports('0.05')) {
    print('Faucet is low; fund it via https://faucet.solana.com and re-run.');
    return;
  }
  await ensureFunded(alice);

  // 1. Mint with ConfidentialTransferMint extension --------------------------
  final mintKey = SolanaPrivateKey.fromBytes(randomBytes(32));
  final mint = mintKey.publicKey().toAddress();
  print('\n== 1. confidential mint ==');
  print('  mint: ${mint.address}');
  final mintRent = await quick.getRent(mintSpace);
  // Token-2022 requires extensions to be initialized BEFORE the base mint.
  final mintSig = await quick.buildSignAndSendConfidential(
    feePayer: faucet,
    signers: [faucetKey, mintKey],
    instructions: [
      SystemProgram.createAccount(
        from: faucet,
        newAccountPubKey: mint,
        layout: SystemCreateLayout(
          lamports: mintRent,
          space: BigInt.from(mintSpace),
          programId: SPLTokenProgramConst.token2022ProgramId,
        ),
      ),
      SPLToken2022ExtensionsProgram.confidentialInitializeMint(
        mint: mint,
        layout: SPLToken2022ConfidentialInitializeMintLayout(
          authority: faucet,
          autoApproveNewAccounts: true,
          auditorElGamalPubkey: null,
        ),
      ),
      SPLTokenProgram.initializeMint2(
        layout: SPLTokenInitializeMint2Layout(
          mintAuthority: faucet,
          decimals: mintDecimals,
          freezeAuthority: null,
        ),
        mint: mint,
        programId: SPLTokenProgramConst.token2022ProgramId,
      ),
    ],
  );
  print('  mint tx: $mintSig');
  print('  explorer: https://explorer.solana.com/tx/$mintSig?cluster=devnet');

  // 2. Token accounts + ConfigureAccount ------------------------------------
  // per-owner ElGamal + AES keys for the confidential accounts.
  final faucetSecret = freshElGamalSecret(zk);
  final aliceSecret = freshElGamalSecret(zk);
  final faucetElGamal = zk.pubkeyFromSecret(faucetSecret).toBytes();
  final aliceElGamal = zk.pubkeyFromSecret(aliceSecret).toBytes();
  final faucetAeKey = randomBytes(16);
  final aliceAeKey = randomBytes(16);

  // Create + configure sequentially (each needs its owner's secret).
  Future<SolAddress> createConfigureFor(
    SolanaPrivateKey ownerKey,
    List<int> elGamalPubkey,
    List<int> aeKey,
    String label,
  ) async {
    final owner = ownerKey.publicKey().toAddress();
    final secret = owner == faucet ? faucetSecret : aliceSecret;
    final tokenKey = SolanaPrivateKey.fromBytes(randomBytes(32));
    final token = tokenKey.publicKey().toAddress();
    print('\n== 2. token account ($label): ${token.address} ==');
    final rent = await quick.getRent(tokenAccountSpace);
    await quick.buildSignAndSendConfidential(
      feePayer: faucet,
      signers: [faucetKey, tokenKey],
      instructions: [
        SystemProgram.createAccount(
          from: faucet,
          newAccountPubKey: token,
          layout: SystemCreateLayout(
            lamports: rent,
            space: BigInt.from(tokenAccountSpace),
            programId: SPLTokenProgramConst.token2022ProgramId,
          ),
        ),
        SPLTokenProgram.initializeAccount3(
          layout: SPLTokenInitializeAccount3Layout(owner: owner),
          account: token,
          mint: mint,
          programId: SPLTokenProgramConst.token2022ProgramId,
        ),
      ],
    );
    final proof = raw
        .provePubkeyValidity(secret: secret, seed32: randomBytes(32))
        .unwrapOrThrow();
    if (proof.length != 64) {
      throw StateError('bad pubkey-validity proof length ${proof.length}');
    }
    final zeroBalance = raw
        .aeEncrypt(key16: aeKey, amount: 0, nonce12: randomBytes(12))
        .unwrapOrThrow();
    if (zeroBalance.length != 36) {
      throw StateError('bad AE ciphertext length ${zeroBalance.length}');
    }
    final sig = await quick.confidentialConfigureAccount(
      token: token,
      mint: mint,
      authority: owner,
      decryptableZeroBalance: zeroBalance.toList(),
      maximumPendingBalanceCreditCounter: BigInt.from(65536),
      proofInstructionOffset: -1,
      proofInstructions: [
        zkProofIx(_discPubkeyValidity, [...elGamalPubkey, ...proof]),
      ],
      proofAccounts: [SystemProgramConst.sysvarInstructionsPubkey],
      feePayer: faucet,
      signers: [faucetKey, ownerKey],
    );
    print('  configure tx: $sig');
    return token;
  }

  final faucetToken = await createConfigureFor(
    faucetKey,
    faucetElGamal,
    faucetAeKey,
    'faucet',
  );
  final aliceToken = await createConfigureFor(
    aliceKey,
    aliceElGamal,
    aliceAeKey,
    'alice',
  );

  // 3. MintTo + Deposit + ApplyPendingBalance --------------------------------
  const depositAmount = 50000; // < 2^16: instant BSGS decrypt.
  print('\n== 3. mint + deposit + apply ==');
  final mintDepositSig = await quick.buildSignAndSendConfidential(
    feePayer: faucet,
    signers: [faucetKey],
    instructions: [
      SPLTokenProgram.mintTo(
        layout: SPLTokenMintToLayout(amount: BigInt.from(depositAmount)),
        mint: mint,
        destination: faucetToken,
        authority: faucet,
        programId: SPLTokenProgramConst.token2022ProgramId,
      ),
      SPLToken2022ExtensionsProgram.confidentialDeposit(
        token: faucetToken,
        mint: mint,
        authority: faucet,
        layout: SPLToken2022ConfidentialDepositLayout(
          amount: BigInt.from(depositAmount),
          decimals: mintDecimals,
        ),
      ),
    ],
  );
  print('  mint+deposit tx: $mintDepositSig');

  var faucetState = await readState(faucetToken);
  print(
    '  faucet pending credits: '
    '${faucetState.pendingBalanceCreditCounter}',
  );
  final faucetNewAvailable = raw
      .aeEncrypt(
        key16: faucetAeKey,
        amount: depositAmount,
        nonce12: randomBytes(12),
      )
      .unwrapOrThrow();
  final applySig = await quick.confidentialApplyPendingBalance(
    token: faucetToken,
    authority: faucet,
    expectedPendingBalanceCreditCounter:
        faucetState.pendingBalanceCreditCounter,
    newDecryptableAvailableBalance: faucetNewAvailable.toList(),
    feePayer: faucet,
    signers: [faucetKey],
  );
  print('  apply tx: $applySig');
  print(
    '  faucet available (AES): '
    '${(await quick.readConfidentialBalances(tokenAccount: faucetToken, api: zk, elGamalSecret: faucetSecret, aeKey16: faucetAeKey))?.available}',
  );

  // 4. Confidential Withdraw --------------------------------------------------
  const withdrawAmount = 5000;
  print('\n== 4. confidential withdraw $withdrawAmount ==');
  const newFaucetAvailable = depositAmount - withdrawAmount;
  faucetState = await readState(faucetToken);
  final withdrawBundle = zk.proveWithdraw(
    sourceSecret: faucetSecret,
    sourcePubkey: faucetElGamal,
    currentCiphertext: faucetState.availableBalance,
    currentBalance: BigInt.from(depositAmount),
    withdrawAmount: BigInt.from(withdrawAmount),
    seed: randomBytes(32),
  );
  final w = withdrawBundle.bytes.toList();
  if (w.length != 1256) throw StateError('bad withdraw bundle ${w.length}');
  final wEq = w.sublist(0, 192);
  final wRange = w.sublist(192, 864);
  final wPodC = w.sublist(864, 1120);
  final wPodB = w.sublist(1120, 1128);
  final wRemComm = w.sublist(1128, 1160);
  final wRemCt = w.sublist(1192, 1256);
  final faucetWithdrawDecryptable = raw
      .aeEncrypt(
        key16: faucetAeKey,
        amount: newFaucetAvailable,
        nonce12: randomBytes(12),
      )
      .unwrapOrThrow();
  final withdrawSig = await quick.confidentialWithdraw(
    token: faucetToken,
    mint: mint,
    authority: faucet,
    amount: BigInt.from(withdrawAmount),
    decimals: mintDecimals,
    newDecryptableAvailableBalance: faucetWithdrawDecryptable.toList(),
    equalityProofInstructionOffset: -2,
    rangeProofInstructionOffset: -1,
    proofInstructions: [
      zkProofIx(_discEq, [...faucetElGamal, ...wRemCt, ...wRemComm, ...wEq]),
      zkProofIx(_discRangeU64, [...wPodC, ...wPodB, ...wRange]),
    ],
    proofAccounts: [SystemProgramConst.sysvarInstructionsPubkey],
    feePayer: faucet,
    signers: [faucetKey],
    type: TransactionType.v1,
    config: proofV1Config,
  );
  print('  withdraw tx: $withdrawSig');
  print(
    '  explorer: https://explorer.solana.com/tx/$withdrawSig?cluster=devnet',
  );
  print(
    '  faucet available after withdraw (AES): '
    '${(await quick.readConfidentialBalances(tokenAccount: faucetToken, api: zk, elGamalSecret: faucetSecret, aeKey16: faucetAeKey))?.available}',
  );

  // 5. Confidential Transfer faucet -> alice -----------------------------------
  const transferAmount = 10000;
  print('\n== 5. confidential transfer $transferAmount (faucet -> alice) ==');
  const sourceAvailable = newFaucetAvailable;
  faucetState = await readState(faucetToken);
  final transferBundle = zk.proveTransfer(
    sourceSecret: faucetSecret,
    sourcePubkey: faucetElGamal,
    destPubkey: aliceElGamal,
    auditorPubkey: List<int>.filled(32, 0),
    currentCiphertext: faucetState.availableBalance,
    currentBalance: BigInt.from(sourceAvailable),
    transferAmount: BigInt.from(transferAmount),
    seed: randomBytes(32),
  );
  final t = transferBundle.bytes.toList();
  if (t.length != 1896) throw StateError('bad transfer bundle ${t.length}');
  final tEq = t.sublist(0, 192);
  final tValidity = t.sublist(192, 384);
  final tRange = t.sublist(384, 1120);
  final tPodC = t.sublist(1120, 1376);
  final tPodB = t.sublist(1376, 1384);
  final tGlo = t.sublist(1384, 1512);
  final tGhi = t.sublist(1512, 1640);
  final tRemComm = t.sublist(1640, 1672);
  final tRemCt = t.sublist(1704, 1768);
  final tAudLo = t.sublist(1768, 1832);
  final tAudHi = t.sublist(1832, 1896);
  const sourceNewAvailable = sourceAvailable - transferAmount;
  final sourceTransferDecryptable = raw
      .aeEncrypt(
        key16: faucetAeKey,
        amount: sourceNewAvailable,
        nonce12: randomBytes(12),
      )
      .unwrapOrThrow();
  final transferSig = await quick.confidentialTransfer(
    source: faucetToken,
    mint: mint,
    destination: aliceToken,
    authority: faucet,
    newSourceDecryptableAvailableBalance: sourceTransferDecryptable.toList(),
    transferAmountAuditorCiphertextLo: tAudLo,
    transferAmountAuditorCiphertextHi: tAudHi,
    equalityProofInstructionOffset: -3,
    ciphertextValidityProofInstructionOffset: -2,
    rangeProofInstructionOffset: -1,
    proofInstructions: [
      zkProofIx(_discEq, [...faucetElGamal, ...tRemCt, ...tRemComm, ...tEq]),
      zkProofIx(_discBatchedValidity3, [
        ...faucetElGamal,
        ...aliceElGamal,
        ...List<int>.filled(32, 0),
        ...tGlo,
        ...tGhi,
        ...tValidity,
      ]),
      zkProofIx(_discRangeU128, [...tPodC, ...tPodB, ...tRange]),
    ],
    proofAccounts: [SystemProgramConst.sysvarInstructionsPubkey],
    feePayer: faucet,
    signers: [faucetKey],
    type: TransactionType.v1,
    config: proofV1Config,
  );
  print('  transfer tx: $transferSig');
  print(
    '  explorer: https://explorer.solana.com/tx/$transferSig?cluster=devnet',
  );

  // 6. Apply on alice + read both sides -----------------------------------------
  print('\n== 6. apply + read ==');
  var aliceState = await readState(aliceToken);
  print('  alice pending credits: ${aliceState.pendingBalanceCreditCounter}');
  final alicePendingTotal = (await quick.readConfidentialBalances(
    tokenAccount: aliceToken,
    api: zk,
    elGamalSecret: aliceSecret,
    aeKey16: aliceAeKey,
  ))
      ?.pendingTotal;
  print('  alice pending total (ElGamal): $alicePendingTotal');
  final aliceNewAvailable = raw
      .aeEncrypt(
        key16: aliceAeKey,
        amount: alicePendingTotal?.toInt() ?? 0,
        nonce12: randomBytes(12),
      )
      .unwrapOrThrow();
  final aliceApplySig = await quick.confidentialApplyPendingBalance(
    token: aliceToken,
    authority: alice,
    expectedPendingBalanceCreditCounter: aliceState.pendingBalanceCreditCounter,
    newDecryptableAvailableBalance: aliceNewAvailable.toList(),
    feePayer: faucet,
    signers: [faucetKey, aliceKey],
  );
  print('  alice apply tx: $aliceApplySig');
  aliceState = await readState(aliceToken);
  print(
    '  alice available (AES): '
    '${(await quick.readConfidentialBalances(tokenAccount: aliceToken, api: zk, elGamalSecret: aliceSecret, aeKey16: aliceAeKey))?.available}',
  );
  print(
    '  faucet available (AES): '
    '${(await quick.readConfidentialBalances(tokenAccount: faucetToken, api: zk, elGamalSecret: faucetSecret, aeKey16: faucetAeKey))?.available}',
  );

  print('\nAll confidential-transfer steps completed on Devnet.');
  print('  mint:    ${mint.address}');
  print('  faucet/confidential account: ${faucetToken.address}');
  print('  alice/confidential account:  ${aliceToken.address}');
}
