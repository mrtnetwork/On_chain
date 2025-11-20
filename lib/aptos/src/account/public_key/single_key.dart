import 'package:blockchain_utils/bip/address/aptos_addr.dart';
import 'package:blockchain_utils/layout/constant/constant.dart';
import 'package:blockchain_utils/layout/core/core/core.dart';
import 'package:on_chain/aptos/src/account/authenticator/authenticator.dart';
import 'package:on_chain/aptos/src/account/core/account.dart';
import 'package:on_chain/aptos/src/account/types/types.dart';
import 'package:on_chain/aptos/src/address/address/address.dart';
import 'package:on_chain/aptos/src/exception/exception.dart';
import 'package:on_chain/aptos/src/keypair/core/keypair.dart';
import 'package:on_chain/serialization/bcs/serialization/serialization.dart';
import 'package:on_chain/utils/utils/map_utils.dart';

class AptosSingleKeyAccountPublicKey extends AptosAccountPublicKey {
  final AptosCryptoPublicKey publicKey;
  const AptosSingleKeyAccountPublicKey(this.publicKey)
      : super(scheme: AptosSigningScheme.signleKey);

  factory AptosSingleKeyAccountPublicKey.deserialize(List<int> bytes) {
    final decode = BcsSerialization.deserialize(bytes: bytes, layout: layout());
    return AptosSingleKeyAccountPublicKey.fromStrunct(decode);
  }
  factory AptosSingleKeyAccountPublicKey.fromStrunct(
      Map<String, dynamic> json) {
    return AptosSingleKeyAccountPublicKey(
        AptosCryptoPublicKey.fromStruct(json.asMap("publicKey")));
  }

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct(
        [AptosCryptoPublicKey.layout(property: "publicKey")],
        property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {"publicKey": publicKey.toVariantLayoutStruct()};
  }

  @override
  List<int> toBytes() {
    return toBcs();
  }

  @override
  AptosAddress toAddress() {
    return AptosAddress(
        AptosAddrEncoder().encodeSingleKey(publicKey.publicKey));
  }

  @override
  bool verifySignature(
      {required List<int> message, required List<int> signature}) {
    AptosAnySignature anySignature;
    try {
      anySignature = AptosAnySignature.deserialize(signature);
    } catch (_) {
      throw DartAptosPluginException(
          "Invalid Aptos Any Signature. deserialize signature failed.");
    }
    return publicKey.verify(
        message: message, signature: anySignature.signatureBytes());
  }
}
