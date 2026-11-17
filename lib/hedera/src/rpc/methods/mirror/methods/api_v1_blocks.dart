import 'package:on_chain/hedera/src/rpc/core/core.dart';
import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/hedera/src/rpc/models/types.dart';

/// GET /api/v1/blocks
class HederaMirrorRequestGetBlocks
    extends
        HederaMirrorRequest<
          HederaMirrorTypesBlocksResponse,
          Map<String, dynamic>
        > {
  final String? blockNumber;
  final int? limit;
  final HederaMirrorTypesOrder? order;
  final List<String>? timestamp;

  const HederaMirrorRequestGetBlocks({
    this.blockNumber,
    this.limit,
    this.order,
    this.timestamp,
  });

  @override
  String? get path => '/api/v1/blocks';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'block.number': blockNumber,
    'limit': limit?.toString(),
    'order': order?.toJson(),
    'timestamp': timestamp?.join(','),
  };

  @override
  HederaMirrorTypesBlocksResponse onResponse(Map<String, dynamic> result) {
    return HederaMirrorTypesBlocksResponse.fromJson(result);
  }
}

/// GET /api/v1/blocks/{hashOrNumber}
class HederaMirrorRequestGetBlock
    extends HederaMirrorRequest<HederaMirrorTypesBlock, Map<String, dynamic>> {
  final String hashOrNumber;

  const HederaMirrorRequestGetBlock({required this.hashOrNumber});

  @override
  String? get path => '/api/v1/blocks/$hashOrNumber';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  HederaMirrorTypesBlock onResponse(Map<String, dynamic> result) {
    return HederaMirrorTypesBlock.fromJson(result);
  }
}
