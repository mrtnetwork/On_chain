import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:example/example/cardano/provider_example/provider.dart';
import 'package:on_chain/ada/src/ada.dart';

void main() async {
  final provider = BlockFrostProvider(BlockFrostHTTPProvider(
      url: "https://cardano-preprod.blockfrost.io/api/v0/",
      projectId: "preprodMVwzqm4PuBDBSfEULoMzoj5QZcy5o3z5"));

  /// Create a BIP32 derivation from a seed
  final bip32 = CardanoIcarusBip32.fromSeed(List<int>.filled(20, 12));

  /// Derive a spending key from the BIP32 derivation path
  final spend = bip32.derivePath("1852'/1815'/0'/0/0");
  final spend2 = bip32.derivePath("1852'/1815'/0'/0/1");
  final spend3 = bip32.derivePath("1852'/1815'/0'/0/2");
  final privateKey1 = AdaPrivateKey.fromBytes(spend.privateKey.raw);
  final privateKey2 = AdaPrivateKey.fromBytes(spend2.privateKey.raw);
  final privateKey3 = AdaPrivateKey.fromBytes(spend3.privateKey.raw);
  final edKey1 = Ed25519KeyHash.fromPubkey(privateKey1.publicKey().toBytes());
  final edKey2 = Ed25519KeyHash.fromPubkey(privateKey2.publicKey().toBytes());
  final edKey3 = Ed25519KeyHash.fromPubkey(privateKey3.publicKey().toBytes());
  final nOfK = NativeScriptScriptNOfK(n: 2, nativeScripts: [
    NativeScriptScriptPubkey(edKey1),
    NativeScriptScriptPubkey(edKey2),
    NativeScriptScriptPubkey(edKey3)
  ]);
  final credential = CredentialScript(nOfK.toHash().data);
  final add = ADAEnterpriseAddress.fromCredential(
      credential: credential, network: ADANetwork.testnetPreprod);

  ADAEnterpriseAddress receiver = ADAEnterpriseAddress(
      "addr_test1vp0q6wvr6y3elejn69efhnxr5akk24azaxcez3xw8m9n85gmr5qny",
      network: ADANetwork.testnetPreprod);
  final fee = ADAHelper.toLovelaces("0.2");
  final input = TransactionInput(
      transactionId: TransactionHash.fromHex(
          "5ef736a772b623c2a7666e5c318c8d2ea603db5c9efbf48c55542cae79ca6a27"),
      index: 0);
  final output = TransactionOutput(
      address: receiver, amount: Value(coin: ADAHelper.toLovelaces("5")));
  final change = TransactionOutput(
      address: add,
      amount: Value(
          coin: ADAHelper.toLovelaces("189.6") -
              fee -
              ADAHelper.toLovelaces("5")));

  /// Construct the transaction body
  final body = TransactionBody(
      inputs: TransactionInputs([input]),
      outputs: TransactionOutputs([change, output]),
      fee: fee);
  final bodyBytes = body.toHash().data.immutable;

  /// Create the ADA transaction with witness
  final transaction = ADATransaction(
      body: body,
      witnessSet: TransactionWitnessSet(
          vKeys: VkeyWitnesses([
            privateKey1.createSignatureWitness(bodyBytes),
            privateKey3.createSignatureWitness(bodyBytes),
          ]),
          nativeScripts: NativeScripts([nOfK])));
  await provider.request(BlockfrostRequestSubmitTransaction(
      transactionCborBytes: transaction.serialize()));

  /// https://preprod.cardanoscan.io/transaction/5ef736a772b623c2a7666e5c318c8d2ea603db5c9efbf48c55542cae79ca6a27
}
