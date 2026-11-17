/// DKLs23 threshold-ECDSA (secp256k1) Ethereum examples on a local Anvil node.
library;

import 'dart:io';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:blockchain_utils/crypto/crypto/keys/utils/ecdsa.dart';
import 'package:on_chain/on_chain.dart';

import 'rpc/http_service.dart';

/// Local Anvil RPC (chain id 31337).
const String rpcUrl = 'http://127.0.0.1:28545';
const int chainId = 31337;

/// Anvil default account 0 (faucet / deployer), 10000 ETH.
const String faucetKeyHex =
    '0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80';

/// Anvil default account 1 (transfer recipient).
const String aliceKeyHex =
    '0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d';

/// Anvil default accounts 2 and 3: members 1 and 2 of the quorum.
const String member1KeyHex =
    '0x5de4111afa1a4b94908f83103eb1f1706367c2e68ca870fc3fb9a804cdab365a';
const String member2KeyHex =
    '0x7c852118294e51e653712a81e05800f419141751be58f605c371e15141b007a6';

/// Anvil default account 4: member 3 of the additive 3-of-3 quorum. The
/// group key of accounts 2 + 3 + 4 is a deterministic address that holds
/// nothing until the faucet funds it (see [ensureFunded]).
const String member3KeyHex =
    '0x47e179ec197488593b187f80a00eb0da91f1b9d0b13f8733639f19c30a34926a';

/// Number of parties in the additive 3-of-3 quorum.
const int n = 3;

/// Transfer amount, in wei (0.01 ETH).
final BigInt amount = BigInt.from(10000000000000000);

/// The QuickClient and raw provider used by every example.
final EthereumQuickClient quick = DefaultEthereumQuickClient(
  provider: EthereumProvider(RPCHttpService(rpcUrl)),
);

final ETHPrivateKey faucetKey = ETHPrivateKey.fromHex(faucetKeyHex);
final ETHAddress faucet = faucetKey.publicKey().toAddress();

final ETHPrivateKey aliceKey = ETHPrivateKey.fromHex(aliceKeyHex);
final ETHAddress alice = aliceKey.publicKey().toAddress();

/// The three quorum members. `fromSecretKeys` makes each secret party `i`'s
/// additive share of the joint key, so the group key is their sum. These are
/// Anvil accounts 2, 3 and 4, so the group address is
/// `0x7E79841F8f8430d1845A505de46906dFDB04091a` — a deterministic address
/// that holds no ETH until the faucet funds it (see [ensureFunded]).
List<Secp256k1PrivateKey> memberKeys() => [
      Secp256k1PrivateKey.fromBytes(BytesUtils.fromHexString(member1KeyHex)),
      Secp256k1PrivateKey.fromBytes(BytesUtils.fromHexString(member2KeyHex)),
      Secp256k1PrivateKey.fromBytes(BytesUtils.fromHexString(member3KeyHex)),
    ];

/// A built DKLs23 quorum: the coordinator key plus its Ethereum address.
class Quorum {
  Quorum({
    required this.key,
    required this.threshold,
    required this.address,
  });

  final Dkls23Secp256k1PrivateKey key;

  /// Resolved threshold; `null` means full quorum (every party signs).
  final int? threshold;

  final ETHAddress address;

  String get describe =>
      '${threshold ?? key.publicKey.n}-of-${key.publicKey.n}';

  /// Signs [digest] with [Dkls23ETHSigner], hashing first the way
  /// `ETHPrivateKey.sign` does (Ethereum signs keccak256 of the payload).
  IECDSASignature sign(List<int> payload, {List<int>? subset}) {
    final digest = QuickCrypto.keccak256Hash(payload);
    return Dkls23ETHSigner(key).signHash(digest, subset: subset);
  }
}

/// Builds the [n]-party additive quorum the examples spend from.
Quorum buildQuorum() {
  final key = Dkls23Secp256k1PrivateKey.fromSecretKeys(memberKeys());
  return Quorum(
    key: key,
    threshold: key.publicKey.threshold,
    address: ETHPublicKey.fromBytes(key.publicKey.aggKey.toBytes()).toAddress(),
  );
}

/// Builds a real `t`-of-`n` quorum through DKG (not the additive import).
///
/// The additive path above can only produce a full quorum (`t == n`); a
/// proper threshold needs the DKG. The resulting group key is a fresh
/// deterministic address that holds nothing until the faucet funds it.
Quorum buildDkgQuorum({required int threshold, required int parties}) {
  final sid =
      QuickCrypto.keccak256Hash(StringUtils.encode('onchain-dkls23')).toList();
  final seeds = [
    for (var i = 0; i < parties; i++)
      QuickCrypto.keccak256Hash([...'onchain/dkls23/seed'.codeUnits, i])
          .toList(),
  ].expand((e) => e).toList();
  final key = Dkls23Secp256k1PrivateKey.generate(
    sid: sid,
    n: parties,
    seeds: seeds,
    threshold: threshold,
  );
  return Quorum(
    key: key,
    threshold: key.publicKey.threshold,
    address: ETHPublicKey.fromBytes(key.publicKey.aggKey.toBytes()).toAddress(),
  );
}

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

