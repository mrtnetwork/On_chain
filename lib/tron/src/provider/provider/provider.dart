import 'dart:async';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/service/service.dart';

/// Facilitates communication with the Tron network by making requests using a provided [TronServiceProvider].
class TronProvider<SERVICE extends IServiceProvider>
    extends IProvider<SERVICE, TronRequestDetails> {
  /// The underlying Tron service provider used for network communication.
  @override
  final SERVICE service;

  /// Constructs a new [TronProvider] instance with the specified [service] service provider.
  TronProvider(this.service);

  /// The unique identifier for each JSON-RPC request.
  int _id = 0;
  SERVICERESPONSE _findError<SERVICERESPONSE>(
    BaseServiceResponse response,
    TronRequestDetails request,
  ) {
    final result = request.toEncodingResponse<SERVICERESPONSE>(response);
    if (result is Map) {
      if (result.hasValue('Error')) {
        throw RPCError(
          message: result["Error"]?.toString() ?? ServiceConst.defaultError,
          relatedNetwork: BlockchainNetwork.tron,
          statusCode: response.statusCode,
        );
      }
    }
    return result;
  }

  /// Sends a request to the tron network using the specified [request] parameter.
  ///
  /// The [timeout] parameter, if provided, sets the maximum duration for the request.
  @override
  Future<RESULT> request<RESULT, SERVICERESPONSE>(
    IServiceRequest<RESULT, SERVICERESPONSE, TronRequestDetails> request, {
    Duration? timeout,
  }) async {
    final r = await requestDynamic<RESULT, SERVICERESPONSE>(
      request,
      timeout: timeout,
    );
    return request.onResonse(r);
  }

  /// Sends a request to the tron network using the specified [request] parameter.
  ///
  /// The [timeout] parameter, if provided, sets the maximum duration for the request.
  /// Whatever is received will be returned
  @override
  Future<SERVICERESPONSE> requestDynamic<RESULT, SERVICERESPONSE>(
    IServiceRequest<RESULT, SERVICERESPONSE, TronRequestDetails> request, {
    Duration? timeout,
  }) async {
    final params = request.buildRequest(_id++);
    final response = await service.doRequest(params, timeout: timeout);
    return _findError<SERVICERESPONSE>(response, params);
  }
}
