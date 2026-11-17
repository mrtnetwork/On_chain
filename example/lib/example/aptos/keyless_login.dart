// Aptos keyless login: Google OAuth -> JWT -> devnet keyless transfer (needs BU_NATIVE_LIB + GOOGLE_CLIENT_ID).
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:http/http.dart' as http;
import 'package:on_chain/on_chain.dart';

const String fullnodeUrl = 'https://fullnode.devnet.aptoslabs.com/v1';
const String faucetUrl = 'https://faucet.devnet.aptoslabs.com/mint';

class _Svc with AptosServiceProvider {
  _Svc(this.url);
  final String url;
  final http.Client client = http.Client();
  @override
  Future<AptosServiceResponse> doRequest(
    AptosRequestDetails params, {
    Duration? timeout,
  }) async {
    final uri = params.encodeUrl(url);
    if (params.requestMethod.isPost) {
      final r = await client
          .post(uri, headers: params.headers, body: params.encodeBody())
          .timeout(timeout ?? const Duration(seconds: 30));
      return params.toResponse(r.bodyBytes, statusCode: r.statusCode);
    }
    final r = await client.get(uri, headers: params.headers).timeout(
          timeout ?? const Duration(seconds: 30),
        );
    return params.toResponse(r.bodyBytes, statusCode: r.statusCode);
  }
}

Future<void> main(List<String> args) async {
  final clientId =
      Platform.environment['GOOGLE_CLIENT_ID'] ?? _arg(args, '--client-id');
  int port = 8080;
  final portArg = _arg(args, '--port') ?? Platform.environment['KEYLESS_PORT'];
  if (portArg != null) port = int.parse(portArg);

  final libPath = Platform.environment['BU_NATIVE_LIB'];
  if (libPath == null) {
    print('backend not exist! set BU_NATIVE_LIB.');
    return;
  }
  blockchainUtils.setRustApi(libraryPath: libPath);

  // Reuse a stable ephemeral file so the printed link (foreground) and the
  // background listener share the same nonce. Override with
  // APTOS_EPHEMERAL_FILE / --ephemeral-file.
  final epkPath = Platform.environment['APTOS_EPHEMERAL_FILE'] ??
      _arg(args, '--ephemeral-file') ??
      'aptos_ephemeral_live.json';
  final ephemeral = await _loadOrCreateEphemeral(epkPath);
  print('ephemeral nonce: ${ephemeral.nonce}');

  final loginUrl = _loginUrl(
    ephemeralNonce: ephemeral.nonce,
    clientId: clientId,
    port: port,
  );
  if (loginUrl != null) {
    print('');
    print('OPEN THIS LINK AND SIGN IN WITH GOOGLE:');
    print(loginUrl);
    print('');
  }
  if (args.contains('--print-only')) return;

  final jwt = await _captureJwt(
    ephemeralNonce: ephemeral.nonce,
    clientId: clientId,
    port: port,
  );
  final claims = AptosJwtClaims.parse(jwt);
  print('iss: ${claims.iss} aud: ${claims.aud}');
  if (_jwtNonce(jwt) != ephemeral.nonce) {
    stderr.writeln(
        'JWT nonce != ephemeral nonce — login used a stale link. Re-run.');
    exit(3);
  }

  final provider = AptosProvider(_Svc(fullnodeUrl));
  final api = AptosQuickApi(provider: provider);
  final quick = DefaultAptosQuickClient(
    fullNodeProvider: provider,
    graphQlProvider:
        AptosProvider(_Svc('https://api.devnet.aptoslabs.com/v1/graphql')),
  );
  final session = AptosKeylessSession(
    pepperService: _Pepper(Platform.environment['APTOS_KEYLESS_PEPPER'] ??
        'https://api.devnet.aptoslabs.com/keyless/pepper/v0/fetch'),
    proverService: _Prover(Platform.environment['APTOS_KEYLESS_PROVER'] ??
        'https://api.devnet.aptoslabs.com/keyless/prover/v0/prove'),
  );
  // NOTE: devnet/testnet pepper /fetch 500s when derivation_path is sent
  // (verified live); omitting it yields the default derivation pepper.
  final account = await _retry(
    () => session.deriveAccount(jwt: jwt, ephemeral: ephemeral),
    attempts: 4,
    label: 'pepper+prove',
  );
  final sender = account.toAddress();
  print('keyless address: ${sender.address}');
  await _fund(sender);
  print('balance: ${await quick.getAccountBalance(sender)} octas');

  final recipient = account.toAddress(); // self-transfer, 1 octa
  final tx = await api.createTransferTransaction(
    sender: sender,
    transferParams: AptosTransferParams.apt(
      apt: BigInt.one,
      destination: recipient,
      allowCreate: true,
    ),
    params: AptosApiBuildTransactionParams(maxGasAmount: BigInt.from(100000)),
  );
  final signed = api.signTransaction(account: account, transaction: tx);

  // Local off-chain verification before submit (needs the Rust backend,
  // same as Poseidon). Catches bad proofs/keys with a named reason instead
  // of a blind on-chain INVALID_SIGNATURE. Set APTOS_SKIP_VERIFY=1 to skip.
  if ((Platform.environment['APTOS_SKIP_VERIFY'] ?? '').isEmpty) {
    final tapMessage =
        AptosKeylessMessageUtils.keylessTransactionSigningMessage(
      transaction: tx,
      proof: account.proof.proof,
    );
    final jwk = await AptosChainJwks.fetchJwk(
      provider: provider,
      iss: claims.iss,
      kid: claims.kid ?? '',
    );
    final vkRes = await provider.request(
      AptosRequestGetAccountResource(
        address: AptosAddress('0x1'),
        resourceType: '0x1::keyless_account::Groth16VerificationKey',
      ),
    );
    final cfgRes = await provider.request(
      AptosRequestGetAccountResource(
        address: AptosAddress('0x1'),
        resourceType: '0x1::keyless_account::Configuration',
      ),
    );
    final keylessConfig = AptosKeylessConfiguration.fromChainResources(
      // ignore: unnecessary_cast
      verificationKey: (vkRes.data as Map).cast<String, dynamic>(),
      // ignore: unnecessary_cast
      configuration: (cfgRes.data as Map).cast<String, dynamic>(),
    );
    final txAuth =
        signed.authenticator as AptosTransactionAuthenticatorSignleSender;
    final keylessSig = (txAuth.sender as AptosAccountAuthenticatorSingleKey)
        .signature as AptosKeylessAnySignature;
    AptosKeylessVerifyUtils.verifyKeylessSignatureLocally(
      publicKey: account.publicKey,
      signature: keylessSig.signature,
      message: tapMessage.toList(),
      jwk: jwk,
      config: keylessConfig,
    );
    print('local keyless verification: PASS');
  }

  final pending = await api.submitTransaction(signed);
  await quick.trackTransaction(
    transactionId: pending.hash,
    periodicTimeOut: const Duration(seconds: 2),
  );
  print('txid: ${pending.hash}');
  print(
      'explorer: https://explorer.aptoslabs.com/txn/${pending.hash}?network=devnet');
}

