// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/algorand/src/rpc/core/core.dart';
import 'package:on_chain/algorand/src/rpc/models/types.dart';

/// GET /v2/applications/{application-id}/box
class AlgoRestRequestGetApplicationBoxByName
    extends AlgoRestRequest<AlgoRestTypesBox, Map<String, dynamic>> {
  final BigInt applicationId;
  final String name;

  const AlgoRestRequestGetApplicationBoxByName({
    required this.applicationId,
    required this.name,
  });

  @override
  String get path => '/v2/applications/$applicationId/box';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String> get queryParameters => {'name': name};

  @override
  AlgoRestTypesBox onResponse(Map<String, dynamic> result) {
    return AlgoRestTypesBox.fromJson(result);
  }
}
