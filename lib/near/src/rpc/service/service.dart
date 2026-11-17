import 'dart:async';
import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/near/src/rpc/core/core.dart';

typedef NearServiceResponse = BaseServiceResponse;

/// A mixin for providing JSON-RPC service functionality.
mixin NearServiceProvider
    implements
        IServiceProvider<NearRequestDetails, BaseGRPCServiceRequestParams> {
  @override
  Future<NearServiceResponse> doRequest(
    NearRequestDetails params, {
    Duration? timeout,
  });

  @override
  Future<List<int>> doGrpcRequest(
    BaseGRPCServiceRequestParams params, {
    Duration? timeout,
  }) {
    throw const BuError(
      OnChainErrorType.nearPlugin,
      "gRPC requests are not supported by this service.",
    );
  }

  @override
  Stream<List<int>> doGrpcRequestStream(
    BaseGRPCServiceRequestParams params, {
    Duration? timeout,
  }) {
    throw const BuError(
      OnChainErrorType.nearPlugin,
      "gRPC requests are not supported by this service.",
    );
  }

  @override
  Future<Stream<List<int>>> doGrpcRequestStreamAsync(
    BaseGRPCServiceRequestParams params, {
    Duration? timeout,
  }) {
    throw const BuError(
      OnChainErrorType.nearPlugin,
      "gRPC requests are not supported by this service.",
    );
  }

  @override
  Future<BaseServiceSubscribtionResponse> doSubscribtionRequest({
    required NearRequestDetails params,
    required BaseServiceSubscribtionRequest<
      dynamic,
      dynamic,
      BaseSubscribtionEvent<dynamic>,
      NearRequestDetails
    >
    request,
    Duration? timeout,
  }) {
    throw const BuError(
      OnChainErrorType.nearPlugin,
      "Subscription requests are not supported by this service.",
    );
  }
}