String? _loginUrl({
  required String ephemeralNonce,
  required String? clientId,
  required int port,
}) {
  if (clientId == null || clientId.isEmpty) return null;
  final redirectUri = 'http://127.0.0.1:$port/callback';
  return 'https://accounts.google.com/o/oauth2/v2/auth?response_type=id_token'
      '&scope=openid%20email%20profile'
      '&nonce=${Uri.encodeComponent(ephemeralNonce)}'
      '&redirect_uri=${Uri.encodeComponent(redirectUri)}'
      '&client_id=${Uri.encodeComponent(clientId)}';
}

/// Loads the stable ephemeral file if present and unexpired, else creates one.
Future<AptosEphemeralKeyPair> _loadOrCreateEphemeral(String path) async {
  final f = File(path);
  if (f.existsSync()) {
    try {
      final j =
          StringUtils.toJson(f.readAsStringSync()) as Map<String, dynamic>;
      final epk = AptosEphemeralKeyPair(
        privateKey: ED25519PrivateKey.fromBytes(
          BytesUtils.fromHexString(j['privateKey'] as String),
        ),
        expiryDateSecs: (j['expiryDateSecs'] as num).toInt(),
        blinder: BytesUtils.fromHexString(j['blinder'] as String),
      );
      if (!epk.isExpired()) return epk;
      print('Existing ephemeral expired — generating a new one.');
    } catch (e) {
      print('Could not reuse $path ($e) — generating a new one.');
    }
  }
  final now = DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000;
  final epk = AptosEphemeralKeyPair(
    privateKey: ED25519PrivateKey.random(),
    expiryDateSecs: now + 3600,
    blinder: QuickCrypto.generateRandom(length: 31),
  );
  await f.parent.create(recursive: true);
  await f.writeAsString(StringUtils.fromJson({
    'privateKey': BytesUtils.toHexString(epk.privateKey.toBytes()),
    'expiryDateSecs': epk.expiryDateSecs,
    'blinder': BytesUtils.toHexString(epk.blinder.toList()),
    'nonce': epk.nonce,
  }));
  print('ephemeral saved to: $path');
  return epk;
}

