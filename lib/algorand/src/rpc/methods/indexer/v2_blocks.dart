// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/algorand/src/rpc/core/core.dart';
import 'package:on_chain/algorand/src/rpc/models/types.dart';

/// GET /v2/blocks/{round-number}
class AlgoIndexerRequestLookupBlock
    extends AlgoIndexerRequest<AlgoRestTypesBlock, Map<String, dynamic>> {
  final int roundNumber;
  final bool? headerOnly;

  const AlgoIndexerRequestLookupBlock({
    required this.roundNumber,
    this.headerOnly,
  });

  @override
  String get path => '/v2/blocks/$roundNumber';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'header-only': headerOnly?.toString(),
  };

  @override
  AlgoRestTypesBlock onResponse(Map<String, dynamic> result) {
    return AlgoRestTypesBlock.fromJson(result);
  }
}
