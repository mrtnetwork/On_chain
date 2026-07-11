import 'dart:async';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/rpc/rpc.dart';

/// Represents an interface to interact with Solana nodes
/// using JSON-RPC requests.
class SolanaProvider<SERVICE extends IServiceProvider>
    extends IProvider<SERVICE, SolanaRequestDetails> {
  /// The JSON-RPC service used for communication with the solana node.
  @override
  final SERVICE service;

  /// Creates a new instance of the [SolanaProvider] class with the specified [rpc].
  SolanaProvider(this.service);

  /// Finds the result in the JSON-RPC response data or throws an [RPCError]
  /// if an error is encountered.
  dynamic _findError({
    required BaseServiceResponse response,
    required SolanaRequestDetails params,
  }) {
    final data = params.toEncodingResponse<Map<String, dynamic>>(response);
    final error = data['error'];
    if (error != null) {
      final errorJson = StringUtils.tryToJson<Map<String, dynamic>>(error);
      final code = IntUtils.tryParse(errorJson?['code']);
      final message = error['message']?.toString();
      throw RPCError(
        errorCode: code,
        message:
            message ?? (error is String ? error : ServiceConst.defaultError),
        request: params.toJson(),
        jsonRpcErrpr: data,
        relatedNetwork: BlockchainNetwork.solana,
        statusCode: response.statusCode,
      );
    }
    return data['result'];
  }

  SERVICERESPONSE _fetchRequest<RESULT, SERVICERESPONSE>({
    required IServiceRequest<RESULT, SERVICERESPONSE, SolanaRequestDetails>
    request,
    required BaseServiceRequestParams params,
    required Object? response,
  }) {
    if (response is Map &&
        response.containsKey('context') &&
        response.containsKey('value')) {
      return ServiceProviderUtils.toResponse<SERVICERESPONSE>(
        object: response['value'],
        params: params,
      );
    }
    return ServiceProviderUtils.toResponse<SERVICERESPONSE>(
      object: response,
      params: params,
    );
  }

  Context? _fetchContext(Object? response) {
    if (response is Map &&
        response.containsKey('context') &&
        response.containsKey('value')) {
      return Context.fromJson(response['context']);
    }
    return null;
  }

  /// Sends a JSON-RPC request to the solana node and returns the result after
  /// processing the response.
  ///
  /// [request]: The JSON-RPC request to be sent.
  /// [timeout]: The maximum duration for waiting for the response.
  /// return value with context if response contains context
  Future<ResultWithContext<RESULT>> requestWithContext<RESULT, SERVICERESPONSE>(
    BaseServiceRequest<RESULT, SERVICERESPONSE, SolanaRequestDetails> request, [
    Duration? timeout,
  ]) async {
    final id = ++_id;
    final params = request.buildRequest(id);
    final response = await service.doRequest(params, timeout: timeout);
    final result = _findError(response: response, params: params);
    return ResultWithContext(
      result: request.onResonse(
        _fetchRequest<RESULT, SERVICERESPONSE>(
          request: request,
          params: params,
          response: result,
        ),
      ),
      context: _fetchContext(result),
    );
  }

  /// Sends a JSON-RPC request to the solana node and returns the result after
  /// processing the response.
  ///
  /// [request]: The JSON-RPC request to be sent.
  /// [timeout]: The maximum duration for waiting for the response.
  /// return value with context if response contains context
  Future<ResultWithContext<SERVICERESPONSE>>
  requestDynamicWithContext<RESULT, SERVICERESPONSE>(
    BaseServiceRequest<RESULT, SERVICERESPONSE, SolanaRequestDetails> request, [
    Duration? timeout,
  ]) async {
    final id = ++_id;
    final params = request.buildRequest(id);
    final response = await service.doRequest(params, timeout: timeout);
    final result = _findError(response: response, params: params);
    return ResultWithContext(
      result: _fetchRequest<RESULT, SERVICERESPONSE>(
        request: request,
        params: params,
        response: result,
      ),
      context: _fetchContext(result),
    );
  }

  /// The unique identifier for each JSON-RPC request.
  int _id = 0;

  /// Sends a JSON-RPC request to the solana node and returns the result after
  /// processing the response.
  ///
  /// [request]: The JSON-RPC request to be sent.
  /// [timeout]: The maximum duration for waiting for the response.
  /// changed value to request class template
  @override
  Future<RESULT> request<RESULT, SERVICERESPONSE>(
    IServiceRequest<RESULT, SERVICERESPONSE, SolanaRequestDetails> request, {
    Duration? timeout,
  }) async {
    final params = request.buildRequest(_id++);
    final response = await _requestDynamic<RESULT, SERVICERESPONSE>(
      request,
      params,
      timeout: timeout,
    );
    final r = _fetchRequest<RESULT, SERVICERESPONSE>(
      request: request,
      params: params,
      response: response,
    );
    return request.onResonse(r);
  }

  /// Sends a JSON-RPC request to the solana node and returns the result after
  /// processing the response.
  ///
  /// [request]: The JSON-RPC request to be sent.
  /// [timeout]: The maximum duration for waiting for the response.
  Future<Object?> _requestDynamic<RESULT, SERVICERESPONSE>(
    IServiceRequest<RESULT, SERVICERESPONSE, SolanaRequestDetails> request,
    SolanaRequestDetails params, {
    Duration? timeout,
  }) async {
    final response = await service.doRequest(params, timeout: timeout);
    final result = _findError(params: params, response: response);
    return result;
  }

  @override
  Future<SERVICERESPONSE> requestDynamic<RESULT, SERVICERESPONSE>(
    IServiceRequest<RESULT, SERVICERESPONSE, SolanaRequestDetails> request, {
    Duration? timeout,
  }) async {
    final params = request.buildRequest(_id++);
    final response = await _requestDynamic<RESULT, SERVICERESPONSE>(
      request,
      params,
      timeout: timeout,
    );
    return _fetchRequest<RESULT, SERVICERESPONSE>(
      request: request,
      params: params,
      response: response,
    );
  }
}
