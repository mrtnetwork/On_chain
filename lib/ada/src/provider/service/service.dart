import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';

typedef BlockFrostServiceResponse<T> = BaseServiceResponse<T>;
mixin BlockFrostServiceProvider
    implements BaseServiceProvider<BlockFrostRequestDetails> {
  /// Example:
  /// @override
  /// Future<BlockFrostServiceResponse<T>> doRequest<T>(BlockFrostRequestDetails params,
  ///     {Duration? timeout}) async {
  ///   final response = await client
  ///      .post(params.toUri(url), headers: params.headers, body: params.body())
  ///      .timeout(timeout ?? defaultTimeOut);
  ///   return params.toResponse(response.bodyBytes, response.statusCode);
  /// }
  @override
  Future<BlockFrostServiceResponse<T>> doRequest<T>(
      BlockFrostRequestDetails params,
      {Duration? timeout});
}
