import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/ada.dart';
import 'provider_example/provider.dart';

void main() async {
  final bip32 = CardanoIcarusBip32.fromSeed(List<int>.filled(20, 12));
  final spend = bip32.derivePath("1852'/1815'/0'/0/0");
  final privateKey = AdaPrivateKey.fromBytes(spend.privateKey.raw);

  ADAEnterpriseAddress addr = ADAEnterpriseAddress(
      "addr_test1vp0q6wvr6y3elejn69efhnxr5akk24azaxcez3xw8m9n85gmr5qny",
      network: AdaNetwork.testnetPreprod);

  ADAEnterpriseAddress receiver = ADAEnterpriseAddress(
      "addr_test1vp0q6wvr6y3elejn69efhnxr5akk24azaxcez3xw8m9n85gmr5qny",
      network: AdaNetwork.testnetPreprod);

  final provider = BlockforestProvider(BlockforestHTTPProvider(
      url: "https://cardano-preprod.blockfrost.io/api/v0/",
      projectId: "preprodMVwzqm4PuBDBSfEULoMzoj5QZcy5o3z5"));

  final input = TransactionInput(
      transactionId: TransactionHash.fromHex(
          "6419830644a3310e8ddf55998154bd07afe9f4a73872b6dd4d39ac43ff59ad8c"),
      index: 0);
  final output = TransactionOutput(
      address: receiver, amount: Value(coin: ADAHelper.toLovelaces("1")));
  final change = TransactionOutput(
      address: addr,
      amount: Value(
          coin: ADAHelper.toLovelaces("10000") - ADAHelper.toLovelaces("1.2")));
  final fee = ADAHelper.toLovelaces("0.2");

  final body =
      TransactionBody(inputs: [input], outputs: [change, output], fee: fee);

  final transaction = ADATransaction(
      body: body,
      witnessSet: TransactionWitnessSet(vKeys: [
        privateKey.createSignatureWitness(body.toHash().data),
      ]));
  await provider.request(BlockfrostRequestSubmitTransaction(
      transactionCborBytes: transaction.serialize()));

  /// https://preprod.cardanoscan.io/transaction/3037b51f48c44e9862c3ddee7aee08278d3ec8f9a241018888b0728eaa359e3b
}

extension Hex on List<int> {
  String toHex() {
    return BytesUtils.toHexString(this);
  }
}
