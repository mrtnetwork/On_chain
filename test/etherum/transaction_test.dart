import 'package:on_chain/ethereum/ethereum.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:test/test.dart';

void main() {
  /// transaction with leading zero s bytes.
  test("transaction leading zero s", () {
    final addr = ETHAddress("0x084937B3f86ea7BbCA86F2809809A65ED8A7ADa9");
    final signer = ETHSigner.fromKeyBytes(BytesUtils.fromHexString(
        "e9f4fe38ffc54abd156dd4b8a39611fce696af62841ee6422ee36ba7b26c53f5"));

    final receiver = ETHAddress("0x4fAfB33f0e492FD10e91b55ED88872104fFd94ee");
    final transaction = ETHTransaction(
        nonce: 0,
        from: addr,
        type: ETHTransactionType.legacy,
        to: receiver,
        gasLimit: BigInt.from(21000),
        data: const [],
        value: ETHHelper.toWei("0.01"),
        chainId: BigInt.from(97),
        gasPrice: BigInt.from(5000000000));
    final serialize = transaction.serialized;
    final sign = signer.sign(serialize);
    final signedSerialize = transaction.signedSerialized(sign);

    final decode = ETHTransaction.fromSerialized(signedSerialize);
    expect(decode.signedSerialized(), signedSerialize);
  });
}
