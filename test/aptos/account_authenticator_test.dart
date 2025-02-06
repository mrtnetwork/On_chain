import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/on_chain.dart';
import 'package:test/test.dart';

void main() {
  _accountAuthenticatorMultiKey();
  _accountAuthenticatorSingleKey();
  _accountAuthenticatorMultiEd25519();
  _noneAuthenticator();
  _accountAuthenticatorEd25519();
}

void _accountAuthenticatorMultiKey() {
  test("Account authenticator MultiKey serialization", () {
    final msigAccount = AptosMultiKeyAccountPublicKey(publicKeys: [
      AptosSecp256k1PrivateKey.fromBytes(List<int>.filled(32, 12)).publicKey,
      AptosED25519PrivateKey.fromBytes(List<int>.filled(32, 13)).publicKey,
    ], requiredSignature: 2);
    final auth = AptosAccountAuthenticatorMultiKey(
        publicKey: msigAccount,
        signature: AptosMultiKeySignature(signatures: [
          AptosSecp256k1AnySignature(
              List<int>.filled(CryptoSignerConst.ed25519SignatureLength, 0)),
          AptosEd25519AnySignature(
              List<int>.filled(CryptoSignerConst.ed25519SignatureLength, 0)),
        ], bitmap: [
          3,
          0,
          0,
          0
        ]));
    expect(auth.toVariantBcsHex(),
        "03020141040f0fb9a244ad31a369ee02b7abfbbb0bfa3812b9a39ed93346d03d67d412d1777965c382f55222a9aed59cb8affc64bb5381f065eab9ef3baa57f2f0ac6bfae9002091a28a0b74381593a4d9469579208926afc8ad82c8839b7644359b9eba9a4b3a02020140000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000403000000");
    final decode = AptosAccountAuthenticator.deserialize(auth.toVariantBcs());
    expect(auth.toVariantBcs(), decode.toVariantBcs());
  });
}

void _accountAuthenticatorSingleKey() {
  test("Account authenticator Single Key Ed25519 serialization", () {
    final publicKey =
        AptosED25519PrivateKey.fromBytes(List<int>.filled(32, 12)).publicKey;
    final auth = AptosAccountAuthenticatorSingleKey(
        publicKey: publicKey,
        signature: AptosEd25519AnySignature(
            List<int>.filled(CryptoSignerConst.ed25519SignatureLength, 0)));
    expect(auth.toVariantBcsHex(),
        "0200200b513ad9b4924015ca0902ed079044d3ac5dbec2306f06948c10da8eb6e39f2d004000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000");
    final decode = AptosAccountAuthenticator.deserialize(auth.toVariantBcs());
    expect(auth.toVariantBcs(), decode.toVariantBcs());
  });
  test("Account authenticator Single Key Secp256k1 serialization", () {
    final publicKey =
        AptosSecp256k1PrivateKey.fromBytes(List<int>.filled(32, 12)).publicKey;
    final auth = AptosAccountAuthenticatorSingleKey(
        publicKey: publicKey,
        signature: AptosSecp256k1AnySignature(
            List<int>.filled(CryptoSignerConst.ecdsaSignatureLength, 0)));
    expect(auth.toVariantBcsHex(),
        "020141040f0fb9a244ad31a369ee02b7abfbbb0bfa3812b9a39ed93346d03d67d412d1777965c382f55222a9aed59cb8affc64bb5381f065eab9ef3baa57f2f0ac6bfae9014000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000");
    final decode = AptosAccountAuthenticator.deserialize(auth.toVariantBcs());
    expect(auth.toVariantBcs(), decode.toVariantBcs());
  });
}

void _accountAuthenticatorMultiEd25519() {
  test("Account authenticator Multi ED25519 serialization", () {
    final publicKey =
        AptosED25519PrivateKey.fromBytes(List<int>.filled(32, 12)).publicKey;
    final publicKey2 =
        AptosED25519PrivateKey.fromBytes(List<int>.filled(32, 13)).publicKey;
    final fakeSignature = AptosEd25519Signature(
        List<int>.filled(CryptoSignerConst.ed25519SignatureLength, 0));
    final auth = AptosAccountAuthenticatorMultiEd25519(
        publicKey: AptosMultiEd25519AccountPublicKey(
            publicKeys: [publicKey, publicKey2], threshold: 2),
        signature: AptosMultiEd25519Signature(
            signatures: [fakeSignature, fakeSignature], bitmap: [3, 0, 0, 0]));
    expect(auth.toVariantBcsHex(),
        "01410b513ad9b4924015ca0902ed079044d3ac5dbec2306f06948c10da8eb6e39f2d91a28a0b74381593a4d9469579208926afc8ad82c8839b7644359b9eba9a4b3a028401000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003000000");
    final decode = AptosAccountAuthenticator.deserialize(auth.toVariantBcs());
    expect(auth.toVariantBcs(), decode.toVariantBcs());
  });
}

void _accountAuthenticatorEd25519() {
  test("Account authenticator ED25519 serialization", () {
    final publicKey =
        AptosED25519PrivateKey.fromBytes(List<int>.filled(32, 12)).publicKey;
    final fakeSignature = AptosEd25519Signature(
        List<int>.filled(CryptoSignerConst.ed25519SignatureLength, 0));
    final auth = AptosAccountAuthenticatorEd25519(
        publicKey: publicKey, signature: fakeSignature);
    expect(auth.toVariantBcsHex(),
        "00200b513ad9b4924015ca0902ed079044d3ac5dbec2306f06948c10da8eb6e39f2d4000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000");
    final decode = AptosAccountAuthenticator.deserialize(auth.toVariantBcs());
    expect(auth.toVariantBcs(), decode.toVariantBcs());
  });
}

void _noneAuthenticator() {
  test("No Account authenticator serialization", () {
    final auth = AptosAccountAuthenticatorNoAccountAuthenticator();
    expect(auth.toVariantBcsHex(), "04");
    final decode = AptosAccountAuthenticator.deserialize(auth.toVariantBcs());
    expect(auth.toVariantBcs(), decode.toVariantBcs());
  });
}
