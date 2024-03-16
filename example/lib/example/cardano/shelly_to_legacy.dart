import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/ada.dart';
import 'provider_example/provider.dart';

void main() async {
  final bip32 = CardanoIcarusBip32.fromSeed(List<int>.filled(20, 12));
  final spend = bip32.derivePath("1852'/1815'/0'/0/0");
  final privateKey = AdaPrivateKey.fromBytes(spend.privateKey.raw);

  ADAByronAddress receiver = ADAByronAddress(
      "FHnt4NL7yPXpa2nSSgu36kbQw4jpxWR3V5Yr7MEaPjWa58V3doFnkj3rwzhTTEX",
      network: AdaNetwork.testnetPreprod);

  final provider = BlockforestProvider(BlockforestHTTPProvider(
      url: "https://cardano-preprod.blockfrost.io/api/v0/",
      projectId: "preprodMVwzqm4PuBDBSfEULoMzoj5QZcy5o3z5"));

  final input = TransactionInput(
      transactionId: TransactionHash.fromHex(
          "f8a357442fb3c535533a1b6fc7333661643bbd16c23c1a0a87702b5e14051916"),
      index: 0);
  final output = TransactionOutput(
      address: receiver, amount: Value(coin: ADAHelper.toLovelaces("20")));
  final fee = ADAHelper.toLovelaces("1");
  final body = TransactionBody(inputs: [input], outputs: [output], fee: fee);

  final transaction = ADATransaction(
      body: body,
      witnessSet: TransactionWitnessSet(vKeys: [
        privateKey.createSignatureWitness(body.toHash().data),
      ]));
  await provider.request(BlockfrostRequestSubmitTransaction(
      transactionCborBytes: transaction.serialize()));
  // https://preprod.cardanoscan.io/transaction/1e488da78cd2985dacdfb19d653694207242a5e688bebb0d5f2974735cb093e1
}
