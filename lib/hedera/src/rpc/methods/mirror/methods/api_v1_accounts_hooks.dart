import 'package:on_chain/hedera/src/rpc/core/core.dart';
import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/hedera/src/rpc/models/types.dart';

/// GET /api/v1/accounts/{idOrAliasOrEvmAddress}/hooks
class HederaMirrorRequestGetHooks
    extends
        HederaMirrorRequest<
          HederaMirrorTypesHooksResponse,
          Map<String, dynamic>
        > {
  final String idOrAliasOrEvmAddress;
  final int? hookId;
  final int? limit;
  final HederaMirrorTypesOrder? order;

  const HederaMirrorRequestGetHooks({
    required this.idOrAliasOrEvmAddress,
    this.hookId,
    this.limit,
    this.order,
  });

  @override
  String? get path => '/api/v1/accounts/$idOrAliasOrEvmAddress/hooks';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'hook.id': hookId?.toString(),
    'limit': limit?.toString(),
    'order': order?.toJson(),
  };

  @override
  HederaMirrorTypesHooksResponse onResponse(Map<String, dynamic> result) {
    return HederaMirrorTypesHooksResponse.fromJson(result);
  }
}
