import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/models/governance/models/governance_action_id.dart';
import 'package:on_chain/ada/src/models/governance/models/proposals/action.dart';
import 'package:on_chain/ada/src/models/governance/models/proposals/constitution.dart';
import 'package:on_chain/ada/src/models/governance/models/proposals/governance_action_type.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';

class NewConstitutionAction extends GovernanceAction {
  final GovernanceActionId? govActionId;
  final Constitution constitution;
  const NewConstitutionAction({this.govActionId, required this.constitution})
      : super(type: GovernanceActionType.newConstitutionAction);
  factory NewConstitutionAction.deserialize(CborListValue cbor) {
    return NewConstitutionAction(
        govActionId: cbor
            .elementAt<CborListValue?>(1)
            ?.convertTo<GovernanceActionId, CborListValue>(
                (e) => GovernanceActionId.deserialize(e)),
        constitution:
            Constitution.deserialize(cbor.elementAt<CborListValue>(2)));
  }
  factory NewConstitutionAction.fromJson(Map<String, dynamic> json) {
    final currentJson =
        json[GovernanceActionType.newConstitutionAction.name] ?? json;
    return NewConstitutionAction(
        govActionId: currentJson["gov_action_id"] == null
            ? null
            : GovernanceActionId.fromJson(currentJson["gov_action_id"]),
        constitution: Constitution.fromJson(currentJson["constitution"]));
  }
  @override
  CborObject toCbor() {
    return CborListValue.definite([
      type.toCbor(),
      govActionId?.toCbor() ?? const CborNullValue(),
      constitution.toCbor()
    ]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      type.name: {
        "gov_action_id": govActionId?.toJson(),
        "constitution": constitution.toJson()
      }
    };
  }
}
