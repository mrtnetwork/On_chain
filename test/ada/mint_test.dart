import 'package:on_chain/ada/ada.dart';
import 'package:test/test.dart';

void main() {
  _mint();
}

void _mint() {
  test("transaction body with mint", () {
    final address = ADABaseAddress(
        "addr_test1qpu5vlrf4xkxv2qpwngf6cjhtw542ayty80v8dyr49rf5ewvxwdrt70qlcpeeagscasafhffqsxy36t90ldv06wqrk2qum8x5w");
    final changeAddress = ADABaseAddress(
        "addr_test1qrq9aq9aeun8ull8ha9gv7h72jn95ds9kv42aqcw6plcu8xvxwdrt70qlcpeeagscasafhffqsxy36t90ldv06wqrk2qls4syh");
    final input = TransactionInput(
        transactionId: TransactionHash(List<int>.filled(32, 0)), index: 0);
    final output = TransactionOutput(
        address: address,
        amount: Value(
            coin: BigInt.from(300),
            multiAsset: MultiAsset({
              PolicyID.fromHex(
                      "8d7f04b6794ae5ed675aaba8acdc16f51c962f7d4677a8f4d4ec30ea"):
                  Assets({
                AssetName([0, 1, 2, 3]): BigInt.from(500)
              })
            })));
    final changeOutput = TransactionOutput(
        address: changeAddress,
        amount: Value(
            coin: BigInt.from(299),
            multiAsset: MultiAsset({
              PolicyID.fromHex(
                      "8d7f04b6794ae5ed675aaba8acdc16f51c962f7d4677a8f4d4ec30ea"):
                  Assets({
                AssetName([0, 1, 2, 3]): BigInt.from(500)
              })
            })));

    final mint = Mint([
      MintInfo(
          policyID: PolicyID.fromHex(
              "8d7f04b6794ae5ed675aaba8acdc16f51c962f7d4677a8f4d4ec30ea"),
          assets: MintAssets({
            AssetName([0, 1, 2, 3]): BigInt.from(1000)
          }))
    ]);
    final transactionBody = TransactionBody(
        inputs: [input],
        outputs: [output, changeOutput],
        fee: BigInt.one,
        mint: mint);
    expect(transactionBody.serializeHex(),
        "a4008182582000000000000000000000000000000000000000000000000000000000000000000001828258390079467c69a9ac66280174d09d62575ba955748b21dec3b483a9469a65cc339a35f9e0fe039cf510c761d4dd29040c48e9657fdac7e9c01d948219012ca1581c8d7f04b6794ae5ed675aaba8acdc16f51c962f7d4677a8f4d4ec30eaa144000102031901f482583900c05e80bdcf267e7fe7bf4a867afe54a65a3605b32aae830ed07f8e1ccc339a35f9e0fe039cf510c761d4dd29040c48e9657fdac7e9c01d948219012ba1581c8d7f04b6794ae5ed675aaba8acdc16f51c962f7d4677a8f4d4ec30eaa144000102031901f4020109a1581c8d7f04b6794ae5ed675aaba8acdc16f51c962f7d4677a8f4d4ec30eaa144000102031903e8");
  });
}
