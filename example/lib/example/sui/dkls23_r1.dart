/// DKLs23 threshold-ECDSA secp256r1 examples with live SUI devnet transfers.
/// Needs the devnet gRPC forwarder; BU_NATIVE_LIB selects the Rust backend.
library;

import 'dart:io';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:grpc/grpc.dart';
import 'package:http/http.dart' as http;
import 'package:on_chain/on_chain.dart';

/// Local gRPC forwarder (tunnels to the devnet gRPC through the SOCKS5 proxy).
const String grpcForwardHost = '127.0.0.1';
const int grpcForwardPort = 19000;
const String grpcAuthority = 'fullnode.devnet.sui.io';

/// 1 SUI = 1e9 mist.
final BigInt oneSui = BigInt.from(1000000000);

/// Sent per transfer (0.01 SUI).
final BigInt transferAmount = oneSui ~/ BigInt.from(100);

/// A gRPC channel provider bound to the local forwarder (with the devnet TLS
/// authority so SNI/verification stay correct).
class _GrpcChannel extends Client {
  _GrpcChannel(super.channel);
  Future<List<int>> doGrpcRequest(
    SuiGrpcRequestDetails params, {
    Duration? timeout,
  }) {
    return $createUnaryCall(
      ClientMethod<SuiGrpcRequestDetails, List<int>>(
        params.method(),
        (value) => value.toBuffer().toList(),
        (value) => value,
      ),
      params,
      options: CallOptions(timeout: timeout ?? const Duration(seconds: 30)),
    );
  }
}

class _GrpcProvider with SuiServiceProvider {
  _GrpcProvider(this.grpc);
  final _GrpcChannel grpc;
  @override
  Future<BaseServiceResponse> doRequest(
    BaseServiceRequestParams params, {
    Duration? timeout,
  }) {
    throw UnsupportedError('JSON-RPC is deprecated on devnet; use gRPC.');
  }

  @override
  Future<List<int>> doGrpcRequest(
    BaseGRPCServiceRequestParams params, {
    Duration? timeout,
  }) {
    return grpc.doGrpcRequest(params as SuiGrpcRequestDetails,
        timeout: timeout);
  }
}

/// REST transport for the devnet faucet.
class _RestService with SuiFaucetService {
  _RestService({http.Client? client}) : _client = client ?? http.Client();
  final http.Client _client;

  @override
  Future<Map<String, dynamic>> postFaucetRequest(Uri url, Map body) async {
    final res = await _client.post(
      url,
      headers: const {'Content-Type': 'application/json'},
      body: StringUtils.fromJson(body.cast<String, dynamic>()),
    );
    if (res.statusCode != 200) {
      throw StateError('faucet request failed (${res.statusCode}).');
    }
    return StringUtils.toJson<Map<String, dynamic>>(res.body);
  }
}

final ClientChannel _channel = ClientChannel(
  grpcForwardHost,
  port: grpcForwardPort,
  options: const ChannelOptions(
    credentials: ChannelCredentials.secure(authority: grpcAuthority),
  ),
);
final DefaultSuiQuickClient quick = DefaultSuiQuickClient(
  provider: SuiProvider(_GrpcProvider(_GrpcChannel(_channel))),
);
final SuiFaucetClient _faucet = SuiFaucetClient.devnet(
  provider: SuiFaucetProvider(_RestService()),
);

/// A DKLs23 secp256r1 quorum as a Sui account.
///
/// Sui's secp256r1 signing convention is `sha256(blake2b256(payload))`
/// (the private key hashes the digest with SHA-256, and the transaction
/// digest itself is blake2b256 of the intent-wrapped payload). The DKLs23
/// signer signs a pre-hashed 32-byte digest, so the quorum does the two
/// hashes itself and the envelope carries the raw 64-byte `r || s`.
class Dkls23SuiR1Account
    extends SuiAccount<SuiSecp256r1AccountPublicKey, SuiSecp256r1Signature> {
  Dkls23SuiR1Account(this.key, {List<int>? subset})
      : _subset = subset == null ? null : List<int>.unmodifiable(subset),
        super(
          publicKey: SuiSecp256r1AccountPublicKey(
            SuiSecp256r1PublicKey.fromBytes(key.publicKey.aggKey.toBytes()),
          ),
          scheme: SuiSigningScheme.secp256r1,
        );

  final Dkls23Secp256r1PrivateKey key;

  /// Signing subset; `null` uses the key's default (first `t` shares).
  final List<int>? _subset;

  /// The quorum's group address.
  SuiAddress address() => publicKey.toAddress();

  /// The quorum's group public key (33-byte compressed P-256 point).
  List<int> groupKey() => key.publicKey.aggKey.toBytes();

  SuiSecp256r1Signature _sign(List<int> digest) {
    final sig = Dkls23Secp256r1Signer(
      key,
    ).sign(digest, hashMessage: false, subset: _subset).signature;
    return SuiSecp256r1Signature(
      publicKey: publicKey.publicKey,
      signature: SuiGenericSignature(
        signature: sig.toBytes(),
        algorithm: SuiKeyAlgorithm.secp256r1,
      ),
    );
  }

  @override
  SuiSecp256r1Signature signTransaction(
    List<int> txbytes, {
    bool hashDigest = true,
  }) {
    final blake = hashDigest ? QuickCrypto.blake2b256Hash(txbytes) : txbytes;
    // Sui's secp256r1 convention: sha256(blake2b256(payload)).
    return _sign(QuickCrypto.sha256Hash(blake));
  }

  @override
  SuiSecp256r1Signature signPersonalMessage(List<int> message) {
    return _sign(
      QuickCrypto.sha256Hash(
        SuiCryptoUtils.generatePersonalMessageDigest(message),
      ),
    );
  }

  @override
  void dispose() {}
}

