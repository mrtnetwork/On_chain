import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/serialization/bcs/serialization/serialization.dart';
import 'package:on_chain/sui/src/account/public_key/keys.dart';
import 'package:on_chain/sui/src/address/address/address.dart';
import 'package:on_chain/sui/src/exception/exception.dart';
import 'package:on_chain/sui/src/keypair/core/core.dart';
import 'package:on_chain/sui/src/keypair/types/types.dart';

/// Abstract class representing a Sui account with signing capabilities.
abstract class SuiAccount<PUBLICKEY extends SuiAccountPublicKey,
    SINATURE extends SuiBaseSignature> {
  final SuiSigningScheme scheme;
  const SuiAccount({required this.publicKey, required this.scheme});
  final PUBLICKEY publicKey;

  /// Signs a transaction using the account's private key.
  SINATURE signTransaction(List<int> txbytes, {bool hashDigest = true});

  /// Signs a personal message with the account's private key.
  SINATURE signPersonalMessage(List<int> message);

  /// Converts the public key to a Sui address.
  SuiAddress toAddress() {
    return publicKey.toAddress();
  }

  @override
  String toString() {
    return "${scheme.name}: ${toAddress()}";
  }
}

/// Abstract class representing a Sui account public key with serialization support.
abstract class SuiAccountPublicKey extends BcsVariantSerialization {
  final SuiSigningScheme scheme;
  const SuiAccountPublicKey({required this.scheme});

  /// Converts the public key to a Sui address.
  SuiAddress toAddress();

  /// verify personal message. the signature must be a valid sui signature.
  bool verifyPrsonalMessage(
      {required List<int> message, required List<int> signature});

  /// Verifies the given signature against the provided message.
  ///
  /// - The signature must be a valid Ed25519, Secp256k1, or Secp256R1 signature.
  /// - This method does not support multisig accounts.
  /// - The message must be exactly what is signed.
  ///
  /// Returns `true` if the signature is valid, otherwise `false`.
  bool verify({required List<int> message, required List<int> signature}) {
    throw DartSuiPluginException(
        "Unsuported feature in ${scheme.name} account.");
  }

  factory SuiAccountPublicKey.deserialize(List<int> bytes, {String? property}) {
    final decode = BcsVariantSerialization.deserialize(
        bytes: bytes, layout: layout(property: property));
    return SuiAccountPublicKey.fromStruct(decode);
  }

  factory SuiAccountPublicKey.fromStruct(Map<String, dynamic> json) {
    final decode = BcsVariantSerialization.toVariantDecodeResult(json);
    final algorithm = SuiSigningScheme.fromName(decode.variantName);
    return switch (algorithm) {
      SuiSigningScheme.ed25519 =>
        SuiEd25519AccountPublicKey.fromStruct(decode.value),
      SuiSigningScheme.secp256k1 =>
        SuiSecp256k1AccountPublicKey.fromStruct(decode.value),
      SuiSigningScheme.secp256r1 =>
        SuiSecp256r1AccountPublicKey.fromStruct(decode.value),
      SuiSigningScheme.multisig =>
        SuiMultisigAccountPublicKey.fromStruct(decode.value),
      _ => throw DartSuiPluginException("Unsupported account type.",
          details: {"account": algorithm.name})
    };
  }

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.bcsLazyEnum([
      LazyVariantModel(
          layout: SuiEd25519AccountPublicKey.layout,
          property: SuiSigningScheme.ed25519.name,
          index: SuiSigningScheme.ed25519.value),
      LazyVariantModel(
          layout: SuiSecp256k1AccountPublicKey.layout,
          property: SuiSigningScheme.secp256k1.name,
          index: SuiSigningScheme.secp256k1.value),
      LazyVariantModel(
          layout: SuiSecp256r1AccountPublicKey.layout,
          property: SuiSigningScheme.secp256r1.name,
          index: SuiSigningScheme.secp256r1.value),
      LazyVariantModel(
          layout: SuiMultisigAccountPublicKey.layout,
          property: SuiSigningScheme.multisig.name,
          index: SuiSigningScheme.multisig.value),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createVariantLayout({String? property}) {
    return layout(property: property);
  }

  /// Returns the name of the signing scheme variant.
  @override
  String get variantName => scheme.name;

  @override
  String toString() {
    return "${scheme.name}: ${toAddress()}";
  }
}
