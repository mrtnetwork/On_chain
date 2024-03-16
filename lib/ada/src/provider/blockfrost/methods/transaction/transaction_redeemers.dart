import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// Obtain the transaction redeemers.
/// qhttps://blockfrost.dev/api/transaction-redeemers
class BlockfrostRequestTransactionRedeemers extends BlockforestRequestParam<
    List<ADATransactionRedeemerResponse>, List<Map<String, dynamic>>> {
  BlockfrostRequestTransactionRedeemers(this.hash);

  /// Hash of the requested transaction
  final String hash;

  /// Transaction redeemers
  @override
  String get method => BlockfrostMethods.transactionRedeemers.url;

  @override
  List<String> get pathParameters => [hash];

  @override
  List<ADATransactionRedeemerResponse> onResonse(
      List<Map<String, dynamic>> result) {
    return result
        .map((e) => ADATransactionRedeemerResponse.fromJson(e))
        .toList();
  }
}
