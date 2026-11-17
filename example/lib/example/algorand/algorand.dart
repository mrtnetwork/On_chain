/// Algorand TestNet examples (payment, atomic group, ASA lifecycle).
library;

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:http/http.dart';
import 'package:on_chain/on_chain.dart';

/// Algorand native decimals (1 ALGO = 1e6 microAlgos).
const int _algoDecimals = 6;

/// Converts a human ALGO amount (e.g. "1.5") to microAlgos.
BigInt algoToMicroAlgo(String amount) {
  final parts = amount.split('.');
  final whole = parts[0];
  final padded = (parts.length > 1 ? parts[1] : '').padRight(
    _algoDecimals,
    '0',
  );
  return BigInt.parse(whole) * BigInt.from(10).pow(_algoDecimals) +
      BigInt.parse(padded);
}

/// Formats microAlgos as a human-readable ALGO string.
String microAlgoToAlgo(BigInt micro) {
  final negative = micro.isNegative;
  final value = micro.abs();
  final whole = value ~/ BigInt.from(10).pow(_algoDecimals);
  final frac = (value % BigInt.from(10).pow(_algoDecimals))
      .toString()
      .padLeft(_algoDecimals, '0');
  return '${negative ? '-' : ''}$whole.$frac';
}

/// Minimal HTTP transport for [AlgoProvider].
/// Works with both Algod (`:4001`) and Indexer (`:8980`) style endpoints.
class AlgoHttpService with AlgoServiceProvider {
  AlgoHttpService(
    this.url, {
    Client? client,
    this.defaultTimeOut = const Duration(minutes: 2),
    this.token,
  }) : client = client ?? Client();

  final String url;
  final String? token;
  final Client client;
  final Duration defaultTimeOut;

  @override
  Future<BaseServiceResponse> doRequest(
    AlgoRequestDetails params, {
    Duration? timeout,
  }) async {
    final headers = params.headers.clone();
    if (token != null) {
      headers['X-Algo-API-Token'] = token!;
    }
    final response = switch (params.requestMethod) {
      RequestMethod.get => await client
          .get(params.encodeUrl(url), headers: headers)
          .timeout(timeout ?? defaultTimeOut),
      _ => await client
          .post(
            params.encodeUrl(url),
            headers: headers,
            body: params.encodeBody(),
          )
          .timeout(timeout ?? defaultTimeOut),
    };
    return params.toResponse(
      response.bodyBytes,
      statusCode: response.statusCode,
    );
  }
}

/// Thin wrapper that mixes in high-level RPC helpers ([AlgoQuickClientApi]).
class AlgoClient with AlgoQuickClientApi {
  AlgoClient(this.provider);
  @override
  final AlgoProvider provider;
}

/// TestNet Algod client (AlgoNode, no token required).
AlgoClient testnetClient() => AlgoClient(
  AlgoProvider(AlgoHttpService('https://testnet-api.algonode.cloud')),
);

/// Deterministic demo key from a 32-byte seed. Replace with a real mnemonic /
/// private key in real apps.
AlgoSecretKey demoSecretKey(int seedByte) =>
    AlgoSecretKey.fromBytes(List<int>.filled(32, seedByte));

AlgoAddress demoAddress(int seedByte) =>
    demoSecretKey(seedByte).toPublicKey().toAddress();

// Deterministic accounts. `faucet` (seed 13) is funded on TestNet and tops up
// the others so the examples can run repeatedly.
AlgoSecretKey get faucetKey => demoSecretKey(13);
AlgoAddress get faucet => demoAddress(13);

AlgoSecretKey get aliceKey => demoSecretKey(12);
AlgoAddress get alice => demoAddress(12);

AlgoSecretKey get bobKey => demoSecretKey(11);
AlgoAddress get bob => demoAddress(11);

AlgoSecretKey get carolKey => demoSecretKey(10);
AlgoAddress get carol => demoAddress(10);

/// Ensures [address] holds at least [minBalance] microAlgos by topping it up
/// from [faucet]. No-op when the account is already funded or is the faucet.
Future<void> ensureFunded(
  AlgoClient client, {
  required AlgoAddress address,
  BigInt? minBalance,
}) async {
  final target = minBalance ?? BigInt.from(1000000); // 1 ALGO
  if (address == faucet) return;
  final balance = await client.getAccountBalance(address);
  if (balance >= target) {
    print('  [fund] ${address.address} already has '
        '${microAlgoToAlgo(balance)} ALGO');
    return;
  }
  final deficit = target - balance;
  print('  [fund] sending ${microAlgoToAlgo(deficit)} ALGO to '
      '${address.address}');
  await sendPayment(
    client,
    sender: faucet,
    signer: faucetKey,
    receiver: address,
    amount: deficit,
  );
}

/// Signs, submits and waits for a single payment.
Future<String> sendPayment(
  AlgoClient client, {
  required AlgoAddress sender,
  required AlgoSecretKey signer,
  required AlgoAddress receiver,
  required BigInt amount,
}) async {
  final composer = AtomicTransactionComposer();
  final signed = await composer.buildTransaction(
    client: client,
    tx: PaymentTxnFields(receiver: receiver, amount: amount),
    sender: sender,
    signer: signer,
  );
  composer.addTransaction(signed);
  final result = await composer.execute(client);
  return result.txIds.first;
}

