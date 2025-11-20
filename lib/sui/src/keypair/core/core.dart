import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/sui/src/address/address/address.dart';
import 'package:on_chain/sui/src/exception/exception.dart';
import 'package:on_chain/sui/src/keypair/constant/constant.dart';
import 'package:on_chain/sui/src/keypair/keys/ed25519.dart';
import 'package:on_chain/sui/src/keypair/keys/secp256k1.dart';
import 'package:on_chain/sui/src/keypair/keys/secp256r1.dart';
import 'package:on_chain/sui/src/keypair/types/types.dart';
import 'package:on_chain/serialization/bcs/serialization/serialization.dart';
import 'package:on_chain/sui/src/keypair/utils/utils.dart';

/// Abstract class defining a contract for authentication key schemes
abstract class SuiAuthenticationKeyScheme {
  // Each implementing class or enum must provide a unique integer value for the scheme
  abstract final int value;
}

/// Enum representing key algorithms supported by Sui.
enum SuiKeyAlgorithm implements SuiAuthenticationKeyScheme {
  ed25519(flag: 0x00, value: 0),
  secp256k1(flag: 0x01, value: 1),
  secp256r1(flag: 0x02, value: 2);

  const SuiKeyAlgorithm({required this.flag, required this.value});
  @override
  final int value;

  final int flag;
  static SuiKeyAlgorithm fromName(String name) {
    return values.firstWhere((e) => e.name == name,
        orElse: () => throw DartSuiPluginException(
            "cannot find Key Algorithm from the given name.",
            details: {"name": name}));
  }

  static SuiKeyAlgorithm fromFlag(int flag) {
    return values.firstWhere((e) => e.flag == flag,
        orElse: () => throw DartSuiPluginException(
            "cannot find Key Algorithm from the given flag.",
            details: {"flag": flag}));
  }

  static SuiKeyAlgorithm fromEllipticCurveType(EllipticCurveTypes type) {
    return switch (type) {
      EllipticCurveTypes.ed25519 => SuiKeyAlgorithm.ed25519,
      EllipticCurveTypes.secp256k1 => SuiKeyAlgorithm.secp256k1,
      EllipticCurveTypes.nist256p1 ||
      EllipticCurveTypes.nist256p1Hybrid =>
        SuiKeyAlgorithm.secp256r1,
      _ => throw DartSuiPluginException("Unsuported Elliptic curve type.",
          details: {"algorithm": type.name})
    };
  }

  EllipticCurveTypes get curveType {
    return switch (this) {
      SuiKeyAlgorithm.ed25519 => EllipticCurveTypes.ed25519,
      SuiKeyAlgorithm.secp256k1 => EllipticCurveTypes.secp256k1,
      SuiKeyAlgorithm.secp256r1 => EllipticCurveTypes.nist256p1
    };
  }
}

/// Enum representing signing schemes supported by Sui.
enum SuiSigningScheme implements SuiAuthenticationKeyScheme {
  ed25519(value: 0x00),
  secp256k1(value: 0x01),
  secp256r1(value: 0x02),
  multisig(value: 0x03),
  zklogin(value: 0x05),
  passkey(value: 0x06);

  const SuiSigningScheme({required this.value});
  @override
  final int value;
  static SuiSigningScheme fromName(String name) {
    return values.firstWhere((e) => e.name == name,
        orElse: () => throw DartSuiPluginException(
            "cannot find Signature scheme from the given name.",
            details: {"name": name}));
  }
}

abstract class SuiBasePrivateKey<PUBLICKEY extends SuiCryptoPublicKey> {
  final SuiKeyAlgorithm algorithm;
  const SuiBasePrivateKey({required this.algorithm});

