import 'package:on_chain/hedera/src/rpc/core/core.dart';
import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/hedera/src/rpc/models/types.dart';

/// GET /api/v1/accounts/{idOrAliasOrEvmAddress}/tokens
class HederaMirrorRequestGetTokensByAccountId
    extends
        HederaMirrorRequest<
          HederaMirrorTypesTokenRelationshipResponse,
          Map<String, dynamic>
        > {
  final String idOrAliasOrEvmAddress;
  final int? limit;
  final HederaMirrorTypesOrder? order;
  final HederaMirrorTypesEntityIdQuery? tokenId;

  const HederaMirrorRequestGetTokensByAccountId({
    required this.idOrAliasOrEvmAddress,
    this.limit,
    this.order,
    this.tokenId,
  });

  @override
  String? get path => '/api/v1/accounts/$idOrAliasOrEvmAddress/tokens';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'limit': limit?.toString(),
    'order': order?.toJson(),
    'token.id': tokenId,
  };

  @override
  HederaMirrorTypesTokenRelationshipResponse onResponse(
    Map<String, dynamic> result,
  ) {
    return HederaMirrorTypesTokenRelationshipResponse.fromJson(result);
  }
}
