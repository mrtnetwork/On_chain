class ADAPoolEpochInfoResponse {
  /// Epoch number
  final int epoch;

  /// Number of blocks created by pool
  final int blocks;

  /// Active (Snapshot of live stake 2 epochs ago) stake in Lovelaces
  final String activeStake;

  /// Pool size (percentage) of overall active stake at that epoch
  final num activeSize;

  /// Number of delegators for epoch
  final int delegatorsCount;

  /// Total rewards received before distribution to delegators
  final String rewards;

  /// Pool operator rewards
  final String fees;

  ADAPoolEpochInfoResponse({
    required this.epoch,
    required this.blocks,
    required this.activeStake,
    required this.activeSize,
    required this.delegatorsCount,
    required this.rewards,
    required this.fees,
  });

  factory ADAPoolEpochInfoResponse.fromJson(Map<String, dynamic> json) {
    return ADAPoolEpochInfoResponse(
      epoch: json['epoch'],
      blocks: json['blocks'],
      activeStake: json['active_stake'],
      activeSize: json['active_size'],
      delegatorsCount: json['delegators_count'],
      rewards: json['rewards'],
      fees: json['fees'],
    );
  }

  Map<String, dynamic> toJson() => {
        'epoch': epoch,
        'blocks': blocks,
        'active_stake': activeStake,
        'active_size': activeSize,
        'delegators_count': delegatorsCount,
        'rewards': rewards,
        'fees': fees,
      };

  @override
  String toString() {
    return 'ADAPoolEpochInfoResponse${toJson()}';
  }
}
