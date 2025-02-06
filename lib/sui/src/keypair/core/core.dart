import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/sui/src/address/address/address.dart';
import 'package:on_chain/sui/src/exception/exception.dart';
import 'package:on_chain/sui/src/keypair/keys/ed25519.dart';
import 'package:on_chain/sui/src/keypair/keys/secp256k1.dart';
import 'package:on_chain/sui/src/keypair/keys/secp256r1.dart';
import 'package:on_chain/sui/src/keypair/types/types.dart';
import 'package:on_chain/bcs/serialization/serialization.dart';

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

  /// private key bytes
  List<int> toBytes();

  /// private key hex bytes.
  String toHex({bool lowerCase = true});

  /// sign digest
  SuiGenericSignature sign(List<int> digest);

  /// public key
  abstract final PUBLICKEY publicKey;
}

abstract class SuiCryptoPublicKey<PUBLICKEY extends IPublicKey>
    extends BcsVariantSerialization {
  final SuiKeyAlgorithm algorithm;
  final PUBLICKEY publicKey;

  /// verify signature
  bool verify({required List<int> message, required List<int> signature});

  // /// verify personal message
  // bool verifyPersonalMessage(
  //     {required List<int> message, required List<int> signature}) {
  //   final digest = QuickCrypto.blake2b256Hash(message);
  //   return verify(message: digest, signature: signature);
  // }
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
