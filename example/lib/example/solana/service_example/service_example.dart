import 'dart:convert';

import 'package:http/http.dart';
import 'package:on_chain/solana/solana.dart';

SolanaRPC solanaRPC(String uri) {
  final service = RPCHttpService(uri);
  return SolanaRPC(service);
}

class RPCHttpService with SolanaJSONRPCService {
  RPCHttpService(this.url,
      {Client? client, this.defaultTimeOut = const Duration(seconds: 30)})
      : client = client ?? Client();

  @override
  final String url;
  final Client client;
  final Duration defaultTimeOut;
  @override
  Future<Map<String, dynamic>> call(SolanaRequestDetails params,
      [Duration? timeout]) async {
    final response = await client
        .post(Uri.parse(url),
            headers: {'Content-Type': 'application/json'},
            body: params.toRequestBody())
        .timeout(timeout ?? defaultTimeOut);
    final data = json.decode(response.body) as Map<String, dynamic>;
    return data;
  }
}
