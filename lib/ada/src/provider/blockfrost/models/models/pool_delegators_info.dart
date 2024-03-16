class ADAPoolDelegatorInfoResponse {
  final String address;
  final String liveStake;

  ADAPoolDelegatorInfoResponse({
    required this.address,
    required this.liveStake,
  });

  factory ADAPoolDelegatorInfoResponse.fromJson(Map<String, dynamic> json) {
    return ADAPoolDelegatorInfoResponse(
      address: json['address'],
      liveStake: json['live_stake'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'live_stake': liveStake,
    };
  }

  @override
  String toString() {
    return "ADAPoolDelegatorInfoResponse${toJson()}";
  }
}
