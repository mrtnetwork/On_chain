import 'package:blockchain_utils/binary/utils.dart';
import 'package:blockchain_utils/string/string.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';

/// Submit a JSON payload with transaction CBOR and additional UTXO set to evaluate how much execution units it requires.
/// https://blockfrost.dev/api/submit-a-transaction-for-execution-units-evaluation-additional-utxo-set
class BlockfrostRequestSubmitATransactionForExecutionUnitsEvaluationAdditionalUTXOset
    extends BlockforestPostRequestParam<dynamic, dynamic> {
  BlockfrostRequestSubmitATransactionForExecutionUnitsEvaluationAdditionalUTXOset(
      {required this.additionalUtxoSet,
      required List<int> transactionCborBytes})
      : transactionCborBytes = BytesUtils.toBytes(transactionCborBytes);

  /// Additional UTXO as an array of tuples [TxIn, TxOut].
  /// See https://ogmios.dev/mini-protocols/local-tx-submission/#additional-utxo-set.
  final List<Map<String, dynamic>> additionalUtxoSet;

  /// Submit a transaction
  @override
  String get method => BlockfrostMethods
      .submitATransactionForExecutionUnitsEvaluationAdditionalUTXOset.url;

  @override
  List<String> get pathParameters => [];

  @override
  Map<String, String>? get header => {"Content-Type": "application/json"};

  /// The transaction to submit, serialized in CBOR.
  List<int> transactionCborBytes;

  @override
  String get body => StringUtils.fromJson({
        "cbor": StringUtils.decode(transactionCborBytes, StringEncoding.base64),
        "additionalUtxoSet": additionalUtxoSet,
      });
}
