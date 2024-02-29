import 'package:on_chain/solana/src/rpc/core/rpc.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';
import 'package:on_chain/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Subscribe to transaction logging.
/// https://solana.com/docs/rpc/websocket/logssubscribe
class SolanaRPClogsSubscribe extends SolanaRPCRequest<int> {
  const SolanaRPClogsSubscribe({required this.filter, Commitment? commitment})
      : super(commitment: commitment);

  /// blockSubscribe
  @override
  String get method => SolanaSubscribeRpcMethods.logsSubscribe.value;

  /// filter criteria for the logs to receive results by account type
  final SubscribeTransactionLogsFilter filter;

  @override
  List<dynamic> toJson() {
    return [
      filter.toJson(),
      SolanaRPCUtils.createConfig([
        commitment?.toJson(),
      ])
    ];
  }

  @override
  int onResonse(result) {
    return result;
  }
}
