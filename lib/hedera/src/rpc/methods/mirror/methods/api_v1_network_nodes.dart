import 'package:on_chain/hedera/src/rpc/core/core.dart';
import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/hedera/src/rpc/models/types.dart';

/// GET /api/v1/network/nodes
class HederaMirrorRequestGetNetworkNodes
    extends
        HederaMirrorRequest<
          HederaMirrorTypesNetworkNodesResponse,
          Map<String, dynamic>
        > {
  final HederaMirrorTypesEntityIdQuery? fileId;
  final int? limit;
  final String? nodeId;
  final HederaMirrorTypesOrder? order;

  const HederaMirrorRequestGetNetworkNodes({
    this.fileId,
    this.limit,
    this.nodeId,
    this.order,
  });

  @override
  String? get path => '/api/v1/network/nodes';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'file.id': fileId,
    'limit': limit?.toString(),
    'node.id': nodeId,
    'order': order?.toJson(),
  };

  @override
  HederaMirrorTypesNetworkNodesResponse onResponse(
    Map<String, dynamic> result,
  ) {
    return HederaMirrorTypesNetworkNodesResponse.fromJson(result);
  }
}
