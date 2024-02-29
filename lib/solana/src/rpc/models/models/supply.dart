import 'package:on_chain/solana/src/address/sol_address.dart';

class SupplyResponse {
  SupplyResponse(
      {required this.total,
      required this.circulating,
      required this.nonCirculating,
      required List<SolAddress> nonCirculatingAccounts})
      : nonCirculatingAccounts =
            List<SolAddress>.unmodifiable(nonCirculatingAccounts);
  factory SupplyResponse.fromJson(Map<String, dynamic> json) {
    return SupplyResponse(
        total: json["total"],
        circulating: json["circulating"],
        nonCirculating: json["nonCirculating"],
        nonCirculatingAccounts: (json["nonCirculatingAccounts"] as List)
            .map((e) => SolAddress.uncheckCurve(e))
            .toList());
  }

  /// Total supply in lamports
  final int total;

  /// Circulating supply in lamports
  final int circulating;

  /// Non-circulating supply in lamports
  final int nonCirculating;

  /// List of non-circulating account addresses
  final List<SolAddress> nonCirculatingAccounts;
}
