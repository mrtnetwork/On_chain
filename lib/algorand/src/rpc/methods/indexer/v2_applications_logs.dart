// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/algorand/src/rpc/core/core.dart';
import 'package:on_chain/algorand/src/rpc/models/types.dart';

/// GET /v2/applications/{application-id}/logs
class AlgoIndexerRequestLookupApplicationLogsByID
    extends
        AlgoIndexerRequest<
          AlgoRestTypesApplicationLogsResponse,
          Map<String, dynamic>
        > {
  final BigInt applicationId;
  final int? limit;
  final String? next;
  final String? txid;
  final int? minRound;
  final int? maxRound;
  final String? senderAddress;

  const AlgoIndexerRequestLookupApplicationLogsByID({
    required this.applicationId,
    this.limit,
    this.next,
    this.txid,
    this.minRound,
    this.maxRound,
    this.senderAddress,
  });

  @override
  String get path => '/v2/applications/$applicationId/logs';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'limit': limit?.toString(),
    'next': next,
    'txid': txid,
    'min-round': minRound?.toString(),
    'max-round': maxRound?.toString(),
    'sender-address': senderAddress,
  };

  @override
  AlgoRestTypesApplicationLogsResponse onResponse(Map<String, dynamic> result) {
    return AlgoRestTypesApplicationLogsResponse.fromJson(result);
  }
}
