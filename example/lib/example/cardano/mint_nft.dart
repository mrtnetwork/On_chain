import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/ada.dart';
import 'provider_example/provider.dart';

void main() async {
  final bip32 = CardanoIcarusBip32.fromSeed(List<int>.filled(20, 12));
  final spend = bip32.derivePath("1852'/1815'/0'/0/0");
  final privateKey = AdaPrivateKey.fromBytes(spend.privateKey.raw);
  ADAEnterpriseAddress addr = ADAEnterpriseAddress.fromPublicKey(
      pubkeyBytes: spend.publicKey.compressed,
      network: AdaNetwork.testnetPreprod);

  final provider = BlockforestProvider(BlockforestHTTPProvider(
      url: "https://cardano-preprod.blockfrost.io/api/v0/",
      projectId: "preprodMVwzqm4PuBDBSfEULoMzoj5QZcy5o3z5"));

  // final block = await provider.request(BlockfrostRequestLatestBlock());
  // final ttl = block.time + 3600;
  const ttl = 1710171725;

  final keyHash = Ed25519KeyHash.fromPubkey(spend.publicKey.compressed);
  final mintScript = NativeScriptScriptAll([
    NativeScriptScriptPubkey(keyHash),
    NativeScriptTimelockExpiry(BigInt.from(ttl))
  ]);
  final policyId = PolicyID(mintScript.toHash().data);
  final assentName = AssetName("MRTNFT".codeUnits);
  final BigInt supply = BigInt.from(1);

  final input = TransactionInput(
      transactionId: TransactionHash.fromHex(
          "22abd233e70762aa64b8baccf0b42db05e5adac49c86e1d6ace1466eab4ad36c"),
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
    policyId.toHex(): {
      "MRTNFT": {
        "name": "MRTNFT",
        "description": "MRTNETWORK TEST",
        "image": "ipfs://someurl",
        "mediaType": "image/jpeg"
      }
    }
  }, jsonSchema: MetadataJsonSchema.noConversions);
  final auxiliary = AuxiliaryData(
    nativeScripts: [mintScript],
    metadata:
        GeneralTransactionMetadata(metadata: {BigInt.from(721): metadata}),
  );

  final body = TransactionBody(
    inputs: [input],
    outputs: [change],
    fee: fee,
    mint: mint,
    ttl: BigInt.from(ttl),
    auxiliaryDataHash: auxiliary.toHash(),
  );

  final transaction = ADATransaction(
      body: body,
      data: auxiliary,
      witnessSet: TransactionWitnessSet(
          vKeys: [privateKey.createSignatureWitness(body.toHash().data)],
          nativeScripts: [mintScript]));
  await provider.request(BlockfrostRequestSubmitTransaction(
      transactionCborBytes: transaction.serialize()));

  /// https://preprod.cardanoscan.io/transaction/86ce1664924e5b6ba34256b53503fa4d77b9fcbc36170125da8b480cc32f47b4
}
