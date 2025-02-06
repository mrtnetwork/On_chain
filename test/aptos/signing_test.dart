import 'package:blockchain_utils/utils/binary/utils.dart';
import 'package:on_chain/on_chain.dart';
import 'package:test/test.dart';

void main() {
  _test();
}

void _test() {
  test("aptos Ed25519 signing test", () {
    final key = AptosEd25519Account(
        AptosED25519PrivateKey.fromBytes(List<int>.filled(32, 13)));
    final sig = key.sign([0]);
    expect(BytesUtils.toHexString(sig.toBytes()),
        "40554b30c696ed67d637ccc1e15a4fd855c55b9b9e41ba5fd1ef612ced4f4fa1f3780da9f96d6297a70dbfadaa6b980c2081c4b4f482afd7e34986a010e00e4707");
    expect(key.publicKey.verifySignature(message: [0], signature: sig.toBcs()),
        true);
  });
  test("aptos SingleKey signing test", () {
    final key = AptosSingleKeyAccount(
        AptosED25519PrivateKey.fromBytes(List<int>.filled(32, 13)));
    final sig = key.sign([0]);
    expect(BytesUtils.toHexString(sig.toBytes()),
        "0040554b30c696ed67d637ccc1e15a4fd855c55b9b9e41ba5fd1ef612ced4f4fa1f3780da9f96d6297a70dbfadaa6b980c2081c4b4f482afd7e34986a010e00e4707");
    expect(
        key.publicKey
            .verifySignature(message: [0], signature: sig.toVariantBcs()),
        true);
  });

  test("aptos MultiKey signing test", () {
    final privateKey1 =
        AptosED25519PrivateKey.fromBytes(List<int>.filled(32, 12));
    final privateKey2 =
        AptosED25519PrivateKey.fromBytes(List<int>.filled(32, 13));
    final privateKey3 =
        AptosSecp256k1PrivateKey.fromBytes(List<int>.filled(32, 14));
    final key = AptosMultiKeyAccount(
        publicKey: AptosMultiKeyAccountPublicKey(publicKeys: [
          privateKey1.publicKey,
          privateKey2.publicKey,
          privateKey3.publicKey
        ], requiredSignature: 3),
        privateKeys: [privateKey1, privateKey2, privateKey3]);
    final sig = key.sign([0]);
    expect(BytesUtils.toHexString(sig.toBytes()),
        "0300400d6753413e37013b8a2d557d260f1462a36fce97d41b416af76d851f45ed15aa83d921b6def066c1856e7ac0a1156bbb583ca12bbbcf98ca97790dab7cd2f3090040554b30c696ed67d637ccc1e15a4fd855c55b9b9e41ba5fd1ef612ced4f4fa1f3780da9f96d6297a70dbfadaa6b980c2081c4b4f482afd7e34986a010e00e47070140cd254c437133edcbf428ba29f544f5b62b5aa07cba2a11b49b2262092ae87b781ce75eaf14a0a7368e1d2c45965bbf9e71c7f44c21c540044d96cfa13e74e83b04e0000000");
    expect(key.publicKey.verifySignature(message: [0], signature: sig.toBcs()),
        true);
  });
  test("aptos MultiED signing test", () {
    final privateKey1 =
        AptosED25519PrivateKey.fromBytes(List<int>.filled(32, 12));
    final privateKey2 =
        AptosED25519PrivateKey.fromBytes(List<int>.filled(32, 13));
    final key = AptosMultiEd25519Account(
        publicKey: AptosMultiEd25519AccountPublicKey(publicKeys: [
          privateKey1.publicKey,
          privateKey2.publicKey,
        ], threshold: 2),
        privateKeys: [privateKey1, privateKey2]);
    final sig = key.sign([0]);
    expect(
        key.publicKey.verifySignature(message: [0], signature: sig.toBytes()),
        true);
  });
}
