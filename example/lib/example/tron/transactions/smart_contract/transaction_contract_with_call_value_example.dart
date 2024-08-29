import 'dart:convert';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:example/example/tron/provider_service/provider_service.dart';
import 'package:example/example/tron/transactions/smart_contract/payable_abi.dart';
import 'package:on_chain/on_chain.dart';

void main() async {
  /// intialize private key, address, receiver and ....
  final seed = BytesUtils.fromHexString(
      "6fed8bf347b201c4ff0379c9173a042163dbd5f1110bcb983ac8615dcbb98c853f7c1b524dcebdf47e2d19778d0b30e25065d5a5012d83b874ab7034e95a713f");
  final bip44 = Bip44.fromSeed(seed, Bip44Coins.tron);
  final ownerPrivateKey = TronPrivateKey.fromBytes(bip44.privateKey.raw);
  final ownerPublicKey = ownerPrivateKey.publicKey();
  final ownerAddress = ownerPublicKey.toAddress();

  /// intialize shasta http provider to send and receive requests
  final rpc =
      TronProvider(TronHTTPProvider(url: "https://api.shasta.trongrid.io"));

  final contract = ContractABI.fromJson(payableContractTest["entrys"]!);

  final function = contract.functionFromName("PayWithTRX");

  /// address /// amount
  final transferparams = [];

  final contractAddress = TronAddress("TFXP3tb7MABUNLL2FqGFNjSwHP6gnQ7vrg");

  final request = await rpc.request(
    TronRequestTriggerConstantContract(
        ownerAddress: ownerAddress,
        contractAddress: contractAddress,
        data: function.encodeHex(transferparams),
        callValue: TronHelper.toSun("10")),
  );
  if (!request.isSuccess) {
    ///   print("${request.error} \n ${request.respose}");
    return;
  }

  /// get transactionRaw from response and make sure set fee limit
  final rawTr = request.transactionRaw!.copyWith(
      feeLimit: TronHelper.toSun("25"),
      data: utf8.encode("https://github.com/mrtnetwork"));

  /// txID
  final _ = rawTr.txID;

  /// get transaaction digest and sign with private key
  final sign = ownerPrivateKey.sign(rawTr.toBuffer());

  /// create transaction object and add raw data and signature to this
  final transaction = Transaction(rawData: rawTr, signature: [sign]);

  /// send transaction to network
  await rpc.request(TronRequestBroadcastHex(transaction: transaction.toHex));

  /// https://shasta.tronscan.org/#/transaction/ff69ad39e1deb621b4439beacb0f9684d8e648167e03b05a5633ef550bb2f0d6
}