/// 1. Key shape: group key == address, and signatures verify + recover.
void exampleKeyShape() {
  print('\n== 1. DKLs23 key shape and signature ==');
  final q = buildQuorum();
  final pub = q.key.publicKey;
  print('  quorum:          ${q.describe}');
  print('  group key:       ${pub.aggKey.toBytes().toHex()}');
  print('  ethereum:        ${q.address.address}');
  print('  threshold field: ${pub.threshold ?? 'null (full quorum)'}');

  final payload = StringUtils.encode('dkls23-eth');
  final digest = QuickCrypto.keccak256Hash(payload);
  final sig = q.sign(payload);

  final ok = ETHVerifier(
    Secp256k1Verifier(Secp256k1PublicKey.fromBytes(pub.aggKey.toBytes())),
  ).verify(digest, sig.toBytes(), hashMessage: false);
  if (!ok) throw StateError('group key failed to verify the signature');

  final recovered = Secp256k1EcdsaUtils.recoverPublicKey(
    hash: digest,
    signature: sig,
  );
  final recoveredAddress = ETHAddress.fromPublicKey(recovered.toBytes());
  if (recoveredAddress.address != q.address.address) {
    throw StateError(
      'recovered ${recoveredAddress.address} != ${q.address.address}',
    );
  }
  print('  verify:          true');
  print('  recovered:       ${recoveredAddress.address}');
}

/// 2. Every backend signs a digest the group key accepts.
void exampleBackends() {
  print('\n== 2. Backend parity (rust / dart) ==');
  final q = buildQuorum();
  final payload = StringUtils.encode('backend-parity');
  final digest = QuickCrypto.keccak256Hash(payload);
  final verifier = ETHVerifier(
    Secp256k1Verifier(
      Secp256k1PublicKey.fromBytes(q.key.publicKey.aggKey.toBytes()),
    ),
  );

  for (final backend in ['rust', 'dart']) {
    useBackend(backend);
    final sig = q.sign(payload);
    final ok = verifier.verify(digest, sig.toBytes(), hashMessage: false);
    final hex = sig.toBytes().toHex();
    print('  $backend: verify=$ok  sig=${hex.substring(0, 24)}...');
    if (!ok) throw StateError('$backend backend produced an invalid signature');
  }
  // Leave the example on the native backend for the live transfers.
  useBackend('rust');
}

/// Tops [address] up from the faucet when its balance is below [need].
///
/// The faucet is Anvil account 0; the transfer is a normal signed EIP-1559
/// transaction, so this doubles as a check that the QuickClient path works.
Future<void> ensureFunded(ETHAddress address, BigInt need) async {
  final balance = await quick.getBalance(address);
  if (balance >= need) return;

  final topUp = BigInt.parse('10000000000000000000'); // 10 ETH
  final builder = ETHTransactionBuilder(
    from: faucet,
    to: address,
    value: topUp,
    chainId: BigInt.from(chainId),
    transactionType: ETHTransactionType.eip1559,
  );
  await builder.autoFill(quick.provider);
  builder.sign(faucetKey);
  await builder.submitAndWatchTransactionAsync(
    quick.provider,
    blockInterval: const Duration(seconds: 1),
  );
  final after = await quick.getBalance(address);
  print('  funded:          $topUp wei -> $after wei');
  if (after < need) {
    throw StateError('faucet failed to fund ${address.address}');
  }
}

/// 3. Quorum transfer, built + signed + submitted through the QuickClient.
Future<void> exampleTransfer({
  required Quorum q,
  required String label,
  List<int>? subset,
}) async {
  print('\n== 3. Quorum transfer ($label) ==');
  print('  from:            ${q.address.address} (${q.describe})');
  print('  to:              ${alice.address}');
  print('  amount:          $amount wei');

  await ensureFunded(q.address, amount * BigInt.from(2));
  final before = await quick.getBalance(q.address);
  final aliceBefore = await quick.getBalance(alice);

  final builder = ETHTransactionBuilder(
    from: q.address,
    to: alice,
    value: amount,
    chainId: BigInt.from(chainId),
    transactionType: ETHTransactionType.eip1559,
  );
  await builder.autoFill(quick.provider);
  builder.setSignature(q.sign(builder.serializedTransaction, subset: subset));
  final txId = builder.transactionID;

  final receipt = await builder.submitAndWatchTransactionAsync(
    quick.provider,
    blockInterval: const Duration(seconds: 1),
  );
  if (receipt.status != true) {
    throw StateError('transfer reverted (status=${receipt.status})');
  }

  final after = await quick.getBalance(q.address);
  final aliceAfter = await quick.getBalance(alice);
  final delta = aliceAfter - aliceBefore;
  print('  tx:              $txId');
  print('  confirmed:       yes (block ${receipt.blockNumber})');
  print('  spent:           ${before - after} wei');
  print('  alice received:  $delta wei');
  if (delta != amount) {
    throw StateError('alice received $delta, expected $amount');
  }
}

Future<void> main() async {
  print('Ethereum local Anvil — DKLs23 threshold ECDSA (secp256k1)');
  print('  rpc:     $rpcUrl');
  print('  chainId: $chainId');
  print(
    '  backend: ${blockchainUtils.hasNativeBackend ? 'rust' : 'dart (default)'}',
  );

  final block = await quick.getBlockHeight();
  final balance = await quick.getBalance(faucet);
  print('  block:   $block');
  print('  faucet:  ${faucet.address} ($balance wei)');
  if (balance == BigInt.zero) {
    print('\nFaucet has no ETH. Fund it:');
    return;
  }

  // 1. group key ↔ address, signature verification and recovery
  exampleKeyShape();

  // 2. rust vs dart parity on the same digest
  exampleBackends();

  // 3a. additive full quorum (threshold == null)
  await exampleTransfer(q: buildQuorum(), label: 'additive full quorum');

  // 3b. real DKG 2-of-3: a proper subset signs
  await exampleTransfer(
    q: buildDkgQuorum(threshold: 2, parties: 3),
    label: 'dkg 2-of-3',
    subset: [0, 1],
  );

  print('\ndone.');
}
