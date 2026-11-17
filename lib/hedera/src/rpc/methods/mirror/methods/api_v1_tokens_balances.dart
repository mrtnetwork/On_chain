import 'package:on_chain/hedera/src/rpc/core/core.dart';
import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/hedera/src/rpc/models/types.dart';

/// GET /api/v1/tokens/{tokenId}/balances
class HederaMirrorRequestGetTokenBalances
    extends
        HederaMirrorRequest<
          HederaMirrorTypesTokenBalancesResponse,
          Map<String, dynamic>
        > {
  final HederaMirrorTypesEntityId tokenId;
  final String? accountBalance;
  final HederaMirrorTypesEntityIdQuery? accountId;
  final String? accountPublickey;
  final int? limit;
  final HederaMirrorTypesOrder? order;
  final List<String>? timestamp;

  const HederaMirrorRequestGetTokenBalances({
    required this.tokenId,
    this.accountBalance,
    this.accountId,
    this.accountPublickey,
    this.limit,
    this.order,
    this.timestamp,
  });

  @override
  String? get path => '/api/v1/tokens/$tokenId/balances';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'account.balance': accountBalance,
    'account.id': accountId,
    'account.publickey': accountPublickey,
    'limit': limit?.toString(),
    'order': order?.toJson(),
    'timestamp': timestamp?.join(','),
  };

  @override
  HederaMirrorTypesTokenBalancesResponse onResponse(
    Map<String, dynamic> result,
  ) {
    return HederaMirrorTypesTokenBalancesResponse.fromJson(result);
  }
}
