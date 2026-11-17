/// Sui devnet examples through `DefaultSuiQuickClient` (transfer, zkLogin keyless, coin publish).
/// Needs the TCP forwarder on 127.0.0.1:19000 (devnet gRPC via the 10808 proxy); zkLogin needs BU_NATIVE_LIB, real-Google needs GOOGLE_CLIENT_ID.
library;

import 'dart:async';
import 'dart:convert';
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
final BigInt _oneSui = BigInt.from(1000000000);

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
    return grpc.doGrpcRequest(params as SuiGrpcRequestDetails, timeout: timeout);
  }
}

/// REST transport for the faucet / prover / JWKS / test issuer.
class _RestService
    with
        SuiFaucetService,
        SuiProverService,
        SuiTestIssuerService,
        SuiJwksService {
  _RestService({http.Client? client}) : _client = client ?? http.Client();
  final http.Client _client;

  Future<Map<String, dynamic>> _post(Uri url, Map<String, dynamic> body) async {
    final res = await _client.post(
      url,
      headers: const {'Content-Type': 'application/json'},
      body: StringUtils.fromJson(body),
    );
    if (res.statusCode != 200) {
      throw StateError('Request to $url failed (${res.statusCode}).');
    }
    return StringUtils.toJson<Map<String, dynamic>>(res.body);
  }

  @override
  Future<Map<String, dynamic>> postFaucetRequest(Uri url, Map body) =>
      _post(url, body.cast<String, dynamic>());
  @override
  Future<Map<String, dynamic>> postProofRequest(Uri url, Map body) =>
      _post(url, body.cast<String, dynamic>());
  @override
  Future<Map<String, dynamic>> postTestIssuerJwt(Uri url) =>
      _post(url, const {});
  @override
  Future<String> fetchJwksDocument(Uri url) async {
    final res = await _client.get(url);
    if (res.statusCode != 200) {
      throw StateError('JWKS fetch from $url failed (${res.statusCode}).');
    }
    return res.body;
  }
}

final _RestService _rest = _RestService();
final SuiZkLoginProverClient _prover = SuiZkLoginProverClient.dev(
  provider: SuiProverProvider(_rest),
);
final SuiTestIssuer _issuer = SuiTestIssuer(service: _rest);
final SuiJwksCache _jwks = SuiJwksCache(provider: SuiJwksProvider(_rest));
final SuiFaucetClient _faucet = SuiFaucetClient.devnet(
  provider: SuiFaucetProvider(_rest),
);

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

/// Funds [address] from the devnet faucet (2 SUI).
Future<void> _fund(SuiAddress address) async {
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
  throw StateError('account not funded after faucet');
}

/// Polls the gRPC `getTransaction` until the tx is executed.
///
/// The QuickClient's `trackTransaction`/`getTransactionStatus` use the
/// deprecated JSON-RPC `sui_getTransactionBlock`, which the devnet rejects —
/// see review.md. The gRPC `getTransaction` is the working path.
Future<void> _waitTx(String digest) async {
  for (var i = 0; i < 100; i++) {
    try {
      final tx = await quick.getTransaction(digest);
      final effects = tx.effects;
      if (effects != null) {
        if (effects.status?.success == true) return;
        throw StateError('tx failed: ${effects.status?.error}');
      }
    } on StateError {
      rethrow;
    } catch (_) {
      // pending: not yet executed.
    }
    await Future.delayed(const Duration(seconds: 3));
  }
  throw StateError('tx not confirmed: $digest');
}

/// 1. Simple SUI transfer.
Future<void> exampleSimpleTransfer() async {
  print('\n== 1. Simple SUI transfer ==');
  final account = SuiEd25519Account(
    SuiED25519PrivateKey.fromBytes(QuickCrypto.generateRandom(length: 32)),
  );
  final sender = account.toAddress();
  print('  sender: ${sender.address}');
  await _fund(sender);
  final senderBal = await quick.getBalance(
    sender,
    coinType: SuiTransactionConst.suiTypeArgs,
  );
  print('  balance: ${senderBal.balance} mist');

  final recipient = SuiEd25519Account(
    SuiED25519PrivateKey.fromBytes(QuickCrypto.generateRandom(length: 32)),
  ).toAddress();

  final builder = SuiTransactionBuilder(client: quick)..pureAddress(recipient);
  builder.transferSui(
    recipient: SuiArgumentInput(0),
    amount: _oneSui ~/ BigInt.from(10), // 0.1 SUI
  );
  await builder.fillTransaction(
    params: SuiFillTransactionParams(sender: sender),
  );
  await builder.signTransaction(
    params: SuiSignTransactionParams(signers: [account]),
  );
  final submitted = await builder.submit();
  print('  txid: ${submitted.digest}');
  print('  recipient: ${recipient.address}');
  print('  explorer: https://suiscan.xyz/devnet/tx/${submitted.digest}');
}

