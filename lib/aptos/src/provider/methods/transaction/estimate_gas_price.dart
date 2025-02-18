import 'package:on_chain/aptos/src/provider/methods/methods/methods.dart';
import 'package:on_chain/aptos/src/provider/core/core.dart';
import 'package:on_chain/aptos/src/provider/models/fullnode/types.dart';

/// Gives an estimate of the gas unit price required to get a transaction on chain in areasonable amount of time.
/// The gas unit price is the amount that each transaction commits topay for each unit of gas consumed in
/// executing the transaction. The estimate is based onrecent history: it gives the minimum gas
/// that would have been required to get into recentblocks, for blocks that were full.
/// (When blocks are not full, the estimate will match theminimum gas unit price.)
/// The estimation is given in three values: de-prioritized (low), regular, and prioritized(aggressive).
/// Using a more aggressive value increases the likelihood that the transactionwill make it into the next block;
/// more aggressive values are computed with a larger historyand higher percentile statistics.
/// More details are in AIP-34.
/// [aptos documation](https://aptos.dev/en/build/apis/fullnode-rest-api-reference)
class AptosRequestEstimateGasPrice
    extends AptosRequest<AptosApiGasEstimation, Map<String, dynamic>> {
  @override
  String get method => AptosApiMethod.estimateGasPrice.url;

  @override
  AptosApiGasEstimation onResonse(Map<String, dynamic> result) {
    return AptosApiGasEstimation.fromJson(result);
  }
}
