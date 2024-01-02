import 'dart:convert';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/on_chain.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  test("personal sign 1", () {
    final privateKey = TronPrivateKey(
        "43985273a3d94eb753fe6acfd7003e88254effce1eb53e2e97b8522558a98038");
    final messagae = utf8.encode("message");
    final sign = privateKey.signPersonalMessage(messagae);
    final verify = privateKey.publicKey().verifyPersonalMessage(messagae, sign);
    expect(sign,
        "fde00bc33d78109bc61de314c1c0526a047e22a2aaae473ca84b32d8aa35ed3e03720e05d614087e3d8c6fae63879755b32aa08818a2d4de66fee1a617a971671b");
    expect(verify, true);
    final publicKey = TronPublicKey.fromPersonalSignature(messagae, sign);
    expect(publicKey?.toHex(), privateKey.publicKey().toHex());
  });
  test("personal sign 2", () {
    final privateKey = TronPrivateKey(
        "43985273a3d94eb753fe6acfd7003e88254effce1eb53e2e97b8522558a98038");
    final messagae = utf8.encode(
        "43985273a3d94eb753fe6acfd7003e88254effce1eb53e2e97b8522558a98038");
    final sign = privateKey.signPersonalMessage(messagae);
    final verify = privateKey.publicKey().verifyPersonalMessage(messagae, sign);
    expect(sign,
        "b243c5e8a4d674873acf2d2c0bc144abbd31f4076cba890fb9a98aad85e9b3c26e522137c0cdb1b8d85569677745d366625326a5c6c245dde72ea87901b7ac8c1b");
    expect(verify, true);
    final publicKey = TronPublicKey.fromPersonalSignature(messagae, sign);
    expect(publicKey?.toHex(), privateKey.publicKey().toHex());
  });
  test("personal sign 3", () {
    final privateKey = TronPrivateKey(
        "43985273a3d94eb753fe6acfd7003e88254effce1eb53e2e97b8522558a98038");
    final messagae = utf8.encode(
        "43985273a3d94eb753fe6acfd7003e88254effce1eb53e2e97b8522558a98038");
    final sign =
        privateKey.signPersonalMessage(messagae, useEthereumPrefix: true);
    final verify = privateKey
        .publicKey()
        .verifyPersonalMessage(messagae, sign, useEthereumPrefix: true);
    expect(verify, true);
    final publicKey = TronPublicKey.fromPersonalSignature(messagae, sign,
        useEthereumPrefix: true);
    expect(publicKey?.toHex(), privateKey.publicKey().toHex());
  });
  test("personal sign 4", () {
    final privateKey = TronPrivateKey(
        "43985273a3d94eb753fe6acfd7003e88254effce1eb53e2e97b8522558a98038");
    final messagae = utf8.encode(
        "43985273a3d94eb753fe6acfd7003e88254effce1eb53e2e97b8522558a98038");
    final sign = privateKey.signPersonalMessage(messagae,
        useEthereumPrefix: true, payloadLength: 32);
    final verify = privateKey.publicKey().verifyPersonalMessage(messagae, sign,
        useEthereumPrefix: true, payloadLength: 32);
    expect(verify, true);
    final publicKey = TronPublicKey.fromPersonalSignature(messagae, sign,
        useEthereumPrefix: true, payloadLength: 32);
    expect(publicKey?.toHex(), privateKey.publicKey().toHex());
  });
  test("personal sign 5", () {
    final privateKey = TronPrivateKey(
        "43985273a3d94eb753fe6acfd7003e88254effce1eb53e2e97b8522558a98038");
    final messagae = utf8.encode(
        "43985273a3d94eb753fe6acfd7003e88254effce1eb53e2e97b8522558a98038");
    final sign = privateKey.signPersonalMessage(messagae,
        useEthereumPrefix: true, payloadLength: 32);
    String etherumPrefix = "\u0019Ethereum Signed Message:\n";
    etherumPrefix = "${etherumPrefix}32";
    final List<int> prefixBytes = utf8.encode(etherumPrefix);
    final List<int> hashedMessage =
        QuickCrypto.keccack256Hash([...prefixBytes, ...messagae]);
    final verify = privateKey
        .publicKey()
        .verifyPersonalMessage(hashedMessage, sign, hashMessage: false);
    expect(verify, true);
    final publicKey = TronPublicKey.fromPersonalSignature(hashedMessage, sign,
        hashMessage: false);
    expect(publicKey?.toHex(), privateKey.publicKey().toHex());
  });
}
