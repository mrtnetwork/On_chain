import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/aptos/src/account/public_key/multi_ed25519.dart';
import 'package:on_chain/aptos/src/account/public_key/multi_key.dart';
import 'package:on_chain/aptos/src/exception/exception.dart';
import 'package:on_chain/aptos/src/keypair/core/keypair.dart';
import 'package:on_chain/aptos/src/keypair/keys/ed25519.dart';
import 'package:on_chain/aptos/src/keypair/types/types.dart';
import 'package:on_chain/aptos/src/transaction/constants/const.dart';
import 'package:on_chain/bcs/serialization/serialization.dart';
import 'package:on_chain/sui/src/exception/exception.dart';
import 'package:on_chain/utils/utils/map_utils.dart';

/// An `AccountAuthenticator` is an abstraction of a signature scheme. It must know:
/// (1) How to check its signature against a message and public key
/// (2) How to convert its public key into an `AuthenticationKeyPreimage` structured as
/// (public_key | signature_scheme_id).
/// Each on-chain `Account` must store an `AuthenticationKey` (computed via a sha3 hash of `(public
/// key bytes | scheme as u8)`).
enum AptosAccountAuthenticators {
  /// Ed25519 Single signature
  ed25519(value: 0),

  /// Ed25519 K-of-N multisignature
  multiEd25519(value: 1),
  singleKey(value: 2),
  multiKey(value: 3),
  noAccountAuthenticator(value: 4),
  abstraction(value: 5);

  final int value;
  const AptosAccountAuthenticators({required this.value});
  static AptosAccountAuthenticators fromName(String? name) {
    return values.firstWhere((e) => e.name == name,
        orElse: () => throw DartAptosPluginException(
            "cannot find correct account authenticator from the given name.",
            details: {"name": name}));
  }
}

/// Base class for Aptos account authenticators, representing different authentication types.
abstract class AptosAccountAuthenticator extends BcsVariantSerialization {
  AptosSignature get signature;

  /// type of authenticator
  final AptosAccountAuthenticators type;
  const AptosAccountAuthenticator({required this.type});
  factory AptosAccountAuthenticator.deserialize(List<int> bytes) {
    final decode = BcsSerialization.deserialize(bytes: bytes, layout: layout());
    return AptosAccountAuthenticator.fromStruct(decode);
  }
  factory AptosAccountAuthenticator.fromStruct(Map<String, dynamic> json) {
    final decode = BcsVariantSerialization.toVariantDecodeResult(json);
    final type = AptosAccountAuthenticators.fromName(decode.variantName);
    return switch (type) {
      AptosAccountAuthenticators.ed25519 =>
        AptosAccountAuthenticatorEd25519.fromStruct(decode.value),
      AptosAccountAuthenticators.multiEd25519 =>
        AptosAccountAuthenticatorMultiEd25519.fromStruct(decode.value),
      AptosAccountAuthenticators.multiKey =>
        AptosAccountAuthenticatorMultiKey.fromStruct(decode.value),
      AptosAccountAuthenticators.singleKey =>
        AptosAccountAuthenticatorSingleKey.fromStruct(decode.value),
      AptosAccountAuthenticators.noAccountAuthenticator =>
        AptosAccountAuthenticatorNoAccountAuthenticator(),
      _ => throw DartAptosPluginException("Unsuported account athenticator.",
          details: {"type": type.name})
    };
  }

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.bcsLazyEnum([
      LazyVariantModel(
          layout: AptosAccountAuthenticatorEd25519.layout,
          property: AptosAccountAuthenticators.ed25519.name,
          index: AptosAccountAuthenticators.ed25519.value),
      LazyVariantModel(
          layout: AptosAccountAuthenticatorMultiEd25519.layout,
          property: AptosAccountAuthenticators.multiEd25519.name,
          index: AptosAccountAuthenticators.multiEd25519.value),
      LazyVariantModel(
          layout: AptosAccountAuthenticatorMultiKey.layout,
          property: AptosAccountAuthenticators.multiKey.name,
          index: AptosAccountAuthenticators.multiKey.value),
      LazyVariantModel(
          layout: AptosAccountAuthenticatorSingleKey.layout,
          property: AptosAccountAuthenticators.singleKey.name,
          index: AptosAccountAuthenticators.singleKey.value),
      LazyVariantModel(
          layout: AptosAccountAuthenticatorNoAccountAuthenticator.layout,
          property: AptosAccountAuthenticators.noAccountAuthenticator.name,
          index: AptosAccountAuthenticators.noAccountAuthenticator.value),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createVariantLayout({String? property}) {
    return layout(property: property);
  }

  @override
  String get variantName => type.name;

  T cast<T extends AptosAccountAuthenticator>() {
    if (this is! T) {
      throw DartAptosPluginException("Invalid account authenticated.",
          details: {"expected": "$T", "type": type.name});
    }
    return this as T;
  }
}

/// Represents an Ed25519 signature for Aptos account authentication.
class AptosEd25519Signature extends AptosSignature {
  /// The Ed25519 signature bytes.
  final List<int> signature;
  AptosEd25519Signature._({required List<int> signature})
      : signature = signature.asImmutableBytes;
  factory AptosEd25519Signature.deserialize(List<int> bytes) {
    final decode = BcsSerialization.deserialize(bytes: bytes, layout: layout());
    return AptosEd25519Signature.fromStruct(decode);
  }
  factory AptosEd25519Signature(List<int> signature) {
    if (signature.length != CryptoSignerConst.ed25519SignatureLength) {
      throw DartSuiPluginException("Invalid signature length.", details: {
        "expected": CryptoSignerConst.ed25519SignatureLength,
        "length": signature.length
      });
    }
    return AptosEd25519Signature._(signature: signature);
  }
  factory AptosEd25519Signature.fromStruct(Map<String, dynamic> json) {
    return AptosEd25519Signature(json.asBytes("signature"));
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([LayoutConst.bcsBytes(property: "signature")],
        property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {"signature": signature};
  }

  @override
  List<int> signatureBytes() {
    return signature;
  }

  @override
  List<int> toBytes() {
    return toBcs();
  }
}

/// Represents an Ed25519 Any signature for Aptos account authentication.
class AptosEd25519AnySignature extends AptosAnySignature {
  /// The Ed25519 signature bytes.
  final List<int> signature;
  AptosEd25519AnySignature._({required List<int> signature})
      : signature = signature.asImmutableBytes,
        super(type: AptosAnySignatures.ed25519);
  factory AptosEd25519AnySignature.deserialize(List<int> bytes) {
    final decode = BcsSerialization.deserialize(bytes: bytes, layout: layout());
    return AptosEd25519AnySignature.fromStruct(decode);
  }
  factory AptosEd25519AnySignature(List<int> signature) {
    if (signature.length != CryptoSignerConst.ed25519SignatureLength) {
      throw DartSuiPluginException("Invalid signature length.", details: {
        "expected": CryptoSignerConst.ed25519SignatureLength,
        "length": signature.length
      });
    }
    return AptosEd25519AnySignature._(signature: signature);
  }
  factory AptosEd25519AnySignature.fromStruct(Map<String, dynamic> json) {
    return AptosEd25519AnySignature(json.asBytes("signature"));
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([LayoutConst.bcsBytes(property: "signature")],
        property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {"signature": signature};
  }

  @override
  List<int> signatureBytes() {
    return signature;
  }
}

/// Represents a Secp256k1 Any signature for Aptos account authentication.
class AptosSecp256k1AnySignature extends AptosAnySignature {
  /// The Secp256k1 signature bytes.
  final List<int> signature;
  AptosSecp256k1AnySignature._({required List<int> signature})
      : signature = signature.asImmutableBytes,
        super(type: AptosAnySignatures.secp256k1);
  factory AptosSecp256k1AnySignature(List<int> signature) {
    if (signature.length != CryptoSignerConst.ed25519SignatureLength) {
      throw DartSuiPluginException("Invalid signature length.", details: {
        "expected": CryptoSignerConst.ecdsaSignatureLength,
        "length": signature.length
      });
    }
    return AptosSecp256k1AnySignature._(signature: signature);
  }
  factory AptosSecp256k1AnySignature.fromStruct(Map<String, dynamic> json) {
    return AptosSecp256k1AnySignature(json.asBytes("signature"));
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.bcsBytes(property: "signature"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {"signature": signature};
  }

  @override
  List<int> signatureBytes() {
    return signature;
  }
}

/// Authenticator for Aptos accounts using the Ed25519 signature scheme.
class AptosAccountAuthenticatorEd25519 extends AptosAccountAuthenticator {
  /// The Ed25519 public key associated with the account.
  final AptosED25519PublicKey publicKey;

  /// The Ed25519 signature used for authentication.
  @override
  final AptosEd25519Signature signature;
  AptosAccountAuthenticatorEd25519(
      {required this.publicKey, required this.signature})
      : super(type: AptosAccountAuthenticators.ed25519);
  factory AptosAccountAuthenticatorEd25519.fromStruct(
      Map<String, dynamic> json) {
    return AptosAccountAuthenticatorEd25519(
        publicKey: AptosED25519PublicKey.fromStruct(json.asMap("publicKey")),
        signature: AptosEd25519Signature.fromStruct(json.asMap("signature")));
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      AptosED25519PublicKey.layout(property: "publicKey"),
      AptosEd25519AnySignature.layout(property: "signature"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "publicKey": publicKey.toLayoutStruct(),
      "signature": signature.toLayoutStruct()
    };
  }
}

/// Vector of the multi-key signatures along with a 32bit [u8; 4] bitmap required to map signatures
/// with their corresponding public keys.
///
/// Note that bits are read from left to right. For instance, in the following bitmap
/// [0b0001_0000, 0b0000_0000, 0b0000_0000, 0b0000_0001], the 3rd and 31st positions are set.
/// Represents a Multi-Ed25519 signature for Aptos, supporting multiple signatures.
class AptosMultiEd25519Signature extends AptosSignature {
  /// A list of Ed25519 signatures included in the multi-signature.
  final List<AptosEd25519Signature> signatures;

  /// A bitmap indicating which public keys are associated with the signatures.
  final List<int> bitmap;
  AptosMultiEd25519Signature._(
      {required List<AptosEd25519Signature> signatures,
      required List<int> bitmap})
      : signatures = signatures.immutable,
        bitmap = bitmap.asImmutableBytes;
  factory AptosMultiEd25519Signature.deserialize(List<int> bytes) {
    final decode = BcsSerialization.deserialize(bytes: bytes, layout: layout());
    return AptosMultiEd25519Signature.fromStruct(decode);
  }
  factory AptosMultiEd25519Signature(
      {required List<AptosEd25519Signature> signatures,
      required List<int> bitmap}) {
    if (signatures.length > AptosConstants.maxSignatureLength) {
      throw DartAptosPluginException(
          "Signature length exceeds the maximum allowed limit of ${AptosConstants.maxSignatureLength}.");
    }
    if (bitmap.length != AptosConstants.bitmapLength) {
      throw DartAptosPluginException(
          "Bitmap length must be exactly ${AptosConstants.bitmapLength}",
          details: {"length": bitmap.length});
    }
    return AptosMultiEd25519Signature._(signatures: signatures, bitmap: bitmap);
  }

  factory AptosMultiEd25519Signature.fromStruct(Map<String, dynamic> json) {
    final List<int> signature = json.asBytes("signature");
    if ((signature.length - AptosConstants.bitmapLength) %
            CryptoSignerConst.ed25519SignatureLength !=
        0) {
      throw DartAptosPluginException(
          "Invalid MultiEd25519 signature bytes length.",
          details: {"length": signature.length});
    }
    final signatureLength = (signature.length - AptosConstants.bitmapLength) ~/
        CryptoSignerConst.ed25519SignatureLength;
    return AptosMultiEd25519Signature(
        signatures: List.generate(signatureLength, (i) {
          final index = i * CryptoSignerConst.ed25519SignatureLength;
          return AptosEd25519Signature(signature.sublist(
              index, index + CryptoSignerConst.ed25519SignatureLength));
        }),
        bitmap: signature.sublist(
            signatureLength * CryptoSignerConst.ed25519SignatureLength));
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([LayoutConst.bcsBytes(property: 'signature')],
        property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  List<int> signatureBytes() {
    return [...signatures.map((e) => e.signature).expand((e) => e), ...bitmap];
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {"signature": signatureBytes()};
  }

  List<int> getIndexesBitmap(List<int> bytes) {
    List<int> indexes = [];
    for (int i = 0; i < 4; i++) {
      for (int b = 0; b < 8; b++) {
        if ((bytes[i] & (1 << (7 - b))) != 0) {
          indexes.add(i * 8 + b);
        }
      }
    }
    if (indexes.length != signatures.length) {
      throw DartAptosPluginException("Invalid signature bitmap.");
    }
    return indexes;
  }

  @override
  List<int> toBytes() {
    return toBcs();
  }
}

/// Enum representing different types of signatures supported by Aptos.
enum AptosAnySignatures {
  /// Ed25519 signature type.
  ed25519(value: 0),

  /// Secp256k1 signature type.
  secp256k1(value: 1),

  /// Keyless signature type.
  keyless(value: 2);

  /// Integer value associated with each signature type.
  final int value;

  /// Constructor to assign the integer value to the signature type.
  const AptosAnySignatures({required this.value});

  /// Retrieves the signature type based on its name.
  static AptosAnySignatures fromName(String? name) {
    return values.firstWhere((e) => e.name == name,
        orElse: () => throw DartAptosPluginException(
            "Cannot find correct Signature from the given name.",
            details: {"name": name}));
  }

  AptosKeyAlgorithm? get toSupportedKeyAlgorithm {
    return switch (this) {
      AptosAnySignatures.ed25519 => AptosKeyAlgorithm.ed25519,
      AptosAnySignatures.secp256k1 => AptosKeyAlgorithm.secp256k1,
      _ => null
    };
  }
}

abstract class AptosSignature extends BcsSerialization {
  /// Abstract method to retrieve the signature as a list of bytes.
  List<int> signatureBytes();

  /// get bcs serialized of signature.
  List<int> toBytes();
}

/// Abstract class representing any type of Aptos signature.
abstract class AptosAnySignature extends BcsVariantSerialization
    implements AptosSignature {
  /// The type of the signature (e.g., Ed25519, Secp256k1).
  final AptosAnySignatures type;

  /// Constructor to initialize the signature type.
  const AptosAnySignature({required this.type});
  factory AptosAnySignature.deserialize(List<int> bytes) {
    final decode =
        BcsVariantSerialization.deserialize(bytes: bytes, layout: layout());
    return AptosAnySignature.fromStruct(decode);
  }
  factory AptosAnySignature.fromStruct(Map<String, dynamic> json) {
    final decode = BcsVariantSerialization.toVariantDecodeResult(json);
    final type = AptosAnySignatures.fromName(decode.variantName);
    return switch (type) {
      AptosAnySignatures.ed25519 =>
        AptosEd25519AnySignature.fromStruct(decode.value),
      AptosAnySignatures.secp256k1 =>
        AptosSecp256k1AnySignature.fromStruct(decode.value),
      _ => throw DartAptosPluginException("Unsuported signature type.",
          details: {"type": type.name})
    };
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.bcsLazyEnum([
      LazyVariantModel(
          layout: AptosEd25519AnySignature.layout,
          property: AptosAnySignatures.ed25519.name,
          index: AptosAnySignatures.ed25519.value),
      LazyVariantModel(
          layout: AptosSecp256k1AnySignature.layout,
          property: AptosAnySignatures.secp256k1.name,
          index: AptosAnySignatures.secp256k1.value)
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createVariantLayout({String? property}) {
    return layout(property: property);
  }

  @override
  String get variantName => type.name;

  @override
  List<int> toBytes() {
    return toVariantBcs();
  }
}

/// Class representing an Aptos account authenticator for MultiEd25519 signature.
class AptosAccountAuthenticatorMultiEd25519 extends AptosAccountAuthenticator {
  /// The public key used in the MultiEd25519 account authentication.
  final AptosMultiEd25519AccountPublicKey publicKey;

  /// The MultiEd25519 signature used for the account authentication.
  @override
  final AptosMultiEd25519Signature signature;
  AptosAccountAuthenticatorMultiEd25519(
      {required this.publicKey, required this.signature})
      : super(type: AptosAccountAuthenticators.multiEd25519);
  factory AptosAccountAuthenticatorMultiEd25519.fromStruct(
      Map<String, dynamic> json) {
    return AptosAccountAuthenticatorMultiEd25519(
        publicKey: AptosMultiEd25519AccountPublicKey.fromStruct(
            json.asMap("publicKey")),
        signature:
            AptosMultiEd25519Signature.fromStruct(json.asMap("signature")));
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      AptosMultiEd25519AccountPublicKey.layout(property: "publicKey"),
      AptosMultiEd25519Signature.layout(property: "signature"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "publicKey": publicKey.toLayoutStruct(),
      "signature": signature.toLayoutStruct()
    };
  }
}

/// Class representing a MultiKey signature for Aptos.
class AptosMultiKeySignature extends AptosSignature {
  /// A list of Aptos signatures (could be Ed25519, Secp256k1).
  final List<AptosAnySignature> signatures;

  final List<int> bitmap;
  AptosMultiKeySignature._(
      {required List<AptosAnySignature> signatures, required List<int> bitmap})
      : signatures = signatures.immutable,
        bitmap = bitmap.asImmutableBytes;
  factory AptosMultiKeySignature(
      {required List<AptosAnySignature> signatures,
      required List<int> bitmap}) {
    if (signatures.length > AptosConstants.maxSignatureLength) {
      throw DartAptosPluginException(
          "Signature length exceeds the maximum allowed limit of ${AptosConstants.maxSignatureLength}.");
    }
    if (bitmap.length != AptosConstants.bitmapLength) {
      throw DartAptosPluginException(
          "Bitmap length must be exactly ${AptosConstants.bitmapLength}",
          details: {"length": bitmap.length});
    }
    return AptosMultiKeySignature._(signatures: signatures, bitmap: bitmap);
  }
  factory AptosMultiKeySignature.deserialize(List<int> bytes) {
    final decode = BcsSerialization.deserialize(bytes: bytes, layout: layout());
    return AptosMultiKeySignature.fromStruct(decode);
  }

  factory AptosMultiKeySignature.fromStruct(Map<String, dynamic> json) {
    return AptosMultiKeySignature(
        signatures: json
            .asListOfMap("signatures")!
            .map((e) => AptosAnySignature.fromStruct(e))
            .toList(),
        bitmap: json.asBytes("bitmap"));
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.bcsVector(AptosAnySignature.layout(), property: 'signatures'),
      LayoutConst.bcsBytes(property: "bitmap")
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "signatures": signatures.map((e) => e.toVariantLayoutStruct()).toList(),
      "bitmap": bitmap
    };
  }

  List<int> getIndexesBitmap(List<int> bytes) {
    List<int> indexes = [];
    for (int i = 0; i < 4; i++) {
      for (int b = 0; b < 8; b++) {
        if ((bytes[i] & (1 << (7 - b))) != 0) {
          indexes.add(i * 8 + b);
        }
      }
    }
    if (indexes.length != signatures.length) {
      throw DartAptosPluginException("Invalid signature bitmap.");
    }
    return indexes;
  }

  @override
  List<int> signatureBytes() {
    return toBcs();
  }

  @override
  List<int> toBytes() {
    return toBcs();
  }
}

/// Class representing a MultiKey account authenticator for Aptos.
class AptosAccountAuthenticatorMultiKey extends AptosAccountAuthenticator {
  /// The public key associated with the multi-key account.
  final AptosMultiKeyAccountPublicKey publicKey;

  /// The multi-key signature, which contains the signatures and their validity.
  @override
  final AptosMultiKeySignature signature;
  AptosAccountAuthenticatorMultiKey(
      {required this.publicKey, required this.signature})
      : super(type: AptosAccountAuthenticators.multiKey);
  factory AptosAccountAuthenticatorMultiKey.fromStruct(
      Map<String, dynamic> json) {
    return AptosAccountAuthenticatorMultiKey(
        publicKey:
            AptosMultiKeyAccountPublicKey.fromStruct(json.asMap("publicKey")),
        signature: AptosMultiKeySignature.fromStruct(json.asMap("signature")));
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      AptosMultiKeyAccountPublicKey.layout(property: "publicKey"),
      AptosMultiKeySignature.layout(property: "signature"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "publicKey": publicKey.toLayoutStruct(),
      "signature": signature.toLayoutStruct()
    };
  }
}

/// Class representing a SingleKey account authenticator for Aptos.
class AptosAccountAuthenticatorSingleKey extends AptosAccountAuthenticator {
  /// The public key associated with the single-key account.
  final AptosCryptoPublicKey publicKey;

  /// The signature associated with the public key, can be Ed25519 or Secp256k1.
  @override
  final AptosAnySignature signature;

  AptosAccountAuthenticatorSingleKey(
      {required this.publicKey, required this.signature})
      : super(type: AptosAccountAuthenticators.singleKey);
  factory AptosAccountAuthenticatorSingleKey.fromStruct(
      Map<String, dynamic> json) {
    return AptosAccountAuthenticatorSingleKey(
        publicKey: AptosCryptoPublicKey.fromStruct(json.asMap("publicKey")),
        signature: AptosAnySignature.fromStruct(json.asMap("signature")));
  }

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      AptosCryptoPublicKey.layout(property: "publicKey"),
      AptosAnySignature.layout(property: "signature"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "publicKey": publicKey.toVariantLayoutStruct(),
      "signature": signature.toVariantLayoutStruct()
    };
  }
}

/// Class representing an account authenticator with no specific account authenticator.
class AptosAccountAuthenticatorNoAccountAuthenticator
    extends AptosAccountAuthenticator {
  AptosAccountAuthenticatorNoAccountAuthenticator()
      : super(type: AptosAccountAuthenticators.noAccountAuthenticator);

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.noArgs(property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {};
  }

  @override
  AptosSignature get signature => throw DartAptosPluginException(
      "The signature is unavailable in `NoAccountAuthenticator`");
}
