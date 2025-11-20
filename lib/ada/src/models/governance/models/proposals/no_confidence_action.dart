import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/models/governance/models/governance_action_id.dart';
import 'package:on_chain/ada/src/models/governance/models/proposals/action.dart';
import 'package:on_chain/ada/src/models/governance/models/proposals/governance_action_type.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';

class NoConfidenceAction extends GovernanceAction {
  final GovernanceActionId? govActionId;
  const NoConfidenceAction({this.govActionId})
      : super(type: GovernanceActionType.noConfidenceAction);
  factory NoConfidenceAction.deserialize(CborListValue cbor) {
    return NoConfidenceAction(
      govActionId: cbor
          .elementAt<CborListValue?>(1)
          ?.convertTo<GovernanceActionId, CborListValue>(
              (e) => GovernanceActionId.deserialize(e)),
    );
  }
  factory NoConfidenceAction.fromJson(Map<String, dynamic> json) {
    final currentJson =
        json[GovernanceActionType.noConfidenceAction.name] ?? json;
    return NoConfidenceAction(
      govActionId: currentJson["gov_action_id"] == null
          ? null
          : GovernanceActionId.fromJson(currentJson["gov_action_id"]),
    );
  }
  @override
  CborObject toCbor() {
    return CborListValue.definite([
      type.toCbor(),
      govActionId?.toCbor() ?? const CborNullValue(),
    ]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      type.name: {
        "gov_action_id": govActionId?.toJson(),
      }
    };
  }
}
