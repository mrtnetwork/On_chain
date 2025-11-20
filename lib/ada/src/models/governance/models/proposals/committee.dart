import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/models/credential/models/credential.dart';
import 'package:on_chain/ada/src/models/protocol/models/unit_interval.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';

class Committee with InternalCborSerialization {
  final Map<Credential, int> members;
  final UnitInterval quorumQhreshold;
  Committee(
      {required Map<Credential, int> members, required this.quorumQhreshold})
      : members = members.immutable;
  factory Committee.deserialize(CborListValue cbor) {
    return Committee(
        members: {
          for (final i in cbor
              .elementAt<CborMapValue>(0)
              .valueAsMap<CborListValue, CborIntValue>()
              .entries)
            Credential.deserialize(i.key): i.value.toInt()
        },
        quorumQhreshold:
            UnitInterval.deserialize(cbor.elementAt<CborTagValue>(1)));
  }
  factory Committee.fromJson(Map<String, dynamic> json) {
    return Committee(members: {
      for (final i in (json["members"] as Map).entries)
        Credential.fromJson(i.key): IntUtils.parse(i.value)
    }, quorumQhreshold: UnitInterval.fromJson(json["quorum_threshold"]));
  }

  @override
  CborObject toCbor() {
    return CborListValue.definite([
      CborMapValue.definite({
        for (final i in members.entries)
          i.key.toCbor(): CborUnsignedValue.u32(i.value),
      }),
      quorumQhreshold.toCbor()
    ]);
  }

  @override
  Map<dynamic, dynamic> toJson() {
    return {
      "members": {for (final i in members.entries) i.key.toJson(): i.value},
      "quorum_threshold": quorumQhreshold.toJson()
    };
  }
}
