import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';

/// History of your Blockfrost usage metrics in the past 30 days.
/// https://blockfrost.dev/api/blockfrost-usage-metrics
class BlockfrostRequestUsageMetrics extends BlockFrostRequest<
    List<Map<String, dynamic>>, List<Map<String, dynamic>>> {
  BlockfrostRequestUsageMetrics();

  /// Blockfrost usage metrics
  @override
  String get method => BlockfrostMethods.blockFrostUsageMetric.url;

  @override
  List<String> get pathParameters => [];
}
