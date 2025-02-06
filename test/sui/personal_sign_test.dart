import 'package:blockchain_utils/utils/string/string.dart';
import 'package:on_chain/on_chain.dart';
import 'package:test/test.dart';

void main() {
  _personalSign();
}

void _personalSign() {
  test("personal sign Secp256r1", () {
    final account = SuiSecp256r1Account(
        SuiSecp256r1PrivateKey.fromBytes(List<int>.filled(32, 14)));
    final signature =
        account.signPersonalMessage(StringUtils.encode("MRTNETWORK"));
    expect(signature.toVariantBcsBase64(),
        "Asgo4GQZbeujT5cjS7WxHxMRLkL7BoRFe3MlNZC7+5CjIyB6jJYBuK5GMPGHJtBi5j/WiV9d8NoR8KHoAP0PScYCbROF/6zJvUhQt1DaF8BjQyvNtSPZDsnPklC6WhvTBmM=");
    final verify = account.publicKey.verifyPrsonalMessage(
        message: StringUtils.encode("MRTNETWORK"),
        signature: signature.toVariantBcs());
    expect(verify, true);
  });
  test("Invalid signature scheme", () {
    final account = SuiSecp256r1Account(
        SuiSecp256r1PrivateKey.fromBytes(List<int>.filled(32, 14)));
    expect(() {
      return account.publicKey.verifyPrsonalMessage(
          message: StringUtils.encode("MRTNETWORK"),
          signature: StringUtils.encode(
              "AXNOgHuyealnt/zs5bYX7bdPzTucz1BCR7MN8dM08A7eWkOPCCBX45QHRy+EZqXfcg6lDunlUY/Rmr+6draBUr4CmcKqhdKyGmLzlpB6gCpY5SHa/VvdrMvXJ4buoYm8Tck=",
              type: StringEncoding.base64));
    }, throwsA(TypeMatcher<DartSuiPluginException>()));
  });
  test("Invalid signature", () {
    final account = SuiSecp256r1Account(
        SuiSecp256r1PrivateKey.fromBytes(List<int>.filled(32, 14)));
    expect(() {
      return account.publicKey.verifyPrsonalMessage(
          message: StringUtils.encode("MRTNETWORK"),
          signature: List<int>.filled(200, 0));
    }, throwsA(TypeMatcher<DartSuiPluginException>()));
  });

  test("personal sign Secp256K1", () {
    final account = SuiSecp256k1Account(
        SuiSecp256k1PrivateKey.fromBytes(List<int>.filled(32, 14)));
    final signature =
        account.signPersonalMessage(StringUtils.encode("MRTNETWORK"));
    expect(signature.toVariantBcsBase64(),
        "AXNOgHuyealnt/zs5bYX7bdPzTucz1BCR7MN8dM08A7eWkOPCCBX45QHRy+EZqXfcg6lDunlUY/Rmr+6draBUr4CmcKqhdKyGmLzlpB6gCpY5SHa/VvdrMvXJ4buoYm8Tck=");
    final verify = account.publicKey.verifyPrsonalMessage(
        message: StringUtils.encode("MRTNETWORK"),
        signature: signature.toVariantBcs());
    expect(verify, true);
  });
  test("personal sign Ed22519", () {
    final account = SuiEd25519Account(
        SuiED25519PrivateKey.fromBytes(List<int>.filled(32, 14)));
    final signature =
        account.signPersonalMessage(StringUtils.encode("MRTNETWORK"));
    expect(signature.toVariantBcsBase64(),
        "AF2ciB8WagXWanac271RFghEWv56/EfWsHd5Ps1OFJU6HrOHXpgw6lZ4AMhJNlEkT5ADjdWiZVWxRT0d8DDRBQwL7vWp5nnmo+E0/ieDe/8yx8tfXUTqCbyw5UK61qTAzA==");
    final verify = account.publicKey.verifyPrsonalMessage(
        message: StringUtils.encode("MRTNETWORK"),
        signature: signature.toVariantBcs());
    expect(verify, true);
  });
  test("personal sign Multisig", () {
    final key1 = SuiED25519PrivateKey.fromBytes(List<int>.filled(32, 14));
    final key2 = SuiED25519PrivateKey.fromBytes(List<int>.filled(32, 5));
    final key3 = SuiED25519PrivateKey.fromBytes(List<int>.filled(32, 7));
    final account = SuiMultisigAccount(
        privateKeys: [key1, key2, key3],
        publicKey: SuiMultisigAccountPublicKey(publicKeys: [
          SuiMultisigPublicKeyInfo(publicKey: key1.publicKey, weight: 1),
          SuiMultisigPublicKeyInfo(publicKey: key2.publicKey, weight: 1),
          SuiMultisigPublicKeyInfo(publicKey: key3.publicKey, weight: 1),
        ], threshold: 3));
    final signature =
        account.signPersonalMessage(StringUtils.encode("MRTNETWORK"));
    expect(signature.toVariantBcsBase64(),
        "AwMAXZyIHxZqBdZqdpzbvVEWCERa/nr8R9awd3k+zU4UlToes4demDDqVngAyEk2USRPkAON1aJlVbFFPR3wMNEFDAArZ7HPNicir0urruTieFYrY3ryvmg8M5KY6+61uk+Os8ARibPKBMaKfhijTDRlgSkCtRzxRCXeP41cJrjNjFgOAA2c0k/ZSNrXfNgRABa88gU/7h9p9SM+nO5dIJdJuRAV0hOyKllbBUkHdQM247df2rAiKJ6/6bPyvlhM6wucsgAHAAMAC+71qeZ55qPhNP4ng3v/MsfLX11E6gm8sOVCutakwMwBAG56HN0psLeP0Tr0xVmP7/TvKpcWbjym8uT7/M2AUFvxAQDqSmxj4pxSCr71UHsTLsX5lUd2rr6+e5JCHuppFEbSLAEDAA==");
    final verify = account.publicKey.verifyPrsonalMessage(
        message: StringUtils.encode("MRTNETWORK"),
        signature: signature.toVariantBcs());
    expect(verify, true);
  });
  test("personal sign Multisig 2", () {
    final key1 = SuiED25519PrivateKey.fromBytes(List<int>.filled(32, 14));
    final key2 = SuiSecp256k1PrivateKey.fromBytes(List<int>.filled(32, 5));
    final key3 = SuiSecp256r1PrivateKey.fromBytes(List<int>.filled(32, 7));
    final key4 = SuiED25519PrivateKey.fromBytes(List<int>.filled(32, 8));
    final key5 = SuiED25519PrivateKey.fromBytes(List<int>.filled(32, 9));
    final account = SuiMultisigAccount(
        privateKeys: [key5, key2, key3],
        publicKey: SuiMultisigAccountPublicKey(publicKeys: [
          SuiMultisigPublicKeyInfo(publicKey: key1.publicKey, weight: 1),
          SuiMultisigPublicKeyInfo(publicKey: key2.publicKey, weight: 1),
          SuiMultisigPublicKeyInfo(publicKey: key3.publicKey, weight: 1),
          SuiMultisigPublicKeyInfo(publicKey: key4.publicKey, weight: 1),
          SuiMultisigPublicKeyInfo(publicKey: key5.publicKey, weight: 2),
        ], threshold: 4));
    final signature =
        account.signPersonalMessage(StringUtils.encode("MRTNETWORK"));
    final verify = account.publicKey.verifyPrsonalMessage(
        message: StringUtils.encode("MRTNETWORK"),
        signature: signature.toVariantBcs());
    expect(verify, true);
  });
  test("verify multisig", () {
    final key1 = SuiED25519PrivateKey.fromBytes(List<int>.filled(32, 14));
    final key2 = SuiSecp256k1PrivateKey.fromBytes(List<int>.filled(32, 5));
    final key3 = SuiSecp256r1PrivateKey.fromBytes(List<int>.filled(32, 7));
    final key4 = SuiED25519PrivateKey.fromBytes(List<int>.filled(32, 8));
    final key5 = SuiED25519PrivateKey.fromBytes(List<int>.filled(32, 9));
    final account = SuiMultisigAccount(
        privateKeys: [key5, key2, key3],
        publicKey: SuiMultisigAccountPublicKey(publicKeys: [
          SuiMultisigPublicKeyInfo(publicKey: key1.publicKey, weight: 1),
          SuiMultisigPublicKeyInfo(publicKey: key2.publicKey, weight: 1),
          SuiMultisigPublicKeyInfo(publicKey: key3.publicKey, weight: 1),
          SuiMultisigPublicKeyInfo(publicKey: key4.publicKey, weight: 1),
          SuiMultisigPublicKeyInfo(publicKey: key5.publicKey, weight: 2),
        ], threshold: 4));
    final signature = StringUtils.encode(
        "AwMAAUYT5VgXwx2uChQ7o8DMdWtOFsB3guDHn9Yci3gxd1ycXnOKyiRAkYzZGzPTeXXLBtxdMvQ7IF7OVIcyLSLIBwFcUbpu0qrAmBEoSQtrB+a6SUYL7B08RNETAtBGI2puyldp4Vc/fW2ojbK0bcRJd0g3cMrAqQ81jbJj3QSh75Q/Aras0QgfuX3cTGvde2SPQquf4uet6MQ/DyckOuqaUPx8cVW5MsBNlrs2Gw07iqDngSlRWxIaliVs3sMKtyUNM5MWAAUAC+71qeZ55qPhNP4ng3v/MsfLX11E6gm8sOVCutakwMwBAQNiwKBG2szobd0DQ8bTx8ecIgi6DZyc8kptBG0h0h+Q9wECAx4YUy/UdUwC8wQdnHXOszuD/9gax85P6ILMscmLxYluAQATmPYsbRpFfFG6aktfPb0vafypMhYhjciZfkFr0X2TygEA/RckOFqgx1tk+3jNYC+h2ZH96/drE8WO1wLqyDXp9hgCBAA=",
        type: StringEncoding.base64);
    final verify = account.publicKey.verifyPrsonalMessage(
        message: StringUtils.encode("MRTNETWORK"), signature: signature);
    expect(verify, true);
  });
}
