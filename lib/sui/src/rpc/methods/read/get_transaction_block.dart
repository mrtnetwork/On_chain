import 'package:on_chain/sui/src/rpc/core/core.dart';
import 'package:on_chain/sui/src/rpc/models/types/types.dart';

/// Return the transaction response object.
/// [sui documation](https://docs.sui.io/sui-api-ref#sui_gettransactionblock)
class SuiRequestGetTransactionBlock
    extends SuiRequest<SuiApiTransactionBlockResponse, Map<String, dynamic>> {
  const SuiRequestGetTransactionBlock(
      {required this.transactionDigest, this.options});

  /// The digest of the queried transaction
  final String transactionDigest;

  /// Options for specifying the content to be returned
  final SuiApiTransactionBlockResponseOptions? options;

  @override
  String get method => 'sui_getTransactionBlock';

  @override
  List<dynamic> toJson() {
    return [transactionDigest, options?.toJson()];
  }

  @override
  SuiApiTransactionBlockResponse onResonse(Map<String, dynamic> result) {
    return SuiApiTransactionBlockResponse.fromJson(result);
  }
}
