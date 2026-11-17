import 'dart:io';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:http/io_client.dart';
import 'package:on_chain/tezos/tezos.dart';

/// JSON-RPC transport for a Tezos node (shell + protocol RPCs).
OctezProvider octezProvider({
  required String url,
  String? proxy,
  Duration timeout = const Duration(minutes: 5),
}) {
  return OctezProvider(TezosHttpService(url, proxy: proxy, timeout: timeout));
}

class TezosHttpService with OctezServiceProvider {
  TezosHttpService(
    this.url, {
    this.proxy,
    this.timeout = const Duration(minutes: 5),
  });

  final String url;
  final String? proxy;
  final Duration timeout;

  @override
  Future<BaseServiceResponse> doRequest(
    BaseOctezServiceRequestParams params, {
    Duration? timeout,
  }) async {
    final httpClient = HttpClient();
    final proxy = this.proxy;
    if (proxy != null) {
      httpClient.findProxy = (uri) => 'PROXY $proxy';
    }
    final client = IOClient(httpClient);
    try {
      final uri = params.encodeUrl(url);
      final response = switch (params.requestMethod) {
        RequestMethod.get => await client
            .get(uri, headers: params.headers)
            .timeout(timeout ?? this.timeout),
        _ => await client
            .post(uri, headers: params.headers, body: params.encodeBody())
            .timeout(timeout ?? this.timeout),
      };
      return params.toResponse(
        response.bodyBytes,
        statusCode: response.statusCode,
      );
    } finally {
      client.close();
    }
  }
}