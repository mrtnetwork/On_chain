import 'package:on_chain/sui/src/rpc/core/core.dart';
import 'package:on_chain/sui/src/rpc/models/types/types.dart';

/// Return transaction execution effects including the gas cost summary, while the effects are not committed to the chain.
/// [sui documation](https://docs.sui.io/sui-api-ref#sui_dryruntransactionblock)
class SuiRequestDryRunTransactionBlock extends SuiRequest<
    SuiApiDryRunTransactionBlockResponse, Map<String, dynamic>> {
  const SuiRequestDryRunTransactionBlock({required this.txBytes});
  final String txBytes;

  @override
  String get method => 'sui_dryRunTransactionBlock';

  @override
  List<dynamic> toJson() {
    return [txBytes];
  }

  @override
  SuiApiDryRunTransactionBlockResponse onResonse(Map<String, dynamic> result) {
    return SuiApiDryRunTransactionBlockResponse.fromJson(result);
  }
}
