/// Solana devnet examples through `SolanaQuickClient` (tour, SOL/SPL/v1 transfers).
library;

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/solana.dart';

import 'new_standards_example.dart';
import 'service_example/service_example.dart';

/// Devnet RPC endpoint.
const String rpcUrl = 'https://api.devnet.solana.com';

/// The single QuickClient used by every example.
final SolanaQuickClient quick = DefaultSolanaQuickClient(
  provider: solanaRPC(rpcUrl),
);

/// Deterministic demo key from a 32-byte seed.
SolanaPrivateKey demoSecretKey(int seedByte) =>
    SolanaPrivateKey.fromBytes(List<int>.filled(32, seedByte));

// Deterministic accounts. `faucet` (seed 12) is a funded, clean devnet account
// and tops up the others so the examples can run repeatedly.
SolanaPrivateKey get faucetKey => demoSecretKey(12);
SolAddress get faucet => faucetKey.publicKey().toAddress();

SolanaPrivateKey get aliceKey => demoSecretKey(23);
SolAddress get alice => aliceKey.publicKey().toAddress();

SolanaPrivateKey get bobKey => demoSecretKey(25);
SolAddress get bob => bobKey.publicKey().toAddress();

/// Latest blockhash from the QuickClient.
Future<SolAddress> latestBlockhash() => quick.getBlockHash();

/// Balance of [address] in lamports (0 when the account does not exist).
Future<BigInt> balanceOf(SolAddress address) =>
    quick.getAccountBalance(address);

/// Polls [signature] until it is confirmed/finalized (or [timeout] elapses).
///
/// Uses the QuickClient's `transactionStatus`; a local poll loop avoids the
/// `trackTransaction` completer bug (see review.md).
Future<void> waitForSignature(
  String signature, {
  Duration timeout = const Duration(seconds: 30),
  Duration interval = const Duration(seconds: 1),
}) async {
  final deadline = DateTime.now().add(timeout);
  while (DateTime.now().isBefore(deadline)) {
    final status = await quick.transactionStatus(signature);
    if (status == SolanaTxStatus.block || status == SolanaTxStatus.failed) {
      return;
    }
    await Future<void>.delayed(interval);
  }
  throw StateError('transaction $signature not confirmed in time');
}

/// Signs, sends and waits for [transaction], returning its signature.
Future<String> signSendWait(
  SolanaTransaction transaction,
  List<SolanaPrivateKey> signers,
) async {
  final signature = await quick.signAndSubmit(
    transaction: transaction,
    signers: signers,
  );
  await waitForSignature(signature);
  return signature;
}

/// Ensures [address] holds at least [minLamports], topping up from [faucet].
Future<void> ensureFunded(
  SolAddress address, {
  BigInt? minLamports,
}) async {
  final target = minLamports ?? SolanaUtils.toLamports('0.01');
  if (address == faucet) return;
  final balance = await balanceOf(address);
  if (balance >= target) {
    print('  [fund] ${address.address} already has $balance lamports');
    return;
  }
  final deficit = target - balance;
  print('  [fund] sending $deficit lamports to ${address.address}');
  final transfer = SystemProgram.transfer(
    from: faucet,
    layout: SystemTransferLayout(lamports: deficit),
    to: address,
  );
  final transaction = SolanaTransaction(
    instructions: [transfer],
    recentBlockhash: await latestBlockhash(),
    payerKey: faucet,
  );
  await signSendWait(transaction, [faucetKey]);
}

/// 0. QuickClient tour: every read/status helper on the faucet account.
Future<void> exampleQuickClientTour() async {
  print('\n== 0. QuickClient tour ==');

  print('  genesis:      ${await quick.getGenesis()}');
  print('  block height: ${await quick.getBlockHeight()}');
  print('  faucet bal:   ${await balanceOf(faucet)} lamports');
  print('  alice bal:    ${await balanceOf(alice)} lamports');

  final info = await quick.getAccountInfo(faucet);
  print('  faucet info:  lamports=${info?.lamports} '
      'owner=${info?.owner} space=${info?.space}');

  final rent = await quick.getRent(165);
  print('  rent (165B):  $rent lamports');

  final signatures = await quick.getSignaturesForAddress(
    account: faucet,
    limit: 3,
  );
  print('  recent sigs:  ${signatures.length}');
}

