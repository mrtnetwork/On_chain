import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';

/// History of your Blockfrost usage metrics per endpoint in the past 30 days.
/// https://blockfrost.dev/api/blockfrost-endpoint-usage-metrics
class BlockfrostRequestEndpointUsageMetrics extends BlockforestRequestParam<
    List<Map<String, dynamic>>, List<Map<String, dynamic>>> {
  BlockfrostRequestEndpointUsageMetrics();

  /// Blockfrost endpoint usage metrics
  @override
  String get method => BlockfrostMethods.blockFrostEndpointUsageMetrics.url;

  @override
  List<String> get pathParameters => [];
}
