import 'package:on_chain/solana/src/rpc/core/rpc.dart';

/// Subscribe to receive notification anytime a new root is set by the validator.
/// https://solana.com/docs/rpc/websocket/rootSubscribe
class SolanaRequestProgramSubscribe extends SolanaRequest<int, int> {
  const SolanaRequestProgramSubscribe();

  /// rootSubscribe
  @override
  String get method => SolanaSubscribeRpcMethods.rootSubscribe.value;
  @override
  List<dynamic> toJson() {
    return [];
  }
}
