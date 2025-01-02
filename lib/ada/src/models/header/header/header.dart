import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/fixed_bytes/models/models.dart';
import 'package:on_chain/ada/src/models/header/header/header_body.dart';

class Header with ADASerialization {
  final HeaderBody headerBody;
  final KESSignature signature;
  const Header({required this.headerBody, required this.signature});
  factory Header.fromCborBytes(List<int> cborBytes) {
    return Header.deserialize(CborObject.fromCbor(cborBytes).cast());
  }
  factory Header.deserialize(CborListValue cbor) {
    if (cbor.value.length == 1) {
      return Header(
          headerBody: HeaderBody.deserialize(cbor.getIndex(0)),
          signature: KESSignature.deserialize(
              cbor.getIndex<CborListValue>(0).getIndex(14)));
    }
    return Header(
        headerBody: HeaderBody.deserialize(cbor.getIndex(0)),
        signature: KESSignature.deserialize(cbor.getIndex(1)));
  }

  @override
  CborObject toCbor() {
    return CborListValue.fixedLength([headerBody.toCbor(), signature.toCbor()]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {'headerBody': headerBody.toJson(), 'signature': signature.toJson()};
  }
}
