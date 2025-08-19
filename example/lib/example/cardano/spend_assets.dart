import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/ada.dart';
import 'provider_example/provider.dart';

void main() async {
  final bip32 = CardanoIcarusBip32.fromSeed(List<int>.filled(20, 12));
  final spend = bip32.derivePath("1852'/1815'/0'/0/0");
  final privateKey = AdaPrivateKey.fromBytes(spend.privateKey.raw);
  ADAEnterpriseAddress addr = ADAEnterpriseAddress(
      "addr_test1vp0q6wvr6y3elejn69efhnxr5akk24azaxcez3xw8m9n85gmr5qny",
      network: ADANetwork.testnetPreprod);
  ADAEnterpriseAddress receiver = ADAEnterpriseAddress(
      "addr_test1vp0q6wvr6y3elejn69efhnxr5akk24azaxcez3xw8m9n85gmr5qny",
      network: ADANetwork.testnetPreprod);

  final provider = BlockFrostProvider(BlockFrostHTTPProvider(
      url: "https://cardano-preprod.blockfrost.io/api/v0/",
      projectId: "preprodMVwzqm4PuBDBSfEULoMzoj5QZcy5o3z5"));

  final policyId = PolicyID.fromHex(
      "7ac8989ef4d5f77fbbc0e783a789a21061bf9e78b1e2ab4996f9e47b");
  final assentName = AssetName("MRT".codeUnits);
  final BigInt supply = BigInt.from(2500000000);
  final input = TransactionInput(
      transactionId: TransactionHash.fromHex(
          "22abd233e70762aa64b8baccf0b42db05e5adac49c86e1d6ace1466eab4ad36c"),
      index: 0);
  final output = TransactionOutput(
      address: receiver,
      amount: Value(
          coin: ADAHelper.toLovelaces("11"),
          multiAsset: MultiAsset({
            policyId: Assets({assentName: BigInt.from(1000)})
          })));
  final change = TransactionOutput(
    address: addr,
    amount: Value(
        coin: BigInt.from(9897800000) - ADAHelper.toLovelaces("12"),
        multiAsset: MultiAsset({
          policyId: Assets({assentName: supply - BigInt.from(1000)})
        })),
  );

  final fee = ADAHelper.toLovelaces("1");

  final body = TransactionBody(
      inputs: TransactionInputs([input]),
      outputs: TransactionOutputs([change, output]),
      fee: fee);
  final transaction = ADATransaction(
      body: body,
      witnessSet: TransactionWitnessSet(
        vKeys: VkeyWitnesses([
          privateKey.createSignatureWitness(body.toHash().data),
        ]),
      ));
  await provider.request(BlockfrostRequestSubmitTransaction(
      transactionCborBytes: transaction.serialize()));

  /// https://preprod.cardanoscan.io/transaction/35d4777fed0146f97012b9ccb0a19120ab4ab2c6210ab36ee2026ae9689a7939?tab=utxo
}
