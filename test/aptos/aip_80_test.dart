import 'package:on_chain/aptos/aptos.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  _test();
}

void _test() {
  test("Aptos Ed25519 AIP-80", () {
    const key =
        "ed25519-priv-0x0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c";
    final privateKey = AptosBasePrivateKey.fromAIP80(key);
    expect(privateKey.algorithm, AptosKeyAlgorithm.ed25519);
    expect(privateKey, isA<AptosED25519PrivateKey>());
    expect(privateKey.toAIP80(), key);
  });
  test("Aptos Secp256k1 AIP-80", () {
    const key =
        "secp256k1-priv-0x0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d";
    final privateKey = AptosBasePrivateKey.fromAIP80(key);
    expect(privateKey.algorithm, AptosKeyAlgorithm.secp256k1);
    expect(privateKey, isA<AptosSecp256k1PrivateKey>());
    expect(privateKey.toAIP80(), key);
  });
}
