import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/models/fixed_bytes/models/models.dart';
import 'package:on_chain/ada/src/models/governance/models/governance_action_id.dart';
import 'package:on_chain/ada/src/models/governance/models/proposals/action.dart';
import 'package:on_chain/ada/src/models/governance/models/proposals/governance_action_type.dart';
import 'package:on_chain/ada/src/models/protocol/models/protocol_param_update.dart';

class ParameterChangeAction extends GovernanceAction {
  final GovernanceActionId? govActionId;
  final ProtocolParamUpdate protocolParamUpdates;
  final ScriptHash? policyHash;
  const ParameterChangeAction({
    this.govActionId,
    required this.protocolParamUpdates,
    this.policyHash,
  }) : super(type: GovernanceActionType.parameterChangeAction);
  factory ParameterChangeAction.deserialize(CborListValue cbor) {
    return ParameterChangeAction(
      govActionId: cbor.maybeObjectAt<GovernanceActionId, CborListValue>(
        1,
        (e) => GovernanceActionId.deserialize(e),
      ),
      protocolParamUpdates: ProtocolParamUpdate.deserialize(
        cbor.objectAt<CborMapValue>(2),
      ),
      policyHash: cbor.maybeObjectAt<ScriptHash, CborBytesValue>(
        3,
        (e) => ScriptHash.deserialize(e),
      ),
    );
  }
  factory ParameterChangeAction.fromJson(Map<String, dynamic> json) {
    final currentJson =
        json[GovernanceActionType.parameterChangeAction.name] ?? json;
    return ParameterChangeAction(
      govActionId:
          currentJson["gov_action_id"] == null
              ? null
              : GovernanceActionId.fromJson(currentJson["gov_action_id"]),
      protocolParamUpdates: ProtocolParamUpdate.fromJson(
        currentJson["protocol_param_updates"],
      ),
      policyHash:
          currentJson["policy_hash"] == null
              ? null
              : ScriptHash.fromHex(currentJson["policy_hash"]),
    );
  }
  @override
  CborObject toCbor() {
    return CborListValue.definite([
      type.toCbor(),
      govActionId?.toCbor() ?? const CborNullValue(),
      protocolParamUpdates.toCbor(),
      policyHash?.toCbor() ?? const CborNullValue(),
    ]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      type.name: {
        "gov_action_id": govActionId?.toJson(),
        "protocol_param_updates": protocolParamUpdates.toJson(),
        "policy_hash": policyHash?.toJson(),
      },
    };
  }
}
