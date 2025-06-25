import 'package:on_chain/sui/src/address/address/address.dart';
import 'package:on_chain/sui/src/rpc/core/core.dart';
import 'package:on_chain/sui/src/rpc/models/types/types.dart';

/// Return all [DelegatedStake].
/// [sui documation](https://docs.sui.io/sui-api-ref#suix_getstakes)
class SuiRequestGetStakes
    extends SuiRequest<List<SuiApiDelegatedStake>, List<Map<String, dynamic>>> {
  const SuiRequestGetStakes(this.owner);
  final SuiAddress owner;

  @override
  String get method => 'suix_getStakes';

  @override
  List<dynamic> toJson() {
    return [owner.address];
  }

  @override
  List<SuiApiDelegatedStake> onResonse(List<Map<String, dynamic>> result) {
    return result.map((e) => SuiApiDelegatedStake.fromJson(e)).toList();
  }
}
