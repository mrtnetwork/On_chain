/// Filecoin Calibration testnet examples (transfer, USDFC token, quick-client tour).
library;

import 'dart:io';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/on_chain.dart';

import 'client.dart';

/// Deterministic funded key (same as the original Filecoin example).
final List<int> _fundedKey = BytesUtils.fromHexString(
  '6aee318111dcc8043234f1b0607f15629bcc65f8f76f2c8bb140db2413d4aba2',
);

final FilBls12SecretKey _bls = FilBls12SecretKey.fromBytes(_fundedKey);
final FilSecp256k1SecretKey _secp = FilSecp256k1SecretKey.fromBytes(_fundedKey);
final FilAddress _blsAddr =
    _bls.toPublicKey().toAddress(network: FilNetwork.testnet);
final FilAddress _secpAddr =
    _secp.toPublicKey().toAddress(network: FilNetwork.testnet);

final DefaultFilClient client = DefaultFilClient(
  lotusClient(),
  network: FilNetworkConfig.calibrationnet,
);

/// USDFC ERC-20 (Calibration).
const String _usdfc = '0xb3042734b608a1B16e9e86B374A3f3e389B4cDf0';
const String fullnodeUrl = 'https://api.calibration.node.glif.io/rpc/v1';

String _fil(BigInt atto) => AmountConverter.eth.toAmount(atto).toString();

/// 1. Simple tFIL transfer: BLS -> secp256k1.
Future<void> exampleSimpleTransfer() async {
  print('\n== 1. Simple tFIL transfer (BLS -> secp) ==');
  print('  from: ${_blsAddr.address}');
  print('  to:   ${_secpAddr.address}');
  final before = await client.getBalance(_secpAddr);
  final tx = await client.buildAndSendMessage(
    to: _secpAddr,
    from: _blsAddr,
    signer: _bls,
    value: AmountConverter.eth.toUnit('1'), // 1 tFIL
  );
  print('  txid: ${tx.messageId}');
  final after = await client.getBalance(_secpAddr);
  print('  secp balance: ${_fil(before)} -> ${_fil(after)} tFIL');
  print(
      '  explorer: https://calibration.filfox.info/en/message/${tx.messageId}');
}

/// 2. Token transfer: deploy a TestToken ERC-20 (FEVM), mint, transfer.
Future<void> exampleTokenTransfer() async {
  print('\n== 2. Token transfer (deploy ERC-20, mint, transfer) ==');
  // 1. Fresh FEVM account.
  final fresh = FilSecp256k1SecretKey.fromBytes(
    QuickCrypto.generateRandom(length: 32),
  );
  final freshAddr = fresh.toPublicKey().toAddress(network: FilNetwork.testnet);
  final freshEth = fresh.toPublicKey().toEthAddress();
  print('  sender: ${freshAddr.address} (${freshEth.address})');

  // 2. Fund tFIL for gas (from the funded BLS account).
  await client.buildAndSendMessage(
    to: freshAddr,
    from: _blsAddr,
    signer: _bls,
    value: AmountConverter.eth.toUnit('1'),
  );
  await _waitBalance(freshAddr, BigInt.from(10).pow(17));

  // 3. Deploy the TestToken via the EAM (FIP-0055): to f010, method
  // Create (frc42 508237557), params CBOR([initcode, nonce]).
  final art = StringUtils.toJson(
    await File('lib/example/tron/trc20_token.json').readAsString(),
  ) as Map<String, dynamic>;
  final initHex = (art['bytecode'] as String).replaceFirst(RegExp(r'^0x'), '');
  final initBytecode = BytesUtils.fromHexString(initHex);
  final createParams = CborListValue<CborObject<Object?>>.definite([
    CborBytesValue(initBytecode),
    const CborIntValue(0),
  ]).encode();
  final deploy = await client.buildAndSendMessage(
    to: FilAddress('f010'),
    from: freshAddr,
    signer: fresh,
    value: BigInt.zero,
    method: BigInt.from(2), // EAM::Create
    params: createParams,
  );
  print('  deploy txid: ${deploy.messageId}');
  final deployLookup = await _waitTx(deploy.messageId);
  final returnValue = deployLookup.receipt.returnValue;
  if (returnValue == null || returnValue.length < 32) {
    throw StateError('no contract address in receipt');
  }
  final ethAddr =
      '0x${returnValue.sublist(12).map((e) => e.toRadixString(16).padLeft(2, '0')).join()}';
  final tokenAddr = await client.filContractAddress(ethAddr);
  print('  TestToken: ${tokenAddr.address}');

  // 4. Mint (faucet(uint256) mints to the caller).
  final faucetCalldata = '57915897${_encodeUint(BigInt.from(1000000))}';
  final mintTx = await client.buildAndSendMessage(
    to: tokenAddr,
    from: freshAddr,
    signer: fresh,
    value: BigInt.zero,
    method: FilEvmMethods.invokeContract,
    params: BytesUtils.fromHexString(faucetCalldata).toCborBytes().encode(),
  );
  print('  mint txid: ${mintTx.messageId}');
  await _waitTx(mintTx.messageId);
  final before = await client.fetchErc20Balance(
    contract: tokenAddr,
    ownerEth: freshEth.address,
  );

  // 5. Transfer 1 token to a fresh recipient.
  final recipient = FilSecp256k1SecretKey.fromBytes(
    QuickCrypto.generateRandom(length: 32),
  );
  final recipientEth = recipient.toPublicKey().toEthAddress();
  final recipientAddr = recipient.toPublicKey().toAddress(
        network: FilNetwork.testnet,
      );
  final calldata = FilQuickEvmApiUtils.filErc20TransferCalldata(
    toEth: recipientEth.address,
    amount: BigInt.from(1000),
  );
  final sent = await client.buildAndSendMessage(
    to: tokenAddr,
    from: freshAddr,
    signer: fresh,
    value: BigInt.zero,
    method: FilEvmMethods.invokeContract,
    params: calldata.toCborBytes().encode(),
  );
  print('  transfer txid: ${sent.messageId}');
  await _waitTx(sent.messageId);

  final after = await client.fetchErc20Balance(
    contract: tokenAddr,
    ownerEth: freshEth.address,
  );
  final recipientBal = await client.fetchErc20Balance(
    contract: tokenAddr,
    ownerEth: recipientEth.address,
  );
  print('  TestToken sender:   $before -> $after');
  print('  TestToken recipient: $recipientBal (${recipientAddr.address})');
  print(
      '  explorer: https://calibration.filfox.info/en/message/${sent.messageId}');
}

