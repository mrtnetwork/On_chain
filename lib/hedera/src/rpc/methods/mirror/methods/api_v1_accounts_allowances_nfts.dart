import 'package:on_chain/hedera/src/rpc/core/core.dart';
import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/hedera/src/rpc/models/types.dart';

/// GET /api/v1/accounts/{idOrAliasOrEvmAddress}/allowances/nfts
class HederaMirrorRequestGetNftAllowances
    extends
        HederaMirrorRequest<
          HederaMirrorTypesNftAllowancesResponse,
          Map<String, dynamic>
        > {
  final String idOrAliasOrEvmAddress;
  final int? limit;
  final HederaMirrorTypesOrder? order;
  final HederaMirrorTypesEntityIdQuery? accountId;
  final HederaMirrorTypesEntityIdQuery? tokenId;
  final bool? owner;

  const HederaMirrorRequestGetNftAllowances({
    required this.idOrAliasOrEvmAddress,
    this.limit,
    this.order,
    this.accountId,
    this.tokenId,
    this.owner,
  });

  @override
  String? get path => '/api/v1/accounts/$idOrAliasOrEvmAddress/allowances/nfts';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'limit': limit?.toString(),
    'order': order?.toJson(),
    'account.id': accountId,
    'token.id': tokenId,
    'owner': owner?.toString(),
  };

  @override
  HederaMirrorTypesNftAllowancesResponse onResponse(
    Map<String, dynamic> result,
  ) {
    return HederaMirrorTypesNftAllowancesResponse.fromJson(result);
  }
}
