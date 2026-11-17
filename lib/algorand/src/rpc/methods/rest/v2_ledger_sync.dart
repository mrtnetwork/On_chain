// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/algorand/src/rpc/core/core.dart';
import 'package:on_chain/algorand/src/rpc/models/types.dart';

class AlgoRestRequestUnsetSyncRound extends AlgoRestRequest<String, dynamic> {
  const AlgoRestRequestUnsetSyncRound();

  @override
  String get path => '/v2/ledger/sync';

  @override
  RequestMethod get requestMethod => RequestMethod.delete;
}

/// GET /v2/ledger/sync
class AlgoRestRequestGetSyncRound
    extends
        AlgoRestRequest<
          AlgoRestTypesGetSyncRoundResponse,
          Map<String, dynamic>
        > {
  const AlgoRestRequestGetSyncRound();

  @override
  String get path => '/v2/ledger/sync';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  AlgoRestTypesGetSyncRoundResponse onResponse(Map<String, dynamic> result) {
    return AlgoRestTypesGetSyncRoundResponse.fromJson(result);
  }
}

class AlgoRestRequestSetSyncRound extends AlgoRestRequest<String, dynamic> {
  final BigInt round;

  const AlgoRestRequestSetSyncRound({required this.round});

  @override
  String get path => '/v2/ledger/sync/$round';

  @override
  RequestMethod get requestMethod => RequestMethod.post;
}
