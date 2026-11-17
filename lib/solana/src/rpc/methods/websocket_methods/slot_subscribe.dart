import 'package:on_chain/solana/src/rpc/core/rpc.dart';

/// Subscribe to receive notification anytime a slot is processed by the validator.
/// https://solana.com/docs/rpc/websocket/slotsubscribe
class SolanaRequestSlotSubscribe extends SolanaRequest<int, int> {
  const SolanaRequestSlotSubscribe();

  /// rootSubscribe
  @override
  String get method => SolanaSubscribeRpcMethods.slotSubscribe.value;
  @override
  List<dynamic> toJson() {
    return [];
  }
}
