import 'package:on_chain/sui/src/address/address/address.dart';
import 'package:on_chain/sui/src/rpc/core/core.dart';
import 'package:on_chain/sui/src/rpc/models/types/types.dart';

/// Return all Coin<`coin_type`> objects owned by an address.
/// [sui documation](https://docs.sui.io/sui-api-ref#suix_getcoins)
class SuiRequestGetCoins
    extends SuiRequest<SuiApiGetCoinResponse, Map<String, dynamic>> {
  const SuiRequestGetCoins(
      {required this.owner, this.coinType, super.pagination});

  /// The owner's Sui address
  final SuiAddress owner;

  /// Optional type name for the coin (e.g., 0x168da5bf1f48dafc111b0a488fa454aca95e0b5e::usdc::USDC), default to 0x2::sui::SUI if not specified.
  final String? coinType;

  @override
  String get method => 'suix_getCoins';

  @override
  List<dynamic> toJson() {
    return [owner.address, coinType, ...super.pagination?.toJson() ?? []];
  }

  @override
  SuiApiGetCoinResponse onResonse(Map<String, dynamic> result) {
    return SuiApiGetCoinResponse.fromJson(result);
  }
}
