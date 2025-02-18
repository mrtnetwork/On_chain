import 'package:on_chain/on_chain.dart';
import 'package:test/test.dart';

void main() {
  _testMultiKey();
  _testMultiKey2();
  _testMultiKeyFailed();
  _testMultiEdAccount4();
  _testMultiEdAccount();
  _testMultiEdAccount2();
  _testMultiEdAccount3();
  _testSignleKeyEd25519();
  _testEd25519LegacyAccount();
  _testSignleKeySecp256k1();
}

void _testMultiKeyFailed() {
  test("Invalid MultiKey account", () {
    final privateKey1 =
        AptosED25519PrivateKey.fromBytes(List<int>.filled(32, 12));

    expect(
        () =>
            AptosMultiKeyAccountPublicKey(publicKeys: [], requiredSignature: 3),
        throwsA(TypeMatcher<DartAptosPluginException>()));
    expect(
        () => AptosMultiKeyAccountPublicKey(
            publicKeys: [privateKey1.publicKey], requiredSignature: 3),
        throwsA(TypeMatcher<DartAptosPluginException>()));
    expect(
        () => AptosMultiKeyAccountPublicKey(
            publicKeys: [privateKey1.publicKey], requiredSignature: 0),
        throwsA(TypeMatcher<DartAptosPluginException>()));
  });
}

void _testMultiKey2() {
  test("MultiKey account 2", () {
    final privateKey1 =
        AptosED25519PrivateKey.fromBytes(List<int>.filled(32, 12));
    final privateKey2 =
        AptosED25519PrivateKey.fromBytes(List<int>.filled(32, 13));
    final privateKey3 =
        AptosSecp256k1PrivateKey.fromBytes(List<int>.filled(32, 14));
    final account = AptosMultiKeyAccountPublicKey(publicKeys: [
      privateKey1.publicKey,
      privateKey2.publicKey,
      privateKey3.publicKey,
    ], requiredSignature: 3);
    expect(
        account.toAddress(),
        AptosAddress(
            "0x4b7c50ba0047625f75407f5dc73a0d00524c50016ea483d44439d5ee72369d05"));
    expect(account.toBcsHex(),
        "0300200b513ad9b4924015ca0902ed079044d3ac5dbec2306f06948c10da8eb6e39f2d002091a28a0b74381593a4d9469579208926afc8ad82c8839b7644359b9eba9a4b3a01410499c2aa85d2b21a62f396907a802a58e521dafd5bddaccbd72786eea189bc4dc9c40c3728b587c47395ce41a2afe84ee70016fafa39d3b54e66fc1f11aefda70403");

    final decode = AptosMultiKeyAccountPublicKey.deserialize(account.toBcs());
    expect(decode.toBcsHex(), account.toBcsHex());
    expect(decode.toHex(),
        "0300200b513ad9b4924015ca0902ed079044d3ac5dbec2306f06948c10da8eb6e39f2d002091a28a0b74381593a4d9469579208926afc8ad82c8839b7644359b9eba9a4b3a01410499c2aa85d2b21a62f396907a802a58e521dafd5bddaccbd72786eea189bc4dc9c40c3728b587c47395ce41a2afe84ee70016fafa39d3b54e66fc1f11aefda70403");
  });
}

void _testMultiKey() {
  test("MultiKey account", () {
    final privateKey1 =
        AptosED25519PrivateKey.fromBytes(List<int>.filled(32, 12));
    final privateKey2 =
        AptosED25519PrivateKey.fromBytes(List<int>.filled(32, 13));
    final privateKey3 =
        AptosED25519PrivateKey.fromBytes(List<int>.filled(32, 14));
    final account = AptosMultiKeyAccountPublicKey(publicKeys: [
      privateKey1.publicKey,
      privateKey2.publicKey,
      privateKey3.publicKey,
    ], requiredSignature: 3);
    expect(
        account.toAddress(),
        AptosAddress(
            "0x82a01ce96b00669a8ac358eac6551cc17dbb16f1841a5ecfe69f4750e20fe56c"));
    expect(account.toBcsHex(),
        "0300200b513ad9b4924015ca0902ed079044d3ac5dbec2306f06948c10da8eb6e39f2d002091a28a0b74381593a4d9469579208926afc8ad82c8839b7644359b9eba9a4b3a00200beef5a9e679e6a3e134fe27837bff32c7cb5f5d44ea09bcb0e542bad6a4c0cc03");

    final decode = AptosMultiKeyAccountPublicKey.deserialize(account.toBcs());
    expect(decode.toBcsHex(), account.toBcsHex());
    expect(decode.toHex(),
        "0300200b513ad9b4924015ca0902ed079044d3ac5dbec2306f06948c10da8eb6e39f2d002091a28a0b74381593a4d9469579208926afc8ad82c8839b7644359b9eba9a4b3a00200beef5a9e679e6a3e134fe27837bff32c7cb5f5d44ea09bcb0e542bad6a4c0cc03");
  });
}

