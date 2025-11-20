import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:blockchain_utils/helper/extensions/extensions.dart';
import 'package:on_chain/ada/src/models/governance/models/voter.dart';
import 'package:on_chain/ada/src/models/governance/models/voting_procedure.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';

import 'governance_action_id.dart';

class VotingProcedures with InternalCborSerialization {
  final Map<Voter, Map<GovernanceActionId, VotingProcedure>> votes;
  VotingProcedures(Map<Voter, Map<GovernanceActionId, VotingProcedure>> votes)
      : votes = votes.immutable;
  factory VotingProcedures.deserialize(CborMapValue cbor) {
    final entries = cbor.valueAsMap<CborListValue, CborMapValue>().entries;
    return VotingProcedures({
      for (final i in entries)
        Voter.deserialize(i.key): {
          for (final e
              in i.value.valueAsMap<CborListValue, CborListValue>().entries)
            GovernanceActionId.deserialize(e.key):
                VotingProcedure.deserialize(e.value)
        }
    });
  }
  factory VotingProcedures.fromJson(Map<dynamic, dynamic> json) {
    return VotingProcedures({
      for (final i in (json["votes"] as Map).entries)
        Voter.fromJson(Map<String, dynamic>.from(i.key)): {
          for (final e in (i.value as Map).entries)
            GovernanceActionId.fromJson(e.key):
                VotingProcedure.fromJson(Map<String, dynamic>.from(e.value))
        }
    });
  }

  @override
  CborObject toCbor() {
    return CborMapValue.definite({
      for (final i in votes.entries)
        i.key.toCbor(): CborMapValue.definite(
            {for (final e in i.value.entries) e.key.toCbor(): e.value.toCbor()})
    });
  }

  @override
  Map<dynamic, dynamic> toJson() {
    return {
      "votes": {
        for (final i in votes.entries)
          i.key.toJson(): {
            for (final e in i.value.entries) e.key.toJson(): e.value.toJson()
          }
      }
    };
  }
}
