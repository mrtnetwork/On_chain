import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';

/// Submit a JSON payload with transaction CBOR and additional UTXO set to evaluate how much execution units it requires.
/// https://blockfrost.dev/api/submit-a-transaction-for-execution-units-evaluation-additional-utxo-set
class BlockfrostRequestSubmitATransactionForExecutionUnitsEvaluationAdditionalUTXOset
    extends BlockFrostPostRequest<dynamic, dynamic> {
  BlockfrostRequestSubmitATransactionForExecutionUnitsEvaluationAdditionalUTXOset(
      {required this.additionalUtxoSet,
      required List<int> transactionCborBytes})
      : transactionCborBytes = transactionCborBytes.asImmutableBytes;

  /// Additional UTXO as an array of tuples [TxIn, TxOut].
  /// See https://ogmios.dev/mini-protocols/local-tx-submission/#additional-utxo-set.
  final List<Map<String, dynamic>> additionalUtxoSet;

  /// Submit a transaction
  @override
  String get method => BlockfrostMethods
      .submitATransactionForExecutionUnitsEvaluationAdditionalUTXOset.url;

  @override
  List<String> get pathParameters => [];

  /// The transaction to submit, serialized in CBOR.
  List<int> transactionCborBytes;

  @override
  List<int> get body {
    final toString = StringUtils.fromJson({
      'cbor':
          StringUtils.decode(transactionCborBytes, type: StringEncoding.base64),
      'additionalUtxoSet': additionalUtxoSet,
    });
    return StringUtils.encode(toString);
  }
}
