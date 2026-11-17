import 'package:on_chain/hedera/src/rpc/core/core.dart';
import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/hedera/src/rpc/models/types.dart';

/// GET /api/v1/balances
class HederaMirrorRequestGetBalances
    extends
        HederaMirrorRequest<
          HederaMirrorTypesBalancesResponse,
          Map<String, dynamic>
        > {
  final String? accountId;
  final String? accountBalance;
  final String? accountPublickey;
  final int? limit;
  final HederaMirrorTypesOrder? order;
  final List<String>? timestamp;

  const HederaMirrorRequestGetBalances({
    this.accountId,
    this.accountBalance,
    this.accountPublickey,
    this.limit,
    this.order,
    this.timestamp,
  });

  @override
  String? get path => '/api/v1/balances';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'account.id': accountId,
    'account.balance': accountBalance,
    'account.publickey': accountPublickey,
    'limit': limit?.toString(),
    'order': order?.toJson(),
    'timestamp': timestamp?.join(','),
  };

  @override
  HederaMirrorTypesBalancesResponse onResponse(Map<String, dynamic> result) {
    return HederaMirrorTypesBalancesResponse.fromJson(result);
  }
}
