import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';

typedef BlockFrostServiceResponse = BaseServiceResponse;

mixin BlockFrostServiceProvider
    implements
        IServiceProvider<
          BlockFrostRequestDetails,
          BaseGRPCServiceRequestParams
        > {
  @override
  Future<BlockFrostServiceResponse> doRequest(
    BlockFrostRequestDetails params, {
    Duration? timeout,
  });
  @override
  Future<BaseServiceSubscribtionResponse> doSubscribtionRequest({
    required BlockFrostRequestDetails params,
    required BaseServiceSubscribtionRequest<
      dynamic,
      dynamic,
      BaseSubscribtionEvent<dynamic>,
      BlockFrostRequestDetails
    >
    request,
    Duration? timeout,
  }) {
    throw const BuError(
      DefaultErrorType.unsupported,
      "Subscription requests are not supported by this service.",
    );
  }

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
