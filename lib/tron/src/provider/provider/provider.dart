import 'dart:async';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/service/service.dart';

/// Facilitates communication with the Tron network by making requests using a provided [TronServiceProvider].
class TronProvider extends BaseProvider<TronRequestDetails> {
  /// The underlying Tron service provider used for network communication.
  final TronServiceProvider rpc;

  /// Constructs a new [TronProvider] instance with the specified [rpc] service provider.
  TronProvider(this.rpc);

  /// The unique identifier for each JSON-RPC request.
  int _id = 0;
  SERVICERESPONSE _findError<SERVICERESPONSE>(
      BaseServiceResponse<SERVICERESPONSE> response,
      TronRequestDetails request) {
    final result = response.getResult(request);
    if (result is Map) {
      if (result.containsKey('Error')) {
        throw RPCError(
            message: result["Error"]?.toString() ?? ServiceConst.defaultError);
      }
    }
    return result;
  }

  /// Sends a request to the tron network using the specified [request] parameter.
  ///
  /// The [timeout] parameter, if provided, sets the maximum duration for the request.
  @override
  Future<RESULT> request<RESULT, SERVICERESPONSE>(
      BaseServiceRequest<RESULT, SERVICERESPONSE, TronRequestDetails> request,
      {Duration? timeout}) async {
    final r = await requestDynamic(request, timeout: timeout);
    return request.onResonse(r);
  }

  /// Sends a request to the tron network using the specified [request] parameter.
  ///
  /// The [timeout] parameter, if provided, sets the maximum duration for the request.
  /// Whatever is received will be returned
  @override
  Future<SERVICERESPONSE> requestDynamic<RESULT, SERVICERESPONSE>(
      BaseServiceRequest<RESULT, SERVICERESPONSE, TronRequestDetails> request,
      {Duration? timeout}) async {
    final params = request.buildRequest(_id++);
    final response =
        await rpc.doRequest<SERVICERESPONSE>(params, timeout: timeout);
    return _findError(response, params);
  }
}
