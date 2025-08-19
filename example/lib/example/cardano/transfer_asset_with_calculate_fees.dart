import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/ada.dart';
import 'provider_example/provider.dart';

/// input and output its same address i forget to change it :)
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

  final input = TransactionInput(
      transactionId: TransactionHash.fromHex(
          "35d4777fed0146f97012b9ccb0a19120ab4ab2c6210ab36ee2026ae9689a7939"),
      index: 1);
  final assetInfo = ADAHelper.separatePolcyAndAssetName(
      "7ac8989ef4d5f77fbbc0e783a789a21061bf9e78b1e2ab4996f9e47b4d5254");
  final BigInt utxoAmount = BigInt.from(11000000);
  final output = TransactionOutput(
      address: receiver,
      amount: Value(
          coin: BigInt.from(3000000),
          multiAsset: MultiAsset({
            assetInfo.item1: Assets({assetInfo.item2: BigInt.from(1000)})
          })));

  /// set maximum fee
  BigInt fee = ADAHelper.toLovelaces("1");
  TransactionOutput change = TransactionOutput(
      address: addr,
      amount: Value(coin: utxoAmount - (BigInt.from(3000000) + fee)));

  TransactionBody body = TransactionBody(
      inputs: TransactionInputs([input]),
      outputs: TransactionOutputs([change, output]),
      fee: fee);

  ADATransaction transaction = ADATransaction(
      body: body,
      witnessSet: TransactionWitnessSet(
          vKeys: VkeyWitnesses([
        privateKey.createSignatureWitness(body.toHash().data),
      ])));
  final param =
      await provider.request(BlockfrostRequestLatestEpochProtocolParameters());
  fee = param.calculateFee(transaction.size);
  change = change.copyWith(
      amount: Value(
    coin: utxoAmount - (BigInt.from(3000000) + fee),
  ));
  body = body.copyWith(outputs: TransactionOutputs([change, output]), fee: fee);
  transaction = transaction.copyWith(
      body: body,
      witnessSet: TransactionWitnessSet(
          vKeys: VkeyWitnesses([
        privateKey.createSignatureWitness(body.toHash().data),
      ])));
  await provider.request(BlockfrostRequestSubmitTransaction(
      transactionCborBytes: transaction.serialize()));

  /// https://preprod.cardanoscan.io/transaction/fc259f25ca49240fef9a55b8eba057b2138d4c2dad519ee1ae57daf1f5dd4de2
}

extension Hex on List<int> {
  String toHex() {
    return BytesUtils.toHexString(this);
  }
}
