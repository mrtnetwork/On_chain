import 'package:on_chain/sui/src/rpc/core/core.dart';
import 'package:on_chain/sui/src/rpc/models/types/types.dart';

/// Execute the transaction and wait for results if desired.
/// Request types: 1. WaitForEffectsCert: waits for TransactionEffectsCert
/// and then return to client. This mode is a proxy for transaction finality.
/// 2. WaitForLocalExecution: waits for TransactionEffectsCert and make sure
/// the node executed the transaction locally before returning the client.
/// The local execution makes sure this node is aware of this transaction
/// when client fires subsequent queries. However if the node fails to execute
/// the transaction locally in a timely manner, a bool type in the response is
/// set to false to indicated the case. request_type is default to be WaitForEffectsCert
/// unless options.show_events or options.show_effects is true
/// [sui documation](https://docs.sui.io/sui-api-ref#sui_executetransactionblock)
class SuiRequestExecuteTransactionBlock
    extends SuiRequest<SuiApiTransactionBlockResponse, Map<String, dynamic>> {
  const SuiRequestExecuteTransactionBlock(
      {required this.txBytes,
      required this.signatures,
      this.options,
      this.type});

  /// A list of signatures (flag || signature || pubkey bytes, as base-64 encoded string).
  /// Signature is committed to the intent message of the transaction data, as base-64 encoded string.
  final List<String> signatures;

  /// BCS serialized transaction data bytes without its type tag, as base-64 encoded string.
  final String txBytes;

  /// Options for specifying the content to be returned
  final SuiApiTransactionBlockResponseOptions? options;

  /// The request type, derived from SuiApiTransactionBlockResponseOptions if None
  final SuiApiExecuteTransactionRequestType? type;

  @override
  String get method => 'sui_executeTransactionBlock';

  @override
  List<dynamic> toJson() {
    return [txBytes, signatures, options?.toJson(), type?.name];
  }

  @override
  SuiApiTransactionBlockResponse onResonse(Map<String, dynamic> result) {
    return SuiApiTransactionBlockResponse.fromJson(result);
  }
}
