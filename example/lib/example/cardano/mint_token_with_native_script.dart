import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/ada.dart';
import 'provider_example/provider.dart';

void main() async {
  final bip32 = CardanoIcarusBip32.fromSeed(List<int>.filled(20, 12));
  final spend = bip32.derivePath("1852'/1815'/0'/0/0");
  final spend2 = bip32.derivePath("1852'/1815'/0'/0/0");
  final privateKey = AdaPrivateKey.fromBytes(spend.privateKey.raw);

  ADAEnterpriseAddress addr = ADAEnterpriseAddress.fromPublicKey(
      pubkeyBytes: spend.publicKey.compressed,
      network: ADANetwork.testnetPreprod);
  ADAEnterpriseAddress receiver = ADAEnterpriseAddress.fromPublicKey(
      pubkeyBytes: spend2.publicKey.compressed,
      network: ADANetwork.testnetPreprod);

  final provider = BlockforestProvider(BlockforestHTTPProvider(
      url: "https://cardano-preprod.blockfrost.io/api/v0/",
      projectId: "preprodMVwzqm4PuBDBSfEULoMzoj5QZcy5o3z5"));

  final keyHash = Ed25519KeyHash.fromPubkey(spend.publicKey.compressed);
  final mintScript = NativeScriptScriptPubkey(keyHash);
  final policyId = PolicyID(mintScript.toHash().data);
  final assentName = AssetName("MRT".codeUnits);
  final BigInt supply = BigInt.from(2500000000);

  final input = TransactionInput(
      transactionId: TransactionHash.fromHex(
          "42680df36ee51b932d2fd62c736b34ca6f2ecfe702e687529b565e157c335088"),
      index: 0);
  final output = TransactionOutput(
      address: receiver, amount: Value(coin: ADAHelper.toLovelaces("11")));
  final change = TransactionOutput(
    address: addr,
    amount: Value(
        coin: BigInt.from(9909800000) - ADAHelper.toLovelaces("12"),
        multiAsset: MultiAsset({
          policyId: Assets({assentName: supply})
        })),
  );
  final mint = Mint([
    MintInfo(policyID: policyId, assets: MintAssets({assentName: supply}))
  ]);
  final fee = ADAHelper.toLovelaces("1");

  final auxiliary = AuxiliaryData(nativeScripts: [mintScript]);
  final body = TransactionBody(
      inputs: [input],
      outputs: [change, output],
      fee: fee,
      mint: mint,
      auxiliaryDataHash: auxiliary.toHash());
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

  /// https://preprod.cardanoscan.io/transaction/22abd233e70762aa64b8baccf0b42db05e5adac49c86e1d6ace1466eab4ad36c
}

extension Hex on List<int> {
  String toHex() {
    return BytesUtils.toHexString(this);
  }
}
