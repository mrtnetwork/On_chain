import 'package:blockchain_utils/cbor/core/cbor.dart';
import 'package:blockchain_utils/cbor/serialization/cbor/cbor.dart';
import 'package:blockchain_utils/cbor/types/types.dart';
import 'package:on_chain/ada/src/models/governance/models/anchor.dart';
import 'package:on_chain/ada/src/models/governance/models/vote_type.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';

class VotingProcedure with InternalCborSerialization {
  final VoteType vote;
  final Anchor? anchor;
  const VotingProcedure({required this.vote, this.anchor});
  factory VotingProcedure.deserialize(CborListValue cbor) {
    return VotingProcedure(
      vote: VoteType.fromValue(cbor.objectAt<CborIntValue>(0).value),
      anchor: cbor.maybeObjectAt<Anchor, CborListValue>(
        1,
        (e) => Anchor.deserialize(e),
      ),
    );
  }
  factory VotingProcedure.fromJson(Map<String, dynamic> json) {
    return VotingProcedure(
      vote: VoteType.fromName(json["vote"]),
      anchor: json["anchor"] == null ? null : Anchor.fromJson(json["anchor"]),
    );
  }

  @override
  CborObject toCbor() {
    return CborListValue.definite([
      vote.toCbor(),
      anchor?.toCbor() ?? const CborNullValue(),
    ]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {"vote": vote.name, "anchor": anchor?.toJson()};
  }
}
