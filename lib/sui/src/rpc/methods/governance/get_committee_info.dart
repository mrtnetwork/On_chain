import 'package:on_chain/sui/src/rpc/core/core.dart';
import 'package:on_chain/sui/src/rpc/models/types/types.dart';

/// Return the committee information for the asked epoch.
/// [sui documation](https://docs.sui.io/sui-api-ref#suix_getcommitteeinfo)
class SuiRequestGetCommitteeInfo
    extends SuiRequest<SuiApiCommitteeInfo, Map<String, dynamic>> {
  const SuiRequestGetCommitteeInfo({this.epoch});

  /// The epoch of interest. If None, default to the latest epoch
  final String? epoch;
  @override
  String get method => 'suix_getCommitteeInfo';

  @override
  List<dynamic> toJson() {
    return [epoch];
  }

  @override
  SuiApiCommitteeInfo onResonse(Map<String, dynamic> result) {
    return SuiApiCommitteeInfo.fromJson(result);
  }
}
