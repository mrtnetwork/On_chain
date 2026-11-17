import 'package:blockchain_utils/crypto/quick_crypto.dart';

import 'package:blockchain_utils/utils/utils.dart';
import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/near/src/crypto/types/types.dart';

typedef DecodedNearKey = ({NearKeyType type, List<int> keyBytes});

class NearCryptoUtils {
  /// Domain-separation tag for ML-DSA-65 pubkey hashing.
  /// nearcore `HashDomainTag::MlDsa65PubkeyV1`.
  static const String mlDsa65PubkeyHashDomainTag =
      "near:ml-dsa-65-pubkey-hash:v1";

  /// Wire prefix of the on-chain ML-DSA-65 handle form
  /// (`ml-dsa-65-hash:<base58>`). nearcore `ML_DSA_65_HASH_PREFIX`.
  static const String mlDsa65HashPrefix = "ml-dsa-65-hash";
  static String encodeKey(NearKeyType type, List<int> keyBytes) {
    return "${type.prefix}:${StringUtils.decode(keyBytes, encoding: StringEncoding.base58)}";
  }

  static DecodedNearKey decodeKey(String key) {
    final split = key.split(":");
    if (split.length != 2) {
      throw OnChainErrors.nearPlugin(
        "DecodedNearKey.decodeKey",
        reason: "Invalid NEAR encoded key.",
      );
    }
    final keyType = NearKeyType.fromPrefix(split[0]);
    try {
      final keyBytes = StringUtils.encode(
        split[1],
        encoding: StringEncoding.base58,
      );
      return (keyBytes: keyBytes, type: keyType);
    } catch (e) {
      throw OnChainErrors.nearPlugin(
        "DecodedNearKey.decodeKey",
        reason: "Invalid NEAR encoded key.",
        internalError: e,
      );
    }
  }

  /// Computes the on-chain handle digest of a full ML-DSA-65 public key:
  /// `SHA3-256(domainTag || rawPublicKey)`.
  /// Mirrors nearcore `MlDsa65PublicKey::to_public_key_handle`.
  /// NEAR stores ML-DSA-65 access keys only in this 32-byte handle form,
  /// so `view_access_key_list` exposes `ml-dsa-65-hash:<base58>` keys.
  static List<int> mlDsa65PublicKeyToHandle(List<int> rawPublicKey) {
    final tag = StringUtils.encode(mlDsa65PubkeyHashDomainTag);
    return QuickCrypto.sha3256Hash([...tag, ...rawPublicKey]);
  }

  /// Encodes a 32-byte handle digest as `ml-dsa-65-hash:<base58>`.
  static String encodeMlDsa65Handle(List<int> handleBytes) {
    return "$mlDsa65HashPrefix:${StringUtils.decode(handleBytes, encoding: StringEncoding.base58)}";
  }

  /// Full public key bytes to their on-chain handle encoding.
  static String mlDsa65PublicKeyToHandleEncoded(List<int> rawPublicKey) {
    return encodeMlDsa65Handle(mlDsa65PublicKeyToHandle(rawPublicKey));
  }

  /// Decodes an `ml-dsa-65-hash:<base58>` handle key to its 32-byte digest.
  /// Returns null when [key] is not in handle form.
  static List<int>? tryDecodeMlDsa65HashKey(String key) {
    final split = key.split(":");
    if (split.length != 2) return null;
    if (split[0].toLowerCase() != mlDsa65HashPrefix) return null;
    try {
      final bytes = StringUtils.encode(
        split[1],
        encoding: StringEncoding.base58,
      );
      if (bytes.length != QuickCrypto.sha3256DigestSize) return null;
      return bytes;
    } catch (_) {
      return null;
    }
  }
}
