import 'package:on_chain/hedera/src/rpc/core/core.dart';
import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/hedera/src/rpc/models/types.dart';

/// GET /api/v1/tokens/{tokenId}/nfts
class HederaMirrorRequestGetNfts
    extends HederaMirrorRequest<HederaMirrorTypesNfts, Map<String, dynamic>> {
  final HederaMirrorTypesEntityId tokenId;
  final HederaMirrorTypesEntityIdQuery? accountId;
  final int? limit;
  final HederaMirrorTypesOrder? order;
  final String? serialnumber;

  const HederaMirrorRequestGetNfts({
    required this.tokenId,
    this.accountId,
    this.limit,
    this.order,
    this.serialnumber,
  });

  @override
  String? get path => '/api/v1/tokens/$tokenId/nfts';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'account.id': accountId,
    'limit': limit?.toString(),
    'order': order?.toJson(),
    'serialnumber': serialnumber,
  };

  @override
  HederaMirrorTypesNfts onResponse(Map<String, dynamic> result) {
    return HederaMirrorTypesNfts.fromJson(result);
  }
}

/// GET /api/v1/tokens/{tokenId}/nfts/{serialNumber}
class HederaMirrorRequestGetNft
    extends HederaMirrorRequest<HederaMirrorTypesNft, Map<String, dynamic>> {
  final HederaMirrorTypesEntityId tokenId;
  final int serialNumber;

  const HederaMirrorRequestGetNft({
    required this.tokenId,
    required this.serialNumber,
  });

  @override
  String? get path => '/api/v1/tokens/$tokenId/nfts/$serialNumber';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  HederaMirrorTypesNft onResponse(Map<String, dynamic> result) {
    return HederaMirrorTypesNft.fromJson(result);
  }
}
