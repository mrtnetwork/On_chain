import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/crypto/public_key/ed25519.dart';
import 'package:on_chain/hedera/src/crypto/public_key/ecdsa384.dart';
import 'package:on_chain/hedera/src/crypto/public_key/rsa3072.dart';
import 'package:on_chain/hedera/src/crypto/public_key/secp256k1.dart';
import 'package:on_chain/hedera/src/crypto/types/types.dart';
import 'package:on_chain/hedera/src/crypto/utils/utils.dart';
import 'package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart';

abstract class HederaPublicKey
    with Equality
    implements Comparable<HederaPublicKey> {
  final HederaKeyType type;
  const HederaPublicKey({required this.type});

  /// Canonical public-key bytes used as SignaturePair.pubKeyPrefix.
  BuBytes toBytes();

  bool verifySignature(List<int> message, List<int> signature);

  /// Alias used by multi-account code.
  bool verify(List<int> message, List<int> signature) =>
      verifySignature(message, signature);

  /// Protobuf [HederaKey] for this primitive.
  HederaKey toHederaKey();

  factory HederaPublicKey.fromBytes(List<int> bytes, {HederaKeyType? type}) {
    final t = type ?? HederaCryptoUtils.detectPublicKeyType(bytes);
    return switch (t) {
      HederaKeyType.ed25519 => HederaEd25519PublicKey.fromBytes(bytes),
      HederaKeyType.secp256k1 => HederaSecp256k1PublicKey.fromBytes(bytes),
      HederaKeyType.ecdsa384 => HederaEcdsa384PublicKey.fromBytes(bytes),
      HederaKeyType.rsa3072 => HederaRsa3072PublicKey.fromBytes(bytes),
    };
  }

  /// Reconstruct from a primitive protobuf key (not composites).
  static HederaPublicKey? fromHederaKey(HederaKey key) {
    if (key.ed25519 != null && key.ed25519!.isNotEmpty) {
      return HederaEd25519PublicKey.fromBytes(key.ed25519!);
    }
    if (key.ecdsaSecp256k1 != null && key.ecdsaSecp256k1!.isNotEmpty) {
      return HederaSecp256k1PublicKey.fromBytes(key.ecdsaSecp256k1!);
    }
    if (key.ecdsa384 != null && key.ecdsa384!.isNotEmpty) {
      return HederaEcdsa384PublicKey.fromBytes(key.ecdsa384!);
    }
    if (key.rsa3072 != null && key.rsa3072!.isNotEmpty) {
      return HederaRsa3072PublicKey.fromBytes(key.rsa3072!);
    }
    return null;
  }

  @override
  int compareTo(HederaPublicKey other) {
    final bytes = toBytes();
    final otherBytes = other.toBytes();
    return BytesUtils.compareBytes(bytes, otherBytes);
  }
}
