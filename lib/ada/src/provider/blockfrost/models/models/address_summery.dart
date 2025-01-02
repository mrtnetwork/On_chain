import 'amount.dart';

class ADAAddressSummaryResponse {
  /// Bech32 encoded addresses
  final String address;

  /// Array of amounts
  final List<ADAAmountResponse> amount;

  /// Stake address that controls the key
  final String? stakeAddress;

  /// Address era
  final String type;

  /// True if this is a script address
  final bool script;

  const ADAAddressSummaryResponse({
    required this.address,
    required this.amount,
    required this.type,
    required this.script,
    this.stakeAddress,
  });

  factory ADAAddressSummaryResponse.fromJson(Map<String, dynamic> json) {
    final amountList = json['amount'] as List;
    final List<ADAAmountResponse> amounts =
        amountList.map((item) => ADAAmountResponse.fromJson(item)).toList();

    return ADAAddressSummaryResponse(
      address: json['address'],
      amount: amounts,
      type: json['type'],
      script: json['script'],
      stakeAddress: json['stake_address'],
    );
  }

  Map<String, dynamic> toJson() => {
        'address': address,
        'amount': amount.map((amount) => amount.toJson()).toList(),
        'stake_address': stakeAddress,
        'type': type,
        'script': script,
      };

  @override
  String toString() {
    return 'ADAAddressSummaryResponse${toJson()}';
  }
}
