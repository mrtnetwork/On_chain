import 'package:on_chain/solana/src/rpc/core/rpc.dart';

/// Subscribe to receive a notification from the validator on a variety of updates on every slot.
/// https://solana.com/docs/rpc/websocket/slotsupdatessubscribe
class SolanaRPCSlotsUpdatesSubscribe extends SolanaRPCRequest<int> {
  const SolanaRPCSlotsUpdatesSubscribe();

  /// slotsUpdatesSubscribe
  @override
  String get method => SolanaSubscribeRpcMethods.slotsUpdatesSubscribe.value;
  @override
  List<dynamic> toJson() {
    return [];
  }

  @override
  int onResonse(result) {
    return result;
  }
}
