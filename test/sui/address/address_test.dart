import 'package:on_chain/on_chain.dart';
import 'package:test/test.dart';

void main() {
  _ed25519();
  _secp256k1();
  _secp256r1();
}

void _ed25519() {
  test("address ed25519", () {
    final suiPrivateKey =
        SuiED25519PrivateKey.fromBytes(List<int>.filled(32, 12));
    final address = suiPrivateKey.publicKey.toAddress();
    expect(address.address,
        "0x788ef496c697b2063a739d74de64b59983453ed3e525fe9fa7d3dc4f49e02daf");
  });
}

void _secp256k1() {
  test("address Secp256k1", () {
    final suiPrivateKey =
        SuiSecp256k1PrivateKey.fromBytes(List<int>.filled(32, 12));
    final address = suiPrivateKey.publicKey.toAddress();
    expect(address.address,
        "0x6257756b91e31542c2b868ad325c883a7369891eed31183a8936af54ef5c9529");
  });
}

void _secp256r1() {
  test("address Secp256r1", () {
    final suiPrivateKey =
        SuiSecp256r1PrivateKey.fromBytes(List<int>.filled(32, 12));
    final address = suiPrivateKey.publicKey.toAddress();
    expect(address.address,
        "0x9bc93515356b1f763a04359c54b9dea70fbbe5e1fd3a39051da5dd8d7beffe8f");
  });
}
