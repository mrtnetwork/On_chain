import 'package:on_chain/solana/src/exception/exception.dart';

class StakeActivationState {
  final String name;
  final int value;
  const StakeActivationState._(this.name, this.value);
  static const StakeActivationState active =
      StakeActivationState._('Active', 0);
  static const StakeActivationState inactive =
      StakeActivationState._('Inactive', 1);
  static const StakeActivationState activating =
      StakeActivationState._('Activating', 2);
  static const StakeActivationState deactivating =
      StakeActivationState._('Deactivating', 3);
  static const List<StakeActivationState> values = [
    active,
    inactive,
    activating,
    deactivating
  ];

  factory StakeActivationState.fromName(String? value) {
    return values.firstWhere(
      (element) => element.name.toLowerCase() == value?.toLowerCase(),
      orElse: () => throw SolanaPluginException(
          'No StakeActivationState found matching the specified value',
          details: {'value': value}),
    );
  }
  factory StakeActivationState.fromValue(int? value) {
    return values.firstWhere(
      (element) => element.value == value,
      orElse: () => throw SolanaPluginException(
          'No StakeActivationState found matching the specified value',
          details: {'value': value}),
    );
  }

  @override
  String toString() {
    return 'ValidatorAccountType.$name';
  }
}
