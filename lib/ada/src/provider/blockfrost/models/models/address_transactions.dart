class ADATransactionSummaryInfoResponse {
  /// Hash of the transaction
  final String txHash;

  /// Transaction index within the block
  final int txIndex;

  /// Block height
  final int blockHeight;

  /// Block creation time in UNIX time
  final int blockTime;

  ADATransactionSummaryInfoResponse({
    required this.txHash,
    required this.txIndex,
    required this.blockHeight,
    required this.blockTime,
  });

  factory ADATransactionSummaryInfoResponse.fromJson(
      Map<String, dynamic> json) {
    return ADATransactionSummaryInfoResponse(
      txHash: json['tx_hash'],
      txIndex: json['tx_index'],
      blockHeight: json['block_height'],
      blockTime: json['block_time'],
    );
  }

  Map<String, dynamic> toJson() => {
        'tx_hash': txHash,
        'tx_index': txIndex,
        'block_height': blockHeight,
        'block_time': blockTime,
      };
  @override
  String toString() {
    return 'ADAAddressTransaction${toJson()}';
  }
}
