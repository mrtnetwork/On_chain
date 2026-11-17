import 'dart:async';
import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/algorand/src/rpc/core/core.dart';

typedef AlgorandServiceResponse = BaseServiceResponse;

/// A mixin for providing Algorand REST service functionality.
mixin AlgoServiceProvider
    implements
        IServiceProvider<AlgoRequestDetails, BaseGRPCServiceRequestParams> {
  @override
  Future<AlgorandServiceResponse> doRequest(
    AlgoRequestDetails params, {
    Duration? timeout,
  });

  @override
  Future<List<int>> doGrpcRequest(
    BaseGRPCServiceRequestParams params, {
    Duration? timeout,
  }) {
    throw const BuError(
      DefaultErrorType.unsupported,
      "gRPC requests are not supported by this service.",
    );
  }

  @override
  Stream<List<int>> doGrpcRequestStream(
    BaseGRPCServiceRequestParams params, {
    Duration? timeout,
  }) {
    throw const BuError(
      DefaultErrorType.unsupported,
      "gRPC requests are not supported by this service.",
    );
  }

  @override
  Future<Stream<List<int>>> doGrpcRequestStreamAsync(
    BaseGRPCServiceRequestParams params, {
    Duration? timeout,
  }) {
    throw const BuError(
      DefaultErrorType.unsupported,
      "gRPC requests are not supported by this service.",
    );
  }

  @override
  Future<BaseServiceSubscribtionResponse> doSubscribtionRequest({
    required AlgoRequestDetails params,
    required BaseServiceSubscribtionRequest<
      dynamic,
      dynamic,
      BaseSubscribtionEvent<dynamic>,
      AlgoRequestDetails
    >
    request,
    Duration? timeout,
  }) {
    throw const BuError(
      DefaultErrorType.unsupported,
      "Subscription requests are not supported by this service.",
    );
  }
}