/// Waits until [messageId] has an on-chain receipt.
Future<LotusResponseMsgLookup> _waitTx(Cid messageId) async {
  for (var i = 0; i < 60; i++) {
    final lookup = await client.stateSearchMsg(messageId);
    if (lookup != null) return lookup;
    await Future.delayed(const Duration(seconds: 3));
  }
  throw StateError('tx not confirmed: ${messageId.cid}');
}

/// Encodes a uint256 as a 32-byte hex word (no 0x).
String _encodeUint(BigInt value) => value.toRadixString(16).padLeft(64, '0');

/// 3. Quick-client debug tour.
Future<void> exampleQuickClientTour() async {
  print('\n== 3. Quick-client debug tour ==');
  print('  networkName:   ${await client.networkName()}');
  print('  epoch:         ${await client.epoch()}');
  print(
      '  chain head:    ${(await client.provider.request(const LotusFullNodeRequestChainHead())).height}');
  print('  gas price:     ${await client.estimateGas(FilMessage(
        to: _blsAddr,
        from: _blsAddr,
        nonce: BigInt.zero,
        value: FilTokenAmount.zero(),
        gasLimit: BigInt.zero,
        gasFeeCap: FilTokenAmount.zero(),
        gasPremium: FilTokenAmount.zero(),
        method: FilMethods.send,
      )).then((e) => e.gasPremium)}');
  print('  bls balance:   ${_fil(await client.getBalance(_blsAddr))} tFIL');
  print('  secp balance:  ${_fil(await client.getBalance(_secpAddr))} tFIL');
  print('  bls nonce:     ${await client.getActorNonce(_blsAddr)}');
  print('  secp nonce:    ${await client.getActorNonce(_secpAddr)}');
  print('  bls state:     ${(await client.getState(_blsAddr))?.balance}');
  print('  lookupID(bls): ${(await client.lookupID(_blsAddr))?.address}');
  print('  lookupID(secp):${(await client.lookupID(_secpAddr))?.address}');
  final usdfcAddr = await client.filContractAddress(_usdfc);
  final meta = await client.fetchErc20Metadata(usdfcAddr);
  print('  USDFC meta:    ${meta?.symbol} (${meta?.decimals})');
}

/// Waits until [address] has at least [min] attoFIL.
Future<void> _waitBalance(FilAddress address, BigInt min) async {
  for (var i = 0; i < 40; i++) {
    if (await client.getBalance(address) >= min) return;
    await Future.delayed(const Duration(seconds: 3));
  }
  throw StateError('balance not funded: ${address.address}');
}

Future<void> main() async {
  print('Filecoin Calibration (QuickClient)');
  print('  fullnode: $fullnodeUrl');
  print('  network:  ${await client.networkName()}');
  print('  bls:      ${_blsAddr.address}');
  print('  secp:     ${_secpAddr.address}');

  final balance = await client.getBalance(_blsAddr);
  print('  bls bal:  ${_fil(balance)} tFIL');
  if (balance < AmountConverter.eth.toUnit('10')) {
    print('\nBLS account is low. Fund it and re-run:');
    print('  ${_blsAddr.address}');
    return;
  }

  await exampleSimpleTransfer();
  await exampleTokenTransfer();
  await exampleQuickClientTour();

  print('\nAll Filecoin examples completed.');
}
