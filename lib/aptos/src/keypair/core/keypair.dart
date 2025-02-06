import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/aptos/src/account/authenticator/authenticator.dart';
import 'package:on_chain/aptos/src/address/address/address.dart';
import 'package:on_chain/aptos/src/keypair/keys/ed25519.dart';
import 'package:on_chain/aptos/src/keypair/keys/secp256k1.dart';
import 'package:on_chain/aptos/src/keypair/types/types.dart';
import 'package:on_chain/bcs/serialization/serialization.dart';

/// Abstract class for representing the private key of an Aptos account.
/// The private key is used for signing messages and generating a public key.
abstract class AptosBasePrivateKey<PUBLICKEY extends AptosCryptoPublicKey,
    SIGNATURE extends AptosAnySignature> {
  /// The key algorithm (e.g., Ed25519, Secp256k1)
  final AptosKeyAlgorithm algorithm;

  /// Constructor that requires the algorithm
  const AptosBasePrivateKey({required this.algorithm});

  /// generate the corresponding public key from this private key
  abstract final AptosCryptoPublicKey publicKey;

  /// serialize the private key to bytes
  List<int> toBytes();

  /// serialize the private key to a hexadecimal string
  String toHex({bool lowerCase = true});

  /// sign a message (digest) using the private key
  AptosAnySignature sign(List<int> digest);
}

abstract class AptosPublicKey extends BcsSerialization {
  /// derive an Aptos address from the public key
  AptosAddress toAddress();

  // serialize the public key to bytes
  List<int> toBytes();

  // serialize the public key to a hexadecimal string (default: lower case)
  String toHex({bool lowerCase = true}) {
    return BytesUtils.toHexString(toBytes(), lowerCase: lowerCase);
  }
}

/// Abstract class for representing a crypto public key in Aptos,
/// extending from `AptosPublicKey` and adding cryptographic verification capabilities.
abstract class AptosCryptoPublicKey<PUBLICKEY extends IPublicKey>
    extends BcsVariantSerialization implements AptosPublicKey {
  final PUBLICKEY publicKey;

  /// Raw bytes of the public key
  List<int> publicKeyBytes();

  /// Serialize the public key using the variant BCS format
  @override
  List<int> toBytes() {
    return toVariantBcs();
  }

  /// Convert the public key bytes to hexadecimal string with optional prefix
  @override
  String toHex({bool lowerCase = true, String prefix = ''}) {
    return BytesUtils.toHexString(toBytes(),
        lowerCase: lowerCase, prefix: prefix);
  }

  /// public key in hexadecimal format
  String publicKeyHex();

  /// The key algorithm used (e.g., Ed25519, Secp256k1)
  final AptosKeyAlgorithm algorithm;
  const AptosCryptoPublicKey(
      {required this.algorithm, required this.publicKey});

  /// Constructor that requires the key algorithm
  bool verify({required List<int> message, required List<int> signature});
  factory AptosCryptoPublicKey.deserialize(List<int> bytes,
      {String? property}) {
    final decode = BcsVariantSerialization.deserialize(
        bytes: bytes, layout: layout(property: property));
    return AptosCryptoPublicKey.fromStruct(decode);
  }
  factory AptosCryptoPublicKey.fromStruct(Map<String, dynamic> json) {
    final decode = BcsVariantSerialization.toVariantDecodeResult(json);
    final algorithm = AptosKeyAlgorithm.fromName(decode.variantName);
    return switch (algorithm) {
      AptosKeyAlgorithm.ed25519 =>
        AptosED25519PublicKey.fromStruct(decode.value),
      AptosKeyAlgorithm.secp256k1 =>
        AptosSecp256k1PublicKey.fromStruct(decode.value),
    } as AptosCryptoPublicKey<PUBLICKEY>;
  }

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.lazyEnum([
      LazyVariantModel(
          layout: AptosED25519PublicKey.layout,
          property: AptosKeyAlgorithm.ed25519.name,
          index: AptosKeyAlgorithm.ed25519.value),
      LazyVariantModel(
          layout: AptosSecp256k1PublicKey.layout,
          property: AptosKeyAlgorithm.secp256k1.name,
          index: AptosKeyAlgorithm.secp256k1.value),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createVariantLayout({String? property}) {
    return layout(property: property);
  }

  @override
  String get variantName => algorithm.name;
}
