import 'package:on_chain/sui/src/address/address/address.dart';
import 'package:on_chain/sui/src/rpc/core/core.dart';
import 'package:on_chain/sui/src/rpc/models/types/types.dart';

/// Return all Coin objects owned by an address.
/// [sui documation](https://docs.sui.io/sui-api-ref#suix_getallcoins)
class SuiRequestGetAllCoins
    extends SuiRequest<SuiApiGetCoinResponse, Map<String, dynamic>> {
  const SuiRequestGetAllCoins({required this.owner, super.pagination});

  /// The owner's Sui address
  final SuiAddress owner;

  @override
  String get method => 'suix_getAllCoins';

  @override
  List<dynamic> toJson() {
    return [owner.address, ...pagination?.toJson() ?? []];
  }

  @override
  SuiApiGetCoinResponse onResonse(Map<String, dynamic> result) {
    return SuiApiGetCoinResponse.fromJson(result);
  }
}
