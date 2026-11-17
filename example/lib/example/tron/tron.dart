/// Tron Shasta testnet examples through `DefaultTronQuickClient`.
library;

import 'dart:io';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/on_chain.dart';

import 'clinet/grpc_client_example.dart';

/// Shasta testnet fullnode (HTTP).
const String fullnodeUrl = 'https://api.shasta.trongrid.io';

/// 1 TRX = 1e6 sun.
final BigInt _oneTrx = BigInt.from(1000000);

/// The single QuickClient used by every example.
final DefaultTronQuickClient quick = getClient(
  rpcUrl: fullnodeUrl,
  grpcUrl: null,
);

/// The funded signer: the seed-12 account (same deterministic seed as the
/// other networks). Single-sig.
final TronPrivateKey primaryKey = TronPrivateKey.fromBytes(
  Bip44.fromSeed(List<int>.filled(32, 12), Bip44Coins.tron)
      .privateKey
      .toBytes(),
);
final TronAddress primary = primaryKey.publicKey().toAddress();

/// A deterministic recipient.
final TronPrivateKey aliceKey = TronPrivateKey.fromBytes(
  Bip44.fromSeed(List<int>.filled(32, 12), Bip44Coins.tron)
      .purpose
      .coin
      .account(0)
      .change(Bip44Changes.chainInt)
      .addressIndex(1)
      .privateKey
      .toBytes(),
);
final TronAddress alice = aliceKey.publicKey().toAddress();

/// Formats sun as a human TRX string.
String sunToTrx(BigInt sun) => AmountConverter.tron.toAmount(sun).toString();

/// Verifies the signer is single-signature (default owner + active permission
/// are 1-of-1) so this example never depends on a multisig setup.
Future<void> _assertSingleSig() async {
  final acct = await quick.getActiveAccount(primary);
  if (acct == null) throw StateError('account not found: ${primary.address}');

  final owner = acct.ownerPermission;
  final defaultActive = acct.activePermission.where((p) => p.id == 2).toList();

  String describe(dynamic p) =>
      p == null ? 'none' : 'threshold=${p.threshold} keys=${p.keys.length}';
  print('  owner perm:  ${describe(owner)}');
  print(
      '  active[2]:   ${describe(defaultActive.isEmpty ? null : defaultActive.first)}');

  bool isSingleSig(dynamic p) =>
      p != null && p.threshold == BigInt.one && p.keys.length == 1;

  if (!isSingleSig(owner) ||
      !isSingleSig(defaultActive.isEmpty ? null : defaultActive.first)) {
    throw StateError(
      'signer is multisig; use a single-signature account for this example',
    );
  }
  print('  single-sig:  OK (1-of-1)');
}

/// 1. QuickClient tour: chain params, block, balance, account resource.
Future<void> exampleQuickClientTour() async {
  print('\n== 1. QuickClient tour ==');
  final block = await quick.getNowBlock();
  final params = await quick.getChainParameters();
  print('  block:      ${block.blockHeader?.rawData?.number}');
  print('  minFee:     ${params.chainParameter.getTransactionFee} sun');
  print('  primary:    ${primary.address}');
  print('  balance:    ${sunToTrx(await quick.getBalance(primary))} TRX');

  final resource = await quick.getAccountResource(primary);
  print('  bandwidth:  ${resource.howManyBandwIth}');
  print('  energy:     ${resource.howManyEnergy}');
}

/// 2. Native TRX transfer: primary sends 1 TRX to Alice.
Future<String> exampleNativeTransfer() async {
  print('\n== 2. Native TRX transfer (primary -> alice, 1 TRX) ==');
  await _ensureFunded(alice, _oneTrx * BigInt.from(5));

  final txId = await _sendTransfer(
    to: alice,
    amount: _oneTrx,
    feeLimit: _oneTrx * BigInt.from(50),
  );
  print('  txid:  $txId');
  print('  alice: ${sunToTrx(await quick.getBalance(alice))} TRX');
  print('  explorer: https://testnet.tronscan.org/#/transaction/$txId');
  return txId;
}

/// 3. TRC-20 deploy (once) + transfer.
Future<void> exampleTrc20() async {
  print('\n== 3. TRC-20 deploy + transfer ==');
  final contractAddress = await _deployTrc20();

  final before = await _trc20Balance(contractAddress, alice);
  final txId = await _callContract(
    contract: contractAddress,
    data: 'a9059cbb${_encodeAddress(alice)}${_encodeUint(BigInt.one)}',
    feeLimit: _oneTrx * BigInt.from(50),
  );
  final after = await _trc20Balance(contractAddress, alice);
  print('  transfer txid: $txId');
  print('  alice LTT:     $before -> $after');
}

