import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/models/credential/models/credentials.dart';
import 'package:on_chain/ada/src/models/credential/models/credential.dart';
import 'package:on_chain/ada/src/models/governance/models/governance_action_id.dart';
import 'package:on_chain/ada/src/models/governance/models/proposals/action.dart';
import 'package:on_chain/ada/src/models/governance/models/proposals/governance_action_type.dart';
import 'package:on_chain/ada/src/models/protocol/models/unit_interval.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';

class UpdateCommitteeAction extends GovernanceAction {
  final GovernanceActionId? govActionId;
  final Credentials membersToRemove;
  final Map<Credential, int> members;
  final UnitInterval quorumQhreshold;
  const UpdateCommitteeAction(
      {this.govActionId,
      required this.members,
      required this.membersToRemove,
      required this.quorumQhreshold})
      : super(type: GovernanceActionType.updateCommitteeAction);
  factory UpdateCommitteeAction.deserialize(CborListValue cbor) {
    return UpdateCommitteeAction(
        govActionId: cbor
            .elementAt<CborListValue?>(1)
            ?.convertTo<GovernanceActionId, CborListValue>(
                (e) => GovernanceActionId.deserialize(e)),
        membersToRemove: Credentials.deserialize(cbor.elementAt<CborObject>(2)),
        members: {
          for (final i in cbor
              .elementAt<CborMapValue>(3)
              .valueAsMap<CborListValue, CborIntValue>()
              .entries)
            Credential.deserialize(i.key): i.value.toInt()
        },
        quorumQhreshold:
            UnitInterval.deserialize(cbor.elementAt<CborTagValue>(4)));
  }
  factory UpdateCommitteeAction.fromJson(Map<String, dynamic> json) {
    final currentJson =
        json[GovernanceActionType.updateCommitteeAction.name] ?? json;
    return UpdateCommitteeAction(
        govActionId: currentJson["gov_action_id"] == null
            ? null
            : GovernanceActionId.fromJson(currentJson["gov_action_id"]),
        membersToRemove: Credentials.fromJson(currentJson["members_to_remove"]),
        members: {
          for (final i in (currentJson["members"] as Map).entries)
            Credential.fromJson(i.key): IntUtils.parse(i.value)
        },
        quorumQhreshold:
            UnitInterval.fromJson(currentJson["quorum_threshold"]));
  }
  @override
  CborObject toCbor() {
    return CborListValue.definite([
      type.toCbor(),
      govActionId?.toCbor() ?? const CborNullValue(),
      membersToRemove.toCbor(),
      CborMapValue.definite({
        for (final i in members.entries)
          i.key.toCbor(): CborUnsignedValue.u32(i.value),
      }),
      quorumQhreshold.toCbor()
    ]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      type.name: {
        "gov_action_id": govActionId?.toJson(),
        "members": {for (final i in members.entries) i.key.toJson(): i.value},
        "quorum_threshold": quorumQhreshold.toJson(),
        "members_to_remove": membersToRemove.toJson()
      }
    };
  }
}
