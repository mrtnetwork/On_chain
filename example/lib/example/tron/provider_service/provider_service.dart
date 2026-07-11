import 'package:http/http.dart' as http;
import 'package:on_chain/tron/tron.dart';

class TronHTTPProvider with TronServiceProvider {
  TronHTTPProvider(
      {required this.url,
      http.Client? client,
      this.defaultRequestTimeout = const Duration(seconds: 30)})
      : client = client ?? http.Client();

  final String url;
  final http.Client client;
  final Duration defaultRequestTimeout;

  @override
  Future<TronServiceResponse> doRequest(TronRequestDetails params,
      {Duration? timeout}) async {
    if (params.requestMethod.isPost) {
      final response = await client
          .post(params.encodeUrl(url),
              headers: params.headers, body: params.encodeBody())
          .timeout(timeout ?? defaultRequestTimeout);
      return params.toResponse(response.bodyBytes,
          statusCode: response.statusCode);
    }
    final response = await client
        .get(params.encodeUrl(url), headers: params.headers)
        .timeout(timeout ?? defaultRequestTimeout);
    return params.toResponse(response.bodyBytes,
        statusCode: response.statusCode);
  }
}
