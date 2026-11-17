// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/algorand/src/rpc/core/core.dart';

class AlgoRestRequestRawTransactionAsync
    extends AlgoRestRequest<dynamic, dynamic> {
  final bool? skipPqAddressCheck;
  final BuBytes source;

  AlgoRestRequestRawTransactionAsync({
    this.skipPqAddressCheck,
    required List<int> source,
  }) : source = source.asImmutableBytes;

  @override
  String get path => '/v2/transactions/async';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, String?> get queryParameters => {
    'skip-pq-address-check': skipPqAddressCheck?.toString(),
  };

  @override
  BuBytes body() => source;

  @override
  dynamic onResponse(dynamic result) {
    return result;
  }
}
