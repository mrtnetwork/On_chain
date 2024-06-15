import 'package:blockchain_utils/utils/utils.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';

/// Submit an already serialized transaction to evaluate how much execution units it requires.
/// https://blockfrost.dev/api/submit-a-transaction-for-execution-units-evaluation
class BlockfrostRequestSubmitATransactionForExecutionUnitsEvaluation
    extends BlockforestPostRequestParam<List<Map<String, dynamic>>,
        Map<String, dynamic>> {
  BlockfrostRequestSubmitATransactionForExecutionUnitsEvaluation(
      List<int> transactionCborBytes)
      : transactionCborBytes = BytesUtils.toBytes(transactionCborBytes);

  /// Submit a transaction for execution units evaluation
  @override
  String get method =>
      BlockfrostMethods.submitATransactionForExecutionUnitsEvaluation.url;

  @override
  Map<String, String>? get header => {"Content-Type": "application/cbor"};

  final List<int> transactionCborBytes;

  @override
  List<String> get pathParameters => [];

  @override
  Object get body => transactionCborBytes;
}
