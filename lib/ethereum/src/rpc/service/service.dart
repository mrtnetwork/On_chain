import 'dart:async';

import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/ethereum/src/rpc/core/core.dart';

typedef EthereumServiceResponse = BaseServiceResponse;

/// A mixin for providing JSON-RPC service functionality.
mixin EthereumServiceProvider
    implements
        IServiceProvider<EthereumRequestDetails, BaseGRPCServiceRequestParams> {
  @override
  Future<EthereumServiceResponse> doRequest(
    EthereumRequestDetails params, {
    Duration? timeout,
  });

  @override
  Future<BaseServiceSubscribtionResponse> doSubscribtionRequest({
    required EthereumRequestDetails params,
    required BaseServiceSubscribtionRequest<
      dynamic,
      dynamic,
      BaseSubscribtionEvent<dynamic>,
      EthereumRequestDetails
    >
    request,
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
}
