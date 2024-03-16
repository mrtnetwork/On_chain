class ADAPoolRetirementResponse {
  /// Bech32 encoded pool ID
  final String poolId;

  /// Retirement epoch number
  final int epoch;

  ADAPoolRetirementResponse({
    required this.poolId,
    required this.epoch,
  });

  factory ADAPoolRetirementResponse.fromJson(Map<String, dynamic> json) {
    return ADAPoolRetirementResponse(
      poolId: json['pool_id'],
      epoch: json['epoch'],
    );
  }

  Map<String, dynamic> toJson() => {
        'pool_id': poolId,
        'epoch': epoch,
      };
  @override
  String toString() {
    // TODO: implement toString
    return "ADAPoolRetirementResponse${toJson()}";
  }
}
