import 'package:blockchain_utils/bip/address/p2pkh_addr.dart';
import 'package:on_chain/ethereum/ethereum.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  test("test keys1", () {
    final privateKey = ETHPrivateKey(
        "91e4ad47a567b23aec1157e280c00b3170125c4de7169ae63021aed37924931a");
    final publicKey = privateKey.publicKey();
    final addr = publicKey.toAddress();
    expect(addr.address, "0x6eCEcA63588925176Ce147Dc72d8f433D829bfb7");
    expect(publicKey.toHex(PubKeyModes.uncompressed).substring(2),
        "95230aab87d27de094b891e627c3a943efa73be1be4d07fc6bff1c84f9684a0cc38ea287fe458ef672abfac8d5b178b89eaa7e329f19a1c7cc767998231669e7");
  });
  test("test keys2", () {
    final privateKey = ETHPrivateKey(
        "1b55546f2e85b7d33bed96b855075edfef218131decedde31c6e1003c23d32ab");
    final publicKey = privateKey.publicKey();
    final addr = publicKey.toAddress();
    expect(addr.address, "0x64A8A5E3D891dCEA6c8d837B6d1de7B01e8cfd6C");
    expect(publicKey.toHex(PubKeyModes.uncompressed).substring(2),
        "f356c5c64f198c71c317bd106bba35de9075b5927349697c9700eb942971253b897848862d117615752bd6cf84b33099b4163dc8b6038dc874d5927eebdbb7e9");
  });
  test("test keys2", () {
    final privateKey = ETHPrivateKey(
        "295002126a4a41f563d0dde594d7b756553395cac2029a6bbf9624c6d2f2d803");
    final publicKey = privateKey.publicKey();
    final addr = publicKey.toAddress();
    expect(addr.address, "0xbE844ACCE40d5B61464B64785807beFbE7EcCeCC");
    expect(publicKey.toHex(PubKeyModes.uncompressed).substring(2),
        "71f3098a6848a18d1af5198198cc4dfdf1cfd0d29a4c7db6c40b052429f4b080293acb207b4c3107fe29cd21989fc16033d27b7cf71dc0ce704f32bef607ea06");
  });
  test("test keys2", () {
    final privateKey = ETHPrivateKey(
        "238967bae6b4245b80a01cd2ca28046b38e19226925c3853623ee5768cc5166b");
    final publicKey = privateKey.publicKey();
    final addr = publicKey.toAddress();
    expect(addr.address, "0xfE13192845d411824df4935c2699cBDb11Bc9a2e");
    expect(publicKey.toHex(PubKeyModes.uncompressed).substring(2),
        "5ad09e10e5b3eb91c9df617edd730a12401da06a1696d437bd128d2173f8a53bbbd00be63dc4f2ce899ef644937f5b9ab25cd90d1655e24f8efe781a2e2f9cad");
  });
}
