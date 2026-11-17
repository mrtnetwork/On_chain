import 'package:on_chain/hedera/src/rpc/core/core.dart';
import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/hedera/src/rpc/models/types.dart';

/// GET /api/v1/contracts/{contractIdOrAddress}/results/logs
class HederaMirrorRequestGetContractLogsByContractId
    extends
        HederaMirrorRequest<
          HederaMirrorTypesContractLogsResponse,
          Map<String, dynamic>
        > {
  final String contractIdOrAddress;
  final String? index;
  final int? limit;
  final HederaMirrorTypesOrder? order;
  final List<String>? timestamp;
  final HederaMirrorTypesLogTopicQueryParam? topic0;
  final HederaMirrorTypesLogTopicQueryParam? topic1;
  final HederaMirrorTypesLogTopicQueryParam? topic2;
  final HederaMirrorTypesLogTopicQueryParam? topic3;

  const HederaMirrorRequestGetContractLogsByContractId({
    required this.contractIdOrAddress,
    this.index,
    this.limit,
    this.order,
    this.timestamp,
    this.topic0,
    this.topic1,
    this.topic2,
    this.topic3,
  });

  @override
  String? get path => '/api/v1/contracts/$contractIdOrAddress/results/logs';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'index': index,
    'limit': limit?.toString(),
    'order': order?.toJson(),
    'timestamp': timestamp?.join(','),
    'topic0': topic0?.join(','),
    'topic1': topic1?.join(','),
    'topic2': topic2?.join(','),
    'topic3': topic3?.join(','),
  };

  @override
  HederaMirrorTypesContractLogsResponse onResponse(
    Map<String, dynamic> result,
  ) {
    return HederaMirrorTypesContractLogsResponse.fromJson(result);
  }
}

/// GET /api/v1/contracts/results/logs
class HederaMirrorRequestGetContractsLogs
    extends
        HederaMirrorRequest<
          HederaMirrorTypesContractLogsResponse,
          Map<String, dynamic>
        > {
  final String? index;
  final int? limit;
  final HederaMirrorTypesOrder? order;
  final List<String>? timestamp;
  final HederaMirrorTypesLogTopicQueryParam? topic0;
  final HederaMirrorTypesLogTopicQueryParam? topic1;
  final HederaMirrorTypesLogTopicQueryParam? topic2;
  final HederaMirrorTypesLogTopicQueryParam? topic3;
  final String? transactionHash;

  const HederaMirrorRequestGetContractsLogs({
    this.index,
    this.limit,
    this.order,
    this.timestamp,
    this.topic0,
    this.topic1,
    this.topic2,
    this.topic3,
    this.transactionHash,
  });

  @override
  String? get path => '/api/v1/contracts/results/logs';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'index': index,
    'limit': limit?.toString(),
    'order': order?.toJson(),
    'timestamp': timestamp?.join(','),
    'topic0': topic0?.join(','),
    'topic1': topic1?.join(','),
    'topic2': topic2?.join(','),
    'topic3': topic3?.join(','),
    'transaction.hash': transactionHash,
  };

  @override
  HederaMirrorTypesContractLogsResponse onResponse(
    Map<String, dynamic> result,
  ) {
    return HederaMirrorTypesContractLogsResponse.fromJson(result);
  }
}
