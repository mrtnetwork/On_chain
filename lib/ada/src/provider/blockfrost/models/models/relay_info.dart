class ADAStakePoolRelayInfoResponse {
  final String? ipv4;
  final String? ipv6;
  final String? dns;
  final String? dnsSrv;
  final int port;

  ADAStakePoolRelayInfoResponse({
    this.ipv4,
    this.ipv6,
    this.dns,
    this.dnsSrv,
    required this.port,
  });

  factory ADAStakePoolRelayInfoResponse.fromJson(Map<String, dynamic> json) {
    return ADAStakePoolRelayInfoResponse(
      ipv4: json['ipv4'],
      ipv6: json['ipv6'],
      dns: json['dns'],
      dnsSrv: json['dns_srv'],
      port: json['port'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ipv4': ipv4,
      'ipv6': ipv6,
      'dns': dns,
      'dns_srv': dnsSrv,
      'port': port,
    };
  }

  @override
  String toString() {
    return "ADAStakePoolRelayInfoResponse${toJson()}";
  }
}
