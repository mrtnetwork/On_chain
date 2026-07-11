import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:on_chain/ada/src/models/fixed_bytes/models/models.dart';
import 'package:on_chain/ada/src/models/governance/models/anchor.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';

class Constitution with InternalCborSerialization {
  final Anchor anchor;
  final ScriptHash? scriptHash;
  const Constitution({required this.anchor, this.scriptHash});
  factory Constitution.deserialize(CborListValue cbor) {
    return Constitution(
      anchor: Anchor.deserialize(cbor.objectAt<CborListValue>(0)),
      scriptHash: cbor.maybeObjectAt<ScriptHash, CborBytesValue>(
        1,
        (e) => ScriptHash.deserialize(e),
      ),
    );
  }
  factory Constitution.fromJson(Map<String, dynamic> json) {
    return Constitution(
      anchor: Anchor.fromJson(json["anchor"]),
      scriptHash:
          json["script_hash"] == null
              ? null
              : ScriptHash.fromHex(json["script_hash"]),
    );
  }

  @override
  CborObject toCbor() {
    return CborListValue.definite([
      anchor.toCbor(),
      scriptHash?.toCbor() ?? CborNullValue(),
    ]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {"anchor": anchor.toJson(), "script_hash": scriptHash?.toJson()};
  }
}
