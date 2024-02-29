import 'package:test/test.dart';
import 'package:on_chain/solana/solana.dart';
import '../../examples/wallet.dart';

void main() {
  group("compile multisig", () {
    _v0();
    _legacy();
  });
}

void _v0() {
  test("compuleV0", () {
    final owner = QuickWalletForTest(index: 406);
    final account1 = QuickWalletForTest(index: 405);
    final account3 = QuickWalletForTest(index: 407);
    final account5 = QuickWalletForTest(index: 408);
    final blockHash = "GWWy2aAev5X3TMRVwdw8W2KMN3dyVrHrQMZukGTf9R1A";
    final initialize = SPLTokenProgram.approveChecked(
        account: owner.address,
        delegate: account3.address,
        owner: account5.address,
        mint: account1.address,
        layout: SPLTokenApproveCheckedLayout(
            amount: BigInt.from(350000), decimals: 8),
        multiSigners: [account1.address, account3.address, account5.address]);

    final SolanaTransaction transaction = SolanaTransaction(
        instructions: [initialize],
        recentBlockhash: SolAddress.uncheckCurve(blockHash),
        payerKey: owner.address,
        type: TransactionType.v0);

    final unsigned = transaction.serializeMessageString();
    transaction.sign([
      owner.privateKey,
      account1.privateKey,
      account3.privateKey,
      account5.privateKey
    ]);

    final signed =
        transaction.serializeString(encoding: TransactionSerializeEncoding.hex);
    final decodeTransaction =
        SolanaTransaction.deserialize(transaction.serialize());
    expect(decodeTransaction.serialize(), transaction.serialize());
    expect(unsigned,
        "8004030105f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd763d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d554a43a7b8e1a60dac1b800be310f94e55f8fb7415780b78177c3ede1aa0b7ca5119ea7dac547c8a6eaa56be1d5ecb4c6e70d653a2f41fdf495af3293642920506ddf6e1d765a193d9cbe146ceeb79ac1cb485ed5f5b37913a8cf5857eff00a9e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc89010407000102030102030a0d30570500000000000800");
    expect(signed,
        "043a7f17d6cb69032e72528fb2c463ac59080b00334d4cb7b38a3e37268ddcf22a11b49e046c1a56433542e382da79f835c2cb6ba9d0b63d3e980138805df7c8035b39be0e918cc4c1761d3ab6ba09551857e681c0cbf020c8131b24e91e898ab064c7f95858b941a365c91b4d777202dd875709f190e18b10d2219bdd08738201ff921076251fb8d7317a775f919416decb2a2d395be25f2c75717a93a63d712b45e63121f88af1cb4d1bc5939ae18e5f283627c24486cfa24fa7ebfd4950eb04943ee876eea8e9ebed307a70801a316af86d2c68c92bc2d565bd88fca61055e9ae640602c204a4cf4537341ec14e06ba2b13946a6d1c92fc502733bf649067088004030105f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd763d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d554a43a7b8e1a60dac1b800be310f94e55f8fb7415780b78177c3ede1aa0b7ca5119ea7dac547c8a6eaa56be1d5ecb4c6e70d653a2f41fdf495af3293642920506ddf6e1d765a193d9cbe146ceeb79ac1cb485ed5f5b37913a8cf5857eff00a9e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc89010407000102030102030a0d30570500000000000800");
  });
}

void _legacy() {
  test("compile legacy", () {
    final owner = QuickWalletForTest(index: 406);
    final account1 = QuickWalletForTest(index: 405);
    final account3 = QuickWalletForTest(index: 407);
    final account5 = QuickWalletForTest(index: 408);
    final blockHash = "GWWy2aAev5X3TMRVwdw8W2KMN3dyVrHrQMZukGTf9R1A";
    final initialize = SPLTokenProgram.approveChecked(
        account: owner.address,
        delegate: account3.address,
        owner: account5.address,
        mint: account1.address,
        layout: SPLTokenApproveCheckedLayout(
            amount: BigInt.from(350000), decimals: 8),
        multiSigners: [account1.address, account3.address, account5.address]);

    final SolanaTransaction transaction = SolanaTransaction(
        instructions: [initialize],
        recentBlockhash: SolAddress.uncheckCurve(blockHash),
        payerKey: owner.address,
        type: TransactionType.legacy);

    final unsigned = transaction.serializeMessageString();
    transaction.sign([
      owner.privateKey,
      account1.privateKey,
      account3.privateKey,
      account5.privateKey
    ]);

    final signed =
        transaction.serializeString(encoding: TransactionSerializeEncoding.hex);
    final decodeTransaction =
        SolanaTransaction.deserialize(transaction.serialize());
    expect(decodeTransaction.serialize(), transaction.serialize());
    expect(unsigned,
        "04030105f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd763d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d554a43a7b8e1a60dac1b800be310f94e55f8fb7415780b78177c3ede1aa0b7ca5119ea7dac547c8a6eaa56be1d5ecb4c6e70d653a2f41fdf495af3293642920506ddf6e1d765a193d9cbe146ceeb79ac1cb485ed5f5b37913a8cf5857eff00a9e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc89010407000102030102030a0d305705000000000008");
    expect(signed,
        "04305d89c51b4ac47f2bf40421f7645415b76e850491cdeb0e7e063a47117e0df8ae0d49340b5852d648fdd403f7026e4d1bf92f0e3d3dd904fd5d044bed52850c4304808ecd4236061122a0f47292e65c2eb0effc23f7af4ab16d41e40f4eb3feffa81006395ca682c94d73e054f4d0d25075c6f37197cc90c9e5377b40b8430c7197f94220986b31922f14a7e950f19d16223bbc3c20d1bf9657f87197f707d5d2c71008a3b127ffe25cb696a131d81eaa72ea49d401143533d1337ced7abc04fb8199f0ebd37b231feac6cbb8b7c5b023236f846af1443a1b5f3a1099ff1b2bbdf0f91e69355f574cae82867ad2757bc8dc7c610b7275ef47daf9791dd08c0904030105f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd763d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d554a43a7b8e1a60dac1b800be310f94e55f8fb7415780b78177c3ede1aa0b7ca5119ea7dac547c8a6eaa56be1d5ecb4c6e70d653a2f41fdf495af3293642920506ddf6e1d765a193d9cbe146ceeb79ac1cb485ed5f5b37913a8cf5857eff00a9e66f07ae6ad93c9ea60272507db1a2d2089bbb67540ff6e291f98bcf5df4bc89010407000102030102030a0d305705000000000008");
  });
}
