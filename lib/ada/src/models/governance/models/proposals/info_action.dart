import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/models/governance/models/proposals/action.dart';
import 'package:on_chain/ada/src/models/governance/models/proposals/governance_action_type.dart';

class InfoAction extends GovernanceAction {
  const InfoAction() : super(type: GovernanceActionType.infoAction);
  factory InfoAction.deserialize(CborListValue cbor) {
    return InfoAction();
  }
  factory InfoAction.fromJson(Map<String, dynamic> json) {
    return InfoAction();
  }
  @override
  CborObject toCbor() {
    return CborListValue.definite([type.toCbor()]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {type.name: {}};
  }
}
