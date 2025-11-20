import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/fixed_bytes/models/models.dart';
import 'package:on_chain/ada/src/models/block/models/header/header/header_body.dart';

class Header with InternalCborSerialization {
  final HeaderBody headerBody;
  final KESSignature signature;
  const Header({required this.headerBody, required this.signature});
  factory Header.fromCborBytes(List<int> cborBytes) {
    return Header.deserialize(
        CborObject.fromCbor(cborBytes).as<CborListValue>("Header"));
  }
  factory Header.fromJson(Map<String, dynamic> json) {
    return Header(
        headerBody: HeaderBody.fromJson(json["header_body"]),
        signature: KESSignature.fromHex(json["signature"]));
  }
  factory Header.deserialize(CborListValue cbor) {
    if (cbor.value.length == 1) {
      return Header(
          headerBody: HeaderBody.deserialize(cbor.elementAt<CborListValue>(0)),
          signature: KESSignature.deserialize(
              cbor.elementAt<CborListValue>(0).elementAt<CborBytesValue>(14)));
    }
    return Header(
        headerBody: HeaderBody.deserialize(cbor.elementAt<CborListValue>(0)),
        signature: KESSignature.deserialize(cbor.elementAt<CborBytesValue>(1)));
  }

  @override
  CborObject toCbor() {
    return CborListValue.definite([headerBody.toCbor(), signature.toCbor()]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'header_body': headerBody.toJson(),
      'signature': signature.toJson()
    };
  }
}
