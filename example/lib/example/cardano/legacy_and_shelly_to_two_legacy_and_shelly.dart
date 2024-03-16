import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/ada.dart';
import 'provider_example/provider.dart';

void main() async {
  final byronLegacy = CardanoByronLegacy.fromSeed(List<int>.filled(32, 12));
  final privateKey = byronLegacy.getPrivateKey(
      firstIndex: Bip32KeyIndex(0), secondIndex: Bip32KeyIndex(2));
  final adaPrivateKey = AdaPrivateKey.fromBytes(privateKey.raw);
  final adaShellyPrivateKey =
      AdaPrivateKey.fromBytes(byronLegacy.masterPrivateKey.raw);
  final pubkey = byronLegacy.getPublicKey(
      firstIndex: Bip32KeyIndex(0), secondIndex: Bip32KeyIndex(2));
  final receiver = ADABaseAddress.fromPublicKey(
      basePubkeyBytes: byronLegacy.masterPublicKey.compressed,
      stakePubkeyBytes: byronLegacy.masterPublicKey.compressed,
      network: ADANetwork.testnet);
  final receiver2 = ADAByronAddress.fromPublicKey(
      chaincode: pubkey.chainCode.toBytes(),
      publicKey: pubkey.compressed,
      network: ADANetwork.testnetPreprod);
  final addr = ADAByronAddress.legacy(
    network: ADANetwork.testnetPreprod,
    chaincode: BytesUtils.fromHexString(
        "0a45cc2bb6a5327ec85fe580145ca465bd4876212e84cf74f7d61e67e2736dc1"),
    hdPath: "m/0'/2'",
    hdPathKey: BytesUtils.fromHexString(
        "d565c7f94b23e7f14d3fc79737a95c471c325e15ab52d5832d3092a8f0bade7a"),
    publicKey: BytesUtils.fromHexString(
        "004e4f3bba48cf6712fcfd9fa2a030b6ca0564d6488e1d821753b0830a32f1ba1a"),
  );
  final provider = BlockforestProvider(BlockforestHTTPProvider(
      url: "https://cardano-preprod.blockfrost.io/api/v0/",
      projectId: "preprodMVwzqm4PuBDBSfEULoMzoj5QZcy5o3z5"));

  final body = TransactionBody(inputs: [
    TransactionInput(
        transactionId: TransactionHash.fromHex(
            "22528a2e224e0405559d12d687d39717cb37130564d8a4ed4058dfe392b8e109"),
        index: 2),
    TransactionInput(
        transactionId: TransactionHash.fromHex(
            "22528a2e224e0405559d12d687d39717cb37130564d8a4ed4058dfe392b8e109"),
        index: 0),
    TransactionInput(
        transactionId: TransactionHash.fromHex(
            "22528a2e224e0405559d12d687d39717cb37130564d8a4ed4058dfe392b8e109"),
        index: 1),
  ], outputs: [
    TransactionOutput(
        address: receiver, amount: Value(coin: ADAHelper.toLovelaces("100"))),
    TransactionOutput(
        address: receiver2, amount: Value(coin: ADAHelper.toLovelaces("100"))),
    TransactionOutput(
        address: addr,
        amount: Value(
            coin: BigInt.from(9898000000) - ADAHelper.toLovelaces("201"))),
  ], fee: ADAHelper.toLovelaces("1"));

  final withness = adaPrivateKey.createBootstrapWitness(
      digest: body.toHash().data,
      address: addr,
      chainCode: privateKey.chainCode.toBytes());
  final withness2 = adaPrivateKey.createBootstrapWitness(
      digest: body.toHash().data,
      address: receiver2,
      chainCode: privateKey.chainCode.toBytes());

  final transaction = ADATransaction(
    body: body,
    witnessSet: TransactionWitnessSet(
      bootstraps: [withness, withness2],
      vKeys: [
        adaShellyPrivateKey.createSignatureWitness(body.toHash().data),
      ],
    ),
  );

  await provider.request(BlockfrostRequestSubmitTransaction(
      transactionCborBytes: transaction.serialize()));

  /// https://preprod.cardanoscan.io/transaction/88eeb2d32f668394541f0cc0f3dbd9e848970317ecab95afc200876d1fe32ab5
}