  /// Decodes a Sui Bech32 secret key into its corresponding private key.
  ///
  /// Takes a [secretKey] as a Bech32-encoded string and returns the private key.
  factory SuiBasePrivateKey.fromSuiSecretKey(String secretKey) {
    try {
      final decode = SuiCryptoUtils.decodeSuiSecretKey(secretKey);
      final algorithm = decode.$1;
      final keyBytes = decode.$2;
      return switch (algorithm) {
        SuiKeyAlgorithm.ed25519 => SuiED25519PrivateKey.fromBytes(keyBytes),
        SuiKeyAlgorithm.secp256k1 => SuiSecp256k1PrivateKey.fromBytes(keyBytes),
        SuiKeyAlgorithm.secp256r1 => SuiSecp256r1PrivateKey.fromBytes(keyBytes)
      } as SuiBasePrivateKey<PUBLICKEY>;
    } on DartSuiPluginException {
      rethrow;
    } catch (e) {
      throw DartSuiPluginException("Invalid sui secret key.",
          details: {"error": e.toString()});
    }
  }

  /// private key bytes
  List<int> toBytes();

  /// private key hex bytes.
  String toHex({bool lowerCase = true});

  /// sign digest
  SuiGenericSignature sign(List<int> digest);

  /// public key
  abstract final PUBLICKEY publicKey;

  /// Encodes the Sui private key to a Bech32 string.
  ///
  /// The encoded format includes the `suiprivkey` HRP,
  /// the key scheme flag, and the secret key bytes.
  String toSuiPrivateKey() {
    return Bech32Encoder.encode(
        SuiKeypairConst.suiPrivateKeyPrefix, [algorithm.flag, ...toBytes()]);
  }
}

abstract class SuiCryptoPublicKey<PUBLICKEY extends IPublicKey>
    extends BcsVariantSerialization {
  final SuiKeyAlgorithm algorithm;
  final PUBLICKEY publicKey;

  T cast<T extends SuiCryptoPublicKey>() {
    if (this is! T) {
      throw DartSuiPluginException("Invalid public key.",
          details: {"expected": "$T", "type": algorithm.name});
    }
    return this as T;
  }

  factory SuiCryptoPublicKey.fromBytes(
      {required List<int> keyBytes, required SuiKeyAlgorithm algorithm}) {
    final SuiCryptoPublicKey key = switch (algorithm) {
      SuiKeyAlgorithm.secp256r1 => SuiSecp256r1PublicKey.fromBytes(keyBytes),
      SuiKeyAlgorithm.secp256k1 => SuiSecp256k1PublicKey.fromBytes(keyBytes),
      SuiKeyAlgorithm.ed25519 => SuiED25519PublicKey.fromBytes(keyBytes)
    } as SuiCryptoPublicKey;
    return key.cast();
  }

  /// verify signature
  bool verify({required List<int> message, required List<int> signature});

  /// generate address from public key
  SuiAddress toAddress();

  /// public key bytes
  List<int> toBytes();

  /// public key as hex
  String toHex();
  const SuiCryptoPublicKey({required this.algorithm, required this.publicKey});

  factory SuiCryptoPublicKey.fromStruct(Map<String, dynamic> json) {
    final decode = BcsVariantSerialization.toVariantDecodeResult(json);
    final algorithm = SuiKeyAlgorithm.fromName(decode.variantName);
    return switch (algorithm) {
      SuiKeyAlgorithm.ed25519 => SuiED25519PublicKey.fromStruct(decode.value),
      SuiKeyAlgorithm.secp256k1 =>
        SuiSecp256k1PublicKey.fromStruct(decode.value),
      SuiKeyAlgorithm.secp256r1 =>
        SuiSecp256r1PublicKey.fromStruct(decode.value)
    } as SuiCryptoPublicKey<PUBLICKEY>;
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.bcsLazyEnum([
      LazyVariantModel(
          layout: SuiED25519PublicKey.layout,
          property: SuiKeyAlgorithm.ed25519.name,
          index: SuiKeyAlgorithm.ed25519.value),
      LazyVariantModel(
          layout: SuiSecp256k1PublicKey.layout,
          property: SuiKeyAlgorithm.secp256k1.name,
          index: SuiKeyAlgorithm.secp256k1.value),
      LazyVariantModel(
          layout: SuiSecp256r1PublicKey.layout,
          property: SuiKeyAlgorithm.secp256r1.name,
          index: SuiKeyAlgorithm.secp256r1.value),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createVariantLayout({String? property}) {
    return layout(property: property);
  }

  @override
  String get variantName => algorithm.name;
}
