import 'dart:convert';
import 'dart:typed_data';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:example/example/tron/provider_service/provider_service.dart';
import 'package:on_chain/tron/tron.dart';

void main() async {
  final ownerAddress = TronAddress("TMcbQBuj5ATtm9feRiMp6QRd587hT7HHyU");
  final receiverAddress = TronAddress("TF3cDajEAaJ8jFXFB2KF3XSUbTpZWzuSrp");

  /// intialize shasta http provider to send and receive requests
  final rpc =
      TronProvider(TronHTTPProvider(url: "https://api.shasta.trongrid.io"));

  /// get account info to read permissions
  final sig = await rpc.request(TronRequestGetAccount(address: ownerAddress));
  if (sig == null) {
    /// account does not exist
    return;
  }

  /// now get all permission (active and owner)
  final List<AccountPermission> permissions = [
    sig.ownerPermission,
    ...sig.activePermissions
  ];

  /// now we find permation we want to use and we have access to all signers
  /// ok now i find permission
  final permission = permissions.singleWhere((e) => e.id == 3);

  /// check if we can send trx or not
  bool hasTrxPermission = false;

  if (permission.operations == null) {
    /// its owner permission and have access to all operations
    hasTrxPermission = true;
  } else {
    final access = TronHelper.decodePermissionOperation(permission.operations!);
    if (access.contains(TransactionContractType.transferContract)) {
      hasTrxPermission = true;
    } else {
      hasTrxPermission = false;
    }
  }

  /// we dont have permission
  if (!hasTrxPermission) {
    return;
  }

  /// ok we have permission and now we initialize all signer address , private key
  /// i use this addresses in updadate_account_permission example
  /// intialize private key, address, receiver and ....
  final seed = BytesUtils.fromHexString(
      "6fed8bf347b201c4ff0379c9173a042163dbd5f1110bcb983ac8615dcbb98c853f7c1b524dcebdf47e2d19778d0b30e25065d5a5012d83b874ab7034e95a713f");
  final bip44 = Bip44.fromSeed(seed, Bip44Coins.tron);
  final wallet1 = bip44.purpose.coin
      .account(0)
      .change(Bip44Changes.chainExt)
      .addressIndex(2);
  final signer1PrivateKey = TronPrivateKey.fromBytes(wallet1.privateKey.raw);
  final wallet2 = bip44.purpose.coin
      .account(0)
      .change(Bip44Changes.chainExt)
      .addressIndex(3);
  final signer2PrivateKey = TronPrivateKey.fromBytes(wallet2.privateKey.raw);

  /// create transfer contract (TRX Transfer)
  final transferContract = TransferContract(
    amount: TronHelper.toSun("1"),
    ownerAddress: ownerAddress,
    toAddress: receiverAddress,
  );

  /// validate transacation and got required data like block hash and ....
  final request = await rpc.request(TronRequestCreateTransaction.fromContract(
      transferContract,
      permissionId: permission.id));
  if (!request.isSuccess) {
    return;
  }

  /// get transactionRaw from response and make sure sed fee limit
  TransactionRaw rawTr = request.transactionRaw!.copyWith(
      feeLimit: TronHelper.toSun("10"),
      data: utf8.encode("https://github.com/mrtnetwork"));

  /// calculate trasaction fee
  /// plese check send_contract_transaction_and_calculate_fee for how to calculate fees
  /// get chain paramets
  final chainParameters = await rpc.request(TronRequestGetChainParameters());

  /// fake tr for calculate current fee before signing
  /// we us 2 signature becuse this transaction need two signature 2 complete
  final fakeTr = Transaction(
      rawData: rawTr, signature: List.generate(2, (index) => Uint8List(65)));

  /// get transaction size
  int bandWidthNeed = fakeTr.length + 64;
  int bandWidthNeedToBurn = 0;

  int totalBurn = 0;

  /// check if i set memo in this example i use memo
  /// https://github.com/mrtnetwork
  totalBurn += chainParameters.getMemoFee!;

  /// check if transaction is multisig
  /// in this case yes
  totalBurn += chainParameters.getMultiSignFee!;

  /// check receiver account is active or not
  final receiverAccountInfo =
      await rpc.request(TronRequestGetAccount(address: receiverAddress));
  if (receiverAccountInfo == null) {
    bandWidthNeedToBurn += chainParameters.getCreateAccountFee!;
    totalBurn += chainParameters.getCreateNewAccountFeeInSystemContract!;
  }

  /// get account resource to check account bandwidth and enrgy
  final accountResource =
      await rpc.request(TronRequestGetAccountResource(address: ownerAddress));

  /// We only reduce if we have the required bandwidth in account
  if (accountResource.howManyBandwIth >= BigInt.from(bandWidthNeed)) {
    bandWidthNeed = 0;
  }
  if (bandWidthNeed > 0) {
    totalBurn += bandWidthNeed * chainParameters.getTransactionFee!;
  }
  if (bandWidthNeedToBurn > 0) {
    totalBurn += bandWidthNeedToBurn * chainParameters.getTransactionFee!;
  }

  /// ok we calculate fee and replace raw transaction with new fee
  rawTr = rawTr.copyWith(feeLimit: BigInt.from(totalBurn));

  /// now we must sign transaction
  /// get raw data for sign
  final rawData = rawTr.toBuffer();

  // txID
  final _ = rawTr.txID;

  /// sign raw data with signers
  final sign1 = signer1PrivateKey.sign(rawData);
  final sign2 = signer2PrivateKey.sign(rawData);

  /// create transaction with raw data and correct signature
  final compeleteTr = Transaction(rawData: rawTr, signature: [sign1, sign2]);

  /// get raw data buffer
  final raw = compeleteTr.toHex;

  /// send transaction to network
  await rpc.request(TronRequestBroadcastHex(transaction: raw));

  /// https://shasta.tronscan.org/#/transaction/0e18d04c2f8fe5489d1d59e50f88daf10f17e8de79cffb4033e47a65fe551c82
}