/// 1. Native SOL transfer: faucet sends 0.01 SOL to Alice.
Future<void> exampleNativeTransfer() async {
  print('\n== 1. Native SOL transfer (faucet -> alice, 0.01 SOL) ==');
  final to = alice;
  final amount = SolanaUtils.toLamports('0.01');
  await ensureFunded(to, minLamports: amount);

  final before = await balanceOf(to);
  final transfer = SystemProgram.transfer(
    from: faucet,
    layout: SystemTransferLayout(lamports: amount),
    to: to,
  );
  final transaction = SolanaTransaction(
    instructions: [transfer],
    recentBlockhash: await latestBlockhash(),
    payerKey: faucet,
  );

  final signature = await signSendWait(transaction, [faucetKey]);
  await Future<void>.delayed(const Duration(seconds: 2));
  final after = await balanceOf(to);

  print('  txid:    $signature');
  print('  status:  ${await quick.transactionStatus(signature)}');
  print('  ${to.address}: $before -> $after lamports');
  print('  explorer: https://explorer.solana.com/tx/$signature?cluster=devnet');
}

/// 2. SPL token: create a mint, mint to the faucet, then transfer to Bob.
Future<void> exampleSplToken() async {
  print('\n== 2. SPL token (create mint -> mint -> transfer) ==');
  await ensureFunded(bob, minLamports: SolanaUtils.toLamports('0.01'));

  // Fresh random mint key for this run (a mint account cannot be re-initialized).
  final mintKey = SolanaPrivateKey.fromBytes(
    QuickCrypto.generateRandom(length: 32),
  );
  final mint = mintKey.publicKey().toAddress();
  print('  mint: ${mint.address}');

  // 1. create the mint account (rent exempt) + initialize it (decimals 3)
  final mintSpace = SolanaMintAccount.size;
  final rent = await quick.getRent(mintSpace);
  final createMint = SystemProgram.createAccount(
    from: faucet,
    newAccountPubKey: mint,
    layout: SystemCreateLayout(
      lamports: rent,
      space: BigInt.from(mintSpace),
      programId: SPLTokenProgramConst.tokenProgramId,
    ),
  );
  final initMint = SPLTokenProgram.initializeMint2(
    layout: SPLTokenInitializeMint2Layout(
      mintAuthority: faucet,
      decimals: 3,
      freezeAuthority: null,
    ),
    mint: mint,
  );
  final createSig = await signSendWait(
    SolanaTransaction(
      payerKey: faucet,
      instructions: [createMint, initMint],
      recentBlockhash: await latestBlockhash(),
    ),
    [faucetKey, mintKey],
  );
  print('  create mint tx: $createSig');

  final mintInfo = await quick.getMintAccount(mint);
  print('  mint authority: ${mintInfo?.mintAuthority} '
      'decimals=${mintInfo?.decimals}');

  // 2. create the faucet's associated token account and mint 1000 tokens.
  final faucetAta = await quick.getTokenAccountAddress(
    account: faucet,
    mint: mint,
  );
  final createAta = AssociatedTokenAccountProgram.associatedTokenAccount(
    payer: faucet,
    associatedToken: faucetAta.pdaAddress,
    owner: faucet,
    mint: mint,
  );
  final mintTo = SPLTokenProgram.mintTo(
    mint: mint,
    destination: faucetAta.pdaAddress,
    authority: faucet,
    layout: SPLTokenMintToLayout(amount: BigInt.from(1000000)), // 1000.000
  );
  final mintSig = await signSendWait(
    SolanaTransaction(
      payerKey: faucet,
      instructions: [createAta, mintTo],
      recentBlockhash: await latestBlockhash(),
    ),
    [faucetKey],
  );
  print('  mint to tx:     $mintSig');
  print('  faucet tokens:  '
      '${await quick.getTokenBalance(account: faucet, mint: mint)}');

  // 3. create Bob's associated token account (Bob pays rent).
  final bobAta = await quick.getTokenAccountAddress(account: bob, mint: mint);
  final createBobAta = AssociatedTokenAccountProgram.associatedTokenAccount(
    payer: bob,
    associatedToken: bobAta.pdaAddress,
    owner: bob,
    mint: mint,
  );
  final bobAtaSig = await signSendWait(
    SolanaTransaction(
      payerKey: bob,
      instructions: [createBobAta],
      recentBlockhash: await latestBlockhash(),
    ),
    [bobKey],
  );
  print('  bob ATA tx:     $bobAtaSig');

  // 4. transfer 100 tokens faucet -> bob.
  final transfer = SPLTokenProgram.transfer(
    source: faucetAta.pdaAddress,
    destination: bobAta.pdaAddress,
    owner: faucet,
    layout: SPLTokenTransferLayout(amount: BigInt.from(100000)), // 100.000
  );
  final transferSig = await signSendWait(
    SolanaTransaction(
      payerKey: faucet,
      instructions: [transfer],
      recentBlockhash: await latestBlockhash(),
    ),
    [faucetKey],
  );
  await Future<void>.delayed(const Duration(seconds: 2));

  print('  transfer tx:    $transferSig');
  print('  bob tokens:     '
      '${await quick.getTokenBalance(account: bob, mint: mint)}');
  print(
      '  explorer: https://explorer.solana.com/tx/$transferSig?cluster=devnet');
}

