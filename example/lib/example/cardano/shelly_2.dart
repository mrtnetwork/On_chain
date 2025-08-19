import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/ada.dart';
import 'provider_example/provider.dart';

void main() async {
  final bip32 = CardanoIcarusBip32.fromSeed(List<int>.filled(20, 12));
  final spend = bip32.derivePath("1852'/1815'/0'/0/0");
  final privateKey = AdaPrivateKey.fromBytes(spend.privateKey.raw);
  ADAEnterpriseAddress addr = ADAEnterpriseAddress.fromPublicKey(
      pubkeyBytes: spend.publicKey.compressed,
      network: ADANetwork.testnetPreprod);
  ADAEnterpriseAddress receiver = ADAEnterpriseAddress(
      "addr_test1vzkrh0ytcw257np6x6lxp74a6p4erj7rqt9azycnckgp2fgw82qet",
      network: ADANetwork.testnetPreprod);
  ADABaseAddress receiver2 = ADABaseAddress(
      "addr_test1qzkrh0ytcw257np6x6lxp74a6p4erj7rqt9azycnckgp2f27p5uc85frnln985tjn0xv8fmdv4t696d3j9zvu0ktx0gs62w8wv",
      network: ADANetwork.testnetPreprod);

  ADAPointerAddress receiver3 = ADAPointerAddress(
      "addr_test1gzkrh0ytcw257np6x6lxp74a6p4erj7rqt9azycnckgp2fgpqyqskrjv3p",
      network: ADANetwork.testnetPreprod);

  final provider = BlockFrostProvider(BlockFrostHTTPProvider(
      url: "https://cardano-preprod.blockfrost.io/api/v0/",
      projectId: "preprodMVwzqm4PuBDBSfEULoMzoj5QZcy5o3z5"));

  final input = TransactionInput(
      transactionId: TransactionHash.fromHex(
          "3037b51f48c44e9862c3ddee7aee08278d3ec8f9a241018888b0728eaa359e3b"),
      index: 1);
  final input2 = TransactionInput(
      transactionId: TransactionHash.fromHex(
          "2d142d849e71ca0d3b5fa50b83a3de74b8855b95f051d741819bc50a579b7d88"),
      index: 0);
  final output1 = TransactionOutput(
      address: receiver, amount: Value(coin: ADAHelper.toLovelaces("10")));
  final output2 = TransactionOutput(
      address: receiver2, amount: Value(coin: ADAHelper.toLovelaces("10")));

  final output4 = TransactionOutput(
      address: receiver3, amount: Value(coin: ADAHelper.toLovelaces("10")));
  final change = TransactionOutput(
      address: addr,
      amount: Value(
          coin: (BigInt.from(9977800000) + BigInt.from(1000000)) -
              ADAHelper.toLovelaces("31")));
  final fee = ADAHelper.toLovelaces("1");
  final body = TransactionBody(
      inputs: TransactionInputs([input, input2]),
      outputs: TransactionOutputs([change, output1, output2, output4]),
      fee: fee);

  final transaction = ADATransaction(
      body: body,
      witnessSet: TransactionWitnessSet(
          vKeys: VkeyWitnesses([
        privateKey.createSignatureWitness(body.toHash().data),
      ])));
  await provider.request(BlockfrostRequestSubmitTransaction(
      transactionCborBytes: transaction.serialize()));

  /// https://preprod.cardanoscan.io/transaction/bdf37b7b9aa9a849435a15ccd8357462e33f2b863f8ca2b9c85f08b263c154ec
}

extension Hex on List<int> {
  String toHex() {
    return BytesUtils.toHexString(this);
  }
}
