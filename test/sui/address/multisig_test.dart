import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/on_chain.dart';
import 'package:test/test.dart';

SuiCryptoPublicKey getPublicKey(int fill) {
  final key = SuiSecp256r1PrivateKey.fromBytes(List<int>.filled(32, fill));
  return key.publicKey;
}

SuiCryptoPublicKey getPublicKeyED25519(int fill) {
  final key = SuiED25519PrivateKey.fromBytes(List<int>.filled(32, fill));
  return key.publicKey;
}

SuiCryptoPublicKey getPublicKeySecp256k1(int fill) {
  final key = SuiSecp256k1PrivateKey.fromBytes(List<int>.filled(32, fill));
  return key.publicKey;
}

void main() {
  _createAddress3();
  _createAddress2();
  _createAddress();
  _createAddress4();
}

void _createAddress2() {
  test("create Multisig Address", () {
    final multisigPubkey = SuiMultisigAccountPublicKey(publicKeys: [
      SuiMultisigPublicKeyInfo(publicKey: getPublicKey(12), weight: 4),
      SuiMultisigPublicKeyInfo(publicKey: getPublicKey(13), weight: 5),
      SuiMultisigPublicKeyInfo(publicKey: getPublicKey(14), weight: 9)
    ], threshold: 9);
    expect(
        multisigPubkey.toAddress(),
        SuiAddress(
            "0xdabb8b9db5e4b80ca629190d8cb03699f778e93ae60f53d9444e2722ff7bd669"));
    expect(multisigPubkey.toBcsBase64(),
        "AwIDQq2XHQN9GrK+384/F/l9utEgXqfMdaBP9YLdylagvzgEAgP3+Ff1FiAh1OkfZYQ2bmm3fbp5AQYFrFxQe1E4lR/CQgUCAm0Thf+syb1IULdQ2hfAY0MrzbUj2Q7Jz5JQulob0wZjCQkA");
    final decode = SuiMultisigAccountPublicKey.deserialize(StringUtils.encode(
        "AwIDQq2XHQN9GrK+384/F/l9utEgXqfMdaBP9YLdylagvzgEAgP3+Ff1FiAh1OkfZYQ2bmm3fbp5AQYFrFxQe1E4lR/CQgUCAm0Thf+syb1IULdQ2hfAY0MrzbUj2Q7Jz5JQulob0wZjCQkA",
        type: StringEncoding.base64));
    expect(decode.toBcsBase64(), multisigPubkey.toBcsBase64());
    // expect(decode.toHex(),
    //     "03020342ad971d037d1ab2bedfce3f17f97dbad1205ea7cc75a04ff582ddca56a0bf38040203f7f857f5162021d4e91f6584366e69b77dba79010605ac5c507b5138951fc2420502026d1385ffacc9bd4850b750da17c063432bcdb523d90ec9cf9250ba5a1bd30663090900");

    expect(BytesUtils.toHexString(decode.toVariantBcs()),
        "0303020342ad971d037d1ab2bedfce3f17f97dbad1205ea7cc75a04ff582ddca56a0bf38040203f7f857f5162021d4e91f6584366e69b77dba79010605ac5c507b5138951fc2420502026d1385ffacc9bd4850b750da17c063432bcdb523d90ec9cf9250ba5a1bd30663090900");
  });
}

void _createAddress() {
  test("create Multisig Address 2", () {
    final multisigPubkey = SuiMultisigAccountPublicKey(publicKeys: [
      SuiMultisigPublicKeyInfo(publicKey: getPublicKey(12), weight: 1),
      SuiMultisigPublicKeyInfo(publicKey: getPublicKey(13), weight: 2),
      SuiMultisigPublicKeyInfo(publicKey: getPublicKey(14), weight: 3)
    ], threshold: 3);
    expect(
        multisigPubkey.toAddress(),
        SuiAddress(
            "0x62fe15a8ddc012c6a6c227d81fa2180bb85821f59b6486bb9ea7d41710289002"));
    expect(multisigPubkey.toBcsBase64(),
        "AwIDQq2XHQN9GrK+384/F/l9utEgXqfMdaBP9YLdylagvzgBAgP3+Ff1FiAh1OkfZYQ2bmm3fbp5AQYFrFxQe1E4lR/CQgICAm0Thf+syb1IULdQ2hfAY0MrzbUj2Q7Jz5JQulob0wZjAwMA");
    final decode = SuiMultisigAccountPublicKey.deserialize(StringUtils.encode(
        "AwIDQq2XHQN9GrK+384/F/l9utEgXqfMdaBP9YLdylagvzgBAgP3+Ff1FiAh1OkfZYQ2bmm3fbp5AQYFrFxQe1E4lR/CQgICAm0Thf+syb1IULdQ2hfAY0MrzbUj2Q7Jz5JQulob0wZjAwMA",
        type: StringEncoding.base64));
    expect(decode.toBcsBase64(), multisigPubkey.toBcsBase64());
  });
}

