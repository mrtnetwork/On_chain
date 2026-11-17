import 'package:on_chain/hedera/src/rpc/core/core.dart';
import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/hedera/src/rpc/models/types.dart';

/// GET /api/v1/accounts/{idOrAliasOrEvmAddress}/airdrops/pending
class HederaMirrorRequestGetPendingTokenAirdrops
    extends
        HederaMirrorRequest<
          HederaMirrorTypesTokenAirdropsResponse,
          Map<String, dynamic>
        > {
  final String idOrAliasOrEvmAddress;
  final int? limit;
  final HederaMirrorTypesOrder? order;
  final HederaMirrorTypesEntityIdQuery? senderId;
  final String? serialnumber;
  final HederaMirrorTypesEntityIdQuery? tokenId;

  const HederaMirrorRequestGetPendingTokenAirdrops({
    required this.idOrAliasOrEvmAddress,
    this.limit,
    this.order,
    this.senderId,
    this.serialnumber,
    this.tokenId,
  });

  @override
  String? get path =>
      '/api/v1/accounts/$idOrAliasOrEvmAddress/airdrops/pending';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'limit': limit?.toString(),
    'order': order?.toJson(),
    'sender.id': senderId,
    'serialnumber': serialnumber,
    'token.id': tokenId,
  };

  @override
  HederaMirrorTypesTokenAirdropsResponse onResponse(
    Map<String, dynamic> result,
  ) {
    return HederaMirrorTypesTokenAirdropsResponse.fromJson(result);
  }
}
