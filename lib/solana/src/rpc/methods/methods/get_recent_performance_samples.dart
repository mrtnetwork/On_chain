import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';

/// Returns a list of recent performance samples, in reverse slot order.
/// Performance samples are taken every 60 seconds and include the number of transactions and slots that occur in a given time window.
/// https://solana.com/docs/rpc/http/getrecentperformancesamples
class SolanaRequestGetRecentPerformanceSamples
    extends SolanaRequest<List<PerfSample>, List> {
  const SolanaRequestGetRecentPerformanceSamples({
    required this.limit,
  });

  /// getRecentPerformanceSamples
  @override
  String get method => SolanaRequestMethods.getRecentPerformanceSamples.value;

  /// number of samples to return (maximum 720)
  final int limit;

  @override
  List<dynamic> toJson() {
    return [limit];
  }

  @override
  List<PerfSample> onResonse(List result) {
    return result.map((e) => PerfSample.fromJson(e)).toList();
  }
}
