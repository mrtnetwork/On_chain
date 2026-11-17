/// ICP examples against a local replica (needs the ICRC ledger installed).
library;

import 'package:on_chain/icp/src/address/address.dart';
import 'package:on_chain/icp/src/crypto/private_key/secp256r1.dart';
import 'package:on_chain/icp/src/did/icrc1/icrc1.dart';
import 'package:on_chain/icp/src/service/client/client/client.dart';
import 'package:on_chain/icp/src/service/client/types/types.dart';

import 'http/http.dart';

/// Local replica endpoint (dfx shared local network).
const String replicaUrl = 'http://127.0.0.1:4943';

/// Local ledger canister id. `dfx deploy` assigns this; it is the ICRC ledger
/// used by every example below. Change it if your local ledger has another id
/// (`dfx canister id icp_ledger`).
const String localLedgerCanisterId = 'lqy7q-dh777-77777-aaaaq-cai';

/// 1 ICP = 100_000_000 e8s.
final BigInt _oneIcp = BigInt.from(100000000);

/// Local network config: only the ledger is real; the other NNS canisters are
/// the mainnet defaults (unused by these examples).
ICPNetworkConfig get localNetwork => const ICPNetworkConfig(
  ledgerCanisterId: IcpPrincipalAddress.unsafe(localLedgerCanisterId),
  cyclesLedgerCanisterId: IcpPrincipalAddress.unsafe(
    'um5iw-rqaaa-aaaaq-qaaba-cai',
  ),
  cyclesMintingCanisterId: IcpPrincipalAddress.unsafe(
    'rkp4c-7iaaa-aaaaa-aaaca-cai',
  ),
  internetIdentityCanisterId: IcpPrincipalAddress.unsafe(
    'rdmx6-jaaaa-aaaaa-aaadq-cai',
  ),
  nnsRootCanisterId: IcpPrincipalAddress.unsafe('rrkah-fqaaa-aaaaa-aaaaq-cai'),
  snsWasmCanisterId: IcpPrincipalAddress.unsafe('qaa6y-5yaaa-aaaaa-aaafa-cai'),
  managementCanisterId: IcpPrincipalAddress.unsafe('aaaaa-aa'),
);

/// Deterministic demo key from a 32-byte seed.
ICPSecp256r1SecretKey demoSecretKey(int seedByte) =>
    ICPSecp256r1SecretKey.fromBytes(List<int>.filled(32, seedByte));

IcpPrincipalAddress principalOf(ICPSecp256r1SecretKey key) =>
    key.toPublicKey().toPrincipalAddress();

// Deterministic accounts. `faucet` (seed 12) is funded on the local ledger and
// tops up the others so the examples can run repeatedly.
ICPSecp256r1SecretKey get faucetKey => demoSecretKey(12);
IcpPrincipalAddress get faucet => principalOf(faucetKey);

ICPSecp256r1SecretKey get aliceKey => demoSecretKey(13);
IcpPrincipalAddress get alice => principalOf(aliceKey);

ICPSecp256r1SecretKey get bobKey => demoSecretKey(14);
IcpPrincipalAddress get bob => principalOf(bobKey);

/// A client that signs calls and queries with [key].
ICPClientDefault clientFor(ICPSecp256r1SecretKey key) {
  return ICPClientDefault(
    provider: icpClient(url: replicaUrl),
    config: ICPClientConfig(
      callStrategy: ICPCallStrategySigning(
        signer: (sender) async => key,
        address: principalOf(key),
      ),
      queryStrategy: ICPQueryStrategySigning(
        signer: (_) async => key,
        address: principalOf(key),
      ),
      // Local replica: skip certificate verification (fast, local only).
      verificationStrategy: const ICPResponseVerificationStrategyNever(),
      network: localNetwork,
    ),
  );
}

/// ICRC-1 balance of [owner].
Future<BigInt> icrc1Balance(
  ICPClientDefault client,
  IcpPrincipalAddress owner,
) {
  return client.getIcrc1LedgerIcrc1BalanceOf(owner.withSubAccountId());
}

/// Ensures [address] holds at least [minE8s], topping up from [faucet].
Future<void> ensureFunded(
  ICPClientDefault client, {
  required IcpPrincipalAddress address,
  BigInt? minE8s,
}) async {
  final target = minE8s ?? _oneIcp * BigInt.from(10);
  if (address == faucet) return;
  final balance = await icrc1Balance(client, address);
  if (balance >= target) {
    print('  [fund] ${address.address} already has $balance e8s');
    return;
  }
  final deficit = target - balance;
  print('  [fund] sending $deficit e8s to ${address.address}');
  final result = await clientFor(faucetKey).icrc1Transfer(
    to: address.withSubAccountId(),
    amount: deficit,
    sender: faucet.withSubAccountId(),
  );
  if (result case final r) {
    if (r.toJson().toString().contains('Err')) {
      throw StateError('funding transfer failed: ${r.toJson()}');
    }
  }
}

/// 1. Token metadata + supply + fee (read-only).
Future<void> exampleTokenInfo(ICPClientDefault client) async {
  print('\n== 1. Token metadata + supply + fee ==');
  final metadata = await client.getIcrc1Metadata();
  for (final entry in metadata) {
    final value = switch (entry.field1) {
      ICRC1ValueText(:final value) => value,
      ICRC1ValueNat(:final value) => value.toString(),
      ICRC1ValueInt(:final value) => value.toString(),
      ICRC1ValueBlob(:final value) => '<${value.length} bytes>',
    };
    print('  ${entry.field0}: $value');
  }
  final decimals = await client.getIcrc1Decimals();
  final fee = await client.getIcrc1LedgerIcrc1Fee();
  final supply = await client.getIcrc1TotalSupply();
  final balance = await icrc1Balance(client, faucet);
  print('  decimals: $decimals');
  print('  fee:      $fee e8s');
  print('  supply:   $supply e8s');
  print('  faucet:   $balance e8s');
}

