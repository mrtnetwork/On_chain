/// FROST Ed25519 threshold-signature SOL transfers on Solana devnet.
/// BU_NATIVE_LIB selects the Rust backend (optional, Dart backend also works).
library;

import 'dart:io';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/solana.dart';

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

/// Pre-funded, clean devnet account used to fund the quorums.
SolanaPrivateKey get faucetKey => demoSecretKey(12);
SolAddress get faucet => faucetKey.publicKey().toAddress();

/// Sent per transfer.
final BigInt transferAmount = SolanaUtils.toLamports('0.001');

/// Number of parties in each quorum.
const int parties = 3;

/// A FROST(Ed25519) quorum as a Solana signer.
///
/// `FrostEd25519Signer` emits a plain 64-byte Ed25519 signature (`R || z`),
/// which is exactly what Solana expects, so the raw signature drops straight
/// into the transaction's signature slot.
class FrostSolanaSigner {
  FrostSolanaSigner(this.key, {List<int>? subset})
      : _subset = subset == null ? null : List<int>.unmodifiable(subset);

  final FrostEd25519PrivateKey key;

  /// Signing subset; `null` uses the key's default (first `t` shares).
  final List<int>? _subset;

  /// The quorum's group address (its Solana account).
  SolAddress address() =>
      SolanaPublicKey.fromBytes(key.publicKey.aggKey.toBytes()).toAddress();

  /// The group public key (32-byte Ed25519 point).
  List<int> groupKey() => key.publicKey.aggKey.toBytes();

  /// Signs a Solana message (the serialized transaction message, signed
  /// as-is — no pre-hash, matching `SolanaPrivateKey.sign`).
  List<int> sign(List<int> message) {
    return FrostEd25519Signer(key)
        .sign(message, subset: _subset)
        .signature
        .toBytes();
  }
}

/// Builds the deterministic FROST quorum for [label].
///
/// [threshold] `null` gives the additive full quorum (`t == n`); a value
/// selects a real threshold (`2 <= t <= n`).
FrostSolanaSigner buildQuorum({
  required String label,
  int? threshold,
  List<int>? subset,
}) {
  final seeds = [
    for (var i = 0; i < parties; i++)
      ED25519PrivateKey.fromBytes(
        QuickCrypto.sha256Hash([
          ...utf8Bytes('onchain/solana/frost/$label'),
          i,
        ]),
      ),
  ];
  final key =
      FrostEd25519PrivateKey.fromSecretKeys(seeds, threshold: threshold);
  return FrostSolanaSigner(key, subset: subset);
}

List<int> utf8Bytes(String s) => StringUtils.encode(s);

/// Selects the active crypto backend: `rust` (FFI) or `dart` (pure Dart).
void useBackend(String backend) {
  if (backend == 'rust') {
    blockchainUtils.setRustApi(
      libraryPath: Platform.environment['BU_NATIVE_LIB'],
    );
  } else {
    blockchainUtils.setDartApi();
  }
}

/// Balance of [address] in lamports (0 when the account does not exist).
Future<BigInt> balanceOf(SolAddress address) =>
    quick.getAccountBalance(address);

/// Latest blockhash.
Future<SolAddress> latestBlockhash() => quick.getBlockHash();