/// Prints the login link (if clientId known) and resolves the JWT either from
/// the localhost redirect or from a paste on stdin — whichever comes first.
Future<String> _captureJwt({
  required String ephemeralNonce,
  required String? clientId,
  required int port,
}) async {
  // Env JWT wins (headless/CI).
  final envJwt = Platform.environment['APTOS_KEYLESS_JWT'];
  if (envJwt != null && envJwt.isNotEmpty) return envJwt.trim();

  final completer = Completer<String>();
  HttpServer? server;

  final loginUrl = _loginUrl(
    ephemeralNonce: ephemeralNonce,
    clientId: clientId,
    port: port,
  );
  if (loginUrl != null) {
    final redirectUri = 'http://127.0.0.1:$port/callback';
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
      unawaited(_serve(server, completer));
    }
  } else {
    print('');
    print('No GOOGLE_CLIENT_ID — manual mode:');
    print(
        '1. Use any Google OAuth client with redirect http://127.0.0.1:$port/callback');
    print('2. Set its login URL nonce=$ephemeralNonce');
    print('3. Paste the id_token JWT below.');
  }

  // Stdin paste fallback races the browser redirect.
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
    final jwt = await completer.future;
    return jwt;
  } finally {
    await sub.cancel();
    if (server != null) await server.close(force: true);
  }
}

Future<void> _serve(HttpServer server, Completer<String> completer) async {
  await for (final req in server) {
    try {
      if (req.method == 'GET' && req.uri.path == '/callback') {
        // id_token arrives in the URL fragment (#) — the server never sees
        // it, so this page forwards it via POST /token.
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
    if (completer.isCompleted) break;
  }
}

Future<void> _fund(AptosAddress address, {int times = 5}) async {
  for (var i = 0; i < times; i++) {
    final r = await http.post(Uri.parse(
      '$faucetUrl?amount=100000000&address=${address.address}',
    ));
    if (r.statusCode != 200) {
      throw StateError('faucet: ${r.statusCode} ${r.body}');
    }
  }
  final provider = AptosProvider(_Svc(fullnodeUrl));
  final api = AptosQuickApi(provider: provider);
  for (var i = 0; i < 40; i++) {
    if (await api.accountIsActive(address)) return;
    await Future.delayed(const Duration(seconds: 2));
  }
  throw StateError('account not active after funding');
}

/// Retries transient service 500s (devnet pepper/prover flake).
Future<T> _retry<T>(
  Future<T> Function() fn, {
  required int attempts,
  required String label,
}) async {
  Object? last;
  for (var i = 1; i <= attempts; i++) {
    try {
      return await fn();
    } catch (e) {
      last = e;
      print('$label attempt $i/$attempts failed: $e');
      if (i < attempts) await Future.delayed(Duration(seconds: 2 * i));
    }
  }
  throw StateError('$label failed after $attempts attempts: $last');
}

String? _arg(List<String> args, String name) {
  final i = args.indexOf(name);
  if (i >= 0 && i + 1 < args.length) return args[i + 1];
  for (final a in args) {
    if (a.startsWith('$name=')) return a.substring(name.length + 1);
  }
  return null;
}

String? _jwtNonce(String jwt) {
  try {
    final p = jwt.split('.')[1];
    final norm = p + '=' * ((4 - p.length % 4) % 4);
    return (StringUtils.toJson(StringUtils.decode(base64Url.decode(norm)))
        as Map)['nonce'] as String?;
  } catch (_) {
    return null;
  }
}

class _Pepper implements AptosPepperService {
  _Pepper(this.url);
  final String url;
  final http.Client _c = http.Client();
  @override
  Future<List<int>> fetchPepper({
    required String jwt,
    required AptosEphemeralKeyPair ephemeral,
    String uidKey = 'sub',
    String? derivationPath,
  }) async {
    final r = await _c.post(
      Uri.parse(url),
      headers: {'content-type': 'application/json'},
      body: StringUtils.fromJson(AptosKeylessServiceUtils.buildPepperFetchBody(
        jwt: jwt,
        ephemeral: ephemeral,
        uidKey: uidKey,
        derivationPath: derivationPath,
      )),
    );
    if (r.statusCode != 200) {
      throw StateError('pepper ${r.statusCode}: ${r.body}');
    }
    return AptosKeylessServiceUtils.parsePepperFetchResponse(
        StringUtils.toJson(r.body) as Map<String, dynamic>);
  }
}

class _Prover implements AptosProverService {
  _Prover(this.url);
  final String url;
  final http.Client _c = http.Client();
  @override
  Future<AptosZeroKnowledgeSig> fetchProof({
    required String jwt,
    required AptosEphemeralKeyPair ephemeral,
    required List<int> pepper,
    String uidKey = 'sub',
  }) async {
    final r = await _c.post(
      Uri.parse(url),
      headers: {'content-type': 'application/json'},
      body: StringUtils.fromJson(AptosKeylessServiceUtils.buildProofRequestBody(
        jwt: jwt,
        ephemeral: ephemeral,
        pepper: pepper,
        expHorizonSecs: 3600,
        uidKey: uidKey,
      )),
    );
    if (r.statusCode != 200) {
      throw StateError('prover ${r.statusCode}: ${r.body}');
    }
    return AptosKeylessServiceUtils.parseProofResponse(
      StringUtils.toJson(r.body) as Map<String, dynamic>,
      expHorizonSecs: 3600,
    );
  }
}
