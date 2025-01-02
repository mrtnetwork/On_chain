class ADAPoolInfoResponse {
  /// Bech32 encoded pool ID
  final String poolId;

  /// Hexadecimal pool ID.
  final String hex;

  /// Active delegated amount
  final String activeStake;

  /// Currently delegated amount
  final String liveStake;

  ADAPoolInfoResponse({
    required this.poolId,
    required this.hex,
    required this.activeStake,
    required this.liveStake,
  });

  factory ADAPoolInfoResponse.fromJson(Map<String, dynamic> json) {
    return ADAPoolInfoResponse(
      poolId: json['pool_id'],
      hex: json['hex'],
      activeStake: json['active_stake'],
      liveStake: json['live_stake'],
    );
  }

  Map<String, dynamic> toJson() => {
        'pool_id': poolId,
        'hex': hex,
        'active_stake': activeStake,
        'live_stake': liveStake,
      };

  @override
  String toString() {
    return 'ADAPoolInfoResponse${toJson()}';
  }
}
