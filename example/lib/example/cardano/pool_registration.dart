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

  final reward = receiver.stakeAddress();
  final metadata = TransactionMetadata.fromJsonSchema(json: {
    "name": "MRT",
    "description": "MRT POOL",
    "ticker": "NP",
    "homepage": "https://github.com/mrtnetwork"
  }, jsonSchema: MetadataJsonSchema.noConversions);
  final poolMetadata = PoolMetadata(
      url: "https://github.com/mrtnetwork",
      poolMetadataHash:
          PoolMetadataHash(QuickCrypto.blake2b256Hash(metadata.serialize())));
  final poolParams = PoolParams(
      operator: Ed25519KeyHash.fromPubkey(spend.publicKey.compressed),
      vrfKeyHash: VRFKeyHash(spend2.publicKey.compressed.sublist(1)),
      pledge: BigInt.one,
      cost: BigInt.from(170000000),
      margin: UnitInterval(numerator: BigInt.one, denominator: BigInt.two),
      poolOwners: [Ed25519KeyHash.fromPubkey(spend.publicKey.compressed)],
      poolMetadata: poolMetadata,
      relays: [
        SingleHostAddr(port: 6666, ipv4: Ipv4([192, 168, 1, 1]))
      ],
      rewardAccount: reward);

  final poolRegistration = PoolRegistration(poolParams);

  final provider = BlockFrostProvider(BlockFrostHTTPProvider(
      url: "https://cardano-preprod.blockfrost.io/api/v0/",
      projectId: "preprodMVwzqm4PuBDBSfEULoMzoj5QZcy5o3z5"));
  final parameters =
      await provider.request(BlockfrostRequestLatestEpochProtocolParameters());
  final poolDeposit = parameters.poolDeposit;
  final input = TransactionInput(
      transactionId: TransactionHash.fromHex(
          "afa75f7ab3e172f8772178766be3830bbf659eee5c4f00fd3966e2c40b3d2d91"),
      index: 1);
  final input2 = TransactionInput(
      transactionId: TransactionHash.fromHex(
          "5407a50e78b10ef0b798d609e4991d01c220a611ff5a05c24be74d9a638d34ab"),
      index: 0);
  final input3 = TransactionInput(
      transactionId: TransactionHash.fromHex(
          "69edd1c1c4fdc282e3fe1d90f368a228d7702316dc33e494e5bee7db81d6183b"),
      index: 1);
  final changeValue =
      BigInt.from(5997000000) - (poolDeposit + ADAHelper.toLovelaces("1"));
  final change = TransactionOutput(
    address: receiver,
    amount: Value(coin: changeValue),
  );
  final fee = ADAHelper.toLovelaces("1");
  final aux = AuxiliaryData(
      metadata:
          GeneralTransactionMetadata(metadata: {BigInt.from(1): metadata}));
  final body = TransactionBody(
    inputs: TransactionInputs([input, input2, input3]),
    outputs: TransactionOutputs([change]),
    auxiliaryDataHash: aux.toHash(),
    fee: fee,
    certificates: Certificates([poolRegistration]),
  );

  final transaction = ADATransaction(
      body: body,
      data: aux,
      witnessSet: TransactionWitnessSet(
          vKeys: VkeyWitnesses(
              [privateKey.createSignatureWitness(body.toHash().data)])));
  await provider.request(BlockfrostRequestSubmitTransaction(
      transactionCborBytes: transaction.serialize()));

  /// https://preprod.cardanoscan.io/transaction/2e7dc6944b2371ec63fb892379fd4cecb12f85ba881ed2bfe06e2818fe019465
}

extension Hex on List<int> {
  String toHex() {
    return BytesUtils.toHexString(this);
  }
}
