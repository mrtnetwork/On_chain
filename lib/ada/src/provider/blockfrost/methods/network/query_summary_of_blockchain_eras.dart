import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// Returns start and end of each era along with parameters that can vary between hard forks.
/// https://blockfrost.dev/api/query-summary-of-blockchain-eras
class BlockfrostRequestQuerySummaryOfBlockchainEras
    extends BlockforestRequestParam<List<ADABlockchainEraResponse>,
        List<Map<String, dynamic>>> {
  BlockfrostRequestQuerySummaryOfBlockchainEras();

  /// Query summary of blockchain eras
  @override
  String get method => BlockfrostMethods.querySummaryOfBlockchainEras.url;

  @override
  List<String> get pathParameters => [];

  @override
  List<ADABlockchainEraResponse> onResonse(List<Map<String, dynamic>> result) {
    return result.map((e) => ADABlockchainEraResponse.fromJson(e)).toList();
  }
}
