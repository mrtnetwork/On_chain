import 'package:on_chain/hedera/src/rpc/core/core.dart';
import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/hedera/src/rpc/models/types.dart';

/// GET /api/v1/accounts/{idOrAliasOrEvmAddress}/rewards
class HederaMirrorRequestGetStakingRewards
    extends
        HederaMirrorRequest<
          HederaMirrorTypesStakingRewardsResponse,
          Map<String, dynamic>
        > {
  final String idOrAliasOrEvmAddress;
  final int? limit;
  final HederaMirrorTypesOrder? order;
  final List<String>? timestamp;

  const HederaMirrorRequestGetStakingRewards({
    required this.idOrAliasOrEvmAddress,
    this.limit,
    this.order,
    this.timestamp,
  });

  @override
  String? get path => '/api/v1/accounts/$idOrAliasOrEvmAddress/rewards';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'limit': limit?.toString(),
    'order': order?.toJson(),
    'timestamp': timestamp?.join(','),
  };

  @override
  HederaMirrorTypesStakingRewardsResponse onResponse(
    Map<String, dynamic> result,
  ) {
    return HederaMirrorTypesStakingRewardsResponse.fromJson(result);
  }
}