/// 2. Keyless (zkLogin) transfer.
Future<void> exampleKeyless() async {
  print('\n== 2. Keyless (zkLogin) ==');
  // Ephemeral session key + expiry + randomness.
  final ephemeral = SuiEd25519Account(
    SuiED25519PrivateKey.fromBytes(QuickCrypto.generateRandom(length: 32)),
  );
  final epoch =
      (await quick.provider.request(
        const SuiGrpcRequestMessage(SuiGetEpochRequest()),
      )).epoch?.epoch ??
          BigInt.zero;
  final maxEpoch = epoch + BigInt.from(10);
  final randomness = BigintUtils.fromBytes(
    QuickCrypto.generateRandom(length: 16),
  );

  // Nonce-bound JWT from the test issuer (stands in for OAuth).
  final nonce = SuiZkLoginUtils.generateNonce(
    ephemeralPublicKey: SuiZkLoginSession.extendedEphemeralKey(ephemeral),
    maxEpoch: maxEpoch.toInt(),
    randomness: randomness,
  );
  final jwt = await _issuer.mintJwt(
    nonce: nonce,
    iss: SuiOidcProvider.testIssuer.iss,
    sub: 'example-user-${DateTime.now().millisecondsSinceEpoch}',
  );

  final session = await SuiZkLoginSession.create(
    ephemeralAccount: ephemeral,
    jwt: jwt,
    salt: BigintUtils.fromBytes(QuickCrypto.generateRandom(length: 16)),
    maxEpoch: maxEpoch,
    jwtRandomness: randomness,
    prover: _prover,
    jwks: _jwks,
  );
  print('  keyless address: ${session.address.address}');
  await _fund(session.address);
  final keylessBal = await quick.getBalance(
    session.address,
    coinType: SuiTransactionConst.suiTypeArgs,
  );
  print('  balance: ${keylessBal.balance} mist');

  final recipient = SuiEd25519Account(
    SuiED25519PrivateKey.fromBytes(QuickCrypto.generateRandom(length: 32)),
  ).toAddress();

  final builder = SuiTransactionBuilder(client: quick)..pureAddress(recipient);
  builder.transferSui(
    recipient: SuiArgumentInput(0),
    amount: _oneSui ~/ BigInt.from(10),
  );
  await builder.fillTransaction(
    params: SuiFillTransactionParams(sender: session.address),
  );
  await builder.signTransaction(
    params: SuiSignTransactionParams(signers: [session.account]),
  );
  final submitted = await builder.submit();
  print('  txid: ${submitted.digest}');
  print('  explorer: https://suiscan.xyz/devnet/tx/${submitted.digest}');
}

