/// NEAR TestNet examples through `IAccountApi` (transfer, multi-token).
library;

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/near/near.dart';

import 'client_example.dart';

/// NEAR TestNet RPC endpoint (official public RPC).
const String rpcUrl = 'https://rpc.testnet.near.org';

/// Deterministic demo key from a 32-byte seed.
NearEd25519SecretKey demoSecretKey(int seedByte) =>
    NearEd25519SecretKey.fromBytes(List<int>.filled(32, seedByte));

/// The funded faucet account (seed 12) — it also hosts the `multi_token`
/// contract at its own address.
NearEd25519SecretKey get faucetKey => demoSecretKey(12);
BaseNearAddress get faucet => faucetKey.toPublicKey().toImplicitAddress();

/// Recipient account used by the examples (seed 13).
NearEd25519SecretKey get aliceKey => demoSecretKey(13);
BaseNearAddress get alice => aliceKey.toPublicKey().toImplicitAddress();

/// The multi-token contract is deployed at the faucet's own address.
MultiTokenContract get multiToken => MultiTokenContract(contractId: faucet);

/// The token id used by the examples.
const String tokenId = 'ghazanfar';

/// Human NEAR -> yoctoNEAR.
BigInt nearToYocto(String amount) => AmountConverter.near.toUnit(amount);

/// YoctoNEAR -> human NEAR.
String yoctoToNear(BigInt yocto) =>
    AmountConverter.near.toAmount(yocto).toString();

/// 0. QuickClient tour: every read/status helper on the faucet account.
Future<void> exampleQuickClientTour(NearQuickClient client) async {
  print('\n== 0. QuickClient tour ==');

  final status = await client.getStatus();
  print('  chain id:     ${status.chainId}');
  print('  block height: ${status.syncInfo.latestBlockHeight}');

  final block = await client.block();
  print('  block hash:   ${block.header.hash}');
  print('  gas price:    ${(await client.gasPrice()).gasPrice}');

  final state = await client.accountState(faucet);
  print('  faucet total: ${yoctoToNear(state.balance.total)} NEAR');
  print('  faucet avail: ${yoctoToNear(state.balance.available)} NEAR');
  print('  storage used: ${state.storageUsage} bytes');
}

/// 1. Native NEAR transfer: faucet sends 0.1 NEAR to Alice.
Future<void> exampleNativeTransfer(NearQuickClient client) async {
  print('\n== 1. Native NEAR transfer (faucet -> alice, 0.1 N) ==');
  final before = await client.accountState(alice);
  final amount = nearToYocto('0.1');

  final result = await client.signAndSendTransaction(
    accountId: faucet,
    receiverId: alice,
    actions: [ActionTransfer(NearTransfer(deposit: amount))],
    secretKey: faucetKey,
  );
  final after = await client.accountState(alice);

  print('  status: ${result.status()}');
  print('  alice:  ${yoctoToNear(before.balance.available)} -> '
      '${yoctoToNear(after.balance.available)} NEAR');
  print('  explorer: https://testnet.nearblocks.io/address/${alice.address}');
}

