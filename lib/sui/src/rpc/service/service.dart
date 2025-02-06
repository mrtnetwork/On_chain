import 'dart:async';
import 'package:blockchain_utils/service/service.dart';
import 'package:on_chain/sui/src/rpc/core/core.dart';

typedef SuiServiceResponse<T> = BaseServiceResponse<T>;

/// A mixin for providing JSON-RPC service functionality.
mixin SuiServiceProvider implements BaseServiceProvider<SuiRequestDetails> {
  /// Example:
  /// @override
  /// Future<`SuiServiceResponse<T>`> doRequest<`T`>(SuiRequestDetails params,
  ///     {Duration? timeout}) async {
  ///   final response = await client
  ///      .post(params.toUri(url), headers: params.headers, body: params.body())
  ///      .timeout(timeout ?? defaultTimeOut);
  ///   return params.toResponse(response.bodyBytes, response.statusCode);
  /// }

  @override
  Future<SuiServiceResponse<T>> doRequest<T>(SuiRequestDetails params,
      {Duration? timeout});
}
