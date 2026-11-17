import 'dart:async';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/sui/src/rpc/core/core.dart';
import 'package:on_chain/sui/src/rpc/core/request.dart';

class SuiProvider<SERVICE extends IServiceProvider>
    implements
        IGrpcProvider<
          SERVICE,
          BaseSuiServiceRequestParams,
          SuiGrpcRequestDetails
        > {
  /// The service used for communication with the Sui node.
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

  /// Sends a request to the Sui node and returns the result after
  /// processing the response.
  ///
  /// [request]: The request to be sent (JSON-RPC or gRPC).
  /// [timeout]: The maximum duration for waiting for the response.
  /// changed value to request class template
  @override
  Future<RESULT> request<RESULT, SERVICERESPONSE>(
    IServiceRequest<RESULT, SERVICERESPONSE, BaseSuiServiceRequestParams>
    request, {
    Duration? timeout,
  }) async {
    final r = await requestDynamic<RESULT, SERVICERESPONSE>(
      request,
      timeout: timeout,
    );
    return request.onResponse(r);
  }

  Future<SERVICERESPONSE> _requestJsonRpc<RESULT, SERVICERESPONSE>(
    IServiceRequest<RESULT, SERVICERESPONSE, BaseSuiServiceRequestParams>
    request,
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

  /// Sends a request to the Sui node and returns whatever is received.
  /// gRPC requests are dispatched to [IServiceProvider.doGrpcRequest],
  /// JSON-RPC requests to [IServiceProvider.doRequest].
  ///
  /// [request]: The request to be sent.
  /// [timeout]: The maximum duration for waiting for the response.
  @override
  Future<SERVICERESPONSE> requestDynamic<RESULT, SERVICERESPONSE>(
    IServiceRequest<RESULT, SERVICERESPONSE, BaseSuiServiceRequestParams>
    request, {
    Duration? timeout,
  }) async {
    switch (request) {
      case SuiGrpcRequest req:
        final SuiGrpcRequestDetails details = req.buildRequest(_id++);
        final response = await service.doGrpcRequest(details, timeout: timeout);
        return JsonParser.valueAs<SERVICERESPONSE>(response);
      default:
        final params = await (request
                as BaseServiceRequest<
                  RESULT,
                  SERVICERESPONSE,
                  SuiRequestDetails
                >)
            .buildRequest(_id++);
        return await _requestJsonRpc<RESULT, SERVICERESPONSE>(
          request,
          params,
          timeout: timeout,
        );
    }
  }

  @override
  Future<List<RESULT>> requestOnce<RESULT>(
    IGRPCServiceRequest<RESULT, SuiGrpcRequestDetails> request, {
    Duration? timeout,
  }) async {
    final result = requestStream<RESULT>(request, timeout: timeout);
    return await result.toList();
  }

  @override
  Future<List<RESULT>> requestOnceAsync<RESULT>(
    IGRPCServiceRequest<RESULT, SuiGrpcRequestDetails> request, {
    Duration? timeout,
  }) async {
    final result = await requestStreamAsync<RESULT>(request, timeout: timeout);
    return await result.toList();
  }

  @override
  Stream<RESULT> requestStream<RESULT>(
    IGRPCServiceRequest<RESULT, SuiGrpcRequestDetails> request, {
    Duration? timeout,
  }) async* {
    final SuiGrpcRequestDetails details = await request.buildRequest(0);
    final result = service.doGrpcRequestStream(details, timeout: timeout);
    yield* result.map((e) => request.onResponse(e));
  }

  @override
  Future<Stream<RESULT>> requestStreamAsync<RESULT>(
    IGRPCServiceRequest<RESULT, SuiGrpcRequestDetails> request, {
    Duration? timeout,
  }) async {
    final SuiGrpcRequestDetails details = await request.buildRequest(0);
    final result = await service.doGrpcRequestStreamAsync(
      details,
      timeout: timeout,
    );
    return result.map((e) => request.onResponse(e));
  }
}
