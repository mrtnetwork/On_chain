// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/algorand/src/rpc/core/core.dart';
import 'package:on_chain/algorand/src/rpc/models/types.dart';

/// GET /v2/applications/{application-id}/boxes
class AlgoRestRequestGetApplicationBoxes
    extends AlgoRestRequest<AlgoRestTypesBoxesResponse, Map<String, dynamic>> {
  final BigInt applicationId;
  final int? max;
  final int? limit;
  final String? next;
  final String? prefix;
  final List<String>? include;
  final int? round;

  const AlgoRestRequestGetApplicationBoxes({
    required this.applicationId,
    this.max,
    this.limit,
    this.next,
    this.prefix,
    this.include,
    this.round,
  });

  @override
  String get path => '/v2/applications/$applicationId/boxes';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'max': max?.toString(),
    'limit': limit?.toString(),
    'next': next,
    'prefix': prefix,
    'include': include?.join(','),
    'round': round?.toString(),
  };

  @override
  AlgoRestTypesBoxesResponse onResponse(Map<String, dynamic> result) {
    return AlgoRestTypesBoxesResponse.fromJson(result);
  }
}
