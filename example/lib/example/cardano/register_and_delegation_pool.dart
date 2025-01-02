import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/ada.dart';
import 'provider_example/provider.dart';

void main() async {
  const mnemonic =
      "puzzle echo foil leopard depth purchase guard update tonight force cheese athlete slice cereal axis";
  final seed = CardanoIcarusSeedGenerator(mnemonic).generate();
  final cip = Cip1852.fromSeed(seed, Cip1852Coins.cardanoIcarusTestnet);

  final shellyWallet =
      CardanoShelley.fromCip1852Object(cip.purpose.coin.account(0));
  final internal10 =
      shellyWallet.change(Bip44Changes.chainInt).addressIndex(10);
  final privateKey = AdaPrivateKey.fromBytes(internal10.bip44.privateKey.raw);
  final stakePrivateKey =
      AdaPrivateKey.fromBytes(internal10.bip44Sk.privateKey.raw);
  final addr = ADABaseAddress.shellyWallet(
      shelleyWallet: internal10, network: ADANetwork.testnetPreprod);

  final provider = BlockFrostProvider(BlockFrostHTTPProvider(
      url: "https://cardano-preprod.blockfrost.io/api/v0/",
      projectId: "preprodMVwzqm4PuBDBSfEULoMzoj5QZcy5o3z5"));
  final input = TransactionInput(
      transactionId: TransactionHash.fromHex(
          "686d43eb2e4a55bb26d624a83219d0e6fc178a5aca8975f66ba6dd59d41fd157"),
      index: 0);
  final registerCert = StakeRegistration(addr.stakeCredential);

  final delegate = StakeDelegation(
      stakeCredential: addr.stakeCredential,
      poolKeyHash: Ed25519PoolKeyHash.fromBech32(
          "pool1tcxnnq73yw07v573w2duesa8d4j40ghfkxg5fn37eveaz20gzs7"));
  final changeOutput = TransactionOutput(
    address: addr,
    amount: Value(coin: ADAHelper.toLovelaces("4997")),
  );
  final body = TransactionBody(
      inputs: [input],
      outputs: [changeOutput],
      certs: [registerCert, delegate],
      fee: ADAHelper.toLovelaces("1"));

  final transaction = ADATransaction(
    body: body,
    witnessSet: TransactionWitnessSet(vKeys: [
      privateKey.createSignatureWitness(body.toHash().data),
      stakePrivateKey.createSignatureWitness(body.toHash().data),
    ]),
  );
  await provider.request(BlockfrostRequestSubmitTransaction(
      transactionCborBytes: transaction.serialize()));

  /// https://preprod.cardanoscan.io/transaction/8f48ca73193ea1f6c2a2ff3522a23967cf11e96364a6b72045b15c90d337713c
}
