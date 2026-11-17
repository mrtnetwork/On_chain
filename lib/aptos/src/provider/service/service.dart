import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/aptos/src/provider/core/core.dart';

typedef AptosServiceResponse = BaseServiceResponse;

mixin AptosServiceProvider
    implements
        IServiceProvider<AptosRequestDetails, BaseGRPCServiceRequestParams> {
  @override
  Future<AptosServiceResponse> doRequest(
    AptosRequestDetails params, {
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
    required AptosRequestDetails params,
    required BaseServiceSubscribtionRequest<
      dynamic,
      dynamic,
      BaseSubscribtionEvent<dynamic>,
      AptosRequestDetails
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
