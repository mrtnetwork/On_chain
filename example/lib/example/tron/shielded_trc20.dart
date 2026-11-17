/// Shielded TRC-20 lifecycle on Shasta (needs BU_NATIVE_LIB for note crypto).
library;

import 'dart:io';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/on_chain.dart';

import 'clinet/grpc_client_example.dart';

/// Shasta testnet endpoints (gRPC is required for the shielded calls).
const String fullnodeUrl = 'https://api.shasta.trongrid.io';
const String grpcHost = 'grpc.shasta.trongrid.io';
const int grpcPort = 50051;

/// 1 TRX = 1e6 sun.
final BigInt _oneTrx = BigInt.from(1000000);

/// The single QuickClient used by every call.
final DefaultTronQuickClient quick = getClient(
  rpcUrl: fullnodeUrl,
  grpcUrl: grpcHost,
  grpcPort: grpcPort,
  grpcTls: false,
);

/// The funded single-sig signer (same seed-12 account as the other networks).
final TronPrivateKey primaryKey = TronPrivateKey.fromBytes(
  Bip44.fromSeed(
    List<int>.filled(32, 12),
    Bip44Coins.tron,
  ).privateKey.toBytes(),
);
final TronAddress primary = primaryKey.publicKey().toAddress();

/// Shielded gRPC surface (createShieldedContractParameters / scan / getRcm).
class _Shield with TronShieldClientApi {
  @override
  final IGrpcProvider<IServiceProvider, BaseTronServiceRequestParams,
      TronGrpcRequestDetails> provider;
  _Shield(this.provider);
}

final _shield = _Shield(quick.provider);

/// Mint demo amounts (ERC-20 smallest units; ShieldedTRC20 scalingFactor 10).
const String _mintRaw = '100000000'; // raw ERC-20 amount to mint

String _sun(BigInt v) => AmountConverter.tron.toAmount(v).toString();

/// Deploys the TestToken ERC-20 and the ShieldedTRC20 (both fresh each run).
Future<(TronAddress trc20, TronAddress shielded)> _deployContracts() async {
  final trc20 = await _deployTrc20();
  final shielded = await _deployShielded(trc20);
  return (trc20, shielded);
}

Future<TronAddress> _deployTrc20() async {
  final json = StringUtils.toJson(
          await File('lib/example/tron/trc20_token.json').readAsString())
      as Map<String, dynamic>;
  final abi = (json['abi'] as List).cast<Map<String, dynamic>>();
  final code = BytesUtils.fromHexString(
    (json['bytecode'] as String).replaceFirst(RegExp(r'^0x'), ''),
  );
  final (txid, addr) = await _deploy(
    name: 'TestToken',
    abi: abi,
    byteCode: code,
    feeLimit: _oneTrx * BigInt.from(300),
  );
  print('  deployed ERC-20 at ${addr.address} (txid $txid)');
  return addr;
}

Future<TronAddress> _deployShielded(TronAddress trc20) async {
  final json = StringUtils.toJson(
    await File('lib/example/tron/shielded_trc20.json').readAsString(),
  ) as Map<String, dynamic>;
  final abi = (json['abi'] as List).cast<Map<String, dynamic>>();
  final initHex = (json['bytecode'] as String).replaceFirst(RegExp(r'^0x'), '');
  // Constructor: (trc20ContractAddress, scalingFactorExponent = 1).
  final deployHex =
      '$initHex${_encodeAddress(trc20)}${_encodeUint(BigInt.one)}';
  final (txid, addr) = await _deploy(
    name: 'ShieldedTRC20',
    abi: abi,
    byteCode: BytesUtils.fromHexString(deployHex),
    feeLimit: _oneTrx * BigInt.from(1000),
  );
  print('  deployed ShieldedTRC20 at ${addr.address} (txid $txid)');
  return addr;
}

