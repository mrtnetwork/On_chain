import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/ada.dart';
import 'provider_example/provider.dart';

void main() async {
  /// Create a BIP32 derivation from a seed
  final bip32 = CardanoIcarusBip32.fromSeed(List<int>.filled(20, 12));

  /// Derive a spending key from the BIP32 derivation path
  final spend = bip32.derivePath("1852'/1815'/0'/0/0");

  /// Extract the private key from the spending key
  final privateKey = AdaPrivateKey.fromBytes(spend.privateKey.raw);

  /// Define the sender enterprise address
  ADAEnterpriseAddress addr = ADAEnterpriseAddress(
      "addr_test1vp0q6wvr6y3elejn69efhnxr5akk24azaxcez3xw8m9n85gmr5qny",
      network: ADANetwork.testnetPreprod);

  /// Define the receiver enterprise address
  ADAEnterpriseAddress receiver = ADAEnterpriseAddress(
      "addr_test1vp0q6wvr6y3elejn69efhnxr5akk24azaxcez3xw8m9n85gmr5qny",
      network: ADANetwork.testnetPreprod);

  /// Set up the Blockfrost provider
  final provider = BlockFrostProvider(BlockFrostHTTPProvider(
      url: "https://cardano-preprod.blockfrost.io/api/v0/",
      projectId: "preprodMVwzqm4PuBDBSfEULoMzoj5QZcy5o3z5"));

  /// Define transaction inputs and outputs
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

  /// Construct the transaction body
  final body =
      TransactionBody(inputs: [input], outputs: [change, output], fee: fee);

  /// Create the ADA transaction with witness
  final transaction = ADATransaction(
      body: body,
      witnessSet: TransactionWitnessSet(vKeys: [
        privateKey.createSignatureWitness(body.toHash().data),
      ]));

  /// Submit the transaction via Blockfrost provider
  await provider.request(BlockfrostRequestSubmitTransaction(
      transactionCborBytes: transaction.serialize()));

  /// https://preprod.cardanoscan.io/transaction/3037b51f48c44e9862c3ddee7aee08278d3ec8f9a241018888b0728eaa359e3b
}

extension Hex on List<int> {
  String toHex() {
    return BytesUtils.toHexString(this);
  }
}
