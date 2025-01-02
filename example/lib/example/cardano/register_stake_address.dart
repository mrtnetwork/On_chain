import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/ada.dart';
import 'provider_example/provider.dart';

void main() async {
  final bip32 = CardanoIcarusBip32.fromSeed(List<int>.filled(20, 12));
  final spend = bip32.derivePath("1852'/1815'/0'/0/0");
  final spend2 = bip32.derivePath("1852'/1815'/0'/0/0");
  final privateKey = AdaPrivateKey.fromBytes(spend.privateKey.raw);

  final receiver = ADABaseAddress.fromPublicKey(
      basePubkeyBytes: spend.publicKey.compressed,
      stakePubkeyBytes: spend2.publicKey.compressed,
      network: ADANetwork.testnetPreprod);

  final provider = BlockFrostProvider(BlockFrostHTTPProvider(
      url: "https://cardano-preprod.blockfrost.io/api/v0/",
      projectId: "preprodMVwzqm4PuBDBSfEULoMzoj5QZcy5o3z5"));
  final stakeRegistration = StakeRegistration(receiver.stakeCredential);
  final input = TransactionInput(
      transactionId: TransactionHash.fromHex(
          "427164b2c0d4874584d11e4e379a748bcef096b2968a8c77242d04822c23c351"),
      index: 1);

  final change = TransactionOutput(
    address: receiver,
    amount: Value(
      coin: ADAHelper.toLovelaces("1000") - ADAHelper.toLovelaces("3"),
    ),
  );
  final fee = ADAHelper.toLovelaces("1");
  final body = TransactionBody(
      inputs: [input], outputs: [change], fee: fee, certs: [stakeRegistration]);

  final transaction = ADATransaction(
      body: body,
      witnessSet: TransactionWitnessSet(vKeys: [
        privateKey.createSignatureWitness(body.toHash().data),
      ]));
  await provider.request(BlockfrostRequestSubmitTransaction(
      transactionCborBytes: transaction.serialize()));

  /// https://preprod.cardanoscan.io/transaction/5407a50e78b10ef0b798d609e4991d01c220a611ff5a05c24be74d9a638d34ab?tab=utxo
}
