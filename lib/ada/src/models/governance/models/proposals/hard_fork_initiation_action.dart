import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:on_chain/ada/src/models/governance/models/governance_action_id.dart';
import 'package:on_chain/ada/src/models/governance/models/proposals/action.dart';
import 'package:on_chain/ada/src/models/governance/models/proposals/governance_action_type.dart';
import 'package:on_chain/ada/src/models/block/models/header/header/protocol_version.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';

class HardForkInitiationAction extends GovernanceAction {
  final GovernanceActionId? govActionId;
  final ProtocolVersion protocolVersion;
  const HardForkInitiationAction(
      {this.govActionId, required this.protocolVersion})
      : super(type: GovernanceActionType.hardForkInitiationAction);
  factory HardForkInitiationAction.deserialize(CborListValue cbor) {
    return HardForkInitiationAction(
      govActionId: cbor
          .elementAt<CborListValue?>(1)
          ?.convertTo<GovernanceActionId, CborListValue>(
              (e) => GovernanceActionId.deserialize(e)),
      protocolVersion:
          ProtocolVersion.deserialize(cbor.elementAt<CborListValue>(2)),
    );
  }
  factory HardForkInitiationAction.fromJson(Map<String, dynamic> json) {
    final currentJson =
        json[GovernanceActionType.hardForkInitiationAction.name] ?? json;
    return HardForkInitiationAction(
        govActionId: currentJson["gov_action_id"] == null
            ? null
            : GovernanceActionId.fromJson(currentJson["gov_action_id"]),
        protocolVersion:
            ProtocolVersion.fromJson(currentJson["protocol_version"]));
  }
  @override
  CborObject toCbor() {
    return CborListValue.definite([
      type.toCbor(),
      govActionId?.toCbor() ?? const CborNullValue(),
      protocolVersion.toCbor()
    ]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      type.name: {
        "gov_action_id": govActionId?.toJson(),
        "protocol_version": protocolVersion.toJson(),
      }
    };
  }
}
