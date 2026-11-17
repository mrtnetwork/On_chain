import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/hedera/src/rpc/core/core.dart';

typedef HederaServiceResponse = BaseServiceResponse;

/// A mixin defining the service provider contract for interacting with the hedera RPC.
mixin HederaServiceProvider
    implements
        IServiceProvider<HederaMirrorRequestDetails, HederaGrpcRequestDetails> {
  @override
  Future<HederaServiceResponse> doRequest(
    HederaMirrorRequestDetails params, {
    Duration? timeout,
  });

  @override
  Future<BaseServiceSubscribtionResponse> doSubscribtionRequest({
    required HederaMirrorRequestDetails params,
    required BaseServiceSubscribtionRequest<
      dynamic,
      dynamic,
      BaseSubscribtionEvent<dynamic>,
      HederaMirrorRequestDetails
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
