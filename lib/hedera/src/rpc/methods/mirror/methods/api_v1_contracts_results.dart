import 'package:on_chain/hedera/src/rpc/core/core.dart';
import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/hedera/src/rpc/models/types.dart';

/// GET /api/v1/contracts/{contractIdOrAddress}/results
class HederaMirrorRequestGetContractResultsByContractId
    extends
        HederaMirrorRequest<
          HederaMirrorTypesContractResultsResponse,
          Map<String, dynamic>
        > {
  final String contractIdOrAddress;
  final String? blockHash;
  final String? blockNumber;
  final String? from;
  final bool? internal;
  final int? limit;
  final HederaMirrorTypesOrder? order;
  final List<String>? timestamp;
  final int? transactionIndex;

  const HederaMirrorRequestGetContractResultsByContractId({
    required this.contractIdOrAddress,
    this.blockHash,
    this.blockNumber,
    this.from,
    this.internal,
    this.limit,
    this.order,
    this.timestamp,
    this.transactionIndex,
  });

  @override
  String? get path => '/api/v1/contracts/$contractIdOrAddress/results';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'block.hash': blockHash,
    'block.number': blockNumber,
    'from': from,
    'internal': internal?.toString(),
    'limit': limit?.toString(),
    'order': order?.toJson(),
    'timestamp': timestamp?.join(','),
    'transaction.index': transactionIndex?.toString(),
  };

  @override
  HederaMirrorTypesContractResultsResponse onResponse(
    Map<String, dynamic> result,
  ) {
    return HederaMirrorTypesContractResultsResponse.fromJson(result);
  }
}

/// GET /api/v1/contracts/{contractIdOrAddress}/results/{timestamp}
class HederaMirrorRequestGetContractResultByIdAndTimestamp
    extends
        HederaMirrorRequest<
          HederaMirrorTypesContractResultDetails,
          Map<String, dynamic>
        > {
  final String contractIdOrAddress;
  final bool? hbar;
  final String timestamp;

  const HederaMirrorRequestGetContractResultByIdAndTimestamp({
    required this.contractIdOrAddress,
    this.hbar,
    required this.timestamp,
  });

  @override
  String? get path =>
      '/api/v1/contracts/$contractIdOrAddress/results/$timestamp';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {'hbar': hbar?.toString()};

  @override
  HederaMirrorTypesContractResultDetails onResponse(
    Map<String, dynamic> result,
  ) {
    return HederaMirrorTypesContractResultDetails.fromJson(result);
  }
}

/// GET /api/v1/contracts/results
class HederaMirrorRequestGetContractsResults
    extends
        HederaMirrorRequest<
          HederaMirrorTypesContractResultsResponse,
          Map<String, dynamic>
        > {
  final String? from;
  final String? blockHash;
  final String? blockNumber;
  final bool? hbar;
  final bool? internal;
  final int? limit;
  final HederaMirrorTypesOrder? order;
  final List<String>? timestamp;
  final int? transactionIndex;

  const HederaMirrorRequestGetContractsResults({
    this.from,
    this.blockHash,
    this.blockNumber,
    this.hbar,
    this.internal,
    this.limit,
    this.order,
    this.timestamp,
    this.transactionIndex,
  });

  @override
  String? get path => '/api/v1/contracts/results';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'from': from,
    'block.hash': blockHash,
    'block.number': blockNumber,
    'hbar': hbar?.toString(),
    'internal': internal?.toString(),
    'limit': limit?.toString(),
    'order': order?.toJson(),
    'timestamp': timestamp?.join(','),
    'transaction.index': transactionIndex?.toString(),
  };

  @override
  HederaMirrorTypesContractResultsResponse onResponse(
    Map<String, dynamic> result,
  ) {
    return HederaMirrorTypesContractResultsResponse.fromJson(result);
  }
}

/// GET /api/v1/contracts/results/{transactionIdOrHash}
class HederaMirrorRequestGetContractResultByTransactionIdOrHash
    extends
        HederaMirrorRequest<
          HederaMirrorTypesContractResultDetails,
          Map<String, dynamic>
        > {
  final String transactionIdOrHash;
  final bool? hbar;
  final int? nonce;

  const HederaMirrorRequestGetContractResultByTransactionIdOrHash({
    required this.transactionIdOrHash,
    this.hbar,
    this.nonce,
  });

  @override
  String? get path => '/api/v1/contracts/results/$transactionIdOrHash';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'hbar': hbar?.toString(),
    'nonce': nonce?.toString(),
  };

  @override
  HederaMirrorTypesContractResultDetails onResponse(
    Map<String, dynamic> result,
  ) {
    return HederaMirrorTypesContractResultDetails.fromJson(result);
  }
}
