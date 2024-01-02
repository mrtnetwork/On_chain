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
  final receiverAddress = TronAddress("TF3cDajEAaJ8jFXFB2KF3XSUbTpZWzuSrp");

  /// intialize shasta http provider to send and receive requests
  final rpc =
      TronProvider(TronHTTPProvider(url: "https://api.shasta.trongrid.io"));

  /// create transfer contract (TRX Transfer)
  final transferContract = TransferContract(
    /// 10 TRX
    amount: TronHelper.toSun("10"),
    ownerAddress: address,
    toAddress: receiverAddress,
  );

  /// validate transacation and got required data like block hash and ....
  final request = await rpc.request(TronRequestCreateTransaction.fromContract(

      /// params: permission ID (multi-sig Transaction), optional data like memo
      transferContract,
      visible: false));

  /// An error has occurred with the request, and we need to investigate the issue to determine what is happening.
  if (!request.isSuccess) {
    /// print(request.error ?? request.respose);
    return;
  }

  /// get transactionRaw from response and make sure sed fee limit
  final rawTr =
      request.transactionRaw!.copyWith(feeLimit: BigInt.from(10000000));

  // txID
  final _ = rawTr.txID;

  /// get transaaction digest and sign with private key
  final sign = prv.sign(rawTr.toBuffer());

  /// create transaction object and add raw data and signature to this
  final transaction = Transaction(rawData: rawTr, signature: [sign]);

  /// get raw data buffer
  final raw = BytesUtils.toHexString(transaction.toBuffer());

  /// send transaction to network
  await rpc.request(TronRequestBroadcastHex(transaction: raw));

  /// https://shasta.tronscan.org/#/transaction/235b4b345312ffc8b332a4a06614df91e0da8bd79de3a4f0855932e0ecf58b40
}
