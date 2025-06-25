import 'package:on_chain/sui/src/address/address/address.dart';
import 'package:on_chain/sui/src/rpc/core/core.dart';
import 'package:on_chain/sui/src/rpc/models/types/types.dart';

/// Runs the transaction in dev-inspect mode. Which allows for nearly any transaction
/// (or Move call) with any arguments. Detailed results are provided, including
/// both the transaction effects and any return values.
/// [sui documation](https://docs.sui.io/sui-api-ref#sui_devinspecttransactionblock)
class SuiRequestDevInspectTransactionBlock
    extends SuiRequest<SuiApiDevInspectResult, Map<String, dynamic>> {
  const SuiRequestDevInspectTransactionBlock(
      {required this.sender,
      required this.txBytes,
      this.gasPrice,
      this.epoch,
      this.additionalArgs});

  final SuiAddress sender;

  /// BCS encoded TransactionKind(as opposed to TransactionData, which include gasBudget and gasPrice)
  final String txBytes;

  /// Gas is not charged, but gas usage is still calculated. Default to use reference gas price
  final String? gasPrice;

  /// The epoch to perform the call. Will be set from the system state object if not provided
  final String? epoch;

  /// Additional arguments including gas_budget, gas_objects, gas_sponsor and skip_checks.
  final SuiApiDevInspectArgs? additionalArgs;

  @override
  String get method => 'sui_devInspectTransactionBlock';

  @override
  List<dynamic> toJson() {
    return [sender.address, txBytes, gasPrice, epoch, additionalArgs?.toJson()];
  }

  @override
  SuiApiDevInspectResult onResonse(Map<String, dynamic> result) {
    return SuiApiDevInspectResult.fromJson(result);
  }
}