void _testMultiEdAccount4() {
  test("Multi Ed25519 account wrong public keys", () {
    final privateKey1 =
        AptosED25519PrivateKey.fromBytes(List<int>.filled(32, 12));
    expect(
        () => AptosMultiEd25519AccountPublicKey(publicKeys: [
              privateKey1.publicKey,
            ], threshold: 2),
        throwsA(TypeMatcher<DartAptosPluginException>()));
  });
  test("Multi Ed25519 account wrong threshold", () {
    final privateKey1 =
        AptosED25519PrivateKey.fromBytes(List<int>.filled(32, 12));
    expect(
        () => AptosMultiEd25519AccountPublicKey(publicKeys: [
              privateKey1.publicKey,
              privateKey1.publicKey,
              privateKey1.publicKey,
              privateKey1.publicKey,
            ], threshold: 7),
        throwsA(TypeMatcher<DartAptosPluginException>()));
  });
}

void _testMultiEdAccount3() {
  test("Multi Ed25519 account", () {
    final privateKey1 =
        AptosED25519PrivateKey.fromBytes(List<int>.filled(32, 12));
    final privateKey2 =
        AptosED25519PrivateKey.fromBytes(List<int>.filled(32, 12));
    final privateKey3 =
        AptosED25519PrivateKey.fromBytes(List<int>.filled(32, 12));
    expect(
        () => AptosMultiEd25519AccountPublicKey(publicKeys: [
              privateKey1.publicKey,
              privateKey2.publicKey,
              privateKey3.publicKey
            ], threshold: 2),
        throwsA(TypeMatcher<DartAptosPluginException>()));
  });
}

void _testMultiEdAccount2() {
  test("Multi Ed25519 account 3", () {
    final privateKey1 =
        AptosED25519PrivateKey.fromBytes(List<int>.filled(32, 12));
    final privateKey2 =
        AptosED25519PrivateKey.fromBytes(List<int>.filled(32, 13));
    final privateKey3 =
        AptosED25519PrivateKey.fromBytes(List<int>.filled(32, 14));
    final account = AptosMultiEd25519AccountPublicKey(publicKeys: [
      privateKey1.publicKey,
      privateKey2.publicKey,
      privateKey3.publicKey
    ], threshold: 2);
    expect(
        account.toAddress(),
        AptosAddress(
            "0xdab62cecd6d92eca7968f1184bce94992b062868d23ea09752c6d04ce6318407"));
    expect(account.toBcsHex(),
        "610b513ad9b4924015ca0902ed079044d3ac5dbec2306f06948c10da8eb6e39f2d91a28a0b74381593a4d9469579208926afc8ad82c8839b7644359b9eba9a4b3a0beef5a9e679e6a3e134fe27837bff32c7cb5f5d44ea09bcb0e542bad6a4c0cc02");

    final decode =
        AptosMultiEd25519AccountPublicKey.deserialize(account.toBcs());
    expect(decode.toBcsHex(), account.toBcsHex());
    expect(decode.toHex(),
        "0b513ad9b4924015ca0902ed079044d3ac5dbec2306f06948c10da8eb6e39f2d91a28a0b74381593a4d9469579208926afc8ad82c8839b7644359b9eba9a4b3a0beef5a9e679e6a3e134fe27837bff32c7cb5f5d44ea09bcb0e542bad6a4c0cc02");
    final fromBytes =
        AptosMultiEd25519AccountPublicKey.fromBytes(account.toBytes());
    expect(account.toAddress(), fromBytes.toAddress());
  });
}

