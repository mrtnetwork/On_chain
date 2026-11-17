import 'package:on_chain/hedera/src/rpc/core/core.dart';
import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/hedera/src/rpc/models/types.dart';

/// GET /api/v1/network/registered-nodes
class HederaMirrorRequestGetRegisteredNodes
    extends
        HederaMirrorRequest<
          HederaMirrorTypesRegisteredNodesResponse,
          Map<String, dynamic>
        > {
  final int? limit;
  final HederaMirrorTypesOrder? order;
  final String? registerednodeId;
  final HederaMirrorTypesRegisteredNodeType? type;

  const HederaMirrorRequestGetRegisteredNodes({
    this.limit,
    this.order,
    this.registerednodeId,
    this.type,
  });

  @override
  String? get path => '/api/v1/network/registered-nodes';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'limit': limit?.toString(),
    'order': order?.toJson(),
    'registerednode.id': registerednodeId,
    'type': type?.toJson(),
  };

  @override
  HederaMirrorTypesRegisteredNodesResponse onResponse(
    Map<String, dynamic> result,
  ) {
    return HederaMirrorTypesRegisteredNodesResponse.fromJson(result);
  }
}
