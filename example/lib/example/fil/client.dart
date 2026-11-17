import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:http/http.dart';
import 'package:on_chain/fil/src/rpc/core/core.dart';
import 'package:on_chain/fil/src/rpc/provider/provider.dart';
import 'package:on_chain/fil/src/rpc/service/service.dart';

LotusProvider lotusClient({
  String url = "https://api.calibration.node.glif.io/rpc/v1",
  String? token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJBbGxvdyI6WyJyZWFkIiwid3JpdGUiLCJzaWduIiwiYWRtaW4iXX0.WDgX-X_yRzwLGCxCYgUlmyh70MCMtP6cHS7wpQNBqrA",
}) =>
    LotusProvider(ICPHttpService(url, token: null));

class ICPHttpService with LotusServiceProvider {
  ICPHttpService(
    this.url, {
    Client? client,
    this.token,
    this.defaultTimeOut = const Duration(minutes: 5),
  }) : client = client ?? Client();

  final String url;
  final Client client;
  final Duration defaultTimeOut;
  final String? token;
  @override
  Future<BaseServiceResponse> doRequest(
    LotusFullNodeRequestDetails params, {
    Duration? timeout,
  }) async {
    final headers = Map<String, String>.from(params.headers);
    if (token != null) {
      headers["Authorization"] = "Bearer $token";
    }
    final response = switch (params.requestMethod) {
      RequestMethod.get => await client
          .get(params.encodeUrl(url), headers: headers)
          .timeout(timeout ?? defaultTimeOut),
      _ => await client
          .post(
            params.encodeUrl(url),
            headers: headers,
            body: params.encodeBody(),
          )
          .timeout(timeout ?? defaultTimeOut),
    };
    if (response.statusCode > 299) {
      print(
        "err! ${params.requestMethod} ${response.statusCode} ${params.encodeUrl(url)} ${response.body}",
      );
    }
    return params.toResponse(
      response.bodyBytes,
      statusCode: response.statusCode,
    );
  }
}
