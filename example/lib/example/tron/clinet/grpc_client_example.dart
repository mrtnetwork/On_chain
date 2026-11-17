import 'dart:async';
import 'dart:io';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:grpc/grpc.dart';
import 'package:on_chain/tron/tron.dart';
import 'client.dart'
    if (dart.library.io) 'grpc_native_client.dart'
    if (dart.library.js_interop) 'grpc_web_client.dart';
import 'package:http/io_client.dart';

DefaultTronQuickClient getClient({
  String? rpcUrl,
  String? grpcUrl = 'grpc.trongrid.io',
  int grpcPort = 50051,
  bool? grpcTls,
  String? proxy,
}) {
  return tronClient(
    grpcPort: grpcPort,
    grpcUrl: grpcUrl,
    fullnodeUrl: rpcUrl,
    tls: grpcTls,
    proxy: proxy,
  );
}

class TronGrpcClient extends Client {
  TronGrpcClient(super.channel);

  static ClientMethod<TronGrpcRequestDetails, List<int>> buildMethod(
    TronGrpcRequestDetails params,
  ) {
    return ClientMethod<TronGrpcRequestDetails, List<int>>(
      params.method(),
      (value) => value.toBuffer(),
      (value) => value,
    );
  }

  Future<List<int>> doGrpcRequest(
    TronGrpcRequestDetails params, {
    Duration? timeout,
  }) async {
    final method = buildMethod(params);

    final request = $createUnaryCall(
      method,
      params,
      options: CallOptions(timeout: timeout),
    );

    return await request;
  }

  Stream<List<int>> doGrpcRequestStream(
    TronGrpcRequestDetails params, {
    Duration? timeout,
  }) {
    final method = buildMethod(params);

    return $createStreamingCall(method, () async* {
      /// walletd streaming APIs expect an initial request message
      yield params;
    }(), options: CallOptions(timeout: timeout));
  }

  Future<Stream<List<int>>> doGrpcRequestStreamAsync(
    TronGrpcRequestDetails params, {
    Duration? timeout,
  }) async {
    return doGrpcRequestStream(params);
  }
}

class TronExampleProvider with TronServiceProvider {
  final TronGrpcClient? grpc;
  final String? rpcUrl;
  final String? proxy;

  TronExampleProvider({
    this.rpcUrl,
    this.grpc,
    this.proxy,
    this.defaultRequestTimeout = const Duration(seconds: 30),
  });

  // final http.Client client;
  final Duration defaultRequestTimeout;

  String getUrl(TronFullNodeRequestDetails params) {
    switch (params.api) {
      case TronProviderApi.fullnode:
        final url = rpcUrl;
        if (url == null) throw Exception("Missing rpc url");
        return url;
      default:
        throw Exception("Unexpected request api. ${params.api.name}");
    }
  }

  @override
  Future<BaseServiceResponse> doRequest(
    TronFullNodeRequestDetails params, {
    Duration? timeout,
  }) async {
    final uri = params.encodeUrl(getUrl(params));

    final httpClient = HttpClient();
    final proxy = this.proxy;
    if (proxy != null) {
      httpClient.findProxy = (uri) {
        return proxy;
      };
    }
    final client = IOClient(httpClient);
    try {
      if (params.requestMethod.isPost) {
        final response = await client
            .post(uri, headers: params.headers, body: params.encodeBody())
            .timeout(timeout ?? defaultRequestTimeout);
        return params.toResponse(
          response.bodyBytes,
          statusCode: response.statusCode,
        );
      }
      final response = await client.get(uri, headers: {
        ...params.headers
      }).timeout(timeout ?? defaultRequestTimeout);
      return params.toResponse(
        response.bodyBytes,
        statusCode: response.statusCode,
      );
    } finally {
      client.close();
    }
  }

  TronGrpcClient getGrpc() {
    final grpc = this.grpc;
    if (grpc == null) {
      throw Exception("Missing grpc client.");
    }
    return grpc;
  }

  @override
  Future<List<int>> doGrpcRequest(
    TronGrpcRequestDetails params, {
    Duration? timeout,
  }) async {
    try {
      return await getGrpc().doGrpcRequest(params, timeout: timeout);
    } on GrpcError catch (e) {
      throw RPCError(message: e.message ?? e.toString(), errorCode: e.code);
    }
  }

  @override
  Stream<List<int>> doGrpcRequestStream(
    TronGrpcRequestDetails params, {
    Duration? timeout,
  }) {
    try {
      return getGrpc().doGrpcRequestStream(params, timeout: timeout);
    } on GrpcError catch (e) {
      throw RPCError(message: e.message ?? e.toString(), errorCode: e.code);
    }
  }

  @override
  Future<Stream<List<int>>> doGrpcRequestStreamAsync(
    TronGrpcRequestDetails params, {
    Duration? timeout,
  }) {
    try {
      return getGrpc().doGrpcRequestStreamAsync(params, timeout: timeout);
    } on GrpcError catch (e) {
      throw RPCError(message: e.message ?? e.toString(), errorCode: e.code);
    }
  }
}
