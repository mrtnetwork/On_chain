// import 'dart:convert';

// import 'package:http/http.dart';
// import 'package:on_chain/solana/rpc/core/core.dart';
// import 'package:on_chain/solana/rpc/core/service.dart';
// import 'package:on_chain/solana/rpc/provider/provider.dart';

// import 'websoket.dart';

// SolanaProvider solanaRPC(String uri) {
//   final service = RPCHttpService(uri);
//   return SolanaProvider(service);
// }

// Future<SolanaProvider> solanaWebsocketRpc(String uri) async {
//   final websoclet = await RPCWebSocketService.connect(uri);
//   return SolanaProvider(websoclet);
// }
// // SolanaRPCWebSocketService

// class RPCHttpService with SolanaJSONRPCService {
//   RPCHttpService(this.url,
//       {Client? client, this.defaultTimeOut = const Duration(seconds: 30)})
//       : client = client ?? Client();

//   @override
//   final String url;
//   final Client client;
//   final Duration defaultTimeOut;
//   @override
//   Future<Map<String, dynamic>> call(SolanaRequestDetails params,
//       [Duration? timeout]) async {
//     final response = await client
//         .post(Uri.parse(url),
//             headers: {'Content-Type': 'application/json'},
//             body: params.toRequestBody())
//         .timeout(timeout ?? defaultTimeOut);
//     final data = json.decode(response.body) as Map<String, dynamic>;
//     return data;
//   }
// }