/// 2. Multi-token transfer: mint to self, then `mt_transfer` to Alice.
Future<void> exampleMultiToken(NearQuickClient client) async {
  print('\n== 2. Multi-token transfer (mint -> mt_transfer) ==');

  // Register Alice with the contract (idempotent-ish; ignore "already
  // registered" failures).
  await _tryStorageDeposit(client, alice);
  // Make sure the faucet itself is registered (the mint needs it).
  await _tryStorageDeposit(client, faucet);

  final selfBefore = await multiToken.getBalance(
    args: MultiTokenContractBalanceArgs(accountId: faucet, tokenId: tokenId),
    client: client,
  );

  // Mint 1000 tokens to the faucet's own account (the contract's `mint` mints
  // to the signer).
  final mint = await client.signAndSendTransaction(
    accountId: faucet,
    receiverId: faucet,
    actions: [
      ActionFunctionCall(
        const NearContractJsonFunction('mint').createFunctionCall(
          args: {
            'token_id': tokenId,
            'receiver_id': faucet.address,
            'amount': '1000',
          },
          gas: NearTokenConst.defaultGas,
        ),
      ),
    ],
    secretKey: faucetKey,
  );
  print('  mint: ${mint.status()}');
  final selfAfterMint = await multiToken.getBalance(
    args: MultiTokenContractBalanceArgs(accountId: faucet, tokenId: tokenId),
    client: client,
  );
  print('  faucet: $selfBefore -> $selfAfterMint');

  // Transfer 500 to Alice via the token helper.
  final destBefore = await multiToken.getBalance(
    args: MultiTokenContractBalanceArgs(accountId: alice, tokenId: tokenId),
    client: client,
  );
  final transfer = await multiToken.transfer(
    client: client,
    secretKey: faucetKey,
    args: MultiTokenContractTransferArgs(
      accountId: faucet,
      receiverId: alice,
      tokenId: tokenId,
      amount: BigInt.from(500),
      deposit: BigInt.one,
    ),
  );
  final destAfter = await multiToken.getBalance(
    args: MultiTokenContractBalanceArgs(accountId: alice, tokenId: tokenId),
    client: client,
  );
  print('  transfer: ${transfer.runtimeType}');
  print('  alice:    $destBefore -> $destAfter');
}

/// 3. Read-only function call: `mt_balance_of` through the node read path.
Future<void> exampleReadCall(NearQuickClient client) async {
  print('\n== 3. Read-only function call (mt_balance_of) ==');
  // Raw read: `readFunction` returns the raw JSON result bytes.
  final raw = await client.readFunction(
    accountId: faucet,
    method: 'mt_balance_of',
    argBytes: StringUtils.encodeJson({
      'account_id': faucet.address,
      'token_id': tokenId,
    }),
  );
  print('  raw result: ${StringUtils.decode(raw.value.result)}');

  // Typed helper over the same data.
  final balance = await multiToken.getBalance(
    args: MultiTokenContractBalanceArgs(accountId: faucet, tokenId: tokenId),
    client: client,
  );
  print('  faucet $tokenId balance: $balance');
}

/// Registers [account] with the multi-token contract (best effort).
Future<void> _tryStorageDeposit(
    NearQuickClient client, BaseNearAddress account) async {
  try {
    final result = await client.signAndSendTransaction(
      accountId: faucet,
      receiverId: faucet,
      actions: [
        ActionFunctionCall(
          const NearContractJsonFunction('storage_deposit').createFunctionCall(
            args: {'account_id': account.address},
            gas: NearTokenConst.defaultGas,
            deposit: nearToYocto('0.1'),
          ),
        ),
      ],
      secretKey: faucetKey,
    );
    print('  [storage_deposit] ${account.address}: ${result.status()}');
  } catch (e) {
    print('  [storage_deposit] ${account.address} skipped: $e');
  }
}

Future<void> main() async {
  final client = nearClient(rpcUrl);

  final status = await client.getStatus();
  final state = await client.accountState(faucet);
  print('NEAR TestNet (QuickClient)');
  print('  rpc:    $rpcUrl');
  print('  chain:  ${status.chainId}');
  print('  height: ${status.syncInfo.latestBlockHeight}');
  print('  faucet: ${faucet.address}');
  print('  alice:  ${alice.address}');
  print('  faucet: ${yoctoToNear(state.balance.total)} NEAR');

  if (state.balance.available < nearToYocto('1')) {
    print('\nFaucet is low. Fund this TestNet account and re-run:');
    print('  ${faucet.address}');
    return;
  }

  await exampleQuickClientTour(client);
  await exampleNativeTransfer(client);
  await exampleMultiToken(client);
  await exampleReadCall(client);

  print('\nAll NEAR examples completed.');
}