/// 2b. Keyless (zkLogin) with a REAL Google JWT (like the Aptos keyless
/// flow): the nonce-bound id_token comes from the browser via the localhost
/// callback (or stdin paste), the address derives from (sub, aud, salt).
Future<void> exampleKeylessGoogle() async {
  print('\n== 2b. Keyless (zkLogin, real Google) ==');
  final clientId = Platform.environment['GOOGLE_CLIENT_ID'];
  if (clientId == null || clientId.isEmpty) {
    print('  skipped: set GOOGLE_CLIENT_ID for the real-Google zkLogin.');
    return;
  }
  final port =
      int.tryParse(Platform.environment['KEYLESS_PORT'] ?? '') ?? 8080;

  final ephemeral = SuiEd25519Account(
    SuiED25519PrivateKey.fromBytes(QuickCrypto.generateRandom(length: 32)),
  );
  final epoch =
      (await quick.provider.request(
        const SuiGrpcRequestMessage(SuiGetEpochRequest()),
      )).epoch?.epoch ??
          BigInt.zero;
  final maxEpoch = epoch + BigInt.from(10);
  final randomness = BigintUtils.fromBytes(
    QuickCrypto.generateRandom(length: 16),
  );
  final nonce = SuiZkLoginUtils.generateNonce(
    ephemeralPublicKey: SuiZkLoginSession.extendedEphemeralKey(ephemeral),
    maxEpoch: maxEpoch.toInt(),
    randomness: randomness,
  );
  final jwt = await _captureGoogleJwt(
    nonce: nonce,
    clientId: clientId,
    port: port,
  );

  final session = await SuiZkLoginSession.create(
    ephemeralAccount: ephemeral,
    jwt: jwt,
    salt: BigintUtils.fromBytes(QuickCrypto.generateRandom(length: 16)),
    maxEpoch: maxEpoch,
    jwtRandomness: randomness,
    prover: _prover,
    jwks: _jwks,
  );
  print('  keyless address: ${session.address.address}');
  await _fund(session.address);
  final keylessBal = await quick.getBalance(
    session.address,
    coinType: SuiTransactionConst.suiTypeArgs,
  );
  print('  balance: ${keylessBal.balance} mist');

  final recipient = SuiEd25519Account(
    SuiED25519PrivateKey.fromBytes(QuickCrypto.generateRandom(length: 32)),
  ).toAddress();

  final builder = SuiTransactionBuilder(client: quick)..pureAddress(recipient);
  builder.transferSui(
    recipient: SuiArgumentInput(0),
    amount: _oneSui ~/ BigInt.from(10),
  );
  await builder.fillTransaction(
    params: SuiFillTransactionParams(sender: session.address),
  );
  await builder.signTransaction(
    params: SuiSignTransactionParams(signers: [session.account]),
  );
  final submitted = await builder.submit();
  print('  txid: ${submitted.digest}');
  print('  explorer: https://suiscan.xyz/devnet/tx/${submitted.digest}');
}

/// Prints the Google login link for [nonce] and resolves the id_token JWT
/// either from the localhost redirect or from a paste on stdin.
Future<String> _captureGoogleJwt({
  required String nonce,
  required String clientId,
  required int port,
}) async {
  final envJwt = Platform.environment['SUI_KEYLESS_JWT'];
  if (envJwt != null && envJwt.isNotEmpty) return envJwt.trim();

  final completer = Completer<String>();
  HttpServer? server;
  final redirectUri = 'http://127.0.0.1:$port/callback';
  print('OPEN THIS LINK AND SIGN IN WITH GOOGLE:');
  print('https://accounts.google.com/o/oauth2/v2/auth?response_type=id_token'
      '&scope=openid%20email%20profile&nonce=${Uri.encodeComponent(nonce)}'
      '&redirect_uri=${Uri.encodeComponent(redirectUri)}'
      '&client_id=${Uri.encodeComponent(clientId)}');
  print('');
  print('Waiting on $redirectUri (5 min) — or paste JWT below.');
  try {
    server = await HttpServer.bind(InternetAddress.loopbackIPv4, port);
  } catch (e) {
    print('Could not bind :$port ($e) — paste-JWT mode only.');
  }
  if (server != null) {
    Timer(const Duration(minutes: 5), () {
      if (!completer.isCompleted) {
        completer.completeError(StateError('Timed out waiting for login.'));
      }
    });
    unawaited(_serveGoogleCallback(server, completer));
  }

  final sub = stdin
      .transform(utf8.decoder)
      .transform(const LineSplitter())
      .listen((line) {
    final t = line.trim();
    if (t.isNotEmpty && t.split('.').length == 3 && !completer.isCompleted) {
      completer.complete(t);
    }
  });
  try {
    return await completer.future;
  } finally {
    await sub.cancel();
    if (server != null) await server.close(force: true);
  }
}

