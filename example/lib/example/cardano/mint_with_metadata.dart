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

  final provider = BlockFrostProvider(BlockFrostHTTPProvider(
      url: "https://cardano-preprod.blockfrost.io/api/v0/",
      projectId: "preprodMVwzqm4PuBDBSfEULoMzoj5QZcy5o3z5"));

  final keyHash = Ed25519KeyHash.fromPubkey(spend.publicKey.compressed);
  final mintScript = NativeScriptScriptPubkey(keyHash);
  final policyId = PolicyID(mintScript.toHash().data);
  final assentName = AssetName("MRTNETWORK".codeUnits);
  final BigInt supply = BigInt.from(2500000000);

  final input = TransactionInput(
      transactionId: TransactionHash.fromHex(
          "42680df36ee51b932d2fd62c736b34ca6f2ecfe702e687529b565e157c335088"),
      index: 1);

  final change = TransactionOutput(
    address: addr,
    amount: Value(
        coin: ADAHelper.toLovelaces("10"),
        multiAsset: MultiAsset({
          policyId: Assets({assentName: supply})
        })),
  );
  final mint = Mint([
    MintInfo(policyID: policyId, assets: MintAssets({assentName: supply}))
  ]);
  final fee = ADAHelper.toLovelaces("1");

  final metadata = TransactionMetadata.fromJsonSchema(json: {
    "name": "MRT",
    "uri": "https://github.com/mrtnetwork",
    "total": 9909800000
  }, jsonSchema: MetadataJsonSchema.noConversions);
  final auxiliary = AuxiliaryData(
    nativeScripts: [mintScript],
    metadata: GeneralTransactionMetadata(metadata: {BigInt.one: metadata}),
  );

  final body = TransactionBody(
    inputs: [input],
    outputs: [change],
    fee: fee,
    mint: mint,
    auxiliaryDataHash: auxiliary.toHash(),
  );
  final transaction = ADATransaction(
      body: body,
      data: auxiliary,
      witnessSet: TransactionWitnessSet(vKeys: [
        privateKey.createSignatureWitness(body.toHash().data),
      ], nativeScripts: [
        mintScript
      ]));
  await provider.request(BlockfrostRequestSubmitTransaction(
      transactionCborBytes: transaction.serialize()));

  /// https://preprod.cardanoscan.io/transaction/af2a4a0f0cdcc2d2aa1710c3c34b9d0bc1c96bb26fa7c63c35431c38c8d2e312
}
