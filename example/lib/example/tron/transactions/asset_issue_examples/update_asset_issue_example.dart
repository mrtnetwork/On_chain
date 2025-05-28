import 'dart:convert';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:example/example/tron/provider_service/provider_service.dart';
import 'package:on_chain/on_chain.dart';

void main() async {
  /// intialize private key, address, receiver and ....
  final seed = BytesUtils.fromHexString(
      "6fed8bf347b201c4ff0379c9173a042163dbd5f1110bcb983ac8615dcbb98c853f7c1b524dcebdf47e2d19778d0b30e25065d5a5012d83b874ab7034e95a713f");
  final bip44 = Bip44.fromSeed(seed, Bip44Coins.tron);
  final prv = TronPrivateKey.fromBytes(bip44.privateKey.raw);
  final publicKey = prv.publicKey();
  final address = publicKey.toAddress();

  /// intialize shasta http provider to send and receive requests
  final rpc =
      TronProvider(TronHTTPProvider(url: "https://api.shasta.trongrid.io"));

  /// create update asset issue contract (update trc10 token)
  final contract = UpdateAssetContract(
      ownerAddress: address,
      description: utf8.encode("TOKEN FOR FUN"),
      url: utf8.encode("https://github.com/mrtnetwork"),
      newLimit: BigInt.from(150000),
      newPublicLimit: BigInt.from(250000));

  /// validate transacation and got required data like block hash and ....
  final request = await rpc.request(TronRequestUpdateAsset.fromContract(

      /// params: permission ID (multi-sig Transaction)
      contract));

  /// get transactionRaw from response and make sure set fee limit
  final rawTr = request.rawData.copyWith(
      feeLimit: BigInt.from(10000000),
      data: utf8.encode("https://github.com/mrtnetwork"));

  /// txID
  final _ = rawTr.txID;
  // /// get transaaction digest and sign with private key
  final sign = prv.sign(rawTr.toBuffer());

  // /// create transaction object and add raw data and signature to this
  final transaction = Transaction(rawData: rawTr, signature: [sign]);

  // /// get raw data buffer
  final raw = BytesUtils.toHexString(transaction.toBuffer());

  /// send transaction to network
  await rpc.request(TronRequestBroadcastHex(transaction: raw));

  /// https://shasta.tronscan.org/#/transaction/f3dbcb4b11a56660fdda4abd66f305c6ea59b8270bcdc8ddc4c49994177e5197
}
