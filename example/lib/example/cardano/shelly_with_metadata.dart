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
      "addr_test1vp0q6wvr6y3elejn69efhnxr5akk24azaxcez3xw8m9n85gmr5qny",
      network: ADANetwork.testnetPreprod);

  final provider = BlockFrostProvider(BlockFrostHTTPProvider(
      url: "https://cardano-preprod.blockfrost.io/api/v0/",
      projectId: "preprodMVwzqm4PuBDBSfEULoMzoj5QZcy5o3z5"));

  final input = TransactionInput(
      transactionId: TransactionHash.fromHex(
          "283d64ef839705ca53c622f2db2e2ccd4f7db46f0dfa0e82d152d72d215f6cc7"),
      index: 0);

  final output = TransactionOutput(
      address: receiver, amount: Value(coin: ADAHelper.toLovelaces("11")));

  final changeOutput = TransactionOutput(
      address: addr,
      amount:
          Value(coin: BigInt.from(9921800000) - ADAHelper.toLovelaces("12")));
  final fee = ADAHelper.toLovelaces("1");

  final decode = StringUtils.toJson('''{"map":[
            {
            "k":{"list":[
                {"map": [
                    {
                        "k": {"string": "github"},
                        "v": {"string": "https://github.com/mrtnetwork/On_chain"}
                    }
                ]}
            ]},
            "v":{"string":"MRT"}
            }
        ]}''');
  final metadata = TransactionMetadata.fromJsonSchema(
      json: decode, jsonSchema: MetadataJsonSchema.detailedSchema);
  final auxiliaryData = AuxiliaryData(
      metadata: GeneralTransactionMetadata(metadata: {BigInt.one: metadata}));
  final body = TransactionBody(
      inputs: TransactionInputs([input]),
      outputs: TransactionOutputs([changeOutput, output]),
      fee: fee,
      auxiliaryDataHash: auxiliaryData.toHash());
  // return;
  final transaction = ADATransaction(
      body: body,
      data: auxiliaryData,
      witnessSet: TransactionWitnessSet(
          vKeys: VkeyWitnesses([
        privateKey.createSignatureWitness(body.toHash().data),
      ])));
  await provider.request(BlockfrostRequestSubmitTransaction(
      transactionCborBytes: transaction.serialize()));

  /// https://preprod.cardanoscan.io/transaction/42680df36ee51b932d2fd62c736b34ca6f2ecfe702e687529b565e157c335088?tab=metadata
}
