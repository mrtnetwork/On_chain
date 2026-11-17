import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/tron/src/provider/core/request.dart';

typedef TronServiceResponse = BaseServiceResponse;

/// A mixin for providing Tron service functionality (FullNode REST + gRPC).
mixin TronServiceProvider
    implements
        IServiceProvider<TronFullNodeRequestDetails, TronGrpcRequestDetails> {
  @override
  Future<TronServiceResponse> doRequest(
    TronFullNodeRequestDetails params, {
    Duration? timeout,
  });

  @override
  Future<BaseServiceSubscribtionResponse> doSubscribtionRequest({
    required TronFullNodeRequestDetails params,
    required BaseServiceSubscribtionRequest<
      dynamic,
      dynamic,
      BaseSubscribtionEvent<dynamic>,
      TronFullNodeRequestDetails
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
