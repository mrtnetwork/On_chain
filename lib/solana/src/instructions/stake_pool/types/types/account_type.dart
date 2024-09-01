import 'package:on_chain/solana/src/exception/exception.dart';

/// Enum representing the account type managed by the program
class StakePoolAccountType {
  final String name;
  final int value;
  const StakePoolAccountType._(this.name, this.value);

  /// If the account has not been initialized, the enum will be 0
  static const StakePoolAccountType uninitialized =
      StakePoolAccountType._("Uninitialized", 0);

  /// Stake pool
  static const StakePoolAccountType stakePool =
      StakePoolAccountType._("StakePool", 1);

  /// Validator stake list
  static const StakePoolAccountType validatorList =
      StakePoolAccountType._("ValidatorList", 2);

  static const List<StakePoolAccountType> values = [
    uninitialized,
    stakePool,
    validatorList
  ];

  factory StakePoolAccountType.fromJson(Map<String, dynamic> json) {
    return StakePoolAccountType.fromName(json["tokenState"]["key"]);
  }

  factory StakePoolAccountType.fromName(String? value) {
    return values.firstWhere(
      (element) => element.name == value,
      orElse: () => throw SolanaPluginException(
          "No StakePoolAccountType found matching the specified value",
          details: {"value": value}),
    );
  }
  factory StakePoolAccountType.fromValue(int? value) {
    return values.firstWhere(
      (element) => element.value == value,
      orElse: () => throw SolanaPluginException(
          "No StakePoolAccountType found matching the specified value",
          details: {"value": value}),
    );
  }

  @override
  String toString() {
    return "StakePoolAccountType.$name";
  }
}
