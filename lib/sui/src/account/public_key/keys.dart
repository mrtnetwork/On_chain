import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/bcs/serialization.dart';
import 'package:on_chain/sui/src/account/core/account.dart';
import 'package:on_chain/sui/src/account/types/types.dart';
import 'package:on_chain/sui/src/keypair/utils/utils.dart';
import 'package:on_chain/sui/src/address/address.dart';
import 'package:on_chain/sui/src/exception/exception.dart';
import 'package:on_chain/sui/src/keypair/keypair.dart';
import 'package:on_chain/utils/utils/map_utils.dart';

/// Represents a Sui account public key using the Ed25519 signing scheme.
class SuiEd25519AccountPublicKey extends SuiAccountPublicKey {
  /// Ed25519 public key
  final SuiED25519PublicKey publicKey;

  /// Creates an Ed25519 account public key.
  const SuiEd25519AccountPublicKey(this.publicKey)
      : super(scheme: SuiSigningScheme.ed25519);

  factory SuiEd25519AccountPublicKey.fromStruct(Map<String, dynamic> json) {
    return SuiEd25519AccountPublicKey(
        SuiED25519PublicKey.fromStruct(json.asMap("publicKey")));
  }

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      SuiED25519PublicKey.layout(property: "publicKey"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {"publicKey": publicKey.toLayoutStruct()};
  }

  /// Converts the Ed25519 public key to a Sui address.
  @override
  SuiAddress toAddress() {
    return publicKey.toAddress();
  }

  @override
  bool verifyPrsonalMessage(
      {required List<int> message, required List<int> signature}) {
    try {
      final ed25519Signature = SuiBaseSignature.deserialize(signature)
          .cast<SuiEd25519Signature>(error: "Invalid signature scheme");
      final digest = SuiCryptoUtils.generatePersonalMessageDigest(message);
      return publicKey.verify(
          message: digest, signature: ed25519Signature.signature.signature);
    } on DartSuiPluginException {
      rethrow;
    } catch (_) {
      throw DartSuiPluginException(
          "Invalid signature. Deserialize signature failed.");
    }
  }

  @override
  bool verify({required List<int> message, required List<int> signature}) {
    try {
      return publicKey.verify(message: message, signature: signature);
    } catch (_) {
      return false;
    }
  }
}

/// Represents a Sui account public key using the Secp256k1 signing scheme.
class SuiSecp256k1AccountPublicKey extends SuiAccountPublicKey {
  /// Secp256k1 public key
  final SuiSecp256k1PublicKey publicKey;

  /// Creates a Secp256k1 account public key.
  const SuiSecp256k1AccountPublicKey(this.publicKey)
      : super(scheme: SuiSigningScheme.secp256k1);

  factory SuiSecp256k1AccountPublicKey.fromStruct(Map<String, dynamic> json) {
    return SuiSecp256k1AccountPublicKey(
        SuiSecp256k1PublicKey.fromStruct(json.asMap("publicKey")));
  }

  /// Defines the layout for the Secp256k1 public key structure.
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      SuiSecp256k1PublicKey.layout(property: "publicKey"),
    ], property: property);
  }

  /// Creates the layout for the Secp256k1 public key.
  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  /// Converts the Secp256k1 public key to a layout struct.
  @override
  Map<String, dynamic> toLayoutStruct() {
    return {"publicKey": publicKey.toLayoutStruct()};
  }

  /// Converts the Secp256k1 public key to a Sui address.
  @override
  SuiAddress toAddress() {
    return publicKey.toAddress();
  }

  @override
  bool verifyPrsonalMessage(
      {required List<int> message, required List<int> signature}) {
    try {
      final ed25519Signature = SuiBaseSignature.deserialize(signature)
          .cast<SuiSecp256k1Signature>(error: "Invalid signature scheme");
      final digest = SuiCryptoUtils.generatePersonalMessageDigest(message);
      return publicKey.verify(
          message: digest, signature: ed25519Signature.signature.signature);
    } on DartSuiPluginException {
      rethrow;
    } catch (_) {
      throw DartSuiPluginException(
          "Invalid signature. Deserialize signature failed.");
    }
  }

  @override
  bool verify({required List<int> message, required List<int> signature}) {
    try {
      return publicKey.verify(message: message, signature: signature);
    } catch (_) {
      return false;
    }
  }
}

/// Represents a Sui account public key using the Secp256r1 signing scheme.
class SuiSecp256r1AccountPublicKey extends SuiAccountPublicKey {
  /// Secp256r1 public key
  final SuiSecp256r1PublicKey publicKey;

  /// Creates a Secp256r1 account public key.
  const SuiSecp256r1AccountPublicKey(this.publicKey)
      : super(scheme: SuiSigningScheme.secp256r1);

  /// Creates a Secp256r1 public key from a structured JSON object.
  factory SuiSecp256r1AccountPublicKey.fromStruct(Map<String, dynamic> json) {
    return SuiSecp256r1AccountPublicKey(
        SuiSecp256r1PublicKey.fromStruct(json.asMap("publicKey")));
  }

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      SuiSecp256r1PublicKey.layout(property: "publicKey"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {"publicKey": publicKey.toLayoutStruct()};
  }

