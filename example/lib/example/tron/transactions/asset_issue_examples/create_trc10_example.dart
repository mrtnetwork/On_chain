import 'dart:convert';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:example/example/tron/provider_service/provider_service.dart';
import 'package:on_chain/on_chain.dart';

void main() async {
  /// intialize private key, address, receiver and ....
  final seed = BytesUtils.fromHexString(
      "6fed8bf347b201c4ff0379c9173a042163dbd5f1110bcb983ac8615dcbb98c853f7c1b524dcebdf47e2d19778d0b30e25065d5a5012d83b874ab7034e95a713f");
  final bip44 = Bip44.fromSeed(seed, Bip44Coins.tron);
  final prv =
      TronPrivateKey.fromBytes(bip44.purpose.coin.account(25).privateKey.raw);
  final publicKey = prv.publicKey();
  final address = publicKey.toAddress();

  /// intialize shasta http provider to send and receive requests
  final rpc =
      TronProvider(TronHTTPProvider(url: "https://api.shasta.trongrid.io"));

  /// create transfer contract (TRX Transfer)
  final transferContract = AssetIssueContract(
      ownerAddress: address,
      abbr: utf8.encode("MRT"),
      name: utf8.encode("MRTTRC10"),
      description: utf8.encode("TOKEN FOR FUN"),
      url: utf8.encode("https://github.com/mrtnetwork"),
      totalSupply: BigInt.from(30000000000000000),
      num: 5,
      frozenSupply: [
        AssetIssueContractFrozenSupply(
            frozenAmount: BigInt.from(1000000), frozenDays: BigInt.from(10))
      ],
      precision: 3,
      trxNum: 5,
      endTime: BigInt.from(
          DateTime.now().add(const Duration(days: 30)).millisecondsSinceEpoch),
      startTime: BigInt.from(
          DateTime.now().add(const Duration(hours: 1)).millisecondsSinceEpoch));

  /// validate transacation and got required data like block hash and ....
  final request = await rpc.request(TronRequestCreateAssetIssue.fromContract(

      /// params: permission ID (multi-sig Transaction)
      transferContract));

  /// An error has occurred with the request, and we need to investigate the issue to determine what is happening.
  if (!request.isSuccess) {
    ///  print(request.error);
    return;
  }

  /// get transactionRaw from response and make sure set fee limit
  final rawTr = request.transactionRaw!.copyWith(
      feeLimit: BigInt.from(10000000),
      data: utf8.encode("https://github.com/mrtnetwork"));

  /// txID
  final _ = rawTr.txID;

  /// get transaaction digest and sign with private key
  final sign = prv.sign(rawTr.toBuffer());

  /// create transaction object and add raw data and signature to this
  final transaction = Transaction(rawData: rawTr, signature: [sign]);

  // /// get raw data buffer
  final raw = BytesUtils.toHexString(transaction.toBuffer());

  // /// send transaction to network
  await rpc.request(TronRequestBroadcastHex(transaction: raw));

  /// https://shasta.tronscan.org/#/transaction/2622e46ad169cea7e5a207ed3ea05456f4d5aca7858a38bcd2d0a4b57185a40e
}
