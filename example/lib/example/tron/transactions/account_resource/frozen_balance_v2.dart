import 'dart:convert';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:example/example/tron/provider_service/provider_service.dart';
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

  /// create contract
  final contract = FreezeBalanceV2Contract(
      ownerAddress: ownerAddress,
      frozenBalance: TronHelper.toSun("3.5"),
      resource: ResourceCode.bandWidth);

  /// validate transacation and got required data like block hash and ....
  final request = await rpc.request(TronRequestFreezeBalanceV2.fromContract(

      /// params: permission ID (multi-sig Transaction)
      contract));

  /// An error has occurred with the request, and we need to investigate the issue to determine what is happening.
  if (!request.isSuccess) {
    //// print(request.error);
    return;
  }

  /// get transactionRaw from response and make sure set fee limit
  final rawTr = request.transactionRaw!.copyWith(
      feeLimit: BigInt.from(10000000),
      data: utf8.encode("https://github.com/mrtnetwork"));

  final _ = rawTr.txID;

  /// get transaaction digest and sign with private key
  final sign = ownerPrivateKey.sign(rawTr.toBuffer());

  /// create transaction object and add raw data and signature to this
  final transaction = Transaction(rawData: rawTr, signature: [sign]);

  /// send transaction to network
  await rpc.request(TronRequestBroadcastHex(transaction: transaction.toHex));

  /// bandwidth
  /// https://shasta.tronscan.org/#/transaction/4a5c796e4f7aab16e5bcc51e85057977f604a04110baaec24c6cf4d266c375b6
  /// energy
  /// https://shasta.tronscan.org/#/transaction/18d2555aa05e6629772157500078db2424ee84c9d2f3ba98f9920cd282eb5ab0
}
