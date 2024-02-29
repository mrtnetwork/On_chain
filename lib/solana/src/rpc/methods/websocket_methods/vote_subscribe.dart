import 'package:on_chain/solana/src/rpc/core/rpc.dart';

/// Subscribe to receive notification anytime a new vote is observed in gossip.
/// These votes are pre-consensus therefore there is no guarantee these votes will enter the ledger.
/// https://solana.com/docs/rpc/websocket/votesubscribe
class SolanaRPCVoteSubscribe extends SolanaRPCRequest<int> {
  const SolanaRPCVoteSubscribe();

  /// slotsUpdatesSubscribe
  @override
  String get method => SolanaSubscribeRpcMethods.voteSubscribe.value;
  @override
  List<dynamic> toJson() {
    return [];
  }

  @override
  int onResonse(result) {
    return result;
  }
}
