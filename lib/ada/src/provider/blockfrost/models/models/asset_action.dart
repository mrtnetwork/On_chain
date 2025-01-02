class ADAAssetActionResponse {
  /// Hash of the transaction containing the asset action
  final String txHash;

  /// Action executed upon the asset policy. Possible values: [minted, burned]
  final String action;

  /// Asset amount of the specific action
  final String amount;

  ADAAssetActionResponse({
    required this.txHash,
    required this.action,
    required this.amount,
  });

  factory ADAAssetActionResponse.fromJson(Map<String, dynamic> json) {
    return ADAAssetActionResponse(
      txHash: json['tx_hash'],
      action: json['action'],
      amount: json['amount'],
    );
  }

  Map<String, dynamic> toJson() => {
        'tx_hash': txHash,
        'action': action,
        'amount': amount,
      };
  @override
  String toString() {
    return 'ADAAssetActionResponse${toJson()}';
  }
}