Future<void> _serveGoogleCallback(
  HttpServer server,
  Completer<String> completer,
) async {
  await for (final req in server) {
    try {
      if (req.method == 'GET' && req.uri.path == '/callback') {
        req.response.headers.contentType = ContentType.html;
        req.response.write('''
<!doctype html><html><body><p>Signing you in…</p><script>
const p = new URLSearchParams(window.location.hash.substring(1));
const t = p.get('id_token'), e = p.get('error');
if (e) document.body.innerHTML = '<pre>Google error: ' + e + '</pre>';
else if (!t) document.body.innerHTML = '<pre>No id_token in fragment.</pre>';
else fetch('/token',{method:'POST',headers:{'content-type':'application/json'},body:JSON.stringify({id_token:t})})
  .then(()=>document.body.innerHTML='<h3>OK — close this tab, back to terminal.</h3>')
  .catch((x)=>document.body.innerHTML='<pre>failed: '+x+'</pre>');
</script></body></html>''');
        await req.response.close();
      } else if (req.method == 'POST' && req.uri.path == '/token') {
        final body = await utf8.decoder.bind(req).join();
        final jwt = (StringUtils.toJson(body) as Map)['id_token'] as String?;
        req.response.headers.contentType = ContentType.text;
        if (jwt == null || jwt.isEmpty) {
          req.response.statusCode = 400;
          req.response.write('missing id_token');
        } else {
          req.response.write('ok');
          if (!completer.isCompleted) completer.complete(jwt);
        }
        await req.response.close();
      } else {
        req.response.statusCode = 404;
        req.response.write('Use /callback via the login link.');
        await req.response.close();
      }
    } catch (_) {
      try {
        await req.response.close();
      } catch (_) {}
    }
  }
}

/// 3. Token: publish `my_coin`, mint MY_COIN, transfer a coin object.
Future<void> exampleTokenTransfer() async {
  print('\n== 3. Token transfer (publish my_coin, mint, transfer) ==');
  final account = SuiEd25519Account(
    SuiED25519PrivateKey.fromBytes(QuickCrypto.generateRandom(length: 32)),
  );
  final sender = account.toAddress();
  print('  sender: ${sender.address}');
  await _fund(sender);

  // 1. Publish the `my_coin` module.
  final publish = SuiTransactionBuilder(client: quick);
  final upgradeCap = publish.publish(
    modules: [BytesUtils.fromHexString(_myCoinBytecode)],
    dependencies: [SuiAddress('0x1'), SuiAddress('0x2')],
  );
  // The publish returns an UpgradeCap that must be used (transferred).
  publish.transferObjects([upgradeCap], publish.pureAddress(sender));
  await publish.fillTransaction(
    params: SuiFillTransactionParams(sender: sender),
  );
  await publish.signTransaction(
    params: SuiSignTransactionParams(signers: [account]),
  );
  final pubRes = await publish.submit();
  print('  publish txid: ${pubRes.digest}');
  await _waitTx(pubRes.digest);

  // 2. Find the treasury cap (created by `my_coin::init`).
  final objs = await quick.getOwnedObjects(owner: sender);
  final cap = objs.objects.firstWhere(
    (o) => o.objectType?.contains('TreasuryCap') ?? false,
  );
  final capType = cap.objectType!; // 0x2::coin::TreasuryCap<0x<pkg>::my_coin::MY_COIN>
  final pkg = _pkgFromType(capType);
  print('  package:      $pkg');
  print('  treasury cap: ${cap.objectId}');

  // 3. Mint MY_COIN to the primary (`my_coin::mint(cap, amount, recipient)`).
  final mint = SuiTransactionBuilder(client: quick);
  final capArg = mint.addInput(
    SuiCallArgObject(SuiObjectArgImmOrOwnedObject(_objRef(cap))),
  );
  mint.moveCall(
    package: pkg,
    module: 'my_coin',
    function: 'mint',
    arguments: [
      capArg,
      mint.pureU64(BigInt.from(1000000000)),
      mint.pureAddress(sender),
    ],
  );
  await mint.fillTransaction(params: SuiFillTransactionParams(sender: sender));
  await mint.signTransaction(
    params: SuiSignTransactionParams(signers: [account]),
  );
  final mintRes = await mint.submit();
  print('  mint txid: ${mintRes.digest}');
  await _waitTx(mintRes.digest);

  // 4. Find the freshly minted Coin<MY_COIN> object.
  final coinType = '0x2::coin::Coin<$pkg::my_coin::MY_COIN>';
  final coinPage = await quick.getOwnedObjects(
    owner: sender,
    objectType: coinType,
  );
  if (coinPage.objects.isEmpty) {
    throw StateError('minted coin not found');
  }
  final coin = coinPage.objects.first;
  print('  MY_COIN coin: ${coin.objectId}');

  // 5. Transfer the coin object to a fresh recipient.
  final recipient = SuiEd25519Account(
    SuiED25519PrivateKey.fromBytes(QuickCrypto.generateRandom(length: 32)),
  ).toAddress();
  final xfer = SuiTransactionBuilder(client: quick);
  final coinArg = xfer.addInput(
    SuiCallArgObject(SuiObjectArgImmOrOwnedObject(_objRef(coin))),
  );
  xfer.transferObjects([coinArg], xfer.pureAddress(recipient));
  await xfer.fillTransaction(params: SuiFillTransactionParams(sender: sender));
  await xfer.signTransaction(
    params: SuiSignTransactionParams(signers: [account]),
  );
  final xferRes = await xfer.submit();
  print('  transfer txid: ${xferRes.digest}');
  await _waitTx(xferRes.digest);
  print('  recipient: ${recipient.address}');
  print('  explorer: https://suiscan.xyz/devnet/tx/${xferRes.digest}');
}

