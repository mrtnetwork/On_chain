import 'package:on_chain/on_chain.dart';
import 'package:test/test.dart';

void main() {
  _testEd25519SuiSecretKey();
}

void _testEd25519SuiSecretKey() {
  test('Ed25519 encode decode sui secret key', () {
    const secretKey =
        "suiprivkey1qpq5zs2pg9q5zs2pg9q5zs2pg9q5zs2pg9q5zs2pg9q5zs2pg9q5z5u89z0";
    final privateKey = SuiBasePrivateKey.fromSuiSecretKey(secretKey);
    final keyBytes = List<int>.filled(32, 65);
    expect(privateKey.toSuiPrivateKey(), secretKey);
    expect(privateKey.algorithm, SuiKeyAlgorithm.ed25519);
    expect(privateKey, isA<SuiED25519PrivateKey>());
    expect(privateKey.toBytes(), keyBytes);
    final decode = SuiCryptoUtils.decodeSuiSecretKey(secretKey);
    expect(decode.$1, SuiKeyAlgorithm.ed25519);
    expect(decode.$2, keyBytes);
    final encode = SuiCryptoUtils.encodeSuiSecretKey(keyBytes,
        type: privateKey.algorithm.curveType);
    expect(encode, secretKey);
  });
  test('Ed25519 encode decode sui secret key', () {
    const secretKey =
        "suiprivkey1qq8qurswpc8qurswpc8qurswpc8qurswpc8qurswpc8qurswpc8qu203pw9";
    final privateKey = SuiBasePrivateKey.fromSuiSecretKey(secretKey);
    final keyBytes = List<int>.filled(32, 14);
    expect(privateKey.toSuiPrivateKey(), secretKey);
    expect(privateKey.algorithm, SuiKeyAlgorithm.ed25519);
    expect(privateKey, isA<SuiED25519PrivateKey>());
    expect(privateKey.toBytes(), keyBytes);
    final decode = SuiCryptoUtils.decodeSuiSecretKey(secretKey);
    expect(decode.$1, SuiKeyAlgorithm.ed25519);
    expect(decode.$2, keyBytes);
    final encode = SuiCryptoUtils.encodeSuiSecretKey(keyBytes,
        type: privateKey.algorithm.curveType);
    expect(encode, secretKey);
  });
  test('Secp256k1 encode decode sui secret key', () {
    const secretKey =
        "suiprivkey1qyzs2pg9q5zs2pg9q5zs2pg9q5zs2pg9q5zs2pg9q5zs2pg9q5zs252arxz";
    final privateKey = SuiBasePrivateKey.fromSuiSecretKey(secretKey);
    final keyBytes = List<int>.filled(32, 5);
    expect(privateKey.toSuiPrivateKey(), secretKey);
    expect(privateKey.algorithm, SuiKeyAlgorithm.secp256k1);
    expect(privateKey, isA<SuiSecp256k1PrivateKey>());
    expect(privateKey.toBytes(), keyBytes);
    final decode = SuiCryptoUtils.decodeSuiSecretKey(secretKey);
    expect(decode.$1, SuiKeyAlgorithm.secp256k1);
    expect(decode.$2, keyBytes);
    final encode = SuiCryptoUtils.encodeSuiSecretKey(keyBytes,
        type: privateKey.algorithm.curveType);
    expect(encode, secretKey);
  });
  test('Secp256r1 encode decode sui secret key', () {
    const secretKey =
        "suiprivkey1qgrswpc8qurswpc8qurswpc8qurswpc8qurswpc8qurswpc8qurswm4n47j";
    final privateKey = SuiBasePrivateKey.fromSuiSecretKey(secretKey);
    final keyBytes = List<int>.filled(32, 7);
    expect(privateKey.toSuiPrivateKey(), secretKey);
    expect(privateKey.algorithm, SuiKeyAlgorithm.secp256r1);
    expect(privateKey, isA<SuiSecp256r1PrivateKey>());
    expect(privateKey.toBytes(), keyBytes);
    final decode = SuiCryptoUtils.decodeSuiSecretKey(secretKey);
    expect(decode.$1, SuiKeyAlgorithm.secp256r1);
    expect(decode.$2, keyBytes);
    final encode = SuiCryptoUtils.encodeSuiSecretKey(keyBytes,
        type: privateKey.algorithm.curveType);
    expect(encode, secretKey);
  });
}