/// 1. Simple payment: Alice sends 1 ALGO to Bob.
Future<void> exampleSimplePayment(AlgoClient client) async {
  print('\n== 1. Simple payment (Alice -> Bob, 1 ALGO) ==');
  await ensureFunded(
    client,
    address: alice,
    minBalance: algoToMicroAlgo('5'),
  );
  await ensureFunded(client, address: bob, minBalance: algoToMicroAlgo('1'));

  final before = await client.getAccountBalance(bob);
  final txId = await sendPayment(
    client,
    sender: alice,
    signer: aliceKey,
    receiver: bob,
    amount: algoToMicroAlgo('1'),
  );
  final after = await client.getAccountBalance(bob);

  print('  txid:   $txId');
  print('  Bob:    ${microAlgoToAlgo(before)} -> '
      '${microAlgoToAlgo(after)} ALGO');
  print('  explorer: https://testnet.algoexplorer.io/tx/$txId');
}

/// 2. Atomic group: Alice pays Bob and Carol in one all-or-nothing group.
Future<void> exampleAtomicGroup(AlgoClient client) async {
  print('\n== 2. Atomic group payment (Alice -> Bob + Carol) ==');
  await ensureFunded(
    client,
    address: alice,
    minBalance: algoToMicroAlgo('5'),
  );
  await ensureFunded(client, address: carol, minBalance: algoToMicroAlgo('1'));

  final composer = AtomicTransactionComposer();
  final amount = algoToMicroAlgo('0.5');

  final toBob = await composer.buildTransaction(
    client: client,
    tx: PaymentTxnFields(receiver: bob, amount: amount),
    sender: alice,
    signer: aliceKey,
  );
  final toCarol = await composer.buildTransaction(
    client: client,
    tx: PaymentTxnFields(receiver: carol, amount: amount),
    sender: alice,
    signer: aliceKey,
  );

  composer
    ..addTransaction(toBob)
    ..addTransaction(toCarol);

  final result = await composer.execute(client);
  print('  group txids: ${result.txIds}');
  print('  Bob:   ${microAlgoToAlgo(await client.getAccountBalance(bob))} ALGO');
  print('  Carol: ${microAlgoToAlgo(await client.getAccountBalance(carol))} '
      'ALGO');
}

/// 3. Asset lifecycle: create an ASA, opt Bob in, then transfer units.
Future<void> exampleAssetLifecycle(AlgoClient client) async {
  print('\n== 3. Asset lifecycle (create -> opt-in -> transfer) ==');
  await ensureFunded(
    client,
    address: alice,
    minBalance: algoToMicroAlgo('5'),
  );
  await ensureFunded(client, address: bob, minBalance: algoToMicroAlgo('1'));

  // ── create ──────────────────────────────────────────────────────────────
  final createComposer = AtomicTransactionComposer();
  final createTx = await createComposer.buildTransaction(
    client: client,
    tx: AssetConfigTxnFields(
      assetParams: AssetParams(
        assetName: 'Example Token',
        unitName: 'EXMP',
        total: BigInt.from(10000000),
        decimals: BigInt.zero,
      ),
    ),
    sender: alice,
    signer: aliceKey,
  );
  createComposer.addTransaction(createTx);
  final createResult = await createComposer.execute(client);
  final createTxId = createResult.txIds.first;

  // Wait for Alice's created assets to appear, then take the newest one.
  final account = await client.getAccount(alice);
  final created = account.createdAssets;
  if (created == null || created.isEmpty) {
    throw StateError('no created asset found for ${alice.address}');
  }
  final assetId = created.map((e) => e.index).reduce(
    (a, b) => a > b ? a : b,
  );
  print('  created asset $assetId (txid $createTxId)');

  // ── opt-in (Bob sends himself 0 units of the asset) ─────────────────────
  final optComposer = AtomicTransactionComposer();
  final optTx = await optComposer.buildTransaction(
    client: client,
    tx: AssetTransferTxnFields(
      xferAsset: assetId,
      assetReceiver: bob,
      assetAmount: BigInt.zero,
    ),
    sender: bob,
    signer: bobKey,
  );
  optComposer.addTransaction(optTx);
  await optComposer.execute(client);
  print('  Bob opted in to asset $assetId');

  // ── transfer ────────────────────────────────────────────────────────────
  final xferComposer = AtomicTransactionComposer();
  final xferTx = await xferComposer.buildTransaction(
    client: client,
    tx: AssetTransferTxnFields(
      xferAsset: assetId,
      assetReceiver: bob,
      assetAmount: BigInt.from(1000),
    ),
    sender: alice,
    signer: aliceKey,
  );
  xferComposer.addTransaction(xferTx);
  final xferResult = await xferComposer.execute(client);
  print('  transfer txid: ${xferResult.txIds.first}');

  final holding = await client.getAccountAsset(alice, assetId);
  print('  Alice holds ${holding.assetHolding?.amount ?? 0} units of '
      '$assetId');
}

/// Minimum balance the faucet needs to run all three examples (10 ALGO).
final BigInt _faucetMinimum = BigInt.from(10000000);

Future<void> main() async {
  final client = testnetClient();

  final status = await client.status();
  final params = await client.getTransactionParams();
  print('Algorand TestNet');
  print('  round:      ${status.lastRound}');
  print('  genesis:    ${params.genesisId}');
  print('  faucet:     ${faucet.address}');
  print('  alice:      ${alice.address}');
  print('  bob:        ${bob.address}');
  print('  carol:      ${carol.address}');

  final faucetBalance = await client.getAccountBalance(faucet);
  print('  faucet bal: ${microAlgoToAlgo(faucetBalance)} ALGO');
  if (faucetBalance < _faucetMinimum) {
    print('\nFaucet is low. Fund this TestNet address from '
        'https://lora.algokit.io/testnet/fund and re-run:');
    print('  ${faucet.address}');
    return;
  }

  await exampleSimplePayment(client);
  await exampleAtomicGroup(client);
  await exampleAssetLifecycle(client);

  print('\nAll Algorand examples completed.');
}