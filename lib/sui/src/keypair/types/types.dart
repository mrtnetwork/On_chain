import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/sui/src/account/public_key/keys.dart';
import 'package:on_chain/sui/src/exception/exception.dart';
import 'package:on_chain/sui/src/keypair/keypair.dart';
import 'package:on_chain/bcs/serialization.dart';
import 'package:on_chain/utils/utils/map_utils.dart';

class SuiGenericSignature extends BcsVariantSerialization {
  final SuiKeyAlgorithm algorithm;
  final List<int> signature;
  SuiGenericSignature({required List<int> signature, required this.algorithm})
      : signature = signature.asImmutableBytes;
  factory SuiGenericSignature.fromStruct(Map<String, dynamic> json) {
    final decode = BcsVariantSerialization.toVariantDecodeResult(json);
    final algorithm = SuiKeyAlgorithm.fromName(decode.variantName);
    return SuiGenericSignature(
        signature: decode.value.asBytes("signature"), algorithm: algorithm);
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.bcsLazyEnum(
        SuiKeyAlgorithm.values
            .map((e) => LazyVariantModel(
                layout: ({property}) => LayoutConst.struct([
                      LayoutConst.fixedBlobN(
                          CryptoSignerConst.ecdsaSignatureLength,
                          property: "signature")
                    ], property: property),
                property: e.name,
                index: e.flag))
            .toList(),
        property: property);
  }

  @override
  Layout<Map<String, dynamic>> createVariantLayout({String? property}) {
    return layout(property: property);
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
  String get variantName => algorithm.name;
}

abstract class SuiBaseSignature extends BcsVariantSerialization {
  final SuiSigningScheme scheme;
  const SuiBaseSignature({required this.scheme});
  factory SuiBaseSignature.deserialize(List<int> bytes) {
    final decode =
        BcsVariantSerialization.deserialize(bytes: bytes, layout: layout());
    return SuiBaseSignature.fromStruct(decode);
  }

  factory SuiBaseSignature.fromStruct(Map<String, dynamic> json) {
    final decode = BcsVariantSerialization.toVariantDecodeResult(json);
    final type = SuiSigningScheme.fromName(decode.variantName);
    return switch (type) {
      SuiSigningScheme.ed25519 => SuiEd25519Signature.fromStruct(decode.value),
      SuiSigningScheme.secp256k1 =>
        SuiSecp256k1Signature.fromStruct(decode.value),
      SuiSigningScheme.secp256r1 =>
        SuiSecp256r1Signature.fromStruct(decode.value),
      SuiSigningScheme.multisig =>
        SuiMultisigSignature.fromStruct(decode.value),
      _ => throw DartSuiPluginException("Unsuported signature scheme.",
          details: {"scheme": type.name})
    };
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.bcsLazyEnum([
      LazyVariantModel(
          layout: SuiEd25519Signature.layout,
          property: SuiSigningScheme.ed25519.name,
          index: SuiSigningScheme.ed25519.value),
      LazyVariantModel(
          layout: SuiSecp256k1Signature.layout,
          property: SuiSigningScheme.secp256k1.name,
          index: SuiSigningScheme.secp256k1.value),
      LazyVariantModel(
          layout: SuiSecp256r1Signature.layout,
          property: SuiSigningScheme.secp256r1.name,
          index: SuiSigningScheme.secp256r1.value),
      LazyVariantModel(
          layout: SuiMultisigSignature.layout,
          property: SuiSigningScheme.multisig.name,
          index: SuiSigningScheme.multisig.value),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createVariantLayout({String? property}) {
    return layout(property: property);
  }

  @override
  String get variantName => scheme.name;

  T cast<T extends SuiBaseSignature>({String? error}) {
    if (this is! T) {
      throw DartSuiPluginException(error ?? "Invalid signature.",
          details: {"expected": "$T", "scheme": scheme.name});
    }
    return this as T;
  }
}

abstract class SuiSignleKeySignature<PUBLICKEY extends SuiCryptoPublicKey>
    extends SuiBaseSignature {
  final SuiGenericSignature signature;
  final PUBLICKEY publicKey;
  const SuiSignleKeySignature(
      {required this.signature,
      required this.publicKey,
      required super.scheme});
}

class SuiEd25519Signature extends SuiSignleKeySignature<SuiED25519PublicKey> {
  SuiEd25519Signature({
    required super.signature,
    required super.publicKey,
  }) : super(scheme: SuiSigningScheme.ed25519);
  factory SuiEd25519Signature.fromStruct(Map<String, dynamic> json) {
    return SuiEd25519Signature(
        signature: SuiGenericSignature(
            signature: json.asBytes("signature"),
            algorithm: SuiKeyAlgorithm.ed25519),
        publicKey: SuiED25519PublicKey.fromStruct(json.asMap("publicKey")));
  }

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.fixedBlobN(CryptoSignerConst.ecdsaSignatureLength,
          property: "signature"),
      SuiED25519PublicKey.layout(property: "publicKey"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "signature": signature.signature,
      "publicKey": publicKey.toLayoutStruct()
    };
  }
}

class SuiSecp256k1Signature
    extends SuiSignleKeySignature<SuiSecp256k1PublicKey> {
  const SuiSecp256k1Signature({
    required super.signature,
    required super.publicKey,
  }) : super(scheme: SuiSigningScheme.secp256k1);
  factory SuiSecp256k1Signature.fromStruct(Map<String, dynamic> json) {
    return SuiSecp256k1Signature(
        signature: SuiGenericSignature(
            signature: json.asBytes("signature"),
            algorithm: SuiKeyAlgorithm.secp256k1),
        publicKey: SuiSecp256k1PublicKey.fromStruct(json.asMap("publicKey")));
  }

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.fixedBlobN(CryptoSignerConst.ecdsaSignatureLength,
          property: "signature"),
      SuiSecp256k1PublicKey.layout(property: "publicKey"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "signature": signature.signature,
      "publicKey": publicKey.toLayoutStruct()
    };
  }
}

class SuiSecp256r1Signature
    extends SuiSignleKeySignature<SuiSecp256r1PublicKey> {
  const SuiSecp256r1Signature({
    required super.signature,
    required super.publicKey,
  }) : super(scheme: SuiSigningScheme.secp256r1);
  factory SuiSecp256r1Signature.fromStruct(Map<String, dynamic> json) {
    return SuiSecp256r1Signature(
        signature: SuiGenericSignature(
            signature: json.asBytes("signature"),
            algorithm: SuiKeyAlgorithm.secp256r1),
        publicKey: SuiSecp256r1PublicKey.fromStruct(json.asMap("publicKey")));
  }

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.fixedBlobN(CryptoSignerConst.ecdsaSignatureLength,
          property: "signature"),
      SuiSecp256r1PublicKey.layout(property: "publicKey"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "signature": signature.signature,
      "publicKey": publicKey.toLayoutStruct()
    };
  }
}

class SuiMultisigSignature extends SuiBaseSignature {
  final SuiMultisigAccountPublicKey publicKey;
  final List<SuiGenericSignature> signatures;
  final int bitmap;
  SuiMultisigSignature._(
      {required this.publicKey,
      required List<SuiGenericSignature> signatures,
      required int bitmap})
      : bitmap = bitmap.asUint16,
        signatures = signatures.immutable,
        super(scheme: SuiSigningScheme.multisig);

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.bcsVector(SuiGenericSignature.layout(),
          property: "signatures"),
      LayoutConst.u16(property: "bitmap"),
      SuiMultisigAccountPublicKey.layout(property: "multisigPublicKey"),
    ], property: property);
  }

  factory SuiMultisigSignature.fromStruct(Map<String, dynamic> json) {
    return SuiMultisigSignature(
        publicKey: SuiMultisigAccountPublicKey.fromStruct(
            json.asMap("multisigPublicKey")),
        signatures: json
            .asListOfMap("signatures")!
            .map((e) => SuiGenericSignature.fromStruct(e))
            .toList(),
        bitmap: json.asInt("bitmap"));
  }
  factory SuiMultisigSignature(
      {required SuiMultisigAccountPublicKey publicKey,
      required List<SuiGenericSignature> signatures,
      required int bitmap}) {
    if (bitmap.isNegative || bitmap > mask16) {
      throw DartSuiPluginException("Invalid multisignature bitmap.",
          details: {"bitmap": bitmap});
    }
    return SuiMultisigSignature._(
        publicKey: publicKey, signatures: signatures, bitmap: bitmap);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "signatures": signatures.map((e) => e.toVariantLayoutStruct()).toList(),
      "bitmap": bitmap,
      "multisigPublicKey": publicKey.toLayoutStruct()
    };
  }
}
