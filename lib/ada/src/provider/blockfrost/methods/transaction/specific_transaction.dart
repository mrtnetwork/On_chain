import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// Return content of the requested transaction.
/// https://blockfrost.dev/api/specific-transaction
class BlockfrostRequestSpecificTransaction extends BlockFrostRequest<
    ADATransactionInfoResponse, Map<String, dynamic>> {
  BlockfrostRequestSpecificTransaction(this.hash);

  /// Hash of the requested transaction
  final String hash;

  /// Specific transaction
  @override
  String get method => BlockfrostMethods.specificTransaction.url;

  @override
  List<String> get pathParameters => [hash];

  @override
  ADATransactionInfoResponse onResonse(Map<String, dynamic> result) {
    return ADATransactionInfoResponse.fromJson(result);
  }
}
