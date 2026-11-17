// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/algorand/src/rpc/core/core.dart';
import 'package:on_chain/algorand/src/rpc/models/types.dart';

/// GET /v2/accounts/{address}/applications
class AlgoRestRequestAccountApplicationsInformation
    extends
        AlgoRestRequest<
          AlgoRestTypesAccountApplicationsInformationResponse,
          Map<String, dynamic>
        > {
  final String address;
  final int? limit;
  final String? next;
  final List<String>? include;

  const AlgoRestRequestAccountApplicationsInformation({
    required this.address,
    this.limit,
    this.next,
    this.include,
  });

  @override
  String get path => '/v2/accounts/$address/applications';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'limit': limit?.toString(),
    'next': next,
    'include': include?.join(','),
  };

  @override
  AlgoRestTypesAccountApplicationsInformationResponse onResponse(
    Map<String, dynamic> result,
  ) {
    return AlgoRestTypesAccountApplicationsInformationResponse.fromJson(result);
  }
}

/// GET /v2/accounts/{address}/applications/{application-id}
class AlgoRestRequestAccountApplicationInformation
    extends
        AlgoRestRequest<
          AlgoRestTypesAccountApplicationResponse,
          Map<String, dynamic>
        > {
  final String address;
  final BigInt applicationId;
  @override
  final RequestFormat? responseFormat;

  const AlgoRestRequestAccountApplicationInformation({
    required this.address,
    required this.applicationId,
    this.responseFormat,
  });

  @override
  String get path => '/v2/accounts/$address/applications/$applicationId';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {'format': responseFormat?.name};

  @override
  AlgoRestTypesAccountApplicationResponse onResponse(
    Map<String, dynamic> result,
  ) {
    return AlgoRestTypesAccountApplicationResponse.fromJson(result);
  }
}