/// Deploys the TestToken TRC-20.
Future<TronAddress> _deployTrc20() async {
  final art = await File('lib/example/tron/trc20_token.json').readAsString();
  final json = StringUtils.toJson(art) as Map<String, dynamic>;
  final abi = (json['abi'] as List).cast<Map<String, dynamic>>();
  final bytecodeHex = (json['bytecode'] as String).replaceFirst(
    RegExp(r'^0x'),
    '',
  );
  final byteCode = BytesUtils.fromHexString(bytecodeHex);

  final contract = TronCreateSmartContract(
    ownerAddress: primary,
    newContract: TronSmartContract(
      originEnergyLimit: BigInt.from(10000000),
      name: 'TestToken',
      bytecode: byteCode,
      consumeUserResourcePercent: BigInt.from(100),
      originAddress: primary,
      abi: TronSmartContractABI(
        entrys: abi.map((e) => TronSmartContractABIEntry.fromJson(e)).toList(),
      ),
    ),
  );

  final txId = await _broadcast(
    contract: contract,
    feeLimit: _oneTrx * BigInt.from(300),
  );
  print('  deploy txid: $txId');
  await quick.trackTransaction(
    transactionId: txId,
    periodicTimeOut: const Duration(seconds: 3),
  );

  // The deployed contract address is in the receipt (`gettransactioninfobyid`).
  final info = await quick.provider.request(
    TronFullNodeRequestWalletGettransactioninfobyidPost(
      requestBody: TronHttpBytesMessageRequest(value: txId, visible: true),
    ),
  );
  final addrBytes = info?.contractAddress;
  if (addrBytes == null || addrBytes.isEmpty) {
    throw StateError('contract address not found in tx $txId');
  }
  final address = TronAddress.fromBytes(addrBytes).address;
  print('  deployed TRC-20 at $address');
  return TronAddress(address);
}

/// Builds, signs and broadcasts a transaction carrying [contract].
Future<String> _broadcast({
  required ITronContract contract,
  required BigInt feeLimit,
}) async {
  final block = await quick.getNowBlock();
  final expire = DateTime.now().toUtc().add(const Duration(hours: 1));
  final raw = TronTransactionraw(
    refBlockBytes: block.refBlockBytes,
    refBlockHash: block.refBlockHash,
    expiration: BigInt.from(expire.millisecondsSinceEpoch),
    feeLimit: feeLimit,
    contract: [TronTransactionContract(parameter: contract)],
    timestamp: block.blockHeader!.rawData!.timestamp,
  );
  final tx = TronTransaction(
    rawData: raw,
    signature: [primaryKey.sign(raw.toBuffer())],
  );
  final res = await quick.broadcastTx(tx);
  if (res.result != true) {
    throw StateError('broadcast failed: code=${res.code} msg=${res.message}');
  }
  await quick.trackTransaction(
    transactionId: res.txid,
    periodicTimeOut: const Duration(seconds: 3),
  );
  return res.txid;
}

/// Sends a native TRX transfer from the primary.
Future<String> _sendTransfer({
  required TronAddress to,
  required BigInt amount,
  required BigInt feeLimit,
}) {
  return _broadcast(
    contract: TronTransferContract(
      amount: amount,
      ownerAddress: primary,
      toAddress: to,
    ),
    feeLimit: feeLimit,
  );
}

/// Calls a contract function (state-changing) from the primary. [data] is the
/// full calldata hex (4-byte selector + ABI-encoded args).
Future<String> _callContract({
  required TronAddress contract,
  required String data,
  required BigInt feeLimit,
}) {
  return _broadcast(
    contract: TronTriggerSmartContract(
      ownerAddress: primary,
      contractAddress: contract,
      data: BytesUtils.fromHexString(data),
      callValue: BigInt.zero,
    ),
    feeLimit: feeLimit,
  );
}

/// Reads a TRC-20 balance via `triggerconstantcontract`.
Future<BigInt> _trc20Balance(TronAddress contract, TronAddress owner) async {
  final result = await quick.provider.request(
    TronFullNodeRequestWalletTriggerconstantcontractPost(
      ownerAddress: primary,
      contractAddress: contract,
      data: '70a08231${_encodeAddress(owner)}',
    ),
  );
  final raw = result.constantResult;
  if (raw.isEmpty) return BigInt.zero;
  // The proto `constant_result` is a list of ABI-encoded 32-byte words.
  return BigInt.parse(BytesUtils.toHexString(raw.first), radix: 16);
}

/// Ensures [address] has at least [min], topping up from the primary.
Future<void> _ensureFunded(TronAddress address, BigInt min) async {
  if (address == primary) return;
  final balance = await quick.getBalance(address);
  if (balance >= min) {
    print('  [fund] ${address.address} already has ${sunToTrx(balance)} TRX');
    return;
  }
  print('  [fund] sending ${sunToTrx(min)} TRX to ${address.address}');
  await _sendTransfer(
    to: address,
    amount: min,
    feeLimit: _oneTrx * BigInt.from(50),
  );
}

/// Encodes a uint256 as a 32-byte hex string (no 0x).
String _encodeUint(BigInt value) => value.toRadixString(16).padLeft(64, '0');

/// Encodes a Tron address as the 32-byte ABI address word (no 0x, left-padded).
String _encodeAddress(TronAddress address) {
  final bytes = address.toBytes(); // 21 bytes (0x41 + 20)
  return bytes
      .sublist(1)
      .map((e) => e.toRadixString(16).padLeft(2, '0'))
      .join()
      .padLeft(64, '0');
}

Future<void> main() async {
  final block = await quick.getNowBlock();
  print('Tron Shasta Testnet (QuickClient)');
  print('  fullnode: $fullnodeUrl');
  print('  block:    ${block.blockHeader?.rawData?.number}');
  print('  primary:  ${primary.address}');
  print('  alice:    ${alice.address}');

  final balance = await quick.getBalance(primary);
  print('  balance:  ${sunToTrx(balance)} TRX');
  if (balance < _oneTrx * BigInt.from(100)) {
    print('\nPrimary balance is low. Fund it and re-run:');
    print('  ${primary.address}');
    return;
  }

  await _assertSingleSig();
  await exampleQuickClientTour();
  await exampleNativeTransfer();
  await exampleTrc20();

  print('\nAll Tron examples completed.');
}
