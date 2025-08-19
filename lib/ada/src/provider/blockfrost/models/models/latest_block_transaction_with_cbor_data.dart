class LatestBlockTransactionWithCborDataResponse {
  final String txHash;
  final String cbor;
  const LatestBlockTransactionWithCborDataResponse(
      {required this.txHash, required this.cbor});
  factory LatestBlockTransactionWithCborDataResponse.fromJson(
      Map<String, dynamic> json) {
    return LatestBlockTransactionWithCborDataResponse(
        txHash: json["tx_hash"], cbor: json["cbor"]);
  }
}
