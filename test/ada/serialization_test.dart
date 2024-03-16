import 'package:on_chain/ada/ada.dart';
import 'package:test/test.dart';

void main() {
  group("Serialization TEST", () {
    _input();
    _output();
    _transaction();
  });
}

void _input() {
  test("transaction inputs", () {
    final inp = TransactionInput(
        transactionId: TransactionHash(List<int>.filled(32, 0)), index: 0);
    expect(inp.serializeHex(),
        "825820000000000000000000000000000000000000000000000000000000000000000000");
  });
}

void _output() {
  test("transaction output", () {
    final address = ADAAddress.fromAddress(
        "addr_test1qpu5vlrf4xkxv2qpwngf6cjhtw542ayty80v8dyr49rf5ewvxwdrt70qlcpeeagscasafhffqsxy36t90ldv06wqrk2qum8x5w");
    final output = TransactionOutput(
        address: address, amount: Value(coin: BigInt.from(1000000)));
    expect(output.serializeHex(),
        "8258390079467c69a9ac66280174d09d62575ba955748b21dec3b483a9469a65cc339a35f9e0fe039cf510c761d4dd29040c48e9657fdac7e9c01d941a000f4240");
  });
}

void _transaction() {
  test("transaction_1", () {
    final input = TransactionInput(
        transactionId: TransactionHash(List<int>.filled(32, 0)), index: 0);
    final output = TransactionOutput(
        address: ADAAddress.fromAddress(
            "addr_test1qpu5vlrf4xkxv2qpwngf6cjhtw542ayty80v8dyr49rf5ewvxwdrt70qlcpeeagscasafhffqsxy36t90ldv06wqrk2qum8x5w"),
        amount: Value(coin: BigInt.from(222)));

    final changeValue =
        BigInt.from(1000000) - (BigInt.from(144502) + BigInt.from(222));

    final changeoutput = TransactionOutput(
        address: ADAAddress.fromAddress(
            "addr_test1qrq9aq9aeun8ull8ha9gv7h72jn95ds9kv42aqcw6plcu8xvxwdrt70qlcpeeagscasafhffqsxy36t90ldv06wqrk2qls4syh"),
        amount: Value(coin: changeValue));
    final transactionBody = TransactionBody(
        inputs: [input],
        outputs: [output, changeoutput],
        fee: BigInt.from(144502),
        ttl: BigInt.from(1000));
    expect(transactionBody.serializeHex(),
        "a4008182582000000000000000000000000000000000000000000000000000000000000000000001828258390079467c69a9ac66280174d09d62575ba955748b21dec3b483a9469a65cc339a35f9e0fe039cf510c761d4dd29040c48e9657fdac7e9c01d9418de82583900c05e80bdcf267e7fe7bf4a867afe54a65a3605b32aae830ed07f8e1ccc339a35f9e0fe039cf510c761d4dd29040c48e9657fdac7e9c01d941a000d0cec021a00023476031903e8");
  });
  test("transaction_2", () {
    final address = ADABaseAddress(
        "addr_test1qpu5vlrf4xkxv2qpwngf6cjhtw542ayty80v8dyr49rf5ewvxwdrt70qlcpeeagscasafhffqsxy36t90ldv06wqrk2qum8x5w");
    final changeAddress = ADAPointerAddress(
        "addr_test12p8rhm536rtq3num9hqvtesd63h0kxcuy42gkv7pm3dt96gpqyqsgsts6d");
    final input = TransactionInput(
        transactionId: TransactionHash(List<int>.filled(32, 0)), index: 0);
    final output = TransactionOutput(
        address: address, amount: Value(coin: BigInt.from(222)));

    final changeValue =
        BigInt.from(1000000) - (BigInt.from(149002) + BigInt.from(222));
    final dataOption = DataHash.fromHex(
        "14efb5788e8713c844dfd32b2e91de1e309fefffd555f827cc9ee16401020304");

    final changeoutput = TransactionOutput(
        address: changeAddress,
        amount: Value(coin: changeValue),
        plutusData: DataOptionDataHash(dataOption));
    final transactionBody = TransactionBody(
        inputs: [input],
        outputs: [output, changeoutput],
        fee: BigInt.from(149002),
        ttl: BigInt.from(1000));
    expect(transactionBody.serializeHex(),
        "a4008182582000000000000000000000000000000000000000000000000000000000000000000001828258390079467c69a9ac66280174d09d62575ba955748b21dec3b483a9469a65cc339a35f9e0fe039cf510c761d4dd29040c48e9657fdac7e9c01d9418de835820504e3bee91d0d608cf9b2dc0c5e60dd46efb1b1c25548b33c1dc5ab2e90101011a000cfb58582014efb5788e8713c844dfd32b2e91de1e309fefffd555f827cc9ee16401020304021a0002460a031903e8");
  });

  test("transaction without change", () {
    final address = ADABaseAddress(
        "addr_test1qpu5vlrf4xkxv2qpwngf6cjhtw542ayty80v8dyr49rf5ewvxwdrt70qlcpeeagscasafhffqsxy36t90ldv06wqrk2qum8x5w");
    final input = TransactionInput(
        transactionId: TransactionHash(List<int>.filled(32, 0)), index: 0);
    final output = TransactionOutput(
        address: address, amount: Value(coin: BigInt.from(880000)));

    final fee = BigInt.from(1000000) - (BigInt.from(880000));

    final transactionBody = TransactionBody(
        inputs: [input], outputs: [output], fee: fee, ttl: BigInt.from(1000));
    expect(transactionBody.serializeHex(),
        "a4008182582000000000000000000000000000000000000000000000000000000000000000000001818258390079467c69a9ac66280174d09d62575ba955748b21dec3b483a9469a65cc339a35f9e0fe039cf510c761d4dd29040c48e9657fdac7e9c01d941a000d6d80021a0001d4c0031903e8");
  });
  test("transaction with refrence", () {
    final address = ADABaseAddress(
        "addr_test1qpu5vlrf4xkxv2qpwngf6cjhtw542ayty80v8dyr49rf5ewvxwdrt70qlcpeeagscasafhffqsxy36t90ldv06wqrk2qum8x5w");
    final changeAddress = ADABaseAddress(
        "addr_test1qrq9aq9aeun8ull8ha9gv7h72jn95ds9kv42aqcw6plcu8xvxwdrt70qlcpeeagscasafhffqsxy36t90ldv06wqrk2qls4syh");
    final input = TransactionInput(
        transactionId: TransactionHash(List<int>.filled(32, 0)), index: 1);
    final input2 = TransactionInput(
        transactionId: TransactionHash(List<int>.filled(32, 0)), index: 2);
    final input3 = TransactionInput(
        transactionId: TransactionHash(List<int>.filled(32, 0)), index: 3);
    final input4 = TransactionInput(
        transactionId: TransactionHash(List<int>.filled(32, 0)), index: 4);
    final output = TransactionOutput(
        address: address, amount: Value(coin: BigInt.from(500)));
    final changeOutput = TransactionOutput(
        address: changeAddress, amount: Value(coin: BigInt.from(999499)));
    final transactionBody = TransactionBody(
      inputs: [input2],
      outputs: [output, changeOutput],
      referenceInputs: [
        input2,
        input,
        input4,
        input3,
      ],
      fee: BigInt.one,
    );
    expect(transactionBody.serializeHex(),
        "a4008182582000000000000000000000000000000000000000000000000000000000000000000201828258390079467c69a9ac66280174d09d62575ba955748b21dec3b483a9469a65cc339a35f9e0fe039cf510c761d4dd29040c48e9657fdac7e9c01d941901f482583900c05e80bdcf267e7fe7bf4a867afe54a65a3605b32aae830ed07f8e1ccc339a35f9e0fe039cf510c761d4dd29040c48e9657fdac7e9c01d941a000f404b02011284825820000000000000000000000000000000000000000000000000000000000000000002825820000000000000000000000000000000000000000000000000000000000000000001825820000000000000000000000000000000000000000000000000000000000000000004825820000000000000000000000000000000000000000000000000000000000000000003");
  });
}
