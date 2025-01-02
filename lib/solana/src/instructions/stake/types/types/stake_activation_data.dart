import 'activation_state.dart';

/// Stake Activation data
class StakeActivationData {
  const StakeActivationData(
      {required this.state, required this.active, required this.inactive});
  factory StakeActivationData.fromJson(Map<String, dynamic> json) {
    return StakeActivationData(
        state: StakeActivationState.fromName(json['state']),
        active: json['active'],
        inactive: json['inactive']);
  }

  /// the stake account's activation state
  final StakeActivationState state;

  /// stake active during the epoch
  final int active;

  /// stake inactive during the epoch
  final int inactive;
}
