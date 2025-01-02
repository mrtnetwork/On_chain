import 'package:blockchain_utils/service/models/params.dart';
import 'package:http/http.dart' as http;
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/service/service.dart';

class BlockFrostHTTPProvider implements BlockFrostServiceProvider {
  BlockFrostHTTPProvider(
      {required this.url,
      this.version = "v0",
      this.projectId,
      http.Client? client,
      this.defaultRequestTimeout = const Duration(seconds: 30)})
      : client = client ?? http.Client();

  final String url;
  final String version;
  final String? projectId;
  final http.Client client;
  final Duration defaultRequestTimeout;

  @override
  Future<BaseServiceResponse<T>> doRequest<T>(BlockFrostRequestDetails params,
      {Duration? timeout}) async {
    if (params.type == RequestServiceType.get) {
      final response =
          await client.get(params.toUri(url, version: version), headers: {
        'Content-Type': 'application/json',
        "Accept": "application/json",
        ...params.headers,
        if (projectId != null) ...{"project_id": projectId!},
      }).timeout(timeout ?? defaultRequestTimeout);
      return params.toResponse(response.bodyBytes, response.statusCode);
    }
    final response = await client
        .post(params.toUri(url, version: version),
            headers: {
              'Content-Type': 'application/json',
              "Accept": "application/json",
              ...params.headers,
              if (projectId != null) ...{"project_id": projectId!},
            },
            body: params.body())
        .timeout(timeout ?? defaultRequestTimeout);
    return params.toResponse(response.bodyBytes, response.statusCode);
  }
}
