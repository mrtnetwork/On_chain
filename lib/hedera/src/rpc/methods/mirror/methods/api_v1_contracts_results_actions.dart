import 'package:on_chain/hedera/src/rpc/core/core.dart';
import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/hedera/src/rpc/models/types.dart';

/// GET /api/v1/contracts/results/{transactionIdOrHash}/actions
class HederaMirrorRequestGetContractActions
    extends
        HederaMirrorRequest<
          HederaMirrorTypesContractActionsResponse,
          Map<String, dynamic>
        > {
  final String transactionIdOrHash;
  final String? index;
  final int? limit;
  final HederaMirrorTypesOrder? order;

  const HederaMirrorRequestGetContractActions({
    required this.transactionIdOrHash,
    this.index,
    this.limit,
    this.order,
  });

  @override
  String? get path => '/api/v1/contracts/results/$transactionIdOrHash/actions';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'index': index,
    'limit': limit?.toString(),
    'order': order?.toJson(),
  };

  @override
  HederaMirrorTypesContractActionsResponse onResponse(
    Map<String, dynamic> result,
  ) {
    return HederaMirrorTypesContractActionsResponse.fromJson(result);
  }
}
