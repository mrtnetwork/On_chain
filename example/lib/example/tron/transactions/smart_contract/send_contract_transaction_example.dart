import 'dart:convert';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:example/example/tron/provider_service/provider_service.dart';
import 'package:on_chain/on_chain.dart';

import 'trc20_abi.dart';

void main() async {
  /// intialize private key, address, receiver and ....
  final seed = BytesUtils.fromHexString(
      "6fed8bf347b201c4ff0379c9173a042163dbd5f1110bcb983ac8615dcbb98c853f7c1b524dcebdf47e2d19778d0b30e25065d5a5012d83b874ab7034e95a713f");
  final bip44 = Bip44.fromSeed(seed, Bip44Coins.tron);
  final ownerPrivateKey = TronPrivateKey.fromBytes(bip44.privateKey.raw);
  final ownerPublicKey = ownerPrivateKey.publicKey();
  final ownerAddress = ownerPublicKey.toAddress();
  final receiverAddress =
      TronPrivateKey.fromBytes(bip44.deriveDefaultPath.privateKey.raw)
          .publicKey()
          .toAddress();

  /// intialize shasta http provider to send and receive requests
  final rpc =
      TronProvider(TronHTTPProvider(url: "https://api.shasta.trongrid.io"));

  final contract = ContractABI.fromJson(trc20Abi);

  final function = contract.functionFromName("transfer");

  /// address /// amount
  final transferparams = [receiverAddress, BigInt.from(10000000000)];

  final contractAddress = TronAddress("TPVyWcQ6JERNnX2AaPwSSk9JkDhPXsUfg5");

  final request = await rpc.request(
    TronRequestTriggerConstantContract(
      ownerAddress: ownerAddress,
      contractAddress: contractAddress,
      data: function.encodeHex(transferparams),
    ),
  );
  if (!request.isSuccess) {
    ///   print("${request.error} \n ${request.respose}");
    return;
  }

  /// get transactionRaw from response and make sure set fee limit
  final rawTr = request.transaction!.rawData.copyWith(
      feeLimit: TronHelper.toSun("25"),
      data: utf8.encode("https://github.com/mrtnetwork"));

  /// txID
  final _ = rawTr.txID;

  /// get transaaction digest and sign with private key
  final sign = ownerPrivateKey.sign(rawTr.toBuffer());

  /// create transaction object and add raw data and signature to this
  final transaction = Transaction(rawData: rawTr, signature: [sign]);

  /// get raw data buffer
  final raw = BytesUtils.toHexString(transaction.toBuffer());

  /// send transaction to network
  await rpc.request(TronRequestBroadcastHex(transaction: raw));

  /// https://shasta.tronscan.org/#/transaction/f0fe0c8c2c91973bcf4ad8f50e8f8e8f6b6a8e348b856be5b1c832f8df74d262
}
