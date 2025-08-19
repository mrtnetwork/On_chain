import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:on_chain/ada/src/models/governance/models/proposals/governance_action_type.dart';
import 'package:on_chain/ada/src/models/governance/models/proposals/hard_fork_initiation_action.dart';
import 'package:on_chain/ada/src/models/governance/models/proposals/info_action.dart';
import 'package:on_chain/ada/src/models/governance/models/proposals/new_constitution_action.dart';
import 'package:on_chain/ada/src/models/governance/models/proposals/no_confidence_action.dart';
import 'package:on_chain/ada/src/models/governance/models/proposals/parameter_change_action.dart';
import 'package:on_chain/ada/src/models/governance/models/proposals/treasury_withdrawals_action.dart';
import 'package:on_chain/ada/src/models/governance/models/proposals/update_committee_action.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';

abstract class GovernanceAction with ADASerialization {
  final GovernanceActionType type;
  const GovernanceAction({required this.type});
  factory GovernanceAction.deserialize(CborListValue cbor) {
    final type =
        GovernanceActionType.deserialize(cbor.elementAt<CborIntValue>(0));
    return switch (type) {
      GovernanceActionType.hardForkInitiationAction =>
        HardForkInitiationAction.deserialize(cbor),
      GovernanceActionType.infoAction => InfoAction.deserialize(cbor),
      GovernanceActionType.newConstitutionAction =>
        NewConstitutionAction.deserialize(cbor),
      GovernanceActionType.noConfidenceAction =>
        NoConfidenceAction.deserialize(cbor),
      GovernanceActionType.parameterChangeAction =>
        ParameterChangeAction.deserialize(cbor),
      GovernanceActionType.treasuryWithdrawalsAction =>
        TreasuryWithdrawalsAction.deserialize(cbor),
      GovernanceActionType.updateCommitteeAction =>
        UpdateCommitteeAction.deserialize(cbor),
      _ => throw UnimplementedError("Unknown Governance Action Type.")
    };
  }

  factory GovernanceAction.fromJson(Map<String, dynamic> json) {
    final type = GovernanceActionType.fromName(json.keys.firstOrNull);
    return switch (type) {
      GovernanceActionType.hardForkInitiationAction =>
        HardForkInitiationAction.fromJson(json),
      GovernanceActionType.infoAction => InfoAction.fromJson(json),
      GovernanceActionType.newConstitutionAction =>
        NewConstitutionAction.fromJson(json),
      GovernanceActionType.noConfidenceAction =>
        NoConfidenceAction.fromJson(json),
      GovernanceActionType.parameterChangeAction =>
        ParameterChangeAction.fromJson(json),
      GovernanceActionType.treasuryWithdrawalsAction =>
        TreasuryWithdrawalsAction.fromJson(json),
      GovernanceActionType.updateCommitteeAction =>
        UpdateCommitteeAction.fromJson(json),
      _ => throw UnimplementedError("Unknown Governance Action Type.")
    };
  }
}
