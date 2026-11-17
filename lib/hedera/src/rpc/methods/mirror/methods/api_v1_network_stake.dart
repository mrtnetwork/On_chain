import 'package:on_chain/hedera/src/rpc/core/core.dart';
import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/hedera/src/rpc/models/types.dart';

/// GET /api/v1/network/stake
class HederaMirrorRequestGetNetworkStake
    extends
        HederaMirrorRequest<
          HederaMirrorTypesNetworkStakeResponse,
          Map<String, dynamic>
        > {
  const HederaMirrorRequestGetNetworkStake();

  @override
  String? get path => '/api/v1/network/stake';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  HederaMirrorTypesNetworkStakeResponse onResponse(
    Map<String, dynamic> result,
  ) {
    return HederaMirrorTypesNetworkStakeResponse.fromJson(result);
  }
}
