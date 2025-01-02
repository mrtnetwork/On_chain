import 'package:blockchain_utils/service/models/params.dart';
import 'package:http/http.dart';
import 'package:on_chain/on_chain.dart';

class RPCHttpService with EthereumServiceProvider {
  RPCHttpService(this.url,
      {Client? client, this.defaultTimeOut = const Duration(seconds: 30)})
      : client = client ?? Client();

  final String url;
  final Client client;
  final Duration defaultTimeOut;
  @override
  Future<BaseServiceResponse<T>> doRequest<T>(EthereumRequestDetails params,
      {Duration? timeout}) async {
    final response = await client
        .post(params.toUri(url), headers: params.headers, body: params.body())
        .timeout(timeout ?? defaultTimeOut);
    return params.toResponse(response.bodyBytes, response.statusCode);
  }
}
