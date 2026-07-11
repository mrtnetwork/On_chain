import 'package:blockchain_utils/service/service.dart';
import 'package:on_chain/tron/src/provider/core/request.dart';

typedef TronServiceResponse = BaseServiceResponse;

/// A mixin for providing JSON-RPC service functionality.
mixin TronServiceProvider
    implements
        IServiceProvider<TronRequestDetails, BaseGRPCServiceRequestParams> {
  @override
  Future<TronServiceResponse> doRequest(
    TronRequestDetails params, {
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
    required TronRequestDetails params,
    required BaseServiceSubscribtionRequest<
      dynamic,
      dynamic,
      BaseSubscribtionEvent<dynamic>,
      TronRequestDetails
    >
    request,
    Duration? timeout,
  }) {
    throw UnsupportedError(
      "Subscribtion requests are not supported by this service.",
    );
  }
}
