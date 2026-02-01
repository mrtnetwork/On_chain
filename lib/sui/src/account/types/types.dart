import 'package:blockchain_utils/helper/helper.dart';
import 'package:blockchain_utils/layout/constant/constant.dart';
import 'package:blockchain_utils/layout/core/core/core.dart';
import 'package:blockchain_utils/utils/compare/hash_code.dart';
import 'package:on_chain/sui/src/account/constant/constant.dart';
import 'package:on_chain/sui/src/exception/exception.dart';
import 'package:on_chain/sui/src/keypair/keypair.dart';
import 'package:on_chain/serialization/bcs/serialization.dart';
import 'package:on_chain/utils/utils/map_utils.dart';

/// Holds information about a multisig public key and its associated weight.
class SuiMultisigPublicKeyInfo extends BcsSerialization {
  /// The cryptographic public key used for multisig verification.
  final SuiCryptoPublicKey publicKey;

  /// The weight of the public key in the multisig configuration.
  final int weight;

  /// Private constructor enforcing the weight as an unsigned 8-bit integer.
  SuiMultisigPublicKeyInfo._({required this.publicKey, required int weight})
      : weight = weight.asU8;

  /// Factory constructor with validation for public key and weight constraints.
  factory SuiMultisigPublicKeyInfo(
      {required SuiCryptoPublicKey publicKey, required int weight}) {
    if (weight < SuiAccountConst.multisigAccountPublicKeyMinWeight ||
        weight > SuiAccountConst.multisigAccountPublicKeyMaxWeight) {
      throw DartSuiPluginException(
          "Invalid signer weight. Weight must be between ${SuiAccountConst.multisigAccountPublicKeyMinWeight} and ${SuiAccountConst.multisigAccountPublicKeyMaxWeight}.");
    }
    return SuiMultisigPublicKeyInfo._(publicKey: publicKey, weight: weight);
  }

  factory SuiMultisigPublicKeyInfo.fromStruct(Map<String, dynamic> json) {
    return SuiMultisigPublicKeyInfo._(
        publicKey: SuiCryptoPublicKey.fromStruct(json.asMap("publicKey")),
        weight: json.as("weight"));
  }

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      SuiCryptoPublicKey.layout(property: "publicKey"),
      LayoutConst.u8(property: "weight")
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {"publicKey": publicKey.toVariantLayoutStruct(), "weight": weight};
  }

  @override
  operator ==(other) {
    if (identical(this, other)) return true;
    if (other is! SuiMultisigPublicKeyInfo) return false;
    return publicKey == other.publicKey && weight == other.weight;
  }

  @override
  int get hashCode => HashCodeGenerator.generateHashCode([publicKey, weight]);
}