/// Deploys a contract and waits for the address.
Future<(String, TronAddress)> _deploy({
  required String name,
  required List<Map<String, dynamic>> abi,
  required List<int> byteCode,
  required BigInt feeLimit,
}) async {
  final contract = TronCreateSmartContract(
    ownerAddress: primary,
    newContract: TronSmartContract(
      originEnergyLimit: BigInt.from(10000000),
      name: name,
      bytecode: byteCode,
      consumeUserResourcePercent: BigInt.from(100),
      originAddress: primary,
      abi: TronSmartContractABI(
        entrys: abi.map((e) => TronSmartContractABIEntry.fromJson(e)).toList(),
      ),
    ),
  );
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
    throw StateError(
      'deploy $name failed: code=${res.code} msg=${res.message}',
    );
  }
  await quick.trackTransaction(
    transactionId: res.txid,
    periodicTimeOut: const Duration(seconds: 3),
  );
  final status = await quick.getTransactionStatus(res.txid);
  if (status != TronTxStatus.block) {
    throw StateError('deploy $name failed on-chain: $status');
  }
  final info = await quick.provider.request(
    TronFullNodeRequestWalletGettransactioninfobyidPost(
      requestBody: TronHttpBytesMessageRequest(value: res.txid, visible: true),
    ),
  );
  final addr = info?.contractAddress;
  if (addr == null || addr.isEmpty) {
    throw StateError('no contract address for $name');
  }
  return (res.txid, TronAddress.fromBytes(addr));
}

/// Broadcasts a `triggerSmartContract` call.
Future<String> _trigger({
  required TronAddress contract,
  required List<int> data,
  required BigInt feeLimit,
}) async {
  final block = await quick.getNowBlock();
  final expire = DateTime.now().toUtc().add(const Duration(hours: 1));
  final call = TronTriggerSmartContract(
    ownerAddress: primary,
    contractAddress: contract,
    data: data,
    callValue: BigInt.zero,
  );
  final raw = TronTransactionraw(
    refBlockBytes: block.refBlockBytes,
    refBlockHash: block.refBlockHash,
    expiration: BigInt.from(expire.millisecondsSinceEpoch),
    feeLimit: feeLimit,
    contract: [TronTransactionContract(parameter: call)],
    timestamp: block.blockHeader!.rawData!.timestamp,
  );
  final tx = TronTransaction(
    rawData: raw,
    signature: [primaryKey.sign(raw.toBuffer())],
  );
  final res = await quick.broadcastTx(tx);
  if (res.result != true) {
    throw StateError('trigger failed: code=${res.code} msg=${res.message}');
  }
  await quick.trackTransaction(
    transactionId: res.txid,
    periodicTimeOut: const Duration(seconds: 3),
  );
  final status = await quick.getTransactionStatus(res.txid);
  if (status != TronTxStatus.block) {
    throw StateError('trigger failed on-chain: $status');
  }
  return res.txid;
}

/// Constant (view) call; returns the raw ABI-encoded result.
Future<List<int>> _constantCall(TronAddress contract, List<int> data) async {
  final res = await quick.provider.request(
    TronFullNodeRequestWalletTriggerconstantcontractPost(
      ownerAddress: primary,
      contractAddress: contract,
      data: BytesUtils.toHexString(data),
    ),
  );
  if (res.constantResult.isEmpty) {
    throw StateError('constant call returned nothing');
  }
  return List<int>.from(res.constantResult.first);
}

/// Encodes a uint256 as a 32-byte ABI word (no 0x).
String _encodeUint(BigInt value) => value.toRadixString(16).padLeft(64, '0');

/// Encodes a Tron address as a 32-byte ABI word (no 0x, left-padded).
String _encodeAddress(TronAddress address) {
  final bytes = address.toBytes(); // 21 bytes (0x41 + 20)
  return bytes
      .sublist(1)
      .map((e) => e.toRadixString(16).padLeft(2, '0'))
      .join()
      .padLeft(64, '0');
}

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
  bool single(dynamic p) =>
      p != null && p.threshold == BigInt.one && p.keys.length == 1;
  if (!single(owner) ||
      !single(defaultActive.isEmpty ? null : defaultActive.first)) {
    throw StateError('signer is multisig; use a single-signature account');
  }
  print('  single-sig:  OK (1-of-1)');
}

