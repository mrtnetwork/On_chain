// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/algorand/src/rpc/core/core.dart';
import 'package:on_chain/algorand/src/rpc/models/types.dart';

/// GET /v2/applications/{application-id}/boxes
class AlgoIndexerRequestSearchForApplicationBoxes
    extends
        AlgoIndexerRequest<AlgoRestTypesBoxesResponse, Map<String, dynamic>> {
  final BigInt applicationId;
  final int? limit;
  final String? next;
  final List<String>? include;

  const AlgoIndexerRequestSearchForApplicationBoxes({
    required this.applicationId,
    this.limit,
    this.next,
    this.include,
  });

  @override
  String get path => '/v2/applications/$applicationId/boxes';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'limit': limit?.toString(),
    'next': next,
    'include': include?.join(','),
  };

  @override
  AlgoRestTypesBoxesResponse onResponse(Map<String, dynamic> result) {
    return AlgoRestTypesBoxesResponse.fromJson(result);
  }
}
