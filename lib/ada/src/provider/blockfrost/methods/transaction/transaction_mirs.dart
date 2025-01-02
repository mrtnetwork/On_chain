import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// Obtain information about Move Instantaneous Rewards (MIRs) of a specific transaction.
/// https://blockfrost.dev/api/transaction-mi-rs
class BlockfrostRequestTransactionMIRs extends BlockFrostRequest<
    List<ADATransactionMIRResponse>, List<Map<String, dynamic>>> {
  BlockfrostRequestTransactionMIRs(this.hash);

  /// Hash of the requested transaction
  final String hash;

  /// Transaction MIRs
  @override
  String get method => BlockfrostMethods.transactionMIRs.url;

  @override
  List<String> get pathParameters => [hash];

  @override
  List<ADATransactionMIRResponse> onResonse(List<Map<String, dynamic>> result) {
    return result.map((e) => ADATransactionMIRResponse.fromJson(e)).toList();
  }
}
