import 'package:on_chain/sui/src/rpc/core/core.dart';
import 'package:on_chain/sui/src/rpc/models/types/types.dart';

/// Return the latest SUI system state object on-chain.
/// [sui documation](https://docs.sui.io/sui-api-ref#suix_getlatestsuisystemstate)
class SuiRequestGetLatestSuiSystemState
    extends SuiRequest<SuiApiSystemStateSummary, Map<String, dynamic>> {
  const SuiRequestGetLatestSuiSystemState();

  @override
  String get method => 'suix_getLatestSuiSystemState';

  @override
  List<dynamic> toJson() {
    return [];
  }

  @override
  SuiApiSystemStateSummary onResonse(Map<String, dynamic> result) {
    return SuiApiSystemStateSummary.fromJson(result);
  }
}
