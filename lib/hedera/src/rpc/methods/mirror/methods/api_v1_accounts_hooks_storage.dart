import 'package:on_chain/hedera/src/rpc/core/core.dart';
import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/hedera/src/rpc/models/types.dart';

/// GET /api/v1/accounts/{idOrAliasOrEvmAddress}/hooks/{hookId}/storage
class HederaMirrorRequestGetHookStorage
    extends
        HederaMirrorRequest<
          HederaMirrorTypesHooksStorageResponse,
          Map<String, dynamic>
        > {
  final String idOrAliasOrEvmAddress;
  final int hookId;
  final String? key;
  final int? limit;
  final HederaMirrorTypesOrder? order;
  final List<String>? timestamp;

  const HederaMirrorRequestGetHookStorage({
    required this.idOrAliasOrEvmAddress,
    required this.hookId,
    this.key,
    this.limit,
    this.order,
    this.timestamp,
  });

  @override
  String? get path =>
      '/api/v1/accounts/$idOrAliasOrEvmAddress/hooks/$hookId/storage';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'key': key,
    'limit': limit?.toString(),
    'order': order?.toJson(),
    'timestamp': timestamp?.join(','),
  };

  @override
  HederaMirrorTypesHooksStorageResponse onResponse(
    Map<String, dynamic> result,
  ) {
    return HederaMirrorTypesHooksStorageResponse.fromJson(result);
  }
}
