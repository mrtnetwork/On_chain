import 'package:on_chain/solana/src/rpc/core/rpc.dart';

/// Subscribe to receive notification anytime a slot is processed by the validator.
/// https://solana.com/docs/rpc/websocket/slotsubscribe
class SolanaRPCSlotSubscribe extends SolanaRPCRequest<int> {
  const SolanaRPCSlotSubscribe();

  /// rootSubscribe
  @override
  String get method => SolanaSubscribeRpcMethods.slotSubscribe.value;
  @override
  List<dynamic> toJson() {
    return [];
  }

  @override
  int onResonse(result) {
    return result;
  }
}
