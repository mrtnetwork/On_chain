import 'package:on_chain/sui/src/rpc/core/core.dart';
import 'package:on_chain/sui/src/rpc/models/types/types.dart';

/// Return one or more [DelegatedStake]. If a Stake was withdrawn its status will be Unstaked.
/// [sui documation](https://docs.sui.io/sui-api-ref#suix_getstakesbyids)
class SuiRequestGetStakesByIds
    extends SuiRequest<List<SuiApiDelegatedStake>, List<Map<String, dynamic>>> {
  const SuiRequestGetStakesByIds(this.stakedSuiIds);
  final List<String> stakedSuiIds;

  @override
  String get method => 'suix_getStakesByIds';

  @override
  List<dynamic> toJson() {
    return [stakedSuiIds];
  }

  @override
  List<SuiApiDelegatedStake> onResonse(List<Map<String, dynamic>> result) {
    return result.map((e) => SuiApiDelegatedStake.fromJson(e)).toList();
  }
}
