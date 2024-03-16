class ADANetworkInfoResponse {
  final ADANetworkSupply supply;
  final ADANetworkStake stake;

  ADANetworkInfoResponse({
    required this.supply,
    required this.stake,
  });

  factory ADANetworkInfoResponse.fromJson(Map<String, dynamic> json) {
    return ADANetworkInfoResponse(
      supply: ADANetworkSupply.fromJson(json['supply']),
      stake: ADANetworkStake.fromJson(json['stake']),
    );
  }

  Map<String, dynamic> toJson() => {
        'supply': supply.toJson(),
        'stake': stake.toJson(),
      };
  @override
  String toString() {
    return "ADANetworkInfoResponse${toJson()}";
  }
}

class ADANetworkSupply {
  final String max;
  final String total;
  final String circulating;
  final String locked;
  final String treasury;
  final String reserves;

  ADANetworkSupply({
    required this.max,
    required this.total,
    required this.circulating,
    required this.locked,
    required this.treasury,
    required this.reserves,
  });

  factory ADANetworkSupply.fromJson(Map<String, dynamic> json) {
    return ADANetworkSupply(
      max: json['max'],
      total: json['total'],
      circulating: json['circulating'],
      locked: json['locked'],
      treasury: json['treasury'],
      reserves: json['reserves'],
    );
  }

  Map<String, dynamic> toJson() => {
        'max': max,
        'total': total,
        'circulating': circulating,
        'locked': locked,
        'treasury': treasury,
        'reserves': reserves,
      };
}

class ADANetworkStake {
  final String live;
  final String active;

  ADANetworkStake({
    required this.live,
    required this.active,
  });

  factory ADANetworkStake.fromJson(Map<String, dynamic> json) {
    return ADANetworkStake(
      live: json['live'],
      active: json['active'],
    );
  }

  Map<String, dynamic> toJson() => {
        'live': live,
        'active': active,
      };
}
