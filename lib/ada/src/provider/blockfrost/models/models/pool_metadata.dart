class ADAPoolMetadataResponse {
  final String poolId;
  final String hex;
  final String? url;
  final String? hash;
  final String? ticker;
  final String? name;
  final String? description;
  final String? homepage;

  ADAPoolMetadataResponse({
    required this.poolId,
    required this.hex,
    this.url,
    this.hash,
    this.ticker,
    this.name,
    this.description,
    this.homepage,
  });

  factory ADAPoolMetadataResponse.fromJson(Map<String, dynamic> json) {
    return ADAPoolMetadataResponse(
      poolId: json['pool_id'],
      hex: json['hex'],
      url: json['url'],
      hash: json['hash'],
      ticker: json['ticker'],
      name: json['name'],
      description: json['description'],
      homepage: json['homepage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pool_id': poolId,
      'hex': hex,
      'url': url,
      'hash': hash,
      'ticker': ticker,
      'name': name,
      'description': description,
      'homepage': homepage,
    };
  }

  @override
  String toString() {
    return 'ADAPoolMetadataResponse${toJson()}';
  }
}
