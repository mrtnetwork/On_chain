import 'dart:async';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ethereum/src/rpc/core/core.dart';

typedef EthereumServiceResponse<T> = BaseServiceResponse<T>;

/// A mixin for providing JSON-RPC service functionality.
mixin EthereumServiceProvider
    implements BaseServiceProvider<EthereumRequestDetails> {
  /// Example:
  /// @override
  /// Future<EthereumServiceResponse<T>> doRequest<T>(EthereumRequestDetails params,
  ///     {Duration? timeout}) async {
  ///   final response = await client
  ///      .post(params.toUri(url), headers: params.headers, body: params.body())
  ///      .timeout(timeout ?? defaultTimeOut);
  ///   return params.toResponse(response.bodyBytes, response.statusCode);
  /// }
  @override
  Future<EthereumServiceResponse<T>> doRequest<T>(EthereumRequestDetails params,
      {Duration? timeout});
}
