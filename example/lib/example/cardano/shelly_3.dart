import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/ada.dart';
import 'provider_example/provider.dart';

void main() async {
  final bip32 = CardanoIcarusBip32.fromSeed(List<int>.filled(20, 12));

  final spend = bip32.derivePath("1852'/1815'/0'/0/0");
  final privateKey = AdaPrivateKey.fromBytes(spend.privateKey.raw);
  ADAEnterpriseAddress addr = ADAEnterpriseAddress.fromPublicKey(
      pubkeyBytes: privateKey.publicKey().toBytes(),
      network: AdaNetwork.testnetPreprod);
  ADAEnterpriseAddress receiver = ADAEnterpriseAddress(
      "addr_test1vpmlrrdzzl68qdr3y7jjzyfmyepnnyjs3lxquckzxc8ysggzzfs29",
      network: AdaNetwork.testnetPreprod);

  final provider = BlockforestProvider(BlockforestHTTPProvider(
      url: "https://cardano-preprod.blockfrost.io/api/v0/",
      projectId: "preprodMVwzqm4PuBDBSfEULoMzoj5QZcy5o3z5"));

  final input = TransactionInput(
      transactionId: TransactionHash.fromHex(
          "bdf37b7b9aa9a849435a15ccd8357462e33f2b863f8ca2b9c85f08b263c154ec"),
      index: 0);

  final output1 = TransactionOutput(
      address: receiver, amount: Value(coin: ADAHelper.toLovelaces("25")));

  final change = TransactionOutput(
      address: addr,
      amount:
          Value(coin: (BigInt.from(9947800000)) - ADAHelper.toLovelaces("26")));

  final fee = ADAHelper.toLovelaces("1");
  final body =
      TransactionBody(inputs: [input], outputs: [change, output1], fee: fee);

  final transaction = ADATransaction(
      body: body,
      witnessSet: TransactionWitnessSet(
          vKeys: [privateKey.createSignatureWitness(body.toHash().data)]));
  await provider.request(BlockfrostRequestSubmitTransaction(
      transactionCborBytes: transaction.serialize()));

  // https://preprod.cardanoscan.io/transaction/283d64ef839705ca53c622f2db2e2ccd4f7db46f0dfa0e82d152d72d215f6cc7
}
