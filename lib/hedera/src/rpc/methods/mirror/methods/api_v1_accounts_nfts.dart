import 'package:on_chain/hedera/src/rpc/core/core.dart';
import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/hedera/src/rpc/models/types.dart';

/// GET /api/v1/accounts/{idOrAliasOrEvmAddress}/nfts
class HederaMirrorRequestGetNftsByAccountId
    extends HederaMirrorRequest<HederaMirrorTypesNfts, Map<String, dynamic>> {
  final String idOrAliasOrEvmAddress;
  final int? limit;
  final HederaMirrorTypesOrder? order;
  final String? serialnumber;
  final HederaMirrorTypesEntityIdQuery? spenderId;
  final HederaMirrorTypesEntityIdQuery? tokenId;

  const HederaMirrorRequestGetNftsByAccountId({
    required this.idOrAliasOrEvmAddress,
    this.limit,
    this.order,
    this.serialnumber,
    this.spenderId,
    this.tokenId,
  });

  @override
  String? get path => '/api/v1/accounts/$idOrAliasOrEvmAddress/nfts';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'limit': limit?.toString(),
    'order': order?.toJson(),
    'serialnumber': serialnumber,
    'spender.id': spenderId,
    'token.id': tokenId,
  };

  @override
  HederaMirrorTypesNfts onResponse(Map<String, dynamic> result) {
    return HederaMirrorTypesNfts.fromJson(result);
  }
}
