class ADAEpochInfoResponse {
  /// Epoch number
  final int epoch;

  /// Unix time of the start of the epoch
  final int startTime;

  /// Unix time of the end of the epoch
  final int endTime;

  /// Unix time of the first block of the epoch
  final int firstBlockTime;

  /// Unix time of the last block of the epoch
  final int lastBlockTime;

  /// Number of blocks within the epoch
  final int blockCount;

  /// Number of transactions within the epoch
  final int txCount;

  /// Sum of all the transactions within the epoch in Lovelaces
  final String output;

  /// Sum of all the fees within the epoch in Lovelaces
  final String fees;

  /// Sum of all the active stakes within the epoch in Lovelaces
  final String? activeStake;

  ADAEpochInfoResponse({
    required this.epoch,
    required this.startTime,
    required this.endTime,
    required this.firstBlockTime,
    required this.lastBlockTime,
    required this.blockCount,
    required this.txCount,
    required this.output,
    required this.fees,
    this.activeStake,
  });

  factory ADAEpochInfoResponse.fromJson(Map<String, dynamic> json) {
    return ADAEpochInfoResponse(
      epoch: json['epoch'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      firstBlockTime: json['first_block_time'],
      lastBlockTime: json['last_block_time'],
      blockCount: json['block_count'],
      txCount: json['tx_count'],
      output: json['output'],
      fees: json['fees'],
      activeStake: json['active_stake'],
    );
  }

  Map<String, dynamic> toJson() => {
        'epoch': epoch,
        'start_time': startTime,
        'end_time': endTime,
        'first_block_time': firstBlockTime,
        'last_block_time': lastBlockTime,
        'block_count': blockCount,
        'tx_count': txCount,
        'output': output,
        'fees': fees,
        'active_stake': activeStake,
      };

  @override
  String toString() {
    return 'ADAEpochInfoResponse${toJson()}';
  }
}
