// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/algorand/src/rpc/core/core.dart';
import 'package:on_chain/algorand/src/rpc/models/types.dart';

/// GET /v2/accounts/{address}
class AlgoRestRequestAccountInformation
    extends AlgoRestRequest<AlgoRestTypesAccount, Map<String, dynamic>> {
  final String address;
  final List<String>? exclude;
  @override
  final RequestFormat? responseFormat;

  const AlgoRestRequestAccountInformation({
    required this.address,
    this.exclude,
    this.responseFormat,
  });

  @override
  String get path => '/v2/accounts/$address';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'exclude': exclude?.join(','),
    'format': responseFormat?.name,
  };

  @override
  AlgoRestTypesAccount onResponse(Map<String, dynamic> result) {
    return AlgoRestTypesAccount.fromJson(result);
  }
}
