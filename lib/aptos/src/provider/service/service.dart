import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/aptos/src/provider/core/core.dart';

typedef AptosServiceResponse<T> = BaseServiceResponse<T>;
mixin AptosServiceProvider implements BaseServiceProvider<AptosRequestDetails> {
  /// Example:
  /// @override
  /// Future<`AptosServiceResponse<T>`> doRequest<`T`>(AptosRequestDetails params,
  ///     {Duration? timeout}) async {
  ///   final response = await client
  ///      .post(params.toUri(url), headers: params.headers, body: params.body())
  ///      .timeout(timeout ?? defaultTimeOut);
  ///   return params.toResponse(response.bodyBytes, response.statusCode);
  /// }
  @override
  Future<AptosServiceResponse<T>> doRequest<T>(AptosRequestDetails params,
      {Duration? timeout});
}
