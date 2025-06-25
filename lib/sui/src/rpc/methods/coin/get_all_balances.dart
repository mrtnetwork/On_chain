import 'package:on_chain/sui/src/address/address/address.dart';
import 'package:on_chain/sui/src/rpc/core/core.dart';
import 'package:on_chain/sui/src/rpc/models/types/types.dart';

/// Return the total coin balance for all coin type, owned by the address owner.
/// [sui documation](https://docs.sui.io/sui-api-ref#suix_getallbalances)
class SuiRequestGetAllBalances extends SuiRequest<List<SuiApiBalanceResponse>,
    List<Map<String, dynamic>>> {
  /// The owner's Sui address
  const SuiRequestGetAllBalances({required this.owner});
  final SuiAddress owner;

  @override
  String get method => 'suix_getAllBalances';

  @override
  List<dynamic> toJson() {
    return [owner.address];
  }

  @override
  List<SuiApiBalanceResponse> onResonse(List<Map<String, dynamic>> result) {
    return result.map((e) => SuiApiBalanceResponse.fromJson(e)).toList();
  }
}
