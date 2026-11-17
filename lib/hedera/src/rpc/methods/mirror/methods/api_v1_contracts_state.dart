import 'package:on_chain/hedera/src/rpc/core/core.dart';
import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/hedera/src/rpc/models/types.dart';

/// GET /api/v1/contracts/{contractIdOrAddress}/state
class HederaMirrorRequestGetContractState
    extends
        HederaMirrorRequest<
          HederaMirrorTypesContractStateResponse,
          Map<String, dynamic>
        > {
  final String contractIdOrAddress;
  final int? limit;
  final HederaMirrorTypesOrder? order;
  final String? slot;
  final List<String>? timestamp;

  const HederaMirrorRequestGetContractState({
    required this.contractIdOrAddress,
    this.limit,
    this.order,
    this.slot,
    this.timestamp,
  });

  @override
  String? get path => '/api/v1/contracts/$contractIdOrAddress/state';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'limit': limit?.toString(),
    'order': order?.toJson(),
    'slot': slot,
    'timestamp': timestamp?.join(','),
  };

  @override
  HederaMirrorTypesContractStateResponse onResponse(
    Map<String, dynamic> result,
  ) {
    return HederaMirrorTypesContractStateResponse.fromJson(result);
  }
}
