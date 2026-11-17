import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/hedera/src/crypto/multi_key/multi_account.dart';
import 'package:on_chain/hedera/src/crypto/public_key/public_key.dart';
import 'package:on_chain/hedera/src/crypto/types/types.dart';
import 'package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart';

class HederaCryptoUtils {
  /// Detect primitive public-key type from raw bytes.
  static HederaKeyType detectPublicKeyType(List<int> bytes) {
    if (bytes.length == Ed25519KeysConst.pubKeyByteLen) {
      return HederaKeyType.ed25519;
    }
    if (bytes.length ==
            Ed25519KeysConst.pubKeyByteLen +
                Ed25519KeysConst.pubKeyPrefix.length &&
        bytes[0] == Ed25519KeysConst.pubKeyPrefix[0]) {
      return HederaKeyType.ed25519;
    }
    if (bytes.length == EcdsaKeysConst.pubKeyCompressedByteLen ||
        bytes.length == EcdsaKeysConst.pubKeyUncompressedByteLen) {
      return HederaKeyType.secp256k1;
    }
    // NIST P-384 compressed ≈ 49 bytes, uncompressed ≈ 97
    if (bytes.length == 49 || bytes.length == 97) {
      return HederaKeyType.ecdsa384;
    }
    // RSA-3072 public key DER/SPKI is typically much larger
    if (bytes.length >= 256) {
      return HederaKeyType.rsa3072;
    }
    throw OnChainErrors.hederaPlugin(
      'detectPublicKeyType',
      reason: 'Invalid public key bytes length (${bytes.length}).',
    );
  }

  /// Build a [HederaSignaturePair] for [type] with full pubkey as prefix.
  static HederaSignaturePair buildSignaturePair({
    required HederaKeyType type,
    required List<int> publicKeyBytes,
    required List<int> signature,
  }) {
    switch (type) {
      case HederaKeyType.ed25519:
        return HederaSignaturePair(
          pubKeyPrefix: publicKeyBytes,
          ed25519: signature,
        );
      case HederaKeyType.secp256k1:
        return HederaSignaturePair(
          pubKeyPrefix: publicKeyBytes,
          ecdsaSecp256k1: signature,
        );
      case HederaKeyType.ecdsa384:
        return HederaSignaturePair(
          pubKeyPrefix: publicKeyBytes,
          ecdsa384: signature,
        );
      case HederaKeyType.rsa3072:
        return HederaSignaturePair(
          pubKeyPrefix: publicKeyBytes,
          rsa3072: signature,
        );
    }
  }

  /// Extract signature bytes from a pair (any algorithm).
  static List<int>? signatureBytesOf(HederaSignaturePair pair) {
    return pair.ed25519 ??
        pair.ecdsaSecp256k1 ??
        pair.ecdsa384 ??
        pair.rsa3072 ??
        pair.contract;
  }

  static HederaMultiAccountPublicKey? multiAccountFromHederaKey(HederaKey key) {
    return HederaThresholdAccountPublicKey.fromHederaKey(key) ??
        HederaKeyListAccountPublicKey.fromHederaKey(key);
  }

  static List<HederaPublicKey> flattenHederaKey(HederaKey key) {
    final out = <HederaPublicKey>[];
    void walk(HederaKey k) {
      final prim = HederaPublicKey.fromHederaKey(k);
      if (prim != null) {
        out.add(prim);
        return;
      }
      if (k.keyList != null) {
        for (final c in k.keyList!.keys) {
          walk(c);
        }
        return;
      }
      if (k.thresholdKey?.keys != null) {
        for (final c in k.thresholdKey!.keys!.keys) {
          walk(c);
        }
      }
    }

    walk(key);
    final seen = <HederaPublicKey>{};
    return out.where((pk) => seen.add(pk)).toList();
  }

  static bool keysEqual(HederaKey a, HederaKey b) {
    if (a == b) return true;
    final keysA = flattenHederaKey(a)..sort();
    final keysB = flattenHederaKey(b)..sort();
    return Equality.deepEqual(keysA, keysB);
  }

  static int requiredSignatureCount(HederaKey key) {
    if (key.thresholdKey != null) return key.thresholdKey!.threshold ?? 0;
    if (key.keyList != null) return key.keyList!.keys.length;
    if (HederaPublicKey.fromHederaKey(key) != null) return 1;
    return 0;
  }

  static bool isEmptyHederaKey(HederaKey? key) {
    if (key == null) return true;
    if (key.keyList != null && key.keyList!.keys.isEmpty) return true;
    return false;
  }

  static bool isValidSupportedCryptoKey(HederaKey key) {
    final ed = key.ed25519;
    if (ed != null) return ed.length == Ed25519KeysConst.pubKeyByteLen;
    final secP = key.ecdsaSecp256k1;
    if (secP != null) {
      return secP.length == EcdsaKeysConst.pubKeyCompressedByteLen ||
          secP.length == EcdsaKeysConst.pubKeyUncompressedByteLen;
    }
    final keyList = key.keyList;
    if (keyList != null) {
      return keyList.keys.isNotEmpty &&
          keyList.keys.every(isValidSupportedCryptoKey);
    }
    final thresholdKey = key.thresholdKey;
    if (thresholdKey != null) {
      final keys = thresholdKey.keys?.keys ?? [];
      final threshold = thresholdKey.threshold ?? 0;
      return keys.isNotEmpty &&
          threshold > 1 &&
          keys.every(isValidSupportedCryptoKey);
    }

    final variables = key.variables;
    return variables.whereType<Object>().length == 1;
  }
}
