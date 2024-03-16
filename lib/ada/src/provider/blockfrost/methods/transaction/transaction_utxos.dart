import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// Return the inputs and UTXOs of the specific transaction.
/// https://blockfrost.dev/api/transaction-utx-os
class BlockfrostRequestTransactionUTXOs extends BlockforestRequestParam<
    ADATransactionUTXOSResponse, Map<String, dynamic>> {
  BlockfrostRequestTransactionUTXOs(this.hash);

  /// Hash of the requested transaction
  final String hash;

  /// Transaction UTXOs
  @override
  String get method => BlockfrostMethods.transactionUTXOs.url;

  @override
  List<String> get pathParameters => [hash];

  @override
  ADATransactionUTXOSResponse onResonse(Map<String, dynamic> result) {
    return ADATransactionUTXOSResponse.fromJson(result);
  }
}
