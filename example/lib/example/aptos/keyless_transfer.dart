// Live keyless transfer on devnet using the keyless_login.dart JWT (needs BU_NATIVE_LIB).
library;

import 'dart:convert';
import 'dart:io';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:http/http.dart' as http;
import 'package:on_chain/on_chain.dart';

const String fullnodeUrl = 'https://fullnode.devnet.aptoslabs.com/v1';
const String graphqlUrl = 'https://api.devnet.aptoslabs.com/v1/graphql';
const String faucetUrl = 'https://faucet.devnet.aptoslabs.com/mint';

class AptosHttpService with AptosServiceProvider {
  AptosHttpService(this.url);
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

final AptosProvider provider = AptosProvider(AptosHttpService(fullnodeUrl));
final AptosProvider graphQl = AptosProvider(AptosHttpService(graphqlUrl));
final DefaultAptosQuickClient quick = DefaultAptosQuickClient(
  fullNodeProvider: provider,
  graphQlProvider: graphQl,
);
final AptosQuickApi api = AptosQuickApi(provider: provider);

Future<void> _fund(AptosAddress address, {int times = 5}) async {
  for (var i = 0; i < times; i++) {
    final uri = Uri.parse(
      '$faucetUrl?amount=100000000&address=${address.address}',
    );
    final r = await http.post(uri);
    if (r.statusCode != 200) {
      throw StateError('faucet failed: ${r.statusCode} ${r.body}');
    }
  }
  for (var i = 0; i < 40; i++) {
    if (await api.accountIsActive(address)) return;
    await Future.delayed(const Duration(seconds: 2));
  }
  throw StateError('account not active after funding');
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

Future<void> main() async {
  final libPath = Platform.environment['BU_NATIVE_LIB'];
  if (libPath == null) {
    print('backend not exist! set BU_NATIVE_LIB.');
    return;
  }
  blockchainUtils.setRustApi(libraryPath: libPath);
  print('rust backend: $libPath');

  // Resolve JWT: env first, else newest aptos_jwt_*.txt in the working directory
  String? jwt = Platform.environment['APTOS_KEYLESS_JWT'];
  jwt ??= _latestFile('aptos_jwt_', '.txt');
  if (jwt != null && jwt.length < 500 && File(jwt).existsSync()) {
    jwt = File(jwt).readAsStringSync().trim();
  }
  if (jwt == null || jwt.isEmpty) {
    stderr.writeln(
        'Missing JWT. Run keyless_login.dart first, or set APTOS_KEYLESS_JWT.');
    exit(2);
  }

  // Resolve ephemeral: must be the SAME one used for the login nonce.
  final epkPath = Platform.environment['APTOS_EPHEMERAL_FILE'] ??
      _latestFile('aptos_ephemeral_', '.json');
  if (epkPath == null || !File(epkPath).existsSync()) {
    stderr.writeln(
        'Missing ephemeral file. Run keyless_login.dart first, or set APTOS_EPHEMERAL_FILE.');
    exit(2);
  }
  final epkJson = StringUtils.toJson(File(epkPath).readAsStringSync())
      as Map<String, dynamic>;
  final ephemeral = AptosEphemeralKeyPair(
    privateKey: ED25519PrivateKey.fromBytes(
      BytesUtils.fromHexString(epkJson['privateKey'] as String),
    ),
    expiryDateSecs: (epkJson['expiryDateSecs'] as num).toInt(),
    blinder: BytesUtils.fromHexString(epkJson['blinder'] as String),
  );
  print('ephemeral nonce: ${ephemeral.nonce}');
  print('jwt nonce match: ${_jwtNonce(jwt) == ephemeral.nonce}');
  if (_jwtNonce(jwt) != ephemeral.nonce) {
    stderr.writeln(
        'JWT nonce != ephemeral nonce. Re-login with this ephemeral nonce.');
    exit(3);
  }
  if (ephemeral.isExpired()) {
    stderr.writeln('Ephemeral expired. Re-run keyless_login.dart.');
    exit(3);
  }

  final pepperUrl = Platform.environment['APTOS_KEYLESS_PEPPER'] ??
      'https://api.devnet.aptoslabs.com/keyless/pepper/v0/fetch';
  final proverUrl = Platform.environment['APTOS_KEYLESS_PROVER'] ??
      'https://api.devnet.aptoslabs.com/keyless/prover/v0/prove';
  final session = AptosKeylessSession(
    pepperService: _HttpPepperService(pepperUrl),
    proverService: _HttpProverService(proverUrl),
  );
  final account = await session.deriveAccount(jwt: jwt, ephemeral: ephemeral);
  final sender = account.toAddress();
  print('keyless address: ${sender.address}');
  await _fund(sender);
  print('balance: ${await quick.getAccountBalance(sender)} octas');

  final recipient = AptosAddress(
    '0x${List<int>.generate(32, (_) => QuickCrypto.generateRandom(length: 1).single).map((e) => e.toRadixString(16).padLeft(2, "0")).join()}',
  );
  final tx = await api.createTransferTransaction(
    sender: sender,
    transferParams: AptosTransferParams.apt(
      apt: BigInt.from(1000),
      destination: recipient,
      allowCreate: true,
    ),
    params: AptosApiBuildTransactionParams(maxGasAmount: BigInt.from(100000)),
  );
  final signed = api.signTransaction(account: account, transaction: tx);
  final pending = await api.submitTransaction(signed);
  await quick.trackTransaction(
    transactionId: pending.hash,
    periodicTimeOut: const Duration(seconds: 2),
  );
  print('txid: ${pending.hash}');
  print('recipient balance: ${await quick.getAccountBalance(recipient)} octas');
  print(
      'explorer: https://explorer.aptoslabs.com/txn/${pending.hash}?network=devnet');
}

String? _latestFile(String prefix, String suffix) {
  final files = Directory.current
      .listSync()
      .whereType<File>()
      .where((f) => f.path.contains(prefix) && f.path.endsWith(suffix))
      .toList();
  if (files.isEmpty) return null;
  files.sort((a, b) => b.statSync().modified.compareTo(a.statSync().modified));
  return files.first.path;
}

class _HttpPepperService implements AptosPepperService {
  _HttpPepperService(this.url);
  final String url;
  final http.Client _client = http.Client();
  @override
  Future<List<int>> fetchPepper({
    required String jwt,
    required AptosEphemeralKeyPair ephemeral,
    String uidKey = 'sub',
    String? derivationPath,
  }) async {
    final body = AptosKeylessServiceUtils.buildPepperFetchBody(
      jwt: jwt,
      ephemeral: ephemeral,
      uidKey: uidKey,
      derivationPath: derivationPath,
    );
    final r = await _client.post(
      Uri.parse(url),
      headers: {'content-type': 'application/json'},
      body: StringUtils.fromJson(body),
    );
    if (r.statusCode != 200) {
      throw StateError('pepper ${r.statusCode}: ${r.body}');
    }
    return AptosKeylessServiceUtils.parsePepperFetchResponse(
        StringUtils.toJson(r.body) as Map<String, dynamic>);
  }
}

class _HttpProverService implements AptosProverService {
  _HttpProverService(this.url);
  final String url;
  final http.Client _client = http.Client();
  @override
  Future<AptosZeroKnowledgeSig> fetchProof({
    required String jwt,
    required AptosEphemeralKeyPair ephemeral,
    required List<int> pepper,
    String uidKey = 'sub',
  }) async {
    final body = AptosKeylessServiceUtils.buildProofRequestBody(
      jwt: jwt,
      ephemeral: ephemeral,
      pepper: pepper,
      expHorizonSecs: 3600,
      uidKey: uidKey,
    );
    final r = await _client.post(
      Uri.parse(url),
      headers: {'content-type': 'application/json'},
      body: StringUtils.fromJson(body),
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
