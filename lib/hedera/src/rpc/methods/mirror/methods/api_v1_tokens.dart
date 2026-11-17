import 'package:on_chain/hedera/src/rpc/core/core.dart';
import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/hedera/src/rpc/models/types.dart';

/// GET /api/v1/tokens
class HederaMirrorRequestGetTokens
    extends
        HederaMirrorRequest<
          HederaMirrorTypesTokensResponse,
          Map<String, dynamic>
        > {
  final HederaMirrorTypesEntityIdQuery? accountId;
  final int? limit;
  final String? name;
  final HederaMirrorTypesOrder? order;
  final String? publickey;
  final HederaMirrorTypesEntityIdQuery? tokenId;
  final List<String>? type;

  const HederaMirrorRequestGetTokens({
    this.accountId,
    this.limit,
    this.name,
    this.order,
    this.publickey,
    this.tokenId,
    this.type,
  });

  @override
  String? get path => '/api/v1/tokens';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'account.id': accountId,
    'limit': limit?.toString(),
    'name': name,
    'order': order?.toJson(),
    'publickey': publickey,
    'token.id': tokenId,
    'type': type?.join(','),
  };

  @override
  HederaMirrorTypesTokensResponse onResponse(Map<String, dynamic> result) {
    return HederaMirrorTypesTokensResponse.fromJson(result);
  }
}

/// GET /api/v1/tokens/{tokenId}
class HederaMirrorRequestGetToken
    extends
        HederaMirrorRequest<HederaMirrorTypesTokenInfo, Map<String, dynamic>> {
  final HederaMirrorTypesEntityId tokenId;
  final String? timestamp;

  const HederaMirrorRequestGetToken({required this.tokenId, this.timestamp});

  @override
  String? get path => '/api/v1/tokens/$tokenId';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {'timestamp': timestamp};

  @override
  HederaMirrorTypesTokenInfo onResponse(Map<String, dynamic> result) {
    return HederaMirrorTypesTokenInfo.fromJson(result);
  }
}
