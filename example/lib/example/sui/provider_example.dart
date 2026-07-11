import 'package:http/http.dart';
import 'package:on_chain/on_chain.dart';

class SuiHttpService with SuiServiceProvider {
  SuiHttpService(this.url,
      {Client? client, this.defaultTimeOut = const Duration(seconds: 30)})
      : client = client ?? Client();
  final String url;
  final Client client;
  final Duration defaultTimeOut;
  @override
  Future<SuiServiceResponse> doRequest(SuiRequestDetails params,
      {Duration? timeout}) async {
    final response = await client
        .post(params.encodeUrl(url),
            headers: params.headers, body: params.encodeBody())
        .timeout(timeout ?? defaultTimeOut);
    return params.toResponse(response.bodyBytes,
        statusCode: response.statusCode);
  }
}