/// Generates a deterministic DKLs23 secp256r1 quorum for [label].
///
/// [threshold] `null` gives the full quorum (`t == n`); a value selects a
/// proper threshold, which requires the DKG.
Dkls23SuiR1Account buildQuorum({
  required String label,
  required int parties,
  int? threshold,
}) {
  final sid = QuickCrypto.keccak256Hash(
    StringUtils.encode('onchain/sui/dkls23/$label'),
  ).toList();
  final seeds = [
    for (var i = 0; i < parties; i++)
      QuickCrypto.keccak256Hash([
        ...StringUtils.encode('onchain/sui/dkls23/$label/seed'),
        i,
      ]).toList(),
  ].expand((e) => e).toList();
  final key = Dkls23Secp256r1PrivateKey.generate(
    sid: sid,
    n: parties,
    seeds: seeds,
    threshold: threshold,
  );
  return Dkls23SuiR1Account(key);
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

/// Funds [address] from the devnet faucet and waits for a coin.
Future<void> fund(SuiAddress address) async {
  final existing = await quick.getBalance(
    address,
    coinType: SuiTransactionConst.suiTypeArgs,
  );
  if ((existing.balance ?? BigInt.zero) > BigInt.zero) return;
  await _faucet.requestSui(address);
  for (var i = 0; i < 40; i++) {
    final coins = await quick
        .watchAccountCoins(address, coinType: SuiTransactionConst.suiTypeArgs)
        .timeout(const Duration(seconds: 10))
        .first
        .catchError((_) => <SuiObject>[]);
    if (coins.isNotEmpty) return;
    await Future.delayed(const Duration(seconds: 2));
  }
  throw StateError('account ${address.address} not funded after faucet');
}

/// 1. Key shape: the group key is a Sui address and the signature verifies.
void exampleKeyShape() {
  print('\n== 1. DKLs23 secp256r1 key shape ==');
  final q = buildQuorum(label: 'shape', parties: 3, threshold: 2);
  print(
      '  quorum:          ${q.key.publicKey.threshold}-of-${q.key.publicKey.n}');
  print('  group key:       ${q.groupKey().toBytes.toHex()}');
  print('  sui address:     ${q.address().address}');

  final payload = StringUtils.encode('dkls23-sui-r1');
  final sig = q.signPersonalMessage(payload).signature.signature;
  // `signPersonalMessage` hashes `sha256(blake2b256(payload))` internally.
  final digest = QuickCrypto.sha256Hash(
    SuiCryptoUtils.generatePersonalMessageDigest(payload),
  );
  final ok = Secp256r1Verifier(
    Secp256r1PublicKey.fromBytes(q.groupKey()),
  ).verify(digest, IECDSASignature.fromBytes(sig), hashMessage: false);
  print('  verify:          $ok');
  if (!ok) throw StateError('group key failed to verify the signature');
}

/// 2. Backend parity: Rust and Dart both produce valid signatures.
void exampleBackends() {
  print('\n== 2. Backend parity (rust / dart) ==');
  final q = buildQuorum(label: 'parity', parties: 2, threshold: 2);
  final payload = StringUtils.encode('backend-parity');
  final digest = QuickCrypto.sha256Hash(QuickCrypto.blake2b256Hash(payload));
  final verifier = Secp256r1Verifier(
    Secp256r1PublicKey.fromBytes(q.groupKey()),
  );

  for (final backend in ['rust', 'dart']) {
    useBackend(backend);
    final sig = Dkls23Secp256r1Signer(q.key)
        .sign(digest, hashMessage: false)
        .signature
        .toBytes();
    final ok = verifier.verify(
      digest,
      IECDSASignature.fromBytes(sig),
      hashMessage: false,
    );
    print(
        '  $backend: verify=$ok  sig=${sig.sublist(0, 12).toBytes.toHex()}...');
    if (!ok) throw StateError('$backend backend produced an invalid signature');
  }
  useBackend('rust');
}

/// 3. A real devnet transfer from the quorum address.
Future<void> exampleTransfer({
  required String label,
  required int parties,
  int? threshold,
  List<int>? subset,
}) async {
  final q = buildQuorum(label: label, parties: parties, threshold: threshold);
  final t = q.key.publicKey.threshold;
  final n = q.key.publicKey.n;
  final scheme = threshold == null ? 'additive' : 'dkg';
  print('\n== 3. Transfer ($scheme $t-of-$n) ==');
  print('  from:            ${q.address().address}');

  await fund(q.address());
  final before = await quick.getBalance(
    q.address(),
    coinType: SuiTransactionConst.suiTypeArgs,
  );

  final recipient = SuiEd25519Account(
    SuiED25519PrivateKey.fromBytes(
      QuickCrypto.keccak256Hash(StringUtils.encode('sui/recipient/$label'))
          .toList(),
    ),
  ).toAddress();

  final builder = SuiTransactionBuilder(client: quick);
  builder.transferSui(
    recipient: builder.pureAddress(recipient),
    amount: transferAmount,
  );
  await builder.fillTransaction(
    params: SuiFillTransactionParams(sender: q.address()),
  );

  final signer = subset == null ? q : Dkls23SuiR1Account(q.key, subset: subset);
  await builder.signTransaction(
    params: SuiSignTransactionParams(signers: [signer]),
  );

  final result = await builder.submit();
  final after = await quick.getBalance(
    q.address(),
    coinType: SuiTransactionConst.suiTypeArgs,
  );
  print('  to:              ${recipient.address}');
  print('  amount:          $transferAmount mist');
  print('  subset:          ${subset ?? 'default (first $t)'}');
  print('  txid:            ${result.digest}');
  print(
      '  spent:           ${(before.balance ?? BigInt.zero) - (after.balance ?? BigInt.zero)} mist');
  print('  explorer:        https://suiscan.xyz/devnet/tx/${result.digest}');
}

/// 4. Devnet validates the scheme: the same bytes as secp256k1 are rejected.
Future<void> exampleSchemeIsEnforced() async {
  print('\n== 4. Devnet validates the secp256r1 scheme ==');
  final q = buildQuorum(label: 'negative', parties: 2, threshold: 2);
  await fund(q.address());
  final recipient = SuiEd25519Account(
    SuiED25519PrivateKey.fromBytes(List<int>.filled(32, 3)),
  ).toAddress();

  final builder = SuiTransactionBuilder(client: quick);
  builder.transferSui(
    recipient: builder.pureAddress(recipient),
    amount: transferAmount,
  );
  await builder.fillTransaction(
    params: SuiFillTransactionParams(sender: q.address()),
  );
  final signed = await builder.signTransaction(
    params: SuiSignTransactionParams(signers: [q]),
  );
  final envelope = SuiBaseSignature.deserialize(
    signed.signedTransaction.signatures.first.toList(),
  ).cast<SuiSecp256r1Signature>();

  // Same r/s, but re-labelled as secp256k1 with an unrelated public key.
  final wrong = SuiSecp256k1Signature(
    publicKey: SuiSecp256k1PublicKey.fromBytes(
      SuiSecp256k1PrivateKey.fromBytes(List<int>.filled(32, 7))
          .publicKey
          .toBytes(),
    ),
    signature: SuiGenericSignature(
      signature: envelope.signature.signature,
      algorithm: SuiKeyAlgorithm.secp256k1,
    ),
  );

  var rejected = false;
  try {
    await quick.executeTransaction(
      txBytes: signed.txBytes,
      signatures: [wrong],
    );
  } catch (e) {
    rejected = e.toString().contains('Invalid user signature');
  }
  print('  mislabelled sig rejected: $rejected');
  if (!rejected) {
    throw StateError('devnet accepted a mislabelled signature');
  }
}

Future<void> main() async {
  if (Platform.environment['BU_NATIVE_LIB'] != null) {
    useBackend('rust');
    print('rust backend: enabled');
  } else {
    print('rust backend: default (no BU_NATIVE_LIB)');
  }
  print(
      'Sui Devnet (DKLs23 secp256r1, QuickClient via $grpcForwardHost:$grpcForwardPort)');
  print('  chain: ${await quick.getChainId()}');
  print('  gas:   ${await quick.getGasPrice()}');

  // 1. group key -> Sui address, signature verifies
  exampleKeyShape();

  // 2. rust vs dart parity
  exampleBackends();

  // 3a. additive full quorum (t == n)
  await exampleTransfer(label: 'additive', parties: 3, threshold: null);

  // 3b. real DKG 2-of-3, signed by a proper subset
  await exampleTransfer(
    label: 'threshold',
    parties: 3,
    threshold: 2,
    subset: [0, 1],
  );

  // 4. devnet enforces the scheme
  await exampleSchemeIsEnforced();

  print('\nAll Sui DKLs23 secp256r1 examples completed.');
  await _channel.shutdown();
}
