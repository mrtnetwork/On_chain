import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/ada.dart';
import 'provider_example/provider.dart';

void main() async {
  /// generate 32byte private key ED25519 from solana coin
  final bip44 = Bip44.fromSeed(List<int>.filled(32, 0), Bip44Coins.solana);
  final privateKey = AdaPrivateKey.fromBytes(bip44.privateKey.raw);

  ADAEnterpriseAddress receiver = ADAEnterpriseAddress(
      "addr_test1vp0q6wvr6y3elejn69efhnxr5akk24azaxcez3xw8m9n85gmr5qny",
      network: AdaNetwork.testnetPreprod);

  final provider = BlockforestProvider(BlockforestHTTPProvider(
      url: "https://cardano-preprod.blockfrost.io/api/v0/",
      projectId: "preprodMVwzqm4PuBDBSfEULoMzoj5QZcy5o3z5"));

  final input = TransactionInput(
      transactionId: TransactionHash.fromHex(
          "3d9ccb18497c97e5ecd3ff1d0a01318d4d3881885263d2471ca64469cd25481b"),
      index: 0);

  final output1 = TransactionOutput(
      address: receiver, amount: Value(coin: ADAHelper.toLovelaces("22")));

  final fee = ADAHelper.toLovelaces("1");
  final body = TransactionBody(inputs: [input], outputs: [output1], fee: fee);

  final transaction = ADATransaction(
      body: body,
      witnessSet: TransactionWitnessSet(
          vKeys: [privateKey.createSignatureWitness(body.toHash().data)]));
  await provider.request(BlockfrostRequestSubmitTransaction(
      transactionCborBytes: transaction.serialize()));
  // https://preprod.cardanoscan.io/transaction/92c09a96d612d1dae606d323dfe24c41c933d27b712f68ca6d82c6b5d096e7b3
}
