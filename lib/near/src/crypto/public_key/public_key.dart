import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/near/src/address/address.dart';
import 'package:on_chain/near/src/crypto/public_key/ed25519.dart';
import 'package:on_chain/near/src/crypto/public_key/mldsa65.dart';
import 'package:on_chain/near/src/crypto/public_key/secp256k1.dart';
import 'package:on_chain/near/src/crypto/utils/utils.dart';
import 'package:on_chain/near/src/crypto/types/types.dart';

abstract class NearPublicKey with VariantLayoutSerializable, Equality {
  final NearKeyType type;
  const NearPublicKey({required this.type});
  BuBytes toBytes();
  factory NearPublicKey.deserialize(String key) {
    final decode = NearCryptoUtils.decodeKey(key);
    return NearPublicKey.fromBytes(
      keyBytes: decode.keyBytes,
      type: decode.type,
    );
  }

  factory NearPublicKey.fromBytes({
    required List<int> keyBytes,
    required NearKeyType type,
  }) {
    return switch (type) {
      NearKeyType.ed25519 => NearEd25519PublicKey.fromBytes(keyBytes),
      NearKeyType.secp256k1 => NearSecp256k1PublicKey.fromBytes(keyBytes),
      NearKeyType.mldsa65 => NearMLDSA65PublicKey.fromBytes(keyBytes),
    };
  }
  factory NearPublicKey.deserializeJson(Map<String, dynamic> json) {
    final decode = VariantLayoutSerializable.toVariantDecodeResult(json);
    final type = NearKeyType.fromName(decode.variantName);
    return switch (type) {
      NearKeyType.ed25519 => NearEd25519PublicKey.deserializeJson(decode.value),
      NearKeyType.secp256k1 => NearSecp256k1PublicKey.deserializeJson(
        decode.value,
      ),
      NearKeyType.mldsa65 => NearMLDSA65PublicKey.deserializeJson(decode.value),
    };
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.lazyEnum([
      LazyVariantModel(
        layout: NearEd25519PublicKey.layout,
        property: NearKeyType.ed25519.name,
        index: NearKeyType.ed25519.value,
      ),
      LazyVariantModel(
        layout: NearSecp256k1PublicKey.layout,
        property: NearKeyType.secp256k1.name,
        index: NearKeyType.secp256k1.value,
      ),
      LazyVariantModel(
        layout: NearMLDSA65PublicKey.layout,
        property: NearKeyType.mldsa65.name,
        index: NearKeyType.mldsa65.value,
      ),
    ], property: property);
  }

  String encode() => NearCryptoUtils.encodeKey(type, toBytes());

  bool verifySignature(List<int> message, List<int> signature);

  T cast<T extends NearPublicKey>() {
    if (this is! T) {
      throw OnChainErrors.nearPlugin(
        "NearPublicKey.cast",
        reason: "Invalid key cast.",
        details: {"expected": "$T", "actual": "$runtimeType"},
      );
    }
    return this as T;
  }

  NearImplicitAddress toImplicitAddress() =>
      throw OnChainErrors.nearPlugin(
        "NearPublicKey.toImplicitAddress",
        reason:
            "Implicit address generation is not supported for ${type.name} keys.",
      );
  @override
  String get variantName => type.name;

  @override
  Layout<Map<String, dynamic>> toVariantLayout({String? property}) {
    return layout(property: property);
  }
}
