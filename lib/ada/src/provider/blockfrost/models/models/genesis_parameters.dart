class ADAGenesisParametersResponse {
  /// The proportion of slots in which blocks should be issued
  final double activeSlotsCoefficient;

  /// Determines the quorum needed for votes on the protocol parameter updates
  final int updateQuorum;

  /// The total number of lovelace in the system
  final String maxLovelaceSupply;

  /// Network identifier
  final int networkMagic;

  /// Number of slots in an epoch
  final int epochLength;

  /// Time of slot 0 in UNIX time
  final int systemStart;

  /// Number of slots in an KES period
  final int slotsPerKesPeriod;

  /// Duration of one slot in seconds
  final int slotLength;

  /// The maximum number of time a KES key can be evolved before a pool operator must create a new operational certificate
  final int maxKesEvolutions;

  /// Security parameter k
  final int securityParam;

  ADAGenesisParametersResponse({
    required this.activeSlotsCoefficient,
    required this.updateQuorum,
    required this.maxLovelaceSupply,
    required this.networkMagic,
    required this.epochLength,
    required this.systemStart,
    required this.slotsPerKesPeriod,
    required this.slotLength,
    required this.maxKesEvolutions,
    required this.securityParam,
  });

  factory ADAGenesisParametersResponse.fromJson(Map<String, dynamic> json) {
    return ADAGenesisParametersResponse(
      activeSlotsCoefficient: json['active_slots_coefficient'],
      updateQuorum: json['update_quorum'],
      maxLovelaceSupply: json['max_lovelace_supply'],
      networkMagic: json['network_magic'],
      epochLength: json['epoch_length'],
      systemStart: json['system_start'],
      slotsPerKesPeriod: json['slots_per_kes_period'],
      slotLength: json['slot_length'],
      maxKesEvolutions: json['max_kes_evolutions'],
      securityParam: json['security_param'],
    );
  }

  Map<String, dynamic> toJson() => {
        'active_slots_coefficient': activeSlotsCoefficient,
        'update_quorum': updateQuorum,
        'max_lovelace_supply': maxLovelaceSupply,
        'network_magic': networkMagic,
        'epoch_length': epochLength,
        'system_start': systemStart,
        'slots_per_kes_period': slotsPerKesPeriod,
        'slot_length': slotLength,
        'max_kes_evolutions': maxKesEvolutions,
        'security_param': securityParam,
      };

  @override
  String toString() {
    return "ADAGenesisParametersResponse${toJson()}";
  }
}
