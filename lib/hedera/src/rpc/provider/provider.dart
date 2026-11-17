import 'dart:async';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/hedera/src/rpc/core/core.dart';

/// Facilitates communication with the hedera by making requests using a provided [HederaProvider].
class HederaProvider<SERVICE extends IServiceProvider>
    implements
        IGrpcProvider<
          SERVICE,
          BaseHederaServiceRequestParams,
          HederaGrpcRequestDetails
        > {
  /// The underlying hedera service provider used for network communication.
  @override
  final SERVICE service;

  /// Constructs a new [HederaProvider] instance with the specified [service] service provider.
  HederaProvider(this.service);

  static SERVICERESPONSE _findError<SERVICERESPONSE>({
    required IServiceRequest request,
    required BaseServiceResponse response,
    required HederaMirrorRequestDetails params,
  }) {
    if (response.type == ServiceResponseType.error) {
      final error = response.cast<BaseServiceErrorResponse>();
      final json = error.tryToJson();
      Iterable<String>? messages;
      try {
        messages = json
            ?.valueAsMap("_status")
            ?.valueAsList<List<Map<String, dynamic>>?>("messages")
            ?.map((e) => e.valueAsString<String>("message"));
      } catch (_) {}
      throw RPCError(
        message:
            messages?.join(",") ??
            ServiceProviderUtils.getDefaultError(response.statusCode),
        request: params.toJson(),
        relatedNetwork: BlockchainNetwork.hedera,
        statusCode: response.statusCode,
        jsonRpcErrpr: json,
      );
    }

    final result = params.toEncodingResponse(response);
    return ServiceProviderUtils.toResponse<SERVICERESPONSE>(
      object: result,
      params: params,
    );
  }

  /// Sends a request to the hedera using the specified [request] parameter.
  ///
  /// The [timeout] parameter, if provided, sets the maximum duration for the request.
  @override
  Future<RESULT> request<RESULT, SERVICERESPONSE>(
    IServiceRequest<RESULT, SERVICERESPONSE, BaseHederaServiceRequestParams>
    request, {
    Duration? timeout,
  }) async {
    final r = await requestDynamic<RESULT, SERVICERESPONSE>(
      request,
      timeout: timeout,
    );
    return request.onResponse(r);
  }

  int _id = 0;

  /// Sends a request to the hedera using the specified [request] parameter.
  ///
  /// The [timeout] parameter, if provided, sets the maximum duration for the request.
  /// Whatever is received will be returned
  @override
  Future<SERVICERESPONSE> requestDynamic<RESULT, SERVICERESPONSE>(
    IServiceRequest<RESULT, SERVICERESPONSE, BaseHederaServiceRequestParams>
    request, {
    Duration? timeout,
  }) async {
    switch (request) {
      case HederaMirrorRequest request:
        final params = request.buildRequest(_id++);
        final response = await service.doRequest(params, timeout: timeout);
        return _findError<SERVICERESPONSE>(
          params: params,
          response: response,
          request: request,
        );
      case HederaGrpcRequest request:
        final params = request.buildRequest(_id++);
        final response = await service.doGrpcRequest(params, timeout: timeout);
        return JsonParser.valueAs<SERVICERESPONSE>(response);
      default:
        throw OnChainErrors.hederaPlugin(
          'requestDynamic',
          reason: "Unexpected request type ${request.runtimeType}.",
        );
    }
  }

  @override
  Stream<RESULT> requestStream<RESULT>(
    IGRPCServiceRequest<RESULT, HederaGrpcRequestDetails> request, {
    Duration? timeout,
  }) async* {
    final r = await request.buildRequest(0);
    final result = service.doGrpcRequestStream(r, timeout: timeout);
    yield* result.map((e) => request.onResponse(e));
  }

  @override
  Future<List<RESULT>> requestOnce<RESULT>(
    IGRPCServiceRequest<RESULT, HederaGrpcRequestDetails> request, {
    Duration? timeout,
  }) async {
    final result = requestStream<RESULT>(request, timeout: timeout);
    return await result.toList();
  }

  @override
  Future<Stream<RESULT>> requestStreamAsync<RESULT>(
    IGRPCServiceRequest<RESULT, HederaGrpcRequestDetails> request, {
    Duration? timeout,
  }) async {
    final r = await request.buildRequest(0);
    final result = await service.doGrpcRequestStreamAsync(r, timeout: timeout);
    return result.map((e) => request.onResponse(e));
  }

  @override
  Future<List<RESULT>> requestOnceAsync<RESULT>(
    IGRPCServiceRequest<RESULT, HederaGrpcRequestDetails> request, {
    Duration? timeout,
  }) async {
    final result = await requestStreamAsync<RESULT>(request, timeout: timeout);
    return await result.toList();
  }
}
