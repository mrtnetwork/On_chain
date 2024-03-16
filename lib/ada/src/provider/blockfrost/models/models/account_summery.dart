import 'amount.dart';

class ADAAccountSummaryResponse {
  /// Bech32 encoded stake address
  final String address;

  /// Array of received sums
  final List<ADAAmountResponse> receivedSum;

  /// Array of sent sums
  final List<ADAAmountResponse> sentSum;

  /// Count of all transactions for all addresses associated with the account
  final int txCount;

  ADAAccountSummaryResponse({
    required this.address,
    required this.receivedSum,
    required this.sentSum,
    required this.txCount,
  });

  factory ADAAccountSummaryResponse.fromJson(Map<String, dynamic> json) {
    var receivedSumList = json['received_sum'] as List;
    List<ADAAmountResponse> receivedSum = receivedSumList
        .map((item) => ADAAmountResponse.fromJson(item))
        .toList();

    var sentSumList = json['sent_sum'] as List;
    List<ADAAmountResponse> sentSum =
        sentSumList.map((item) => ADAAmountResponse.fromJson(item)).toList();

    return ADAAccountSummaryResponse(
      address: json["address"] ?? json['stake_address'],
      receivedSum: receivedSum,
      sentSum: sentSum,
      txCount: json['tx_count'],
    );
  }

  Map<String, dynamic> toJson() => {
        'address': address,
        'received_sum': receivedSum.map((asset) => asset.toJson()).toList(),
        'sent_sum': sentSum.map((asset) => asset.toJson()).toList(),
        'tx_count': txCount,
      };
  @override
  String toString() {
    return "ADAAccountSummaryResponse${toJson()}";
  }
}
