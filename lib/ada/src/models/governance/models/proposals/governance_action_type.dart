import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:on_chain/ada/src/exception/exception.dart';
import 'package:on_chain/serialization/cbor/cbor_serialization.dart';

/// Represents a Governance Action type.
class GovernanceActionType with InternalCborSerialization {
  /// The name of the Governance Action type.
  final String name;

  /// The value of the Governance Action type.
  final int value;

  const GovernanceActionType._(this.name, this.value);
  static const GovernanceActionType parameterChangeAction =
      GovernanceActionType._('ParameterChangeAction', 0);

  static const GovernanceActionType hardForkInitiationAction =
      GovernanceActionType._('HardForkInitiationAction', 1);

  static const GovernanceActionType treasuryWithdrawalsAction =
      GovernanceActionType._('TreasuryWithdrawalsAction', 2);

  static const GovernanceActionType noConfidenceAction =
      GovernanceActionType._('NoConfidenceAction', 3);

  static const GovernanceActionType updateCommitteeAction =
      GovernanceActionType._('UpdateCommitteeAction', 4);

  static const GovernanceActionType newConstitutionAction =
      GovernanceActionType._('NewConstitutionAction', 5);

  static const GovernanceActionType infoAction =
      GovernanceActionType._('InfoAction', 6);

  /// List of all Governance Action types.
  static const List<GovernanceActionType> values = [
    parameterChangeAction,
    hardForkInitiationAction,
    treasuryWithdrawalsAction,
    noConfidenceAction,
    updateCommitteeAction,
    newConstitutionAction,
    infoAction
  ];

  factory GovernanceActionType.deserialize(CborIntValue cbor) {
    return fromValue(cbor.value);
  }

  @override
  CborObject toCbor() {
    return CborIntValue(value);
  }

  /// Returns the [GovernanceActionType] corresponding to the provided [value].
  static GovernanceActionType fromValue(int? value) {
    return values.firstWhere(
      (element) => element.value == value,
      orElse: () => throw ADAPluginException(
          'No GovernanceActionType found matching the specified value',
          details: {'value': value}),
    );
  }

  /// Returns the [GovernanceActionType] corresponding to the provided [value].
  static GovernanceActionType fromName(String? name) {
    return values.firstWhere(
      (element) => element.name == name,
      orElse: () => throw ADAPluginException(
          'No GovernanceActionType found matching the specified name',
          details: {'name': name}),
    );
  }

  @override
  String toString() {
    return 'NativeScriptType.$name';
  }

  @override
  String toJson() {
    return name;
  }
}
