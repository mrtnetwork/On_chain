import 'dart:async';
import 'package:blockchain_utils/service/service.dart';
import 'package:on_chain/sui/src/rpc/core/core.dart';

typedef SuiServiceResponse = BaseServiceResponse;

/// A mixin for providing JSON-RPC service functionality.
mixin SuiServiceProvider
    implements
        IServiceProvider<SuiRequestDetails, BaseGRPCServiceRequestParams> {
  @override
  Future<SuiServiceResponse> doRequest(
    SuiRequestDetails params, {
    Duration? timeout,
  });

  @override
  Future<List<int>> doGrpcRequest(
    BaseGRPCServiceRequestParams params, {
    Duration? timeout,
  }) {
    throw UnsupportedError("gRPC requests are not supported by this service.");
  }

  @override
  Stream<List<int>> doGrpcRequestStream(
    BaseGRPCServiceRequestParams params, {
    Duration? timeout,
  }) {
    throw UnsupportedError("gRPC requests are not supported by this service.");
  }

  @override
  Future<Stream<List<int>>> doGrpcRequestStreamAsync(
    BaseGRPCServiceRequestParams params, {
    Duration? timeout,
  }) {
    throw UnsupportedError("gRPC requests are not supported by this service.");
  }

  @override
  Future<BaseServiceSubscribtionResponse> doSubscribtionRequest({
    required SuiRequestDetails params,
    required BaseServiceSubscribtionRequest<
      dynamic,
      dynamic,
      BaseSubscribtionEvent<dynamic>,
      SuiRequestDetails
    >
    request,
    Duration? timeout,
  }) {
    throw UnsupportedError(
      "Subscribtion requests are not supported by this service.",
    );
  }
}