  /// Converts the Secp256r1 public key to a Sui address.
  @override
  SuiAddress toAddress() {
    return publicKey.toAddress();
  }

  @override
  bool verifyPrsonalMessage(
      {required List<int> message, required List<int> signature}) {
    try {
      final ed25519Signature = SuiBaseSignature.deserialize(signature)
          .cast<SuiSecp256r1Signature>(error: "Invalid signature scheme");
      final digest = SuiCryptoUtils.generatePersonalMessageDigest(message);
      return publicKey.verify(
          message: digest, signature: ed25519Signature.signature.signature);
    } on DartSuiPluginException {
      rethrow;
    } catch (_) {
      throw DartSuiPluginException(
          "Invalid signature. Deserialize signature failed.");
    }
  }

  @override
  bool verify({required List<int> message, required List<int> signature}) {
    try {
      return publicKey.verify(message: message, signature: signature);
    } catch (_) {
      return false;
    }
  }
}

/// Represents a multisig public key with multiple public keys and a threshold.
class SuiMultisigAccountPublicKey extends SuiAccountPublicKey {
  /// List of multisig public key info.
  final List<SuiMultisigPublicKeyInfo> publicKeys;

  /// Threshold required for multisig approval.
  final int threshold;

  /// Creates a multisig account public key with validation.
  const SuiMultisigAccountPublicKey._(
      {required this.publicKeys, required this.threshold})
      : super(scheme: SuiSigningScheme.multisig);

  /// Validates and creates a multisig account public key.
  factory SuiMultisigAccountPublicKey(
      {required List<SuiMultisigPublicKeyInfo> publicKeys,
      required int threshold}) {
    if (publicKeys.isEmpty) {
      throw DartSuiPluginException(
          "At least one public key is required for a multisig address.");
    }
    final keys = publicKeys.map((e) => e.publicKey).toSet();
    if (keys.length != publicKeys.length) {
      throw DartSuiPluginException("Duplicate public key detected.");
    }
    if (threshold < 1 || threshold >= mask16) {
      throw DartSuiPluginException(
          "Invalid threshold. Must be between 1 and $mask16.");
    }
    final sumWeight = publicKeys.fold<int>(0, (p, c) => p + c.weight);
    if (sumWeight < threshold) {
      throw DartSuiPluginException(
          "Sum of public key weights must meet or exceed the threshold.");
    }
    return SuiMultisigAccountPublicKey._(
        publicKeys: publicKeys, threshold: threshold);
  }

  /// Deserializes a multisig public key from byte data.
  factory SuiMultisigAccountPublicKey.deserialize(List<int> bytes) {
    final decode = BcsSerialization.deserialize(bytes: bytes, layout: layout());
    return SuiMultisigAccountPublicKey.fromStruct(decode);
  }

  factory SuiMultisigAccountPublicKey.fromStruct(Map<String, dynamic> json) {
    return SuiMultisigAccountPublicKey._(
        publicKeys: json
            .asListOfMap("publicKeys")!
            .map((e) => SuiMultisigPublicKeyInfo.fromStruct(e))
            .toList(),
        threshold: json.as("threshold"));
  }

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.bcsVector(SuiMultisigPublicKeyInfo.layout(),
          property: "publicKeys"),
      LayoutConst.u16(property: "threshold")
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "publicKeys": publicKeys.map((e) => e.toLayoutStruct()).toList(),
      "threshold": threshold
    };
  }

  /// Converts the multisig public key to a Sui address.
  @override
  SuiAddress toAddress() {
    return SuiAddress(SuiAddrEncoder().encodeMultisigKey(
        pubKey: publicKeys
            .map((e) => SuiPublicKeyAndWeight(
                publicKey: e.publicKey.publicKey, weight: e.weight))
            .toList(),
        threshold: threshold));
  }

  @override
  bool verifyPrsonalMessage(
      {required List<int> message, required List<int> signature}) {
    try {
      final digest = SuiCryptoUtils.generatePersonalMessageDigest(message);

      final multisigSignature = SuiBaseSignature.deserialize(signature)
          .cast<SuiMultisigSignature>(error: "Invalid signature scheme.");

      // Check public key match
      if (multisigSignature.publicKey != this) {
        return false;
      }
      int weight = 0;
      for (final i in multisigSignature.signatures) {
        for (final publicKey in publicKeys) {
          if (i.algorithm != publicKey.publicKey.algorithm) continue;
          if (publicKey.publicKey
              .verify(message: digest, signature: i.signature)) {
            weight += publicKey.weight;
            break;
          }
        }
      }
      return weight >= threshold;
    } on DartSuiPluginException {
      rethrow;
    } catch (e) {
      throw DartSuiPluginException(
          "Invalid multisig signature: deserialize signature failed.");
    }
  }

  @override
  operator ==(other) {
    if (identical(this, other)) return true;
    if (other is! SuiMultisigAccountPublicKey) return false;
    return CompareUtils.iterableIsEqual(publicKeys, other.publicKeys) &&
        threshold == other.threshold;
  }

  @override
  int get hashCode =>
      HashCodeGenerator.generateHashCode([publicKeys, threshold]);
}
