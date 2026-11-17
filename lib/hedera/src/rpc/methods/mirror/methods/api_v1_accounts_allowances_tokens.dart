import 'package:on_chain/hedera/src/rpc/core/core.dart';
import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/hedera/src/rpc/models/types.dart';

/// GET /api/v1/accounts/{idOrAliasOrEvmAddress}/allowances/tokens
class HederaMirrorRequestGetTokenAllowances
    extends
        HederaMirrorRequest<
          HederaMirrorTypesTokenAllowancesResponse,
          Map<String, dynamic>
        > {
  final String idOrAliasOrEvmAddress;
  final int? limit;
  final HederaMirrorTypesOrder? order;
  final HederaMirrorTypesEntityIdQuery? spenderId;
  final HederaMirrorTypesEntityIdQuery? tokenId;

  const HederaMirrorRequestGetTokenAllowances({
    required this.idOrAliasOrEvmAddress,
    this.limit,
    this.order,
    this.spenderId,
    this.tokenId,
  });

  @override
  String? get path =>
      '/api/v1/accounts/$idOrAliasOrEvmAddress/allowances/tokens';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'limit': limit?.toString(),
    'order': order?.toJson(),
    'spender.id': spenderId,
    'token.id': tokenId,
  };

  @override
  HederaMirrorTypesTokenAllowancesResponse onResponse(
    Map<String, dynamic> result,
  ) {
    return HederaMirrorTypesTokenAllowancesResponse.fromJson(result);
  }
}
