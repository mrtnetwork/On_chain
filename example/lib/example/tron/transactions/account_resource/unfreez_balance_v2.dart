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
  final contract = UnfreezeBalanceV2Contract(
      ownerAddress: ownerAddress,
      unfreezeBalance: TronHelper.toSun("1.2"),
      resource: ResourceCode.energy);

  /// validate transacation and got required data like block hash and ....
  final request = await rpc.request(TronRequestUnfreezeBalanceV2.fromContract(

      /// params: contract and permission ID (multi-sig Transaction)
      contract,
      permissionId: null));

  /// get transactionRaw from response and make sure set fee limit
  final rawTr = request.rawData.copyWith(
      feeLimit: BigInt.from(10000000),
      data: utf8.encode("https://github.com/mrtnetwork"));

  // return;

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

  /// bandwidth
  /// https://shasta.tronscan.org/#/transaction/08613cbc8f234d7ad5037529ee332cff71e364d6197e8f739cf541db51337d44
  /// energy
  /// https://shasta.tronscan.org/#/transaction/9b021238d0d9d62c1b7217189d1f7d163777562b33e4ee1823ea49136b50d062
}
