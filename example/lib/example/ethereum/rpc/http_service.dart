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
  Future<BaseServiceResponse> doRequest(EthereumRequestDetails params,
      {Duration? timeout}) async {
    final response = await client
        .post(params.encodeUrl(url),
            headers: params.headers, body: params.encodeBody())
        .timeout(timeout ?? defaultTimeOut);
    return params.toResponse(response.bodyBytes,
        statusCode: response.statusCode);
  }

  @override
  Future<BaseServiceSubscribtionResponse> doSubscribtionRequest(
      {required EthereumRequestDetails params,
      required BaseServiceSubscribtionRequest<dynamic, dynamic,
              BaseSubscribtionEvent<dynamic>, EthereumRequestDetails>
          request,
      Duration? timeout}) {
    throw UnimplementedError("Http request not supported.");
  }
}
