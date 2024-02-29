import 'package:on_chain/solana/src/rpc/core/rpc.dart';

/// Subscribe to receive notification anytime a new root is set by the validator.
/// https://solana.com/docs/rpc/websocket/rootSubscribe
class SolanaRPCProgramSubscribe extends SolanaRPCRequest<int> {
  const SolanaRPCProgramSubscribe();

  /// rootSubscribe
  @override
  String get method => SolanaSubscribeRpcMethods.rootSubscribe.value;
  @override
  List<dynamic> toJson() {
    return [];
  }

  @override
  int onResonse(result) {
    return result;
  }
}
