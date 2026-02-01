import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/ada.dart';
import 'provider_example/provider.dart';

void main() async {
  final byronLegacyWallet =
      CardanoByronLegacy.fromSeed(List<int>.filled(32, 12));
  final key = byronLegacyWallet.deriveKey(Bip32KeyIndex(0), Bip32KeyIndex(2));
  final privateKey = key.privateKey;
  final adaPrivateKey = AdaPrivateKey.fromBytes(privateKey.raw);
  final receiverLegacy = ADAByronAddress(
      "KjgoiXJS2coQ3nS6mdqjBvy1HnFKgiZEeTbNTtncA1HgTEDnbkhXkFKBQn5DxXiGZ4nZp25VtcqvMfpg4QRPdVELJE8LpWkyLav3kcKyXc2w",
      network: ADANetwork.testnetPreprod);
  final multiSig = ADAByronAddress(
    "KjgoiXJS2coqEj7BmUEY9TSJxppxySTBNDskVreRH2VN9TGV2SX1b8BRstVaPAA7eWCsEFLg8VKj47mNLJ5M21qPiaZqxphEYDBjdwvg44ot",
    network: ADANetwork.testnetPreprod,
  );
  final provider = BlockFrostProvider(BlockFrostHTTPProvider(
      url: "https://cardano-preprod.blockfrost.io/api/v0/",
      projectId: "preprodMVwzqm4PuBDBSfEULoMzoj5QZcy5o3z5"));
  final body = TransactionBody(
      inputs: TransactionInputs([
        TransactionInput(
            transactionId: TransactionHash.fromHex(
                "436fd1b30d6f5fdee6dc6772f47c1b15d9bfc9a6afff4f38820e68c006ac2749"),
            index: 0)
      ]),
      outputs: TransactionOutputs([
        TransactionOutput(
            address: receiverLegacy,
            amount: Value(coin: ADAHelper.toLovelaces("100"))),
        TransactionOutput(
            address: multiSig,
            amount: Value(
                coin: ADAHelper.toLovelaces("10000") -
                    ADAHelper.toLovelaces("101"))),
      ]),
      fee: ADAHelper.toLovelaces("1"));

  final withness = adaPrivateKey.createBootstrapWitness(
      chainCode: key.chainCode.toBytes(),
      address: multiSig,
      digest: body.toHash().data);

  final transaction = ADATransaction(
    body: body,
    witnessSet:
        TransactionWitnessSet(bootstraps: BootstrapWitnesses([withness])),
  );
  await provider.request(BlockfrostRequestSubmitTransaction(
      transactionCborBytes: transaction.serialize()));

  /// https://preprod.cardanoscan.io/transaction/433ed3da1e8b910385c93ae494e4bbe4849c42a8a0f860d2d066bb3215234a16
}
