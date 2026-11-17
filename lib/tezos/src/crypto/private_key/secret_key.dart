import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/tezos/src/crypto/private_key/bls12.dart';
import 'package:on_chain/tezos/src/crypto/private_key/ed25519.dart';
import 'package:on_chain/tezos/src/crypto/private_key/ml_dsa_44.dart';
import 'package:on_chain/tezos/src/crypto/private_key/secp256k1.dart';
import 'package:on_chain/tezos/src/crypto/private_key/secp256r1.dart';
import 'package:on_chain/tezos/src/crypto/public_key/public_key.dart';
import 'package:on_chain/tezos/src/crypto/types/signature.dart';
import 'package:on_chain/tezos/src/crypto/types/types.dart';
import 'package:on_chain/tezos/src/crypto/utils/utils.dart';
import 'package:on_chain/tezos/src/operations/operations/group.dart';

abstract class TezosSecretKey<PK extends TezosPublicKey>
    with Equality, SecretState
    implements TezosSigner {
  final TezosKeyType type;
  const TezosSecretKey({required this.type});

  factory TezosSecretKey.decode(String base58) {
    final key = TezosCryptoUtils.decodeSecretKey(base58);
    return key.cast();
  }
  factory TezosSecretKey.fromBytes({
    required List<int> keyBytes,
    required CryptoKeyType type,
  }) {
    final TezosSecretKey key = switch (type) {
      CryptoKeyType.secp256k1 => TezosSecp256k1SecretKey.fromBytes(keyBytes),
      CryptoKeyType.nist256p1 => TezosSecp256r1SecretKey.fromBytes(keyBytes),
      CryptoKeyType.ed25519 => TezosEd25519SecretKey.fromBytes(keyBytes),
      CryptoKeyType.bls12G1 => TezosBlsSecretKey.fromBytes(keyBytes),
      CryptoKeyType.mldsa44 => TezosMLDSA44SecretKey.fromBytes(keyBytes),
      _ =>
        throw OnChainErrors.tezosPlugin(
          "TezosSecretKey.fromBytes",
          reason: "Unsupported key type.",
          details: {"keyType": type.name},
        ),
    };
    return key.cast();
  }

  SecretBytes toBytes();

  PK toPublicKey();

  @override
  TezosSignature sign(List<int> digest);

  @override
  Future<TezosSignature> signAsync(List<int> digest) async => sign(digest);

  bool verifySignature(List<int> digest, List<int> signature) =>
      toPublicKey().verify(digest, signature);

  T cast<T extends TezosSecretKey>() {
    if (this is! T) {
      throw OnChainErrors.tezosPlugin(
        "TezosSecretKey.cast",
        reason: "Invalid key cast.",
        details: {"expected": "$T", "actual": "$runtimeType"},
      );
    }
    return this as T;
  }

  String encode() {
    return TezosCryptoUtils.encodeSecretKey(this);
  }

  @override
  Future<TezosOperationGroup> signOperation(
    TezosOperationGroup operation,
  ) async {
    final signDigest = operation.signedDigest();
    final signature = await signAsync(signDigest);
    return operation.copyWith(signature: signature);
  }
}