/// 2. Simple ICRC-1 transfer: faucet sends 2 ICP to Alice.
Future<void> exampleSimpleTransfer(ICPClientDefault client) async {
  print('\n== 2. Simple ICRC-1 transfer (faucet -> alice, 2 ICP) ==');
  await ensureFunded(client, address: alice, minE8s: _oneIcp * BigInt.from(5));

  final before = await icrc1Balance(client, alice);
  final amount = _oneIcp * BigInt.from(2);
  final result = await client.icrc1Transfer(
    to: alice.withSubAccountId(),
    amount: amount,
    sender: faucet.withSubAccountId(),
  );
  final after = await icrc1Balance(client, alice);

  print('  result: ${result.toJson()}');
  print('  alice:  $before -> $after e8s');
  print('  alice principal: ${alice.address}');
}

/// 3. ICRC-2 approve + transferFrom: faucet approves Bob, Bob spends.
Future<void> exampleApproveAndTransferFrom(ICPClientDefault client) async {
  print('\n== 3. ICRC-2 approve + transferFrom ==');
  await ensureFunded(client, address: bob, minE8s: _oneIcp * BigInt.from(5));

  final faucetClient = clientFor(faucetKey);
  final bobClient = clientFor(bobKey);

  // faucet approves bob to spend 10 ICP.
  final allowanceAmount = _oneIcp * BigInt.from(10);
  final approve = await faucetClient.icrc2Approve(
    spender: bob.withSubAccountId(),
    amount: allowanceAmount,
    sender: faucet.withSubAccountId(),
  );
  final allowance = await faucetClient.getIcrc2Allowance(
    faucet.withSubAccountId(),
    bob.withSubAccountId(),
  );
  print('  approve:   ${approve.toJson()}');
  print('  allowance: ${allowance.toJson()}');

  // bob moves 1 ICP from faucet to alice using the allowance.
  final before = await icrc1Balance(client, alice);
  final spend = _oneIcp;
  final transferFrom = await bobClient.icrc2TransferFrom(
    amount: spend,
    from: faucet.withSubAccountId(),
    to: alice.withSubAccountId(),
    sender: bob.withSubAccountId(),
  );
  final after = await icrc1Balance(client, alice);
  print('  transferFrom: ${transferFrom.toJson()}');
  print('  alice: $before -> $after e8s');
}

/// 0. QuickClient tour: every read/status helper exposed by the client.
Future<void> exampleQuickClientTour(ICPClientDefault client) async {
  print('\n== 0. QuickClient tour ==');

  final status = await client.status();
  print('  replica health:      ${status.replicaHealthStatus}');
  print('  root key present:    ${await client.rootKey() != null}');

  final name = await client.getIcrc1Name();
  final symbol = await client.getIcrc1Symbol();
  final decimals = await client.getIcrc1Decimals();
  final fee = await client.getIcrc1LedgerIcrc1Fee();
  final supply = await client.getIcrc1TotalSupply();
  final metadata = await client.getIcrc1Metadata();
  final standards = await client.getIcrc1SupportedStandards(
    faucet.withSubAccountId(),
    bob.withSubAccountId(),
  );

  print('  name/symbol:         $name ($symbol), $decimals decimals');
  print('  fee:                 $fee e8s');
  print('  total supply:        $supply e8s');
  print('  metadata entries:    ${metadata.length}');
  print('  supported standards: ${standards.length}');

  final balance = await client.getIcrc1LedgerIcrc1BalanceOf(
    faucet.withSubAccountId(),
  );
  print('  faucet ICRC-1:       $balance e8s');

  final allowance = await client.getIcrc2Allowance(
    faucet.withSubAccountId(),
    bob.withSubAccountId(),
  );
  print('  faucet->bob allowance: ${allowance.toJson()}');

  // Legacy-helper probe (documented bug): the current ICRC ledger canister
  // does not expose the old `account_balance` method.
  try {
    final legacy = await client.getLedgerAccountBalance(faucet);
    print('  legacy account_balance: $legacy e8s (unexpected)');
  } catch (e) {
    print('  legacy account_balance: unavailable on ICRC ledger -> $e');
  }
}

Future<void> main() async {
  final client = clientFor(faucetKey);

  final status = await client.status();
  final supply = await client.getIcrc1TotalSupply();
  print('ICP Local Replica (QuickClient)');
  print('  replica:  $replicaUrl');
  print('  ledger:   $localLedgerCanisterId');
  print('  health:   ${status.replicaHealthStatus}');
  print('  supply:   $supply e8s');
  print('  faucet:   ${faucet.address}');
  print('  alice:    ${alice.address}');
  print('  bob:      ${bob.address}');

  final faucetBalance = await icrc1Balance(client, faucet);
  print('  faucet:   $faucetBalance e8s');
  if (faucetBalance < _oneIcp * BigInt.from(20)) {
    print('\nFaucet is low. Fund it from the minting identity, e.g.:');
    print('  dfx canister call $localLedgerCanisterId icrc1_transfer '
        '\'(record { to = record { owner = principal "${faucet.address}" }; '
        'amount = 1000_000_000 : nat })\'');
    return;
  }

  await exampleQuickClientTour(client);
  await exampleTokenInfo(client);
  await exampleSimpleTransfer(client);
  await exampleApproveAndTransferFrom(client);

  print('\nAll ICP examples completed.');
}