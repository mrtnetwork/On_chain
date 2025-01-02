import 'dart:async';
import 'package:blockchain_utils/service/service.dart';
import 'package:on_chain/solana/src/rpc/core/core.dart';

typedef SolanaServiceResponse<T> = BaseServiceResponse<T>;

/// A mixin for providing JSON-RPC service functionality.
mixin SolanaServiceProvider
    implements BaseServiceProvider<SolanaRequestDetails> {
  /// Example:
  /// @override
  /// Future<SolanaServiceResponse<T>> doRequest<T>(SolanaRequestDetails params,
  ///     {Duration? timeout}) async {
  ///   final response = await client
  ///      .post(params.toUri(url), headers: params.headers, body: params.body())
  ///      .timeout(timeout ?? defaultTimeOut);
  ///   return params.toResponse(response.bodyBytes, response.statusCode);
  /// }

  @override
  Future<SolanaServiceResponse<T>> doRequest<T>(SolanaRequestDetails params,
      {Duration? timeout});
}