void _createAddress3() {
  test("create Multisig Address 3", () {
    final multisigPubkey = SuiMultisigAccountPublicKey(publicKeys: [
      SuiMultisigPublicKeyInfo(publicKey: getPublicKey(12), weight: 2),
      SuiMultisigPublicKeyInfo(publicKey: getPublicKey(13), weight: 3),
      SuiMultisigPublicKeyInfo(publicKey: getPublicKey(14), weight: 2),
      SuiMultisigPublicKeyInfo(publicKey: getPublicKey(15), weight: 1)
    ], threshold: 7);
    expect(
        multisigPubkey.toAddress(),
        SuiAddress(
            "0xa556fa9859153cc81698df8f9ed67401b2c6ac24cd90e31b32b80b9ceac37d4e"));
    expect(multisigPubkey.toBcsBase64(),
        "BAIDQq2XHQN9GrK+384/F/l9utEgXqfMdaBP9YLdylagvzgCAgP3+Ff1FiAh1OkfZYQ2bmm3fbp5AQYFrFxQe1E4lR/CQgMCAm0Thf+syb1IULdQ2hfAY0MrzbUj2Q7Jz5JQulob0wZjAgIDj/t6Lq6q95McH7IRkrc3s5KQ/sbwVd9KNf1eVch6lM4BBwA=");
    final decode = SuiMultisigAccountPublicKey.deserialize(StringUtils.encode(
        "BAIDQq2XHQN9GrK+384/F/l9utEgXqfMdaBP9YLdylagvzgCAgP3+Ff1FiAh1OkfZYQ2bmm3fbp5AQYFrFxQe1E4lR/CQgMCAm0Thf+syb1IULdQ2hfAY0MrzbUj2Q7Jz5JQulob0wZjAgIDj/t6Lq6q95McH7IRkrc3s5KQ/sbwVd9KNf1eVch6lM4BBwA=",
        type: StringEncoding.base64));
    expect(decode.toBcsBase64(), multisigPubkey.toBcsBase64());
    // expect(decode.toHex(),
    //     "04020342ad971d037d1ab2bedfce3f17f97dbad1205ea7cc75a04ff582ddca56a0bf38020203f7f857f5162021d4e91f6584366e69b77dba79010605ac5c507b5138951fc2420302026d1385ffacc9bd4850b750da17c063432bcdb523d90ec9cf9250ba5a1bd306630202038ffb7a2eaeaaf7931c1fb21192b737b39290fec6f055df4a35fd5e55c87a94ce010700");

    expect(BytesUtils.toHexString(decode.toVariantBcs()),
        "0304020342ad971d037d1ab2bedfce3f17f97dbad1205ea7cc75a04ff582ddca56a0bf38020203f7f857f5162021d4e91f6584366e69b77dba79010605ac5c507b5138951fc2420302026d1385ffacc9bd4850b750da17c063432bcdb523d90ec9cf9250ba5a1bd306630202038ffb7a2eaeaaf7931c1fb21192b737b39290fec6f055df4a35fd5e55c87a94ce010700");
  });
}

void _createAddress4() {
  test("create Multisig Address 4", () {
    final multisigPubkey = SuiMultisigAccountPublicKey(publicKeys: [
      SuiMultisigPublicKeyInfo(publicKey: getPublicKey(12), weight: 2),
      SuiMultisigPublicKeyInfo(publicKey: getPublicKeyED25519(13), weight: 3),
      SuiMultisigPublicKeyInfo(publicKey: getPublicKeySecp256k1(14), weight: 2),
      SuiMultisigPublicKeyInfo(publicKey: getPublicKeyED25519(15), weight: 1)
    ], threshold: 7);
    expect(
        multisigPubkey.toAddress(),
        SuiAddress(
            "0xcb214af0483b39c446690f19ae2da8ce703f52239ff94fd42553ceb48c4dda3d"));
    expect(multisigPubkey.toBcsBase64(),
        "BAIDQq2XHQN9GrK+384/F/l9utEgXqfMdaBP9YLdylagvzgCAJGiigt0OBWTpNlGlXkgiSavyK2CyIObdkQ1m566mks6AwECmcKqhdKyGmLzlpB6gCpY5SHa/VvdrMvXJ4buoYm8TckCANm/IUh0ioXInaWq2O4LD8LRBf051BpMeWU2NU8K4pAMAQcA");
    final decode = SuiMultisigAccountPublicKey.deserialize(StringUtils.encode(
        "BAIDQq2XHQN9GrK+384/F/l9utEgXqfMdaBP9YLdylagvzgCAJGiigt0OBWTpNlGlXkgiSavyK2CyIObdkQ1m566mks6AwECmcKqhdKyGmLzlpB6gCpY5SHa/VvdrMvXJ4buoYm8TckCANm/IUh0ioXInaWq2O4LD8LRBf051BpMeWU2NU8K4pAMAQcA",
        type: StringEncoding.base64));
    expect(decode.toBcsBase64(), multisigPubkey.toBcsBase64());
    // expect(decode.toHex(),
    //     "04020342ad971d037d1ab2bedfce3f17f97dbad1205ea7cc75a04ff582ddca56a0bf38020091a28a0b74381593a4d9469579208926afc8ad82c8839b7644359b9eba9a4b3a03010299c2aa85d2b21a62f396907a802a58e521dafd5bddaccbd72786eea189bc4dc90200d9bf2148748a85c89da5aad8ee0b0fc2d105fd39d41a4c796536354f0ae2900c010700");

    expect(BytesUtils.toHexString(decode.toVariantBcs()),
        "0304020342ad971d037d1ab2bedfce3f17f97dbad1205ea7cc75a04ff582ddca56a0bf38020091a28a0b74381593a4d9469579208926afc8ad82c8839b7644359b9eba9a4b3a03010299c2aa85d2b21a62f396907a802a58e521dafd5bddaccbd72786eea189bc4dc90200d9bf2148748a85c89da5aad8ee0b0fc2d105fd39d41a4c796536354f0ae2900c010700");
  });
}
