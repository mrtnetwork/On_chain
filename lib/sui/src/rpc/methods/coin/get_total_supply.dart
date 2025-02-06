import 'package:on_chain/sui/src/rpc/core/core.dart';
import 'package:on_chain/utils/utils/map_utils.dart';

/// Return total supply for a coin.
/// [sui documation](https://docs.sui.io/sui-api-ref#suix_gettotalsupply)
class SuiRequestGetTotalSupply
    extends SuiRequest<BigInt, Map<String, dynamic>> {
  const SuiRequestGetTotalSupply({required this.coinType});

  /// Type name for the coin (e.g., 0x168da5bf1f48dafc111b0a488fa454aca95e0b5e::usdc::USDC)
  final String coinType;

  @override
  String get method => 'suix_getTotalSupply';

  @override
  List<dynamic> toJson() {
    return [coinType];
  }

  @override
  BigInt onResonse(Map<String, dynamic> result) {
    return result.asBigInt("value");
  }
}