Future<void> main() async {
  // The shielded note crypto / proving needs the Rust backend.
  final libPath = Platform.environment['BU_NATIVE_LIB'];
  if (libPath == null) {
    print('backend not exist! set BU_NATIVE_LIB.');
    return;
  }
  blockchainUtils.setRustApi(libraryPath: libPath);

  final block = await quick.getNowBlock();
  print('Tron Shasta Shielded TRC-20 (QuickClient)');
  print('  fullnode: $fullnodeUrl');
  print('  block:    ${block.blockHeader?.rawData?.number}');
  print('  primary:  ${primary.address}');
  print('  balance:  ${_sun(await quick.getBalance(primary))} TRX');
  await _assertSingleSig();

  // ---- 1. deploy ERC-20 + ShieldedTRC20 -----------------------------------
  print('\n== 1. Deploy contracts ==');
  final (trc20, shielded) = await _deployContracts();
  final shieldedBytes = List<int>.from(shielded.toBytes());

  // ---- 2. approve the shielded contract on the ERC-20 ---------------------
  print('\n== 2. Approve ShieldedTRC20 on the ERC-20 ==');
  final approveData =
      '095ea7b3${_encodeAddress(shielded)}${_encodeUint(BigInt.parse(_mintRaw))}';
  final approveTx = await _trigger(
    contract: trc20,
    data: BytesUtils.fromHexString(approveData),
    feeLimit: _oneTrx * BigInt.from(50),
  );
  print('  approve txid: $approveTx');

  // ---- 3. mint: transparent ERC-20 -> shielded note -----------------------
  print('\n== 3. Mint (transparent -> shielded) ==');
  final skA = TronShieldSpendingKey.master(
    QuickCrypto.generateRandom(length: 32),
  );
  final (aAddr, _) = skA.defaultAddress();
  final aBech32 = TronShieldAddressCodec.toBech32(aAddr);
  print('  shield A: $aBech32');

  final rcmMint = List<int>.from((await _shield.getRcm()).value!);
  // ShieldedTRC20 was deployed with scalingFactorExponent = 1 => factor 10.
  final shieldedValue = BigInt.parse(_mintRaw) ~/ BigInt.from(10);
  final mintParams = TronShieldClientApi.buildMintTRC20Params(
    ovk: skA.externalOvk(),
    fromAmount: _mintRaw,
    receives: [
      (
        paymentAddress: aBech32,
        value: shieldedValue,
        rcm: rcmMint,
        memo: List<int>.filled(512, 0),
      ),
    ],
    shieldedContractAddress: shieldedBytes,
  );
  final mintRes = await _shield.createShieldedContractParameters(mintParams);
  final mintData = BytesUtils.fromHexString(
    ShieldTRC20Codec.mintSelector + mintRes.triggerContractInput!,
  );
  final mintTx = await _trigger(
    contract: shielded,
    data: mintData,
    feeLimit: _oneTrx * BigInt.from(100),
  );
  print('  mint txid: $mintTx');
  print('  minted $shieldedValue shielded units to $aBech32');

  // ---- 4. scan: find the fresh note ---------------------------------------
  print('\n== 4. Scan for the note ==');
  await Future.delayed(const Duration(seconds: 6));
  TronDecryptNotesTRC20 scan = const TronDecryptNotesTRC20(noteTxs: []);
  for (int i = 0; i < 12; i++) {
    final now = await quick.getNowBlock();
    final end = now.blockHeader!.rawData!.number!.toInt();
    scan = await _shield.scanShieldedTRC20NotesByIvk(
      TronIvkDecryptTRC20Parameters(
        startBlockIndex: BigInt.from((end - 500).clamp(0, end)),
        endBlockIndex: BigInt.from(end),
        shieldedTrc20ContractAddress: shieldedBytes,
        ivk: List<int>.from(skA.externalIvk().toBytes()),
        ak: List<int>.from(skA.fullViewingKey().vk.ak.toBytes()),
        nk: List<int>.from(skA.fullViewingKey().vk.nk.toBytes()),
      ),
    );
    if (scan.noteTxs.isNotEmpty) break;
    await Future.delayed(const Duration(seconds: 6));
  }
  if (scan.noteTxs.isEmpty) throw StateError('mint note not found');
  print(
    '  found ${scan.noteTxs.length} note(s); '
    'value=${scan.noteTxs.first.note?.value}',
  );

  // ---- 5. transfer: shielded A -> shielded B + change ---------------------
  print('\n== 5. Transfer (shielded -> shielded) ==');
  final skB = TronShieldSpendingKey.master(
    QuickCrypto.generateRandom(length: 32),
  );
  final (bAddr, _) = skB.defaultAddress();
  final bBech32 = TronShieldAddressCodec.toBech32(bAddr);
  print('  shield B: $bBech32');

  final askA = List<int>.from(
    SaplingExtendedSpendingKey.fromBytes(skA.toBytes()).sk.ask.toBytes(),
  );
  final nskA = List<int>.from(
    SaplingExtendedSpendingKey.fromBytes(skA.toBytes()).sk.nsk.toBytes(),
  );

  final leafCount = ShieldTRC20Codec.decodeLeafCount(
    await _constantCall(shielded, ShieldTRC20Codec.encodeLeafCount()),
  );
  final mintPos = (leafCount - BigInt.one).toInt();
  final gpMint = await _constantCall(
    shielded,
    ShieldTRC20Codec.encodeGetPath(BigInt.from(mintPos)),
  );
  final gp = ShieldTRC20Codec.decodeGetPath(gpMint);
  final root = gp.root;
  final path = gp.path.expand((e) => e).toList();

  final transferToB = shieldedValue ~/ BigInt.from(2);
  final change = shieldedValue - transferToB;
  final alphaT = List<int>.from(JubJubFr.random().toBytes());
  final rcmB = List<int>.from((await _shield.getRcm()).value!);
  final rcmChange = List<int>.from((await _shield.getRcm()).value!);

  final tParams = await _shield.createShieldedContractParameters(
    TronPrivateShieldedTRC20Parameters(
      ask: askA,
      nsk: nskA,
      ovk: List<int>.from(skA.externalOvk().inner),
      shieldedSpends: [
        TronSpendNoteTRC20(
          note: TronNote(
            value: shieldedValue,
            paymentAddress: aBech32,
            rcm: rcmMint,
            memo: List<int>.filled(512, 0),
          ),
          alpha: alphaT,
          root: root,
          path: path,
          pos: BigInt.from(mintPos),
        ),
      ],
      shieldedReceives: [
        TronReceiveNote(
          note: TronNote(
            value: transferToB,
            paymentAddress: bBech32,
            rcm: rcmB,
            memo: List<int>.filled(512, 0),
          ),
        ),
        TronReceiveNote(
          note: TronNote(
            value: change,
            paymentAddress: aBech32,
            rcm: rcmChange,
            memo: List<int>.filled(512, 0),
          ),
        ),
      ],
      shieldedTrc20ContractAddress: shieldedBytes,
    ),
  );

  final tSig = ShieldTRC20Signer.spendAuthSig(
    ask: askA,
    alpha: alphaT,
    messageHash: List<int>.from(tParams.messageHash!),
  );
  List<List<int>> words(List<int> b) => ShieldTRC20Codec.toWords(b);

  final tInput = [
    List<int>.from(tParams.spendDescription.first.nullifier!),
    List<int>.from(tParams.spendDescription.first.anchor!),
    List<int>.from(tParams.spendDescription.first.valueCommitment!),
    List<int>.from(tParams.spendDescription.first.rk!),
    ...words(List<int>.from(tParams.spendDescription.first.zkproof!)),
  ];
  final tOutputs = <List<List<int>>>[];
  final tCs = <List<List<int>>>[];
  for (final rd in tParams.receiveDescription) {
    tOutputs.add([
      List<int>.from(rd.noteCommitment!),
      List<int>.from(rd.valueCommitment!),
      List<int>.from(rd.epk!),
      ...words(List<int>.from(rd.zkproof!)),
    ]);
    tCs.add(
      ShieldTRC20Codec.packCiphertext(
        List<int>.from(rd.cEnc!),
        List<int>.from(rd.cOut!),
      ),
    );
  }

  final tData = [
    ...BytesUtils.fromHexString(ShieldTRC20Codec.transferSelector),
    ...ShieldTRC20Codec.encodeTransfer(
      inputs: [tInput],
      sigs: [
        [tSig.sublist(0, 32), tSig.sublist(32)],
      ],
      outputs: tOutputs,
      bindingSig: words(List<int>.from(tParams.bindingSignature!)),
      cs: tCs,
    ),
  ];
  final transferTx = await _trigger(
    contract: shielded,
    data: tData,
    feeLimit: _oneTrx * BigInt.from(100),
  );
  print('  transfer txid: $transferTx');
  print('  sent $transferToB to B, $change change to A');

  print('\nAll shielded TRC-20 examples completed.');
  print('  mint:     https://testnet.tronscan.org/#/transaction/$mintTx');
  print('  transfer: https://testnet.tronscan.org/#/transaction/$transferTx');
}
