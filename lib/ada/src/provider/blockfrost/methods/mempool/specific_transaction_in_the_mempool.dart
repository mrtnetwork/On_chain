import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// Return content of the requested transaction.
/// https://blockfrost.dev/api/specific-transaction-in-the-mempool
class BlockfrostRequestSpecificTransactionInTheMempool
    extends BlockforestRequestParam<ADAMempoolTransactionResponse,
        Map<String, dynamic>> {
  BlockfrostRequestSpecificTransactionInTheMempool(this.hash);

  /// Hash of the requested transaction
  final String hash;

  /// Specific transaction in the mempool
  @override
  String get method => BlockfrostMethods.specificTransactionInTheMempool.url;

  @override
  List<String> get pathParameters => [hash];

  @override
  ADAMempoolTransactionResponse onResonse(Map<String, dynamic> result) {
    return ADAMempoolTransactionResponse.fromJson(result);
  }
}
