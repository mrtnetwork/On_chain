import 'package:blockchain_utils/service/models/params.dart';
import 'package:http/http.dart';
import 'package:on_chain/solana/solana.dart';

SolanaProvider solanaRPC(String uri) {
  final service = RPCHttpService(uri);
  return SolanaProvider(service);
}

class RPCHttpService with SolanaServiceProvider {
  RPCHttpService(this.url,
      {Client? client, this.defaultTimeOut = const Duration(seconds: 30)})
      : client = client ?? Client();

  final String url;
  final Client client;
  final Duration defaultTimeOut;
  @override
  Future<BaseServiceResponse<T>> doRequest<T>(SolanaRequestDetails params,
      {Duration? timeout}) async {
    final response = await client
        .post(params.toUri(url), headers: params.headers, body: params.body())
        .timeout(timeout ?? defaultTimeOut);
    return params.toResponse(response.bodyBytes, response.statusCode);
  }
}