void _testMultiEdAccount() {
  test("Multi Ed25519 account 2", () {
    final privateKey1 =
        AptosED25519PrivateKey.fromBytes(List<int>.filled(32, 12));
    final privateKey2 =
        AptosED25519PrivateKey.fromBytes(List<int>.filled(32, 13));
    final privateKey3 =
        AptosED25519PrivateKey.fromBytes(List<int>.filled(32, 14));
    final account = AptosMultiEd25519AccountPublicKey(publicKeys: [
      privateKey1.publicKey,
      privateKey2.publicKey,
      privateKey3.publicKey
    ], threshold: 3);
    expect(
        account.toAddress(),
        AptosAddress(
            "bca0f886d39361116fc4dbe2c80f9ca7edae425030df03b4a158fd448faac91b"));
    expect(account.toBcsHex(),
        "610b513ad9b4924015ca0902ed079044d3ac5dbec2306f06948c10da8eb6e39f2d91a28a0b74381593a4d9469579208926afc8ad82c8839b7644359b9eba9a4b3a0beef5a9e679e6a3e134fe27837bff32c7cb5f5d44ea09bcb0e542bad6a4c0cc03");

    final decode =
        AptosMultiEd25519AccountPublicKey.deserialize(account.toBcs());
    expect(decode.toBcsHex(), account.toBcsHex());
    expect(decode.toHex(),
        "0b513ad9b4924015ca0902ed079044d3ac5dbec2306f06948c10da8eb6e39f2d91a28a0b74381593a4d9469579208926afc8ad82c8839b7644359b9eba9a4b3a0beef5a9e679e6a3e134fe27837bff32c7cb5f5d44ea09bcb0e542bad6a4c0cc03");
    final fromBytes =
        AptosMultiEd25519AccountPublicKey.fromBytes(account.toBytes());
    expect(account.toAddress(), fromBytes.toAddress());
  });
}

void _testEd25519LegacyAccount() {
  test("Ed25519 legacy account", () {
    final privateKey =
        AptosED25519PrivateKey.fromBytes(List<int>.filled(32, 12));
    final account = AptosEd25519AccountPublicKey(privateKey.publicKey);
    expect(
        account.toAddress(),
        AptosAddress(
            "0x7d4a0ae87cd417f94052b01a3db4c7927167dba69efe311955d1a3864878eeb3"));
    expect(account.toBcsHex(),
        "200b513ad9b4924015ca0902ed079044d3ac5dbec2306f06948c10da8eb6e39f2d");
    final decode = AptosEd25519AccountPublicKey.deserialize(account.toBcs());
    expect(decode.toBcsHex(), account.toBcsHex());
    expect(decode.toHex(),
        "0b513ad9b4924015ca0902ed079044d3ac5dbec2306f06948c10da8eb6e39f2d");
  });
}

void _testSignleKeyEd25519() {
  test("Ed25519 singleKey account", () {
    final privateKey =
        AptosED25519PrivateKey.fromBytes(List<int>.filled(32, 12));
    final account = AptosSingleKeyAccountPublicKey(privateKey.publicKey);
    expect(
        account.toAddress(),
        AptosAddress(
            "0x6f1468722b30e87e8be765554d244db068b8de2222bb9600cf5a03139922ef86"));
    expect(account.toBcsHex(),
        "00200b513ad9b4924015ca0902ed079044d3ac5dbec2306f06948c10da8eb6e39f2d");
    final decode = AptosSingleKeyAccountPublicKey.deserialize(account.toBcs());
    expect(decode.toBcsHex(), account.toBcsHex());
    expect(decode.toHex(),
        "00200b513ad9b4924015ca0902ed079044d3ac5dbec2306f06948c10da8eb6e39f2d");
  });
}

void _testSignleKeySecp256k1() {
  test("Secp256k1 singleKey account", () {
    final privateKey =
        AptosSecp256k1PrivateKey.fromBytes(List<int>.filled(32, 12));
    final account = AptosSingleKeyAccountPublicKey(privateKey.publicKey);
    expect(
        account.toAddress(),
        AptosAddress(
            "0x89dd43dcedf165f975202fae5f8aecf03013ebc14bb3c09a1431313b4ee52b02"));
    expect(account.toBcsHex(),
        "0141040f0fb9a244ad31a369ee02b7abfbbb0bfa3812b9a39ed93346d03d67d412d1777965c382f55222a9aed59cb8affc64bb5381f065eab9ef3baa57f2f0ac6bfae9");
    final decode = AptosSingleKeyAccountPublicKey.deserialize(account.toBcs());
    expect(decode.toBcsHex(), account.toBcsHex());
    expect(decode.toHex(),
        "0141040f0fb9a244ad31a369ee02b7abfbbb0bfa3812b9a39ed93346d03d67d412d1777965c382f55222a9aed59cb8affc64bb5381f065eab9ef3baa57f2f0ac6bfae9");
  });
}
