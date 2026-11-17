// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/algorand/src/rpc/core/core.dart';
import 'package:on_chain/algorand/src/rpc/models/types.dart';

/// GET /v2/applications
class AlgoIndexerRequestSearchForApplications
    extends
        AlgoIndexerRequest<
          AlgoRestTypesApplicationsResponse,
          Map<String, dynamic>
        > {
  final int? applicationId;
  final String? creator;
  final bool? includeAll;
  final int? limit;
  final String? next;

  const AlgoIndexerRequestSearchForApplications({
    this.applicationId,
    this.creator,
    this.includeAll,
    this.limit,
    this.next,
  });

  @override
  String get path => '/v2/applications';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'application-id': applicationId?.toString(),
    'creator': creator,
    'include-all': includeAll?.toString(),
    'limit': limit?.toString(),
    'next': next,
  };

  @override
  AlgoRestTypesApplicationsResponse onResponse(Map<String, dynamic> result) {
    return AlgoRestTypesApplicationsResponse.fromJson(result);
  }
}

/// GET /v2/applications/{application-id}
class AlgoIndexerRequestLookupApplicationByID
    extends
        AlgoIndexerRequest<
          AlgoRestTypesApplicationResponse,
          Map<String, dynamic>
        > {
  final BigInt applicationId;
  final bool? includeAll;

  const AlgoIndexerRequestLookupApplicationByID({
    required this.applicationId,
    this.includeAll,
  });

  @override
  String get path => '/v2/applications/$applicationId';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'include-all': includeAll?.toString(),
  };

  @override
  AlgoRestTypesApplicationResponse onResponse(Map<String, dynamic> result) {
    return AlgoRestTypesApplicationResponse.fromJson(result);
  }
}
