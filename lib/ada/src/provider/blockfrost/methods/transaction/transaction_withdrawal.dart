import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// Obtain information about withdrawals of a specific transaction.
/// https://blockfrost.dev/api/transaction-withdrawal
class BlockfrostRequestTransactionWithdrawal extends BlockforestRequestParam<
    List<ADATransactionWithdrawalResponse>, List<Map<String, dynamic>>> {
  BlockfrostRequestTransactionWithdrawal(this.hash);

  /// Hash of the requested transaction
  final String hash;

  /// Transaction withdrawal
  @override
  String get method => BlockfrostMethods.transactionWithdrawal.url;

  @override
  List<String> get pathParameters => [hash];

  @override
  List<ADATransactionWithdrawalResponse> onResonse(
      List<Map<String, dynamic>> result) {
    return result
        .map((e) => ADATransactionWithdrawalResponse.fromJson(e))
        .toList();
  }
}
