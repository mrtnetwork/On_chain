// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/algorand/src/rpc/core/core.dart';
import 'package:on_chain/algorand/src/rpc/models/types.dart';

/// GET /v2/accounts/{account-id}/apps-local-state
class AlgoIndexerRequestLookupAccountAppLocalStates
    extends
        AlgoIndexerRequest<
          AlgoRestTypesApplicationLocalStatesResponse,
          Map<String, dynamic>
        > {
  final String accountId;
  final int? applicationId;
  final bool? includeAll;
  final int? limit;
  final String? next;

  const AlgoIndexerRequestLookupAccountAppLocalStates({
    required this.accountId,
    this.applicationId,
    this.includeAll,
    this.limit,
    this.next,
  });

  @override
  String get path => '/v2/accounts/$accountId/apps-local-state';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'application-id': applicationId?.toString(),
    'include-all': includeAll?.toString(),
    'limit': limit?.toString(),
    'next': next,
  };

  @override
  AlgoRestTypesApplicationLocalStatesResponse onResponse(
    Map<String, dynamic> result,
  ) {
    return AlgoRestTypesApplicationLocalStatesResponse.fromJson(result);
  }
}
