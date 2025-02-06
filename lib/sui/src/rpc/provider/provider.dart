import 'dart:async';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/sui/src/rpc/core/core.dart';
import 'package:on_chain/sui/src/rpc/service/service.dart';

/// Represents an interface to interact with Sui nodes
/// using JSON-RPC requests.
class SuiProvider extends BaseProvider<SuiRequestDetails> {
  /// The JSON-RPC service used for communication with the Sui node.
  final SuiServiceProvider rpc;

  /// Creates a new instance of the [SuiProvider] class with the specified [rpc].
  SuiProvider(this.rpc);

  /// Finds the result in the JSON-RPC response data or throws an [RPCError]
  /// if an error is encountered.
  Object? _findError<SERVICERESPONSE>(
      {required BaseServiceResponse<Map<String, dynamic>> response,
      required SuiRequestDetails params}) {
    final data = response.getResult(params);
    final error = data['error'];
    if (error != null) {
      final errorJson = StringUtils.tryToJson<Map<String, dynamic>>(error);
      final code = IntUtils.tryParse(errorJson?['code']);
      final message = error['message']?.toString();
      throw RPCError(
          errorCode: code,
          message: message ?? error.toString(),
          request: params.toJson(),
          details: errorJson);
    }
    return data['result'];
  }

  SERVICERESPONSE _fetchRequest<RESULT, SERVICERESPONSE>(
      {required BaseServiceRequest<RESULT, SERVICERESPONSE, SuiRequestDetails>
          request,
      required BaseServiceRequestParams params,
      required Object? response}) {
    return ServiceProviderUtils.parseResponse<SERVICERESPONSE>(
        object: response, params: params);
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
      BaseServiceRequest<RESULT, SERVICERESPONSE, SuiRequestDetails> request,
      {Duration? timeout}) async {
    final params = request.buildRequest(_id++);
    final response = await _requestDynamic<RESULT, SERVICERESPONSE>(
        request, params,
        timeout: timeout);
    final r = _fetchRequest<RESULT, SERVICERESPONSE>(
        request: request, params: params, response: response);
    return request.onResonse(r);
  }

  /// Sends a JSON-RPC request to the Sui node and returns the result after
  /// processing the response.
  ///
  /// [request]: The JSON-RPC request to be sent.
  /// [timeout]: The maximum duration for waiting for the response.
  Future<Object?> _requestDynamic<RESULT, SERVICERESPONSE>(
      BaseServiceRequest<RESULT, SERVICERESPONSE, SuiRequestDetails> request,
      SuiRequestDetails params,
      {Duration? timeout}) async {
    final response =
        await rpc.doRequest<Map<String, dynamic>>(params, timeout: timeout);
    final result = _findError(params: params, response: response);
    return result;
  }

  @override
  Future<SERVICERESPONSE> requestDynamic<RESULT, SERVICERESPONSE>(
      BaseServiceRequest<RESULT, SERVICERESPONSE, SuiRequestDetails> request,
      {Duration? timeout}) async {
    final params = request.buildRequest(_id++);
    final response = await _requestDynamic<RESULT, SERVICERESPONSE>(
        request, params,
        timeout: timeout);
    return _fetchRequest(request: request, params: params, response: response);
  }
}
