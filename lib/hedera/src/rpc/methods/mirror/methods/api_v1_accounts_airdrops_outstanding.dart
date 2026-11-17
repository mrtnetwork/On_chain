import 'package:on_chain/hedera/src/rpc/core/core.dart';
import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/hedera/src/rpc/models/types.dart';

/// GET /api/v1/accounts/{idOrAliasOrEvmAddress}/airdrops/outstanding
class HederaMirrorRequestGetOutstandingTokenAirdrops
    extends
        HederaMirrorRequest<
          HederaMirrorTypesTokenAirdropsResponse,
          Map<String, dynamic>
        > {
  final String idOrAliasOrEvmAddress;
  final int? limit;
  final HederaMirrorTypesOrder? order;
  final HederaMirrorTypesEntityIdQuery? receiverId;
  final String? serialnumber;
  final HederaMirrorTypesEntityIdQuery? tokenId;

  const HederaMirrorRequestGetOutstandingTokenAirdrops({
    required this.idOrAliasOrEvmAddress,
    this.limit,
    this.order,
    this.receiverId,
    this.serialnumber,
    this.tokenId,
  });

  @override
  String? get path =>
      '/api/v1/accounts/$idOrAliasOrEvmAddress/airdrops/outstanding';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'limit': limit?.toString(),
    'order': order?.toJson(),
    'receiver.id': receiverId,
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
