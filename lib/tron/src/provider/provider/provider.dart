import 'dart:async';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/service/service.dart';

/// Facilitates communication with the Tron network by making requests using a provided [TronServiceProvider].
class TronProvider<SERVICE extends IServiceProvider>
    implements
        IGrpcProvider<
          SERVICE,
          BaseTronServiceRequestParams,
          TronGrpcRequestDetails
        > {
  /// The underlying Tron service provider used for network communication.
  @override
  final SERVICE service;

  /// Constructs a new [TronProvider] with the given [service].
  TronProvider(this.service);

  /// The unique identifier for each JSON-RPC request.
  int _id = 0;
  SERVICERESPONSE _findError<SERVICERESPONSE>(
    BaseServiceResponse response,
    TronFullNodeRequestDetails request,
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

  /// Sends a request to the Tron network.
  ///
  /// The [timeout] sets the maximum duration for the request.
  @override
  Future<RESULT> request<RESULT, SERVICERESPONSE>(
    IServiceRequest<RESULT, SERVICERESPONSE, BaseTronServiceRequestParams>
    request, {
    Duration? timeout,
  }) async {
    final r = await requestDynamic<RESULT, SERVICERESPONSE>(
      request,
      timeout: timeout,
    );
    return request.onResponse(r);
  }

  /// Sends a request to the Tron network and returns whatever is received.
  ///
  /// The [timeout] sets the maximum duration for the request.
  /// Whatever is received will be returned
  @override
  Future<SERVICERESPONSE> requestDynamic<RESULT, SERVICERESPONSE>(
    IServiceRequest<RESULT, SERVICERESPONSE, BaseTronServiceRequestParams>
    request, {
    Duration? timeout,
  }) async {
    switch (request) {
      case TronFullNodeRequest request:
        final params = request.buildRequest(_id++);
        final response = await service.doRequest(params, timeout: timeout);
        return _findError<SERVICERESPONSE>(response, params);
      case TronGrpcRequest request:
        final params = request.buildRequest(_id++);
        final response = await service.doGrpcRequest(params, timeout: timeout);
        return JsonParser.valueAs<SERVICERESPONSE>(response);
      default:
        throw CoreErrors.invalidOperationArguments(
          'requestDynamic',
          reason: "Unexpected request type ${request.runtimeType}. ",
        );
    }
  }

  @override
  Future<List<RESULT>> requestOnce<RESULT>(
    IGRPCServiceRequest<RESULT, TronGrpcRequestDetails> request, {
    Duration? timeout,
  }) async {
    final result = requestStream<RESULT>(request, timeout: timeout);
    return await result.toList();
  }

  @override
  Future<List<RESULT>> requestOnceAsync<RESULT>(
    IGRPCServiceRequest<RESULT, TronGrpcRequestDetails> request, {
    Duration? timeout,
  }) async {
    final result = await requestStreamAsync<RESULT>(request, timeout: timeout);
    return await result.toList();
  }

  @override
  Stream<RESULT> requestStream<RESULT>(
    IGRPCServiceRequest<RESULT, TronGrpcRequestDetails> request, {
    Duration? timeout,
  }) async* {
    final r = await request.buildRequest(0);
    final result = service.doGrpcRequestStream(r, timeout: timeout);
    yield* result.map((e) => request.onResponse(e));
  }

  @override
  Future<Stream<RESULT>> requestStreamAsync<RESULT>(
    IGRPCServiceRequest<RESULT, TronGrpcRequestDetails> request, {
    Duration? timeout,
  }) async {
    final r = await request.buildRequest(0);
    final result = await service.doGrpcRequestStreamAsync(r, timeout: timeout);
    return result.map((e) => request.onResponse(e));
  }
}
