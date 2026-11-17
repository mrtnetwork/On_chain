import 'dart:io';

import 'package:grpc/grpc.dart';
import 'package:http/io_client.dart';
import 'package:on_chain/hedera/src/rpc/rpc.dart';

/// Minimal Hedera transport used by the examples.
///
/// Mirror REST (account / token / topic / transaction lookups) and the HAPI
/// gRPC endpoint (queries, transaction submit) are both required. The mirror
/// is optional only for examples that never read state; the client itself
/// always needs the gRPC channel to submit.
class HederaGrpcClient extends Client {
  HederaGrpcClient(super.channel);

  static ClientMethod<HederaGrpcRequestDetails, List<int>> _method(
    HederaGrpcRequestDetails params,
  ) {
    return ClientMethod<HederaGrpcRequestDetails, List<int>>(
      params.method(),
      (value) => value.toBuffer(),
      (value) => value,
    );
  }

  Future<List<int>> doGrpcRequest(
    HederaGrpcRequestDetails params, {
    Duration? timeout,
  }) {
    return $createUnaryCall(
      _method(params),
      params,
      options: CallOptions(timeout: timeout),
    );
  }

  Stream<List<int>> doGrpcRequestStream(
    HederaGrpcRequestDetails params, {
    Duration? timeout,
  }) {
    return $createStreamingCall(
      _method(params),
      () async* {
        yield params;
      }(),
      options: CallOptions(timeout: timeout),
    );
  }

  Future<Stream<List<int>>> doGrpcRequestStreamAsync(
    HederaGrpcRequestDetails params, {
    Duration? timeout,
  }) async {
    return doGrpcRequestStream(params, timeout: timeout);
  }
}

class HederaExampleProvider with HederaServiceProvider {
  HederaExampleProvider({
    this.rpcUrl,
    this.grpc,
    this.proxy,
    this.timeout = const Duration(seconds: 30),
  });

  final String? rpcUrl;
  final HederaGrpcClient? grpc;

  /// Optional HTTP proxy (`host:port`) for the mirror REST endpoint.
  final String? proxy;
  final Duration timeout;

  @override
  Future<HederaServiceResponse> doRequest(
    HederaMirrorRequestDetails params, {
    Duration? timeout,
  }) async {
    final rpcUrl = this.rpcUrl;
    if (rpcUrl == null) {
      throw StateError('Missing mirror rpc url.');
    }
    final httpClient = HttpClient();
    final proxy = this.proxy;
    if (proxy != null) {
      httpClient.findProxy = (uri) => 'PROXY $proxy';
    }
    final client = IOClient(httpClient);
    try {
      final uri = params.encodeUrl(rpcUrl);
      if (params.requestMethod.isPost) {
        final response = await client
            .post(uri, headers: params.headers, body: params.encodeBody())
            .timeout(timeout ?? this.timeout);
        return params.toResponse(
          response.bodyBytes,
          statusCode: response.statusCode,
        );
      }
      final response = await client.get(uri,
          headers: {...params.headers}).timeout(timeout ?? this.timeout);
      return params.toResponse(
        response.bodyBytes,
        statusCode: response.statusCode,
      );
    } finally {
      client.close();
    }
  }

  HederaGrpcClient _grpc() {
    final grpc = this.grpc;
    if (grpc == null) {
      throw StateError('Missing gRPC channel.');
    }
    return grpc;
  }

  @override
  Future<List<int>> doGrpcRequest(
    HederaGrpcRequestDetails params, {
    Duration? timeout,
  }) {
    return _grpc().doGrpcRequest(params, timeout: timeout);
  }

  @override
  Stream<List<int>> doGrpcRequestStream(
    HederaGrpcRequestDetails params, {
    Duration? timeout,
  }) {
    return _grpc().doGrpcRequestStream(params, timeout: timeout);
  }

  @override
  Future<Stream<List<int>>> doGrpcRequestStreamAsync(
    HederaGrpcRequestDetails params, {
    Duration? timeout,
  }) {
    return _grpc().doGrpcRequestStreamAsync(params, timeout: timeout);
  }
}

/// Build the provider used by [DefaultHederaClient].
HederaProvider hederaProvider({
  String? rpcUrl,
  required String grpcUrl,
  int grpcPort = 50211,
  bool tls = false,
  String? proxy,
}) {
  final channel = HederaGrpcClient(
    ClientChannel(
      grpcUrl,
      port: grpcPort,
      options: ChannelOptions(
        credentials: tls
            ? const ChannelCredentials.secure()
            : const ChannelCredentials.insecure(),
      ),
    ),
  );
  return HederaProvider(
    HederaExampleProvider(rpcUrl: rpcUrl, grpc: channel, proxy: proxy),
  );
}
