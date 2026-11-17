import 'dart:async';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/near/src/rpc/core/core.dart';

/// Represents an interface to interact with Near nodes
/// using JSON-RPC requests.
class NearProvider<SERVICE extends IServiceProvider>
    extends IProvider<SERVICE, NearRequestDetails> {
  /// The JSON-RPC service used for communication with the Near node.
  @override
  final SERVICE service;

  /// Creates a new instance of the [NearProvider] class with the specified [service].
  NearProvider(this.service);

  /// Finds the result in the JSON-RPC response data or throws an [RPCError]
  /// if an error is encountered.
  Object? _findError({
    required BaseServiceResponse response,
    required NearRequestDetails params,
  }) {
    RPCError toError(
      NearRequestDetails params,
      Map<String, dynamic>? errorJson,
    ) {
      final message =
          errorJson?.valueAsString<String?>("message") ??
          errorJson?.valueAsString("name");
      return RPCError(
        message:
            (message is String
                ? message
                : ServiceProviderUtils.getDefaultError(response.statusCode)),
        request: params.toJson(),
        relatedNetwork: BlockchainNetwork.near,
        statusCode: response.statusCode,
        errorCode: errorJson?.valueAsInt("code"),
        jsonRpcErrpr: errorJson,
      );
    }

    if (response case BaseServiceErrorResponse err) {
      final errorJson = err.tryToJson();
      if (errorJson != null && errorJson.hasValue("error")) {
        throw toError(params, errorJson.valueAs("error"));
      }
      throw err.defaultError();
    }
    final data = params.toEncodingResponse<Map<String, dynamic>>(response);
    final error = data['error'];
    if (error != null) {
      final errorJson = StringUtils.tryToJson<Map<String, dynamic>>(error);
      throw toError(params, errorJson);
    }
    final result = data['result'];
    if (result is Map && result.hasValue('error')) {
      final resultMap = JsonParser.valueEnsureAsMap<String, dynamic>(result);
      throw RPCError(
        message:
            resultMap.valueAsString<String?>('error') ??
            ServiceProviderUtils.getDefaultError(response.statusCode),
        request: params.toJson(),
        relatedNetwork: BlockchainNetwork.near,
        statusCode: response.statusCode,
        jsonRpcErrpr: resultMap.clone()..removeWhere((k, v) => k == 'error'),
      );
    }
    return result;
  }

  /// The unique identifier for each JSON-RPC request.
  int _id = 0;

  /// Sends a JSON-RPC request to the Near node and returns the result after
  /// processing the response.
  ///
  /// [request]: The JSON-RPC request to be sent.
  /// [timeout]: The maximum duration for waiting for the response.
  /// changed value to request class template
  @override
  Future<RESULT> request<RESULT, SERVICERESPONSE>(
    IServiceRequest<RESULT, SERVICERESPONSE, NearRequestDetails> request, {
    Duration? timeout,
  }) async {
    final params = await request.buildRequest(_id++);
    final response = await _requestDynamic<RESULT, SERVICERESPONSE>(
      request,
      params,
      timeout: timeout,
    );
    return request.onResponse(response);
  }

  /// Sends a JSON-RPC request to the Near node and returns the result after
  /// processing the response.
  ///
  /// [request]: The JSON-RPC request to be sent.
  /// [timeout]: The maximum duration for waiting for the response.
  Future<SERVICERESPONSE> _requestDynamic<RESULT, SERVICERESPONSE>(
    IServiceRequest<RESULT, SERVICERESPONSE, NearRequestDetails> request,
    NearRequestDetails params, {
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
    IServiceRequest<RESULT, SERVICERESPONSE, NearRequestDetails> request, {
    Duration? timeout,
  }) async {
    final params = await request.buildRequest(_id++);
    return await _requestDynamic<RESULT, SERVICERESPONSE>(
      request,
      params,
      timeout: timeout,
    );
  }
}