/// Polls [signature] until it is confirmed/finalized (or [timeout] elapses).
///
/// Uses `transactionStatus` in a local poll loop to avoid the
/// `trackTransaction` completer bug (see review.md).
Future<void> waitForSignature(
  String signature, {
  Duration timeout = const Duration(seconds: 40),
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

/// Tops up [address] from [faucet] when it holds less than [minLamports].
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
  await _submit(
    transaction: SolanaTransaction(
      instructions: [transfer],
      recentBlockhash: await latestBlockhash(),
      payerKey: faucet,
    ),
    signers: [faucetKey],
  );
}

/// Signs [transaction] with [signers], submits it and waits for confirmation.
Future<String> _submit({
  required SolanaTransaction transaction,
  required List<SolanaPrivateKey> signers,
}) async {
  transaction.sign(signers);
  final signature = await quick.sendTransaction(transaction);
  await waitForSignature(signature);
  return signature;
}

/// 1. Key shape: the group key is a Solana address and signatures verify.
void exampleKeyShape() {
  print('\n== 1. FROST Ed25519 key shape ==');
  final q = buildQuorum(label: 'shape', threshold: 2);
  print(
      '  quorum:          ${q.key.publicKey.threshold}-of-${q.key.publicKey.n}');
  print('  group key:       ${q.groupKey().toBytes.toHex()}');
  print('  solana address:  ${q.address().address}');

  final message = QuickCrypto.sha256Hash(utf8Bytes('frost-solana'));
  final signature = q.sign(message);
  final ok = SolanaPublicKey.fromBytes(
    q.groupKey(),
  ).verify(message: message, signature: signature);
  print('  verify:          $ok  sig=${signature.length}B');
  if (!ok) throw StateError('group key failed to verify the signature');
}

/// 2. Backend parity: Rust and Dart both produce valid Ed25519 signatures.
void exampleBackends() {
  print('\n== 2. Backend parity (rust / dart) ==');
  final q = buildQuorum(label: 'parity', threshold: 2);
  final message = QuickCrypto.sha256Hash(utf8Bytes('backend-parity'));

  for (final backend in ['rust', 'dart']) {
    useBackend(backend);
    final signature = q.sign(message);
    final ok = SolanaPublicKey.fromBytes(
      q.groupKey(),
    ).verify(message: message, signature: signature);
    final hex = signature.sublist(0, 12).toBytes.toHex();
    print('  $backend: verify=$ok  sig=$hex...');
    if (!ok) throw StateError('$backend backend produced an invalid signature');
  }
  useBackend('rust');
}

/// Signs [transaction] with a FROST quorum and submits it.
Future<String> submitWithQuorum({
  required FrostSolanaSigner quorum,
  required SolanaTransaction transaction,
}) async {
  final message = transaction.serializeMessage();
  final signature = quorum.sign(message);
  transaction.addSignature(quorum.address(), signature);
  final txSignature = await quick.sendTransaction(transaction);
  await waitForSignature(txSignature);
  return txSignature;
}

/// 3. A real devnet transfer from the quorum address.
Future<void> exampleTransfer({
  required String label,
  int? threshold,
  List<int>? subset,
}) async {
  final q = buildQuorum(label: label, threshold: threshold, subset: subset);
  // A null threshold resolves to the full quorum; show the effective value.
  final t = q.key.publicKey.threshold ?? q.key.publicKey.n!;
  final n = q.key.publicKey.n;
  final scheme = threshold == null ? 'additive' : 'threshold';
  print('\n== 3. Transfer ($scheme $t-of-$n) ==');
  print('  from:            ${q.address().address}');

  await ensureFunded(q.address());
  final before = await balanceOf(q.address());

  final recipient = demoSecretKey(31).publicKey().toAddress();
  final transfer = SystemProgram.transfer(
    from: q.address(),
    layout: SystemTransferLayout(lamports: transferAmount),
    to: recipient,
  );
  final transaction = SolanaTransaction(
    instructions: [transfer],
    recentBlockhash: await latestBlockhash(),
    payerKey: q.address(),
  );

  final signature = await submitWithQuorum(quorum: q, transaction: transaction);
  await Future<void>.delayed(const Duration(seconds: 2));
  final after = await balanceOf(q.address());

  print('  to:              ${recipient.address}');
  print('  amount:          $transferAmount lamports');
  print('  subset:          ${subset ?? 'default (first $t held shares)'}');
  print('  txid:            $signature');
  print('  spent:           ${before - after} lamports (incl. fee)');
  print(
      '  explorer:        https://explorer.solana.com/tx/$signature?cluster=devnet');
}

Future<void> main() async {
  if (Platform.environment['BU_NATIVE_LIB'] != null) {
    useBackend('rust');
    print('rust backend: enabled');
  } else {
    print('rust backend: default (no BU_NATIVE_LIB)');
  }
  final genesis = await quick.getGenesis();
  final height = await quick.getBlockHeight();
  final faucetBalance = await balanceOf(faucet);

  print('Solana Devnet (FROST Ed25519)');
  print('  rpc:     $rpcUrl');
  print('  genesis: $genesis');
  print('  height:  $height');
  print('  faucet:  ${faucet.address} ($faucetBalance lamports)');

  if (faucetBalance < SolanaUtils.toLamports('0.02')) {
    print('\nFaucet is low. Fund this Devnet address and re-run:');
    print('  ${faucet.address}');
    print('  (RPC airdrop is closed; use https://faucet.solana.com)');
    return;
  }

  // 1. group key -> Solana address, signature verifies
  exampleKeyShape();

  // 2. rust vs dart parity
  exampleBackends();

  // 3a. additive full quorum (threshold == null)
  await exampleTransfer(label: 'additive', threshold: null);

  // 3b. real threshold 2-of-3, signed by a proper subset
  await exampleTransfer(label: 'threshold', threshold: 2, subset: [0, 1]);

  print('\nAll Solana FROST Ed25519 examples completed.');
}
