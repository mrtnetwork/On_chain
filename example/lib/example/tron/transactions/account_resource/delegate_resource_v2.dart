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
  final accountForCreate = TronAddress("TTQ5iiGK45w3Za5R8jBjYDHEywoZZgGt8j");

  /// intialize shasta http provider to send and receive requests
  final rpc =
      TronProvider(TronHTTPProvider(url: "https://api.shasta.trongrid.io"));

  /// create contract
  final contract = DelegateResourceContract(
      ownerAddress: ownerAddress,
      balance: TronHelper.toSun("1"),
      receiverAddress: accountForCreate,
      resource: ResourceCode.energy,
      lock: true,
      lockPeriod: BigInt.from(3));

  /// validate transacation and got required data like block hash and ....
  final request = await rpc.request(TronRequestDelegateResource.fromContract(

      /// params: contract and permission ID (multi-sig Transaction)
      contract,
      permissionId: null));

  /// An error has occurred with the request, and we need to investigate the issue to determine what is happening.
  if (!request.isSuccess) {
    // print(request.error);
    return;
  }

  /// get transactionRaw from response and make sure set fee limit
  final rawTr = request.transactionRaw!.copyWith(
      feeLimit: BigInt.from(10000000),
      data: utf8.encode("https://github.com/mrtnetwork"));

  /// txID
  final _ = rawTr.txID;

  /// get transaaction digest and sign with private key
  final sign = ownerPrivateKey.sign(rawTr.toBuffer());

  // /// create transaction object and add raw data and signature to this
  final transaction = Transaction(rawData: rawTr, signature: [sign]);

  // /// get raw data buffer
  final raw = BytesUtils.toHexString(transaction.toBuffer());

  // /// send transaction to network
  await rpc.request(TronRequestBroadcastHex(transaction: raw));

  /// energy
  /// https://shasta.tronscan.org/#/transaction/5f3de10df1097d7d351b1508a44f4c6515d123138fffb5b8d31016ce774fe400
}