/// 3. v1 transfer (SIMD-0385): 0x81 prefix, signatures at the tail, fee +
/// limits in the message config (no ComputeBudget instructions).
Future<void> exampleV1Transfer() async {
  print('\n== 3. v1 transfer (SIMD-0385) ==');
  await ensureFunded(bob, minLamports: SolanaUtils.toLamports('0.01'));

  const config = TransactionV1Config(
    priorityFeeLamports: null,
    computeUnitLimit: 20000,
    loadedAccountsDataSizeLimit: 64 * 1024,
  );

  final transfer = SystemProgram.transfer(
    from: faucet,
    layout: SystemTransferLayout(lamports: SolanaUtils.toLamports('0.001')),
    to: bob,
  );

  final transaction = SolanaTransaction(
    instructions: [transfer],
    recentBlockhash: await latestBlockhash(),
    payerKey: faucet,
    type: TransactionType.v1,
    config: config,
  );

  transaction.sign([faucetKey]);
  assert(transaction.areSignaturesReady());

  // v1 must go over base64 (base58 stays capped at 1232 bytes; v1 allows 4096).
  final wire = transaction.serializeString(
    encoding: TransactionSerializeEncoding.base64,
  );
  assert(wire.isNotEmpty);

  final simulation = await quick.simulate(transaction: transaction);
  if (simulation.err != null) {
    throw StateError('simulation failed: ${simulation.err}');
  }

  final signature = await quick.sendTransaction(
    transaction,
    encoding: SolanaRequestEncoding.base64,
  );
  await waitForSignature(signature);
  await Future<void>.delayed(const Duration(seconds: 2));

  final status = await quick.transactionStatus(signature);
  final bobBalance = await balanceOf(bob);
  print('  txid:    $signature');
  print('  status:  $status');
  print('  bob:     $bobBalance lamports');
  print('  explorer: https://explorer.solana.com/tx/$signature?cluster=devnet');
}

Future<void> main() async {
  final genesis = await quick.getGenesis();
  final height = await quick.getBlockHeight();
  final faucetBalance = await balanceOf(faucet);

  print('Solana Devnet (QuickClient)');
  print('  rpc:     $rpcUrl');
  print('  genesis: $genesis');
  print('  height:  $height');
  print('  faucet:  ${faucet.address}');
  print('  alice:   ${alice.address}');
  print('  bob:     ${bob.address}');
  print('  faucet:  $faucetBalance lamports');

  if (faucetBalance < SolanaUtils.toLamports('0.02')) {
    print('\nFaucet is low. Fund this Devnet address and re-run:');
    print('  ${faucet.address}');
    print('  (RPC airdrop is closed; use https://faucet.solana.com)');
    return;
  }

  await exampleQuickClientTour();
  await exampleNativeTransfer();
  await exampleSplToken();
  await exampleV1Transfer();
  await exampleNewStandards();

  print('\nAll Solana examples completed.');
}
