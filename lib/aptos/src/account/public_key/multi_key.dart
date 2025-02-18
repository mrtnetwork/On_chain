import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/aptos/src/account/authenticator/authenticator.dart';
import 'package:on_chain/aptos/src/account/constant/constants.dart';
import 'package:on_chain/aptos/src/account/core/account.dart';
import 'package:on_chain/aptos/src/account/types/types.dart';
import 'package:on_chain/aptos/src/address/address/address.dart';
import 'package:on_chain/aptos/src/exception/exception.dart';
import 'package:on_chain/aptos/src/keypair/core/keypair.dart';
import 'package:on_chain/bcs/serialization.dart';
import 'package:on_chain/utils/utils/map_utils.dart';

class AptosMultiKeyAccountPublicKey extends AptosAccountPublicKey {
  /// List of public keys
  final List<AptosCryptoPublicKey> publicKeys;

  /// Minimum number of signatures required for a valid signature
  final int requiredSignature;
  AptosMultiKeyAccountPublicKey._(
      {required List<AptosCryptoPublicKey> publicKeys,
      required int requiredSignature})
      : publicKeys = publicKeys.immutable,
        requiredSignature = requiredSignature.asUint8,
        super(scheme: AptosSigningScheme.multikey);
  factory AptosMultiKeyAccountPublicKey(
      {required List<AptosCryptoPublicKey> publicKeys,
      required int requiredSignature}) {
    final keys = publicKeys.toSet();
    if (keys.length != publicKeys.length) {
      throw DartAptosPluginException("Duplicate public key detected.");
    }
    if (requiredSignature < AptosAccountConst.mulitKeyMinRequiredSignature ||
        requiredSignature > AptosAccountConst.multiKeyMaxRequiredSignature) {
      throw DartAptosPluginException(
          "Invalid required signature. The required signature must be between ${AptosAccountConst.mulitKeyMinRequiredSignature} and ${AptosAccountConst.multiKeyMaxRequiredSignature}.");
    }
    if (publicKeys.length < AptosAccountConst.mulitKeyMinRequiredSignature ||
        publicKeys.length > AptosAccountConst.multiKeyMaxKeys) {
      throw DartAptosPluginException(
          "The number of public keys provided is invalid. It must be between ${AptosAccountConst.mulitKeyMinRequiredSignature} and ${AptosAccountConst.multiKeyMaxKeys}.");
    }
    if (publicKeys.length < requiredSignature) {
      throw DartAptosPluginException(
          "The number of public keys must be at least equal to the required signatures.");
    }

    return AptosMultiKeyAccountPublicKey._(
        publicKeys: publicKeys, requiredSignature: requiredSignature);
  }

  factory AptosMultiKeyAccountPublicKey.deserialize(List<int> bytes) {
    final decode = BcsSerialization.deserialize(bytes: bytes, layout: layout());
    return AptosMultiKeyAccountPublicKey.fromStruct(decode);
  }
  factory AptosMultiKeyAccountPublicKey.fromStruct(Map<String, dynamic> json) {
    return AptosMultiKeyAccountPublicKey._(
        publicKeys: json
            .asListOfMap("publicKeys")!
            .map((e) => AptosCryptoPublicKey.fromStruct(e))
            .toList(),
        requiredSignature: json.as("requiredSignature"));
  }

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.bcsVector(AptosCryptoPublicKey.layout(),
          property: 'publicKeys'),
      LayoutConst.u8(property: "requiredSignature")
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  List<int> toBytes() {
    return toBcs();
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "requiredSignature": requiredSignature,
      "publicKeys": publicKeys.map((e) => e.toVariantLayoutStruct()).toList()
    };
  }

  @override
  AptosAddress toAddress() {
    return AptosAddress(AptosAddrEncoder().encodeMultiKey(
        publicKeys: publicKeys.map((e) => e.publicKey).toList(),
        requiredSignature: requiredSignature));
  }

  @override
  bool verifySignature(
      {required List<int> message, required List<int> signature}) {
    AptosMultiKeySignature anySignature;
    try {
      anySignature = AptosMultiKeySignature.deserialize(signature);
    } catch (_) {
      throw DartAptosPluginException(
          "Invalid Aptos Multikey Signature. deserialize signature failed.");
    }
    if (anySignature.signatures.isEmpty) return false;
    final indexes = anySignature.getIndexesBitmap(anySignature.bitmap);
    for (int i = 0; i < indexes.length; i++) {
      final signature = anySignature.signatures[i];
      final pubkeyIndex = indexes[i];
      if (pubkeyIndex >= publicKeys.length) return false;
      final publicKey = publicKeys.elementAt(pubkeyIndex);
      if (publicKey.algorithm != signature.type.toSupportedKeyAlgorithm) {
        return false;
      }
      if (!publicKey.verify(
          message: message, signature: signature.signatureBytes())) {
        return false;
      }
    }
    return true;
  }
}
