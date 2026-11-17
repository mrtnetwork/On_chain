import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:http/http.dart';
import 'package:on_chain/icp/src/rpc/core/core.dart';
import 'package:on_chain/icp/src/rpc/provider/provider.dart';
import 'package:on_chain/icp/src/rpc/service/service.dart';

ICPProvider icpClient({String url = "http://127.0.0.1:8000"}) =>
    ICPProvider(ICPHttpService(url));

class ICPHttpService with ICPServiceProvider {
  ICPHttpService(
    this.url, {
    Client? client,
    this.defaultTimeOut = const Duration(minutes: 5),
  }) : client = client ?? Client();

  final String url;
  final Client client;
  final Duration defaultTimeOut;
  @override
  Future<BaseServiceResponse> doRequest(
    ICPRequestDetails params, {
    Duration? timeout,
  }) async {
    final response = switch (params.requestMethod) {
      RequestMethod.get => await client
          .get(params.encodeUrl(url), headers: params.headers)
          .timeout(timeout ?? defaultTimeOut),
      _ => await client
          .post(
            params.encodeUrl(url),
            headers: params.headers,
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
