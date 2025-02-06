import 'package:http/http.dart';
import 'package:on_chain/on_chain.dart';

class SuiHttpService implements SuiServiceProvider {
  SuiHttpService(this.url,
      {Client? client, this.defaultTimeOut = const Duration(seconds: 30)})
      : client = client ?? Client();
  final String url;
  final Client client;
  final Duration defaultTimeOut;
  @override
  Future<SuiServiceResponse<T>> doRequest<T>(SuiRequestDetails params,
      {Duration? timeout}) async {
    final response = await client
        .post(params.toUri(url), headers: params.headers, body: params.body())
        .timeout(timeout ?? defaultTimeOut);
    return params.parseResponse(response.bodyBytes, response.statusCode);
  }
}
