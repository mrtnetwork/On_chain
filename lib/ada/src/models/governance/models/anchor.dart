import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:on_chain/ada/src/models/fixed_bytes/models/models.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';

class Anchor with InternalCborSerialization {
  final String url;
  final AnchorDataHash dataHash;
  const Anchor({required this.url, required this.dataHash});
  factory Anchor.deserialize(CborListValue cbor) {
    return Anchor(
        url: cbor.elementAtString(0),
        dataHash:
            AnchorDataHash.deserialize(cbor.elementAt<CborBytesValue>(1)));
  }
  factory Anchor.fromJson(Map<String, dynamic> json) {
    return Anchor(
        url: json["anchor_url"],
        dataHash: AnchorDataHash.fromHex(json["anchor_data_hash"]));
  }

  @override
  CborObject toCbor() {
    return CborListValue.definite([CborStringValue(url), dataHash.toCbor()]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {"anchor_url": url, "anchor_data_hash": dataHash.toHex()};
  }
}
