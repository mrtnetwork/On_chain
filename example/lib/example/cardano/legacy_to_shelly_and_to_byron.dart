import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/ada.dart';
import 'provider_example/provider.dart';

void main() async {
  final byronLegacyWallet =
      CardanoByronLegacy.fromSeed(List<int>.filled(32, 12));
  final privateKey = byronLegacyWallet.getPrivateKey(
      firstIndex: Bip32KeyIndex(0), secondIndex: Bip32KeyIndex(2));
  final adaPrivateKey = AdaPrivateKey.fromBytes(privateKey.raw);
  final pubkey = byronLegacyWallet.getPublicKey(
      firstIndex: Bip32KeyIndex(0), secondIndex: Bip32KeyIndex(2));
  final receiver = ADABaseAddress.fromPublicKey(
      basePubkeyBytes: byronLegacyWallet.masterPublicKey.compressed,
      stakePubkeyBytes: byronLegacyWallet.masterPublicKey.compressed,
      network: ADANetwork.testnet);
  final receiver2 = ADAByronAddress.fromPublicKey(
      chaincode: pubkey.chainCode.toBytes(),
      publicKey: pubkey.compressed,
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
                "433ed3da1e8b910385c93ae494e4bbe4849c42a8a0f860d2d066bb3215234a16"),
            index: 1)
      ]),
      outputs: TransactionOutputs([
        TransactionOutput(
            address: receiver,
            amount: Value(coin: ADAHelper.toLovelaces("100"))),
        TransactionOutput(
            address: receiver2,
            amount: Value(coin: ADAHelper.toLovelaces("100"))),
        TransactionOutput(
            address: multiSig,
            amount: Value(
                coin: BigInt.from(9899000000) - ADAHelper.toLovelaces("201"))),
      ]),
      fee: ADAHelper.toLovelaces("1"));
  final withness = adaPrivateKey.createBootstrapWitness(
      address: multiSig,
      chainCode: privateKey.chainCode.toBytes(),
      digest: body.toHash().data);
  final transaction = ADATransaction(
    body: body,
    witnessSet:
        TransactionWitnessSet(bootstraps: BootstrapWitnesses([withness])),
  );
  await provider.request(BlockfrostRequestSubmitTransaction(
      transactionCborBytes: transaction.serialize()));
  // https://preprod.cardanoscan.io/transaction/22528a2e224e0405559d12d687d39717cb37130564d8a4ed4058dfe392b8e109
}
