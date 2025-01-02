import 'package:blockchain_utils/service/service.dart';
import 'package:on_chain/tron/src/provider/core/request.dart';

typedef TronServiceResponse<T> = BaseServiceResponse<T>;

/// A mixin for providing JSON-RPC service functionality.
mixin TronServiceProvider implements BaseServiceProvider<TronRequestDetails> {
  /// Example:
  /// @override
  /// Future<TronServiceResponse<T>> doRequest<T>(TronRequestDetails params,
  ///     {Duration? timeout}) async {
  ///   final response = await client
  ///      .post(params.toUri(url), headers: params.headers, body: params.body())
  ///      .timeout(timeout ?? defaultTimeOut);
  ///   return params.toResponse(response.bodyBytes, response.statusCode);
  /// }

  @override
  Future<TronServiceResponse<T>> doRequest<T>(TronRequestDetails params,
      {Duration? timeout});
}
