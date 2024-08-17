void main() async {
//   /// WebSocket RPC Service
//   final websocketRpc = await RPCWebSocketService.connect(
//       "wss://go.getblock.io/b9c91d92aaeb4e5ba2d4cca664ab708c", onEvents: (p0) {
//     print("on event $p0");
//   }, onClose: (p0) {});
// // Establish a WebSocket RPC connection to the specified endpoint for real-time updates.

//   /// Ethereum RPC
//   final rpc = EVMRPC(websocketRpc);

//   final getblock = await rpc.request(RPCETHSubscribe());
//   print("block $getblock");
//   Timer.periodic(const Duration(seconds: 5), (s) async {
//     // final re = await rpc.request(RPCETHSubscribe());
//     // print("re $re");
//   });
//   print("get block $getblock");
//   final changed = await Future.delayed(const Duration(seconds: 60));
}
