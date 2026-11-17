import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:http/http.dart' show Client;
import 'package:on_chain/near/near.dart';

NearQuickClient nearClient(String uri) {
  final service = NearHttpService(uri);
  return DefaultNearQuickClient(NearProvider(service));
}

class NearHttpService with NearServiceProvider {
  NearHttpService(
    this.url, {
    Client? client,
    this.defaultTimeOut = const Duration(minutes: 5),
  }) : client = client ?? Client();

  final String url;
  final Client client;
  final Duration defaultTimeOut;
  @override
  Future<BaseServiceResponse> doRequest(
    NearRequestDetails params, {
    Duration? timeout,
  }) async {
    final response = await client
        .post(
          params.encodeUrl(url),
          headers: params.headers,
          body: params.encodeBody(),
        )
        .timeout(timeout ?? defaultTimeOut);
    return params.toResponse(
      response.bodyBytes,
      statusCode: response.statusCode,
    );
  }
}
