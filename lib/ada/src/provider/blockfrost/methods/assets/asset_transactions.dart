import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// List of a specific asset transactions.
/// https://blockfrost.dev/api/asset-transactions
class BlockfrostRequestAssetTransactions extends BlockforestRequestParam<
    List<ADATransactionSummaryInfoResponse>, List<Map<String, dynamic>>> {
  BlockfrostRequestAssetTransactions(this.asset,
      {BlockforestRequestFilterParams? filter});

  /// Concatenation of the policy_id and hex-encoded asset_name
  final String asset;

  /// Asset transactions
  @override
  String get method => BlockfrostMethods.assetTransactions.url;

  @override
  List<String> get pathParameters => [asset];

  @override
  List<ADATransactionSummaryInfoResponse> onResonse(List<Map<String, dynamic>> result) {
    return result.map((e) => ADATransactionSummaryInfoResponse.fromJson(e)).toList();
  }
}
