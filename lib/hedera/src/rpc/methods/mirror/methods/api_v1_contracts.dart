import 'package:on_chain/hedera/src/rpc/core/core.dart';
import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/hedera/src/rpc/models/types.dart';

/// GET /api/v1/contracts
class HederaMirrorRequestGetContracts
    extends
        HederaMirrorRequest<
          HederaMirrorTypesContractsResponse,
          Map<String, dynamic>
        > {
  final String? contractId;
  final int? limit;
  final HederaMirrorTypesOrder? order;

  const HederaMirrorRequestGetContracts({
    this.contractId,
    this.limit,
    this.order,
  });

  @override
  String? get path => '/api/v1/contracts';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'contract.id': contractId,
    'limit': limit?.toString(),
    'order': order?.toJson(),
  };

  @override
  HederaMirrorTypesContractsResponse onResponse(Map<String, dynamic> result) {
    return HederaMirrorTypesContractsResponse.fromJson(result);
  }
}

/// GET /api/v1/contracts/{contractIdOrAddress}
class HederaMirrorRequestGetContract
    extends
        HederaMirrorRequest<
          HederaMirrorTypesContractResponse,
          Map<String, dynamic>
        > {
  final String contractIdOrAddress;
  final List<String>? timestamp;

  const HederaMirrorRequestGetContract({
    required this.contractIdOrAddress,
    this.timestamp,
  });

  @override
  String? get path => '/api/v1/contracts/$contractIdOrAddress';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'timestamp': timestamp?.join(','),
  };

  @override
  HederaMirrorTypesContractResponse onResponse(Map<String, dynamic> result) {
    return HederaMirrorTypesContractResponse.fromJson(result);
  }
}
