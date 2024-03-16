import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/ada.dart';
import 'package:test/test.dart';

void main() {
  group("delegated transaction body", () {
    _delegationTransactionTest();
  });
}

void _delegationTransactionTest() {
  test("transaction_1", () {
    final stakePubKeyBytes = BytesUtils.fromHexString(
        "0013fe0ab7d1fd4cbb55508c755829219d77432f9dc26c9955a632cbcbe30cfa34");
    final stakeCred = AdaAddressUtils.publicKeyToCredential(stakePubKeyBytes);
    final registrationKey = StakeRegistration(stakeCred);

    final delegation = StakeDelegation(
        stakeCredential: stakeCred,
        poolKeyHash: Ed25519PoolKeyHash.fromPubkey(stakePubKeyBytes));
    final changeAddress = ADABaseAddress(
        "addr_test1qrq9aq9aeun8ull8ha9gv7h72jn95ds9kv42aqcw6plcu8xvxwdrt70qlcpeeagscasafhffqsxy36t90ldv06wqrk2qls4syh");
    final input = TransactionInput(
        transactionId: TransactionHash(List<int>.filled(32, 0)), index: 0);
    final changeOutput = TransactionOutput(
        address: changeAddress, amount: Value(coin: BigInt.from(3785998)));
    final transactionBody = TransactionBody(
        inputs: [input],
        outputs: [changeOutput],
        fee: BigInt.from(214002),
        ttl: BigInt.from(1000),
        certs: [registrationKey, delegation]);
    expect(transactionBody.serializeHex(),
        "a50081825820000000000000000000000000000000000000000000000000000000000000000000018182583900c05e80bdcf267e7fe7bf4a867afe54a65a3605b32aae830ed07f8e1ccc339a35f9e0fe039cf510c761d4dd29040c48e9657fdac7e9c01d941a0039c50e021a000343f2031903e8048282008200581ccc339a35f9e0fe039cf510c761d4dd29040c48e9657fdac7e9c01d9483028200581ccc339a35f9e0fe039cf510c761d4dd29040c48e9657fdac7e9c01d94581ccc339a35f9e0fe039cf510c761d4dd29040c48e9657fdac7e9c01d94");
  });
}
