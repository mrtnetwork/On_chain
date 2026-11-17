import 'package:blockchain_utils/encoding/encoding.dart';
import 'package:on_chain/tezos/src/crypto/private_key/bls12.dart';
import 'package:on_chain/tezos/src/crypto/private_key/ed25519.dart';
import 'package:on_chain/tezos/src/crypto/private_key/ml_dsa_44.dart';
import 'package:on_chain/tezos/src/crypto/private_key/secp256k1.dart';
import 'package:on_chain/tezos/src/crypto/private_key/secp256r1.dart';
import 'package:on_chain/tezos/src/crypto/private_key/secret_key.dart';
import 'package:on_chain/tezos/src/crypto/public_key/bls12.dart';
import 'package:on_chain/tezos/src/crypto/public_key/ed25519.dart';
import 'package:on_chain/tezos/src/crypto/public_key/ml_dsa_44.dart';
import 'package:on_chain/tezos/src/crypto/public_key/public_key.dart';
import 'package:on_chain/tezos/src/crypto/public_key/secp256k1.dart';
import 'package:on_chain/tezos/src/crypto/public_key/secp256r1.dart';
import 'package:on_chain/tezos/src/crypto/types/types.dart';

class TezosCryptoUtils {
  static String encodePublicKey(TezosPublicKey publicKey) {
    return Base58Encoder.encodeWithChecksum([
      ...publicKey.type.publicKeyPrefixBytes,
      ...publicKey.toBytes(),
    ]);
  }

  static TezosPublicKey decodePubkey(String publicKey) {
    final type = TezosKeyType.fromPublicKeyBase58(publicKey);
    final decode = Base58Decoder.decodeWithChecksum(publicKey);
    final bytes = decode.sublist(type.publicKeyPrefixBytes.length);
    return switch (type) {
      TezosKeyType.ed25519 => TezosEd25519PublicKey.fromBytes(bytes),
      TezosKeyType.secp256k1 => TezosSecp256k1PublicKey.fromBytes(bytes),
      TezosKeyType.secp256r1 => TezosSecp256r1PublicKey.fromBytes(bytes),
      TezosKeyType.bls => TezosBlsPublicKey.fromBytes(bytes),
      TezosKeyType.mlDsa => TezosMLDSA44PublicKey.fromBytes(bytes),
    };
  }

  static TezosSecretKey decodeSecretKey(String sk) {
    final type = TezosKeyType.fromSecretKeyBase58(sk);
    final decode = Base58Decoder.decodeWithChecksum(sk);
    final bytes = decode.sublist(type.privateKeyPrefixBytes.length);
    return switch (type) {
      TezosKeyType.ed25519 => TezosEd25519SecretKey.fromBytes(bytes),
      TezosKeyType.secp256k1 => TezosSecp256k1SecretKey.fromBytes(bytes),
      TezosKeyType.secp256r1 => TezosSecp256r1SecretKey.fromBytes(bytes),
      TezosKeyType.bls => TezosBlsSecretKey.fromBytes(bytes),
      TezosKeyType.mlDsa => TezosMLDSA44SecretKey.fromBytes(bytes),
    };
  }

  static String encodeSecretKey(
    TezosSecretKey sk, {
    bool ed25519Expanded = false,
  }) {
    List<int> prefix = sk.type.privateKeyPrefixBytes;
    List<int> skBytes = sk.toBytes();
    if (ed25519Expanded && sk.type == TezosKeyType.ed25519) {
      prefix = TezosKeyType.ed25519ExpandedSecretKeyPrefixBytes;
      skBytes = [...skBytes, ...sk.toPublicKey().toBytes()];
    }
    return Base58Encoder.encodeWithChecksum([...prefix, ...skBytes]);
  }
}
