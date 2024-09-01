import 'package:on_chain/solana/src/exception/exception.dart';

/// Status of the stake account in the validator list, for accounting
class ValidatorStakeInfoStatus {
  final String name;
  final int value;
  const ValidatorStakeInfoStatus._(this.name, this.value);

  /// Stake account is active, there may be a transient stake as well
  static const ValidatorStakeInfoStatus active =
      ValidatorStakeInfoStatus._("Active", 0);

  /// Only transient stake account exists, when a transient stake is
  /// deactivating during validator removal
  static const ValidatorStakeInfoStatus deactivatingTransient =
      ValidatorStakeInfoStatus._("DeactivatingTransient", 1);

  /// No more validator stake accounts exist, entry ready for removal during
  /// [UpdateStakePoolBalance]
  static const ValidatorStakeInfoStatus readyForRemoval =
      ValidatorStakeInfoStatus._("ReadyForRemoval", 2);

  /// Only the validator stake account is deactivating, no transient stake
  /// account exists
  static const ValidatorStakeInfoStatus deactivatingValidator =
      ValidatorStakeInfoStatus._("DeactivatingValidator", 3);

  /// Both the transient and validator stake account are deactivating, when
  /// a validator is removed with a transient stake active
  static const ValidatorStakeInfoStatus deactivatingAll =
      ValidatorStakeInfoStatus._("DeactivatingAll", 4);

  static const List<ValidatorStakeInfoStatus> values = [
    active,
    deactivatingTransient,
    readyForRemoval,
    deactivatingValidator,
    deactivatingAll
  ];

  factory ValidatorStakeInfoStatus.fromJson(Map<String, dynamic> json) {
    return ValidatorStakeInfoStatus.fromName(json["tokenState"]["key"]);
  }

  factory ValidatorStakeInfoStatus.fromName(String? value) {
    return values.firstWhere(
      (element) => element.name == value,
      orElse: () => throw SolanaPluginException(
          "No ValidatorStakeInfoStatus found matching the specified value",
          details: {"value": value}),
    );
  }
  factory ValidatorStakeInfoStatus.fromValue(int? value) {
    return values.firstWhere(
      (element) => element.value == value,
      orElse: () => throw SolanaPluginException(
          "No ValidatorStakeInfoStatus found matching the specified value",
          details: {"value": value}),
    );
  }

  @override
  String toString() {
    return "ValidatorStakeInfoStatus.$name";
  }
}
