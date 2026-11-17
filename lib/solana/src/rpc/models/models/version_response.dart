/// Current Solana version running on the node (getVersion).
class SolanaVersionResponse {
  const SolanaVersionResponse({required this.solanaCore, this.featureSet});
  factory SolanaVersionResponse.fromJson(Map<String, dynamic> json) {
    return SolanaVersionResponse(
      solanaCore: json['solana-core'],
      featureSet: json['feature-set'],
    );
  }
  Map<String, dynamic> toJson() {
    return {'solana-core': solanaCore, 'feature-set': featureSet};
  }

  /// Solana core version string.
  final String solanaCore;

  /// Feature set version number.
  final int? featureSet;
}
