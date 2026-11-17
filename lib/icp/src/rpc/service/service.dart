import 'dart:async';
import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/icp/src/rpc/core/core.dart';

typedef ICPServiceResponse = BaseServiceResponse;

/// A mixin for providing service functionality.
mixin ICPServiceProvider
    implements
        IServiceProvider<ICPRequestDetails, BaseGRPCServiceRequestParams> {
  @override
  Future<ICPServiceResponse> doRequest(
    ICPRequestDetails params, {
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
    required ICPRequestDetails params,
    required BaseServiceSubscribtionRequest<
      dynamic,
      dynamic,
      BaseSubscribtionEvent<dynamic>,
      ICPRequestDetails
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
