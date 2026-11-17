/// Aptos devnet examples (transfer, encrypted transfer, keyless, quick-client tour).
library;

import 'dart:io';
import 'dart:math';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:http/http.dart' as http;
import 'package:on_chain/on_chain.dart';

/// Devnet endpoints.
const String fullnodeUrl = 'https://fullnode.devnet.aptoslabs.com/v1';
const String graphqlUrl = 'https://api.devnet.aptoslabs.com/v1/graphql';
const String faucetUrl = 'https://faucet.devnet.aptoslabs.com/mint';

/// A tiny HTTP provider for the Aptos REST/GraphQL API.
class AptosHttpService with AptosServiceProvider {
  AptosHttpService(
    this.url, {
    http.Client? client,
    this.defaultTimeOut = const Duration(seconds: 30),
  }) : client = client ?? http.Client();
  final String url;
  final http.Client client;
  final Duration defaultTimeOut;
  @override
  Future<AptosServiceResponse> doRequest(
    AptosRequestDetails params, {
    Duration? timeout,
  }) async {
    final uri = params.encodeUrl(url);
    final t = timeout ?? defaultTimeOut;
    if (params.requestMethod.isPost) {
      final r = await client
          .post(uri, headers: params.headers, body: params.encodeBody())
          .timeout(t);
      return params.toResponse(r.bodyBytes, statusCode: r.statusCode);
    }
    final r = await client.get(uri, headers: params.headers).timeout(t);
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

/// Funds [address] from the devnet faucet (the faucet caps at 1 APT/request).
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

/// 1. Simple APT transfer.
Future<AptosAddress> exampleSimpleTransfer() async {
  print('\n== 1. Simple transfer ==');
  final account = AptosEd25519Account(
    AptosED25519PrivateKey.fromBytes(QuickCrypto.generateRandom(length: 32)),
  );
  final sender = account.toAddress();
  print('  sender: ${sender.address}');
  await _fund(sender);
  print('  balance: ${await quick.getAccountBalance(sender)} octas');

  final recipient = _randomAddress();
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
  print('  txid: ${pending.hash}');
  print('  recipient: ${await quick.getAccountBalance(recipient)} octas');
  print('  explorer: https://explorer.aptoslabs.com/txn/${pending.hash}'
      '?network=devnet');
  return recipient;
}

/// 2. AIP-144 encrypted (mempool-private) transfer.
Future<void> exampleEncryptedTransfer() async {
  print('\n== 2. Encrypted transfer ==');
  final account = AptosEd25519Account(
    AptosED25519PrivateKey.fromBytes(QuickCrypto.generateRandom(length: 32)),
  );
  final sender = account.toAddress();
  print('  sender: ${sender.address}');
  await _fund(sender);

  final encryption = await api.getBatchEncryptionKey();
  print('  encryption epoch: ${encryption.epoch}');

  // Self-transfer of 1 octo through the encrypted mempool.
  final raw = await api.buildEncryptedTransfer(
    sender: sender,
    transferParams: AptosTransferParams.apt(
      apt: BigInt.one,
      destination: sender,
    ),
    params: AptosApiBuildTransactionParams(maxGasAmount: BigInt.from(100000)),
  );
  final signed = api.signTransaction(account: account, transaction: raw);
  final pending = await api.submitTransaction(signed);
  await quick.trackTransaction(
    transactionId: pending.hash,
    periodicTimeOut: const Duration(seconds: 2),
  );
  print('  txid: ${pending.hash}');
  print('  status: ${await quick.transactionStatus(pending.hash)}');
  print('  explorer: https://explorer.aptoslabs.com/txn/${pending.hash}'
      '?network=devnet');
}

/// 3. Keyless (AIP-61).
///
/// A live keyless flow needs a real OIDC JWT whose `nonce` matches the
/// ephemeral keypair used for pepper/prove._nonce must be generated first,
/// then the IdP login mints the JWT with that nonce.
/// Set `APTOS_KEYLESS_JWT` (compact JWT) plus `APTOS_EPHEMERAL_FILE` (JSON with
/// `privateKey`/`expiryDateSecs`/`blinder`, as written by `keyless_login.dart`)
/// to run it; otherwise the account
/// address is derived from a fixed pepper so the code path is visible.
///
/// Easiest live run (prints a Google link, captures the JWT, funds, transfers):
///   dart run lib/example/aptos/keyless_login.dart
Future<void> exampleKeyless() async {
  print('\n== 3. Keyless ==');
  final jwt = Platform.environment['APTOS_KEYLESS_JWT'];
  if (jwt == null || jwt.isEmpty) {
    final pubkey = AptosKeylessAccountPublicKey(
      iss: 'https://accounts.google.com',
      uidKey: 'sub',
      uidVal: '123456789',
      aud: 'my-dapp',
      pepper: List<int>.filled(31, 3),
    );
    print('  demo keyless address: ${pubkey.toAddress().address}');
    print('  (for live: run keyless_login.dart, or set APTOS_KEYLESS_JWT +');
    print(
        '   APTOS_EPHEMERAL_FILE (same login) + optional APTOS_KEYLESS_PEPPER/PROVER)');
    return;
  }
  final epkPath = Platform.environment['APTOS_EPHEMERAL_FILE'];
  if (epkPath == null || !File(epkPath).existsSync()) {
    print('  APTOS_KEYLESS_JWT set but no APTOS_EPHEMERAL_FILE: the JWT nonce');
    print(
        '  must match the ephemeral keypair, so a fresh keypair cannot work.');
    print('  Run keyless_login.dart for the interactive flow.');
    return;
  }

  // The pepper/prover services expose the actions at /fetch and /prove; the
  // base /v0 URL only returns 404 for POST.
  // NOTE: do NOT send derivation_path (devnet/testnet pepper 500s on it).
  final pepperUrl = Platform.environment['APTOS_KEYLESS_PEPPER'] ??
      'https://api.devnet.aptoslabs.com/keyless/pepper/v0/fetch';
  final proverUrl = Platform.environment['APTOS_KEYLESS_PROVER'] ??
      'https://api.devnet.aptoslabs.com/keyless/prover/v0/prove';
  final session = AptosKeylessSession(
    pepperService: _HttpPepperService(pepperUrl),
    proverService: _HttpProverService(proverUrl),
  );
  final epkJson = StringUtils.toJson(File(epkPath).readAsStringSync())
      as Map<String, dynamic>;
  final ephemeral = AptosEphemeralKeyPair(
    privateKey: ED25519PrivateKey.fromBytes(
      BytesUtils.fromHexString(epkJson['privateKey'] as String),
    ),
    expiryDateSecs: (epkJson['expiryDateSecs'] as num).toInt(),
    blinder: BytesUtils.fromHexString(epkJson['blinder'] as String),
  );
  final account = await session.deriveAccount(jwt: jwt, ephemeral: ephemeral);
  final sender = account.toAddress();
  print('  keyless address: ${sender.address}');
  await _fund(sender);
  print('  balance: ${await quick.getAccountBalance(sender)} octas');

  final recipient = _randomAddress();
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
  print('  txid: ${pending.hash}');
  print('  recipient: ${await quick.getAccountBalance(recipient)} octas');
}

/// 4. Quick-client debug tour: exercise every `AptosQuickClient` method.
Future<void> exampleQuickClientTour(AptosAddress account) async {
  print('\n== 4. Quick-client debug tour ==');

  print('  getChainId:        ${await quick.getChainId()}');
  print('  getLedgerInfo:     ${(await quick.getLedgerInfo()).chainId}');
  print('  getBlockHeight:    ${await quick.getBlockHeight()}');
  print('  getGasUnitPrice:   ${await quick.getGasUnitPrice()}');
  print('  getAccountBalance: ${await quick.getAccountBalance(account)}');
  print('  getAccountSequence:${await quick.getAccountSequence(account)}');
  print(
      '  getCoinBalance:    ${await quick.getCoinBalance(owner: account, assetType: AptosConstants.aptosCoinAssetType)}');

  // Fungible asset metadata + NFT object lookup.
  final meta = await quick.getFungibleAssetMetadata(
    AptosConstants.aptosCoinAssetType,
  );
  print(
      '  fungibleAssetMeta: ${meta == null ? 'null' : '${meta.symbol} (${meta.decimals})'}');
  print(
      '  nftObjectAddress:  ${await quick.getNftObjectAddress(owner: account, tokenDataId: '0xdead')}');

  // Delegation reads (empty for a fresh account, still exercises the method).
  print('  delegatorPools:    ${await quick.getDelegatorPools(account)}');
  print(
      '  chainDelegations:  ${(await quick.getChainDelegations(account)).length}');
  print(
      '  topDelegations:    ${(await quick.getTopDelegationPools(limit: 3)).length}');
  print(
      '  allDelegations:    ${(await quick.getAllDelegationPools(limit: 3)).length}');

  // Streaming methods: read the first page only (empty -> 0).
  print(
      '  tokenBalances:     ${await _firstPage(quick.watchAccountTokenBalances(address: account))}');
  print(
      '  fungibleTokens:    ${await _firstPage(quick.watchAccountFungibleTokens(account))}');
  print(
      '  nfts:              ${await _firstPage(quick.watchAccountNFTs(account, limit: 5))}');

  // Build + simulate + submit + track a real transfer.
  final account2 = AptosEd25519Account(
    AptosED25519PrivateKey.fromBytes(QuickCrypto.generateRandom(length: 32)),
  );
  await _fund(account2.toAddress(), times: 2);
  final built = await quick.buildTransaction(
    sender: account2.toAddress(),
    entry: quick.fungibleAssetTransferEntry(
      assetType: _randomAddress(),
      recipient: account2.toAddress(),
      amount: BigInt.one,
    ),
    maxGasAmount: BigInt.from(100000),
  );
  print(
      '  buildTransaction:  seq=${built.sequenceNumber} gas=${built.gasUnitPrice}');

  final raw2 = await api.createTransferTransaction(
    sender: account2.toAddress(),
    transferParams: AptosTransferParams.apt(
      apt: BigInt.one,
      destination: account2.toAddress(),
      allowCreate: true,
    ),
    params: AptosApiBuildTransactionParams(maxGasAmount: BigInt.from(100000)),
  );
  print(
      '  transferTx:        seq=${raw2.sequenceNumber} gas=${raw2.gasUnitPrice}');

  final simAuth = AptosTransactionAuthenticatorEd25519(
    publicKey: account2.privateKey.publicKey,
    signature: AptosEd25519Signature(List<int>.filled(64, 0)),
  );
  final simulated = await quick.simulateTransaction(
    rawTransaction: raw2,
    authenticator: simAuth,
  );
  print('  simulate:          success=${simulated.success}');

  final signed = api.signTransaction(account: account2, transaction: raw2);
  final submitted = await quick.submitTransaction(signed);
  print(
      '  submit:            ${submitted.hash} submitted=${submitted.submitted}');
  await quick.trackTransaction(
    transactionId: submitted.hash,
    periodicTimeOut: const Duration(seconds: 2),
  );
  print(
      '  status:            ${await quick.transactionStatus(submitted.hash)}');

  // Entry builders (shape-only).
  final asset = _randomAddress();
  quick.fungibleAssetTransferEntry(
    assetType: asset,
    recipient: account2.toAddress(),
    amount: BigInt.one,
  );
  quick.objectTransferEntry(object: account, recipient: account);
  quick.delegationStakeEntry(pool: account, amount: BigInt.one);
  quick.delegationUnstakeEntry(pool: account, amount: BigInt.one);
  quick.delegationWithdrawEntry(pool: account, amount: BigInt.one);
  print('  entry builders:    ok');
}

/// A random 32-byte address.
AptosAddress _randomAddress() => AptosAddress(
      '0x${List<int>.generate(32, (_) => Random.secure().nextInt(256)).map((e) => e.toRadixString(16).padLeft(2, '0')).join()}',
    );

/// Reads the first page length of a paginated stream (0 if empty, -1 on timeout).
Future<int> _firstPage(Stream<List<dynamic>> stream) async {
  try {
    final pages =
        await stream.timeout(const Duration(seconds: 15)).take(1).toList();
    return pages.isEmpty ? 0 : pages.first.length;
  } catch (_) {
    return -1;
  }
}

Future<void> main() async {
  // Poseidon (keyless address derivation) needs the native backend.
  final libPath = Platform.environment['BU_NATIVE_LIB'];
  if (libPath != null) {
    blockchainUtils.setRustApi(libraryPath: libPath);
    print('rust backend: enabled');
  } else {
    print(
        'rust backend: disabled (keyless live derivation needs BU_NATIVE_LIB)');
  }

  final ledger = await quick.getLedgerInfo();
  print('Aptos Devnet (QuickClient)');
  print('  fullnode: $fullnodeUrl');
  print('  chain:    ${ledger.chainId} block: ${ledger.blockHeight}');

  await exampleSimpleTransfer();
  await exampleEncryptedTransfer();
  await exampleKeyless();

  // Quick-client tour against the funded keyless-or-fresh account.
  final tourAccount = AptosEd25519Account(
    AptosED25519PrivateKey.fromBytes(QuickCrypto.generateRandom(length: 32)),
  );
  await _fund(tourAccount.toAddress(), times: 2);
  await exampleQuickClientTour(tourAccount.toAddress());

  print('\nAll Aptos examples completed.');
}

/// HTTP pepper service (AIP-61) — POSTs the JWT + ephemeral material.
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

/// HTTP prover service (AIP-61) — POSTs the JWT + ephemeral + pepper.
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
