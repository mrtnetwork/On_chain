// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/algorand/src/rpc/core/core.dart';
import 'package:on_chain/algorand/src/rpc/models/types.dart';

/// GET /v2/devmode/blocks/offset
class AlgoRestRequestGetBlockTimeStampOffset
    extends
        AlgoRestRequest<
          AlgoRestTypesGetBlockTimeStampOffsetResponse,
          Map<String, dynamic>
        > {
  const AlgoRestRequestGetBlockTimeStampOffset();

  @override
  String get path => '/v2/devmode/blocks/offset';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  AlgoRestTypesGetBlockTimeStampOffsetResponse onResponse(
    Map<String, dynamic> result,
  ) {
    return AlgoRestTypesGetBlockTimeStampOffsetResponse.fromJson(result);
  }
}

class AlgoRestRequestSetBlockTimeStampOffset
    extends AlgoRestRequest<dynamic, dynamic> {
  final int offset;

  const AlgoRestRequestSetBlockTimeStampOffset({required this.offset});

  @override
  String get path => '/v2/devmode/blocks/offset/$offset';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic onResponse(dynamic result) {
    return result;
  }
}
