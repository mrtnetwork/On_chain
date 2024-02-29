import 'package:on_chain/solana/solana.dart';
import 'websocket_service_example.dart';

typedef OnRPCNotification = void Function(Map<String, dynamic> notification);
void main() async {
  void onAccountInfo(Map<String, dynamic> json) {
    /// handle account notification
  }

  Map<int, OnRPCNotification> handleNotifications = {};
  final websocket = await RPCWebSocketService.connect(
    "wss://api.devnet.solana.com",
    onEvents: (notification) {
      final int subscribeId = notification["subscription"];
      handleNotifications[subscribeId]?.call(notification["result"]);
    },
    onClose: (p0) {},
  );
  final rpc = SolanaRPC(websocket);
  final subscribeId = await rpc.request(const SolanaRPCAccountSubscribeInfo(
      account: SolAddress.unchecked(
          "527pWSWfeQGLM7SoyVXjCRkrSZBtDkH6ShEBJB3nUDkA")));
  handleNotifications[subscribeId] = onAccountInfo;
  await Future.delayed(const Duration(seconds: 100));
  final cancel = await rpc.request(SolanaRPCUnSubscribe(
      subscribeId: subscribeId,
      method: SolanaUnSubscribeRpcMethods.accountUnsubscribe));
  if (cancel) {
    handleNotifications.remove(subscribeId);
  }
}
