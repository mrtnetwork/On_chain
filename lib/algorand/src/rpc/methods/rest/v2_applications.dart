// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/algorand/src/rpc/core/core.dart';
import 'package:on_chain/algorand/src/rpc/models/types.dart';

/// GET /v2/applications/{application-id}
class AlgoRestRequestGetApplicationByID
    extends AlgoRestRequest<AlgoRestTypesApplication, Map<String, dynamic>> {
  final BigInt applicationId;
  final bool? includeAll;

  const AlgoRestRequestGetApplicationByID({
    required this.applicationId,
    this.includeAll,
  });

  @override
  String get path => '/v2/applications/$applicationId';

  @override
  Map<String, String?> get queryParameters => {
    "include-all": includeAll?.toString(),
  };

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  AlgoRestTypesApplication onResponse(Map<String, dynamic> result) {
    return AlgoRestTypesApplication.fromJson(result);
  }
}
