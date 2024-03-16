class ADAStakePoolInfoResponse {
  /// Bech32 pool ID
  final String poolId;

  /// Hexadecimal pool ID
  final String hex;

  /// VRF key hash
  final String vrfKey;

  /// Total minted blocks
  final int blocksMinted;

  /// Number of blocks minted in the current epoch
  final int blocksEpoch;

  /// Live stake in Lovelaces
  final String liveStake;

  /// Live stake size
  final double liveSize;

  /// Live stake saturation
  final double liveSaturation;

  /// Number of live delegators
  final int liveDelegators;

  /// Active stake in Lovelaces
  final String activeStake;

  /// Active stake size
  final double activeSize;

  /// Stake pool certificate pledge
  final String declaredPledge;

  /// Stake pool current pledge
  final String livePledge;

  /// Margin tax cost of the stake pool
  final double marginCost;

  /// Fixed tax cost of the stake pool
  final String fixedCost;

  /// Bech32 reward account of the stake pool
  final String rewardAccount;

  /// List of owners
  final List<String> owners;

  /// List of registration certificates
  final List<String> registration;

  /// List of retirement certificates
  final List<String> retirement;

  ADAStakePoolInfoResponse({
    required this.poolId,
    required this.hex,
    required this.vrfKey,
    required this.blocksMinted,
    required this.blocksEpoch,
    required this.liveStake,
    required this.liveSize,
    required this.liveSaturation,
    required this.liveDelegators,
    required this.activeStake,
    required this.activeSize,
    required this.declaredPledge,
    required this.livePledge,
    required this.marginCost,
    required this.fixedCost,
    required this.rewardAccount,
    required this.owners,
    required this.registration,
    required this.retirement,
  });

  factory ADAStakePoolInfoResponse.fromJson(Map<String, dynamic> json) {
    return ADAStakePoolInfoResponse(
      poolId: json['pool_id'],
      hex: json['hex'],
      vrfKey: json['vrf_key'],
      blocksMinted: json['blocks_minted'],
      blocksEpoch: json['blocks_epoch'],
      liveStake: json['live_stake'],
      liveSize: json['live_size'],
      liveSaturation: json['live_saturation'],
      liveDelegators: json['live_delegators'],
      activeStake: json['active_stake'],
      activeSize: json['active_size'],
      declaredPledge: json['declared_pledge'],
      livePledge: json['live_pledge'],
      marginCost: json['margin_cost'],
      fixedCost: json['fixed_cost'],
      rewardAccount: json['reward_account'],
      owners: List<String>.from(json['owners']),
      registration: List<String>.from(json['registration']),
      retirement: List<String>.from(json['retirement']),
    );
  }

  Map<String, dynamic> toJson() => {
        'pool_id': poolId,
        'hex': hex,
        'vrf_key': vrfKey,
        'blocks_minted': blocksMinted,
        'blocks_epoch': blocksEpoch,
        'live_stake': liveStake,
        'live_size': liveSize,
        'live_saturation': liveSaturation,
        'live_delegators': liveDelegators,
        'active_stake': activeStake,
        'active_size': activeSize,
        'declared_pledge': declaredPledge,
        'live_pledge': livePledge,
        'margin_cost': marginCost,
        'fixed_cost': fixedCost,
        'reward_account': rewardAccount,
        'owners': owners,
        'registration': registration,
        'retirement': retirement,
      };

  @override
  String toString() {
    return "ADAStakePoolInfoResponse${toJson()}";
  }
}