/// Builds a `SuiObjectRef` from a gRPC `SuiObject`.
SuiObjectRef _objRef(SuiObject o) => SuiObjectRef(
  address: SuiAddress(o.objectId!),
  version: o.version!,
  digest: SuiObjectDigest(Base58Decoder.decode(o.digest!).toList()),
);

/// Extracts the package id from a `TreasuryCap<0x<pkg>::my_coin::MY_COIN>` type.
SuiAddress _pkgFromType(String type) {
  final m = RegExp(r'TreasuryCap<(0x[0-9a-fA-F]+)::').firstMatch(type);
  if (m == null) throw StateError('cannot parse package from $type');
  return SuiAddress(m.group(1)!);
}

/// The `my_coin` module bytecode (hex, from the Sui `my_coin` example).
const String _myCoinBytecode =
    'a11ceb0b060000000a01000c020c2403302d045d0c05697707e001be01089e036006fe030f0a8d04050c92043b000c010e02070212021302140002020001030701000002000c01000102010c01000102040c0100010405020005060700000a000100000b020100010d01050100020807080102020b0f100100030f0a01010c03100e01010c04110b0c00020403060509060d040606110208000708050004070b040108000305070805020b030108000b04010800010806010b01010900010800070900020a020a020a020b01010806070805020b040109000b03010900010b03010800010900010608050105010b040108000209000503070b0401090003070805010b02010900010b0201080004436f696e0c436f696e4d65746164617461074d595f434f494e064f7074696f6e0b5472656173757279436170095478436f6e746578740355726c04636f696e0f6372656174655f63757272656e63790b64756d6d795f6669656c6404696e6974046d696e74076d795f636f696e046e6f6e65066f7074696f6e147075626c69635f667265657a655f6f626a6563740f7075626c69635f7472616e736665720673656e646572087472616e736665720a74785f636f6e746578740375726c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000020a0208074d595f434f494e0a02010000020109010000000003120b00310607000701070138000a0138010c020c030b0238020b030b012e11073803020101000001070b000b010b0338040b0238050200';

Future<void> main() async {
  final libPath = Platform.environment['BU_NATIVE_LIB'];
  if (libPath != null) {
    blockchainUtils.setRustApi(libraryPath: libPath);
    print('rust backend: enabled');
  } else {
    print('rust backend: disabled (zkLogin needs BU_NATIVE_LIB)');
  }
  print('Sui Devnet (QuickClient via $grpcForwardHost:$grpcForwardPort)');
  print('  chain: ${await quick.getChainId()}');
  print('  gas:   ${await quick.getGasPrice()}');

  await exampleSimpleTransfer();
  await exampleKeyless();
  await exampleKeylessGoogle();
  await exampleTokenTransfer();

  print('\nAll Sui examples completed.');
  await _channel.shutdown();
}