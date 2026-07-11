import 'dart:async';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/sui/src/rpc/core/core.dart';

/// Represents an interface to interact with Sui nodes
/// using JSON-RPC requests.
class SuiProvider<SERVICE extends IServiceProvider>
    extends IProvider<SERVICE, SuiRequestDetails> {
  /// The JSON-RPC service used for communication with the Sui node.
  @override
  final SERVICE service;

  /// Creates a new instance of the [SuiProvider] class with the specified [service].
  SuiProvider(this.service);

  /// Finds the result in the JSON-RPC response data or throws an [RPCError]
  /// if an error is encountered.
  Object? _findError({
    required BaseServiceResponse response,
    required SuiRequestDetails params,
  }) {
    final data = params.toEncodingResponse<Map<String, dynamic>>(response);
    final error = data['error'];
    if (error != null) {
      final errorJson = StringUtils.tryToJson<Map<String, dynamic>>(error);
      final code = IntUtils.tryParse(errorJson?['code']);
      final message = error['message'];
      throw RPCError(
        errorCode: code,
        message: (message is String ? message : ServiceConst.defaultError),
        request: params.toJson(),
        relatedNetwork: BlockchainNetwork.sui,
        statusCode: response.statusCode,
        jsonRpcErrpr: data,
      );
    }
    return data['result'];
  }

  /// The unique identifier for each JSON-RPC request.
  int _id = 0;

  /// Sends a JSON-RPC request to the Sui node and returns the result after
  /// processing the response.
  ///
  /// [request]: The JSON-RPC request to be sent.
  /// [timeout]: The maximum duration for waiting for the response.
  /// changed value to request class template
  @override
  Future<RESULT> request<RESULT, SERVICERESPONSE>(
    IServiceRequest<RESULT, SERVICERESPONSE, SuiRequestDetails> request, {
    Duration? timeout,
  }) async {
    final params = request.buildRequest(_id++);
    final response = await _requestDynamic<RESULT, SERVICERESPONSE>(
      request,
      params,
      timeout: timeout,
    );
    return request.onResonse(response);
  }

  /// Sends a JSON-RPC request to the Sui node and returns the result after
  /// processing the response.
  ///
  /// [request]: The JSON-RPC request to be sent.
  /// [timeout]: The maximum duration for waiting for the response.
  Future<SERVICERESPONSE> _requestDynamic<RESULT, SERVICERESPONSE>(
    IServiceRequest<RESULT, SERVICERESPONSE, SuiRequestDetails> request,
    SuiRequestDetails params, {
    Duration? timeout,
  }) async {
    final response = await service.doRequest(params, timeout: timeout);
    final result = _findError(params: params, response: response);
    return ServiceProviderUtils.toResponse<SERVICERESPONSE>(
      object: result,
      params: params,
    );
  }

  @override
  Future<SERVICERESPONSE> requestDynamic<RESULT, SERVICERESPONSE>(
    IServiceRequest<RESULT, SERVICERESPONSE, SuiRequestDetails> request, {
    Duration? timeout,
  }) async {
    final params = request.buildRequest(_id++);
    return await _requestDynamic<RESULT, SERVICERESPONSE>(
      request,
      params,
      timeout: timeout,
    );
  }
}
