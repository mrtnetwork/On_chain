// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/algorand/src/rpc/core/core.dart';
import 'package:on_chain/algorand/src/rpc/models/types.dart';

/// GET /v2/block-headers
class AlgoIndexerRequestSearchForBlockHeaders
    extends
        AlgoIndexerRequest<
          AlgoRestTypesBlockHeadersResponse,
          Map<String, dynamic>
        > {
  final int? limit;
  final String? next;
  final int? minRound;
  final int? maxRound;
  final String? beforeTime;
  final String? afterTime;
  final List<String>? proposers;
  final List<String>? expired;
  final List<String>? absent;

  const AlgoIndexerRequestSearchForBlockHeaders({
    this.limit,
    this.next,
    this.minRound,
    this.maxRound,
    this.beforeTime,
    this.afterTime,
    this.proposers,
    this.expired,
    this.absent,
  });

  @override
  String get path => '/v2/block-headers';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'limit': limit?.toString(),
    'next': next,
    'min-round': minRound?.toString(),
    'max-round': maxRound?.toString(),
    'before-time': beforeTime,
    'after-time': afterTime,
    'proposers': proposers?.join(','),
    'expired': expired?.join(','),
    'absent': absent?.join(','),
  };

  @override
  AlgoRestTypesBlockHeadersResponse onResponse(Map<String, dynamic> result) {
    return AlgoRestTypesBlockHeadersResponse.fromJson(result);
  }
}
