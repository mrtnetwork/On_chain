import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:example/example/cardano/provider_example/provider.dart';
import 'package:on_chain/ada/ada.dart';

void main() async {
  /// Create a BIP32 derivation from a seed
  final bip32 = CardanoIcarusBip32.fromSeed(List<int>.filled(20, 12));

  /// Derive a spending key from the BIP32 derivation path
  final spend = bip32.derivePath("1852'/1815'/0'/0/0");
  final spend2 = bip32.derivePath("1852'/1815'/0'/0/1");
  final spend3 = bip32.derivePath("1852'/1815'/0'/0/2");
  final spend4 = bip32.derivePath("1852'/1815'/0'/0/3");
  final privateKey1 = AdaPrivateKey.fromBytes(spend.privateKey.raw);
  final privateKey2 = AdaPrivateKey.fromBytes(spend2.privateKey.raw);
  final privateKey3 = AdaPrivateKey.fromBytes(spend3.privateKey.raw);
  final privateKey4 = AdaPrivateKey.fromBytes(spend4.privateKey.raw);
  final edKey1 = Ed25519KeyHash.fromPubkey(privateKey1.publicKey().toBytes());
  final edKey2 = Ed25519KeyHash.fromPubkey(privateKey2.publicKey().toBytes());
  final edKey3 = Ed25519KeyHash.fromPubkey(privateKey3.publicKey().toBytes());
  final edKey4 = Ed25519KeyHash.fromPubkey(privateKey4.publicKey().toBytes());
  final nOfK = NativeScriptScriptNOfK(n: 2, nativeScripts: [
    NativeScriptScriptPubkey(edKey1),
    NativeScriptScriptPubkey(edKey2),
    NativeScriptScriptPubkey(edKey3)
  ]);
  final stakeNofK = NativeScriptScriptNOfK(n: 2, nativeScripts: [
    NativeScriptScriptPubkey(edKey1),
    NativeScriptScriptPubkey(edKey4)
  ]);
  final credential = CredentialScript(nOfK.toHash().data);
  final stakeCredential = CredentialScript(stakeNofK.toHash().data);

  final add = ADABaseAddress.fromCredential(
      baseCredential: credential,
      stakeCredential: stakeCredential,
      network: ADANetwork.testnetPreprod);

  final provider = BlockFrostProvider(BlockFrostHTTPProvider(
      url: "https://cardano-preprod.blockfrost.io/api/v0/",
      projectId: "preprodMVwzqm4PuBDBSfEULoMzoj5QZcy5o3z5"));
  final input = TransactionInput(
      transactionId: TransactionHash.fromHex(
          "98b4753e70615096320ce7ff9e0649e2437471a34a94cbe8039666def67c1b6a"),
      index: 0);
  final registerCert = StakeRegistration(stakeCredential);
  final delegate = StakeDelegation(
      stakeCredential: stakeCredential,
      poolKeyHash: Ed25519PoolKeyHash.fromBech32(
          "pool1tcxnnq73yw07v573w2duesa8d4j40ghfkxg5fn37eveaz20gzs7"));
  final changeOutput = TransactionOutput(
    address: add,
    amount: Value(coin: ADAHelper.toLovelaces("47")),
  );
  final body = TransactionBody(
      inputs: TransactionInputs([input]),
      outputs: TransactionOutputs([changeOutput]),
      certificates: Certificates([registerCert, delegate]),
      fee: ADAHelper.toLovelaces("1"));
  final bodyBytes = body.toHash().data.immutable;
  final transaction = ADATransaction(
    body: body,
    witnessSet: TransactionWitnessSet(
        nativeScripts: NativeScripts([nOfK, stakeNofK]),
        vKeys: VkeyWitnesses([
          privateKey1.createSignatureWitness(bodyBytes),
          privateKey2.createSignatureWitness(bodyBytes),
          privateKey4.createSignatureWitness(bodyBytes),
        ])),
  );
  await provider.request(BlockfrostRequestSubmitTransaction(
      transactionCborBytes: transaction.serialize()));
}
