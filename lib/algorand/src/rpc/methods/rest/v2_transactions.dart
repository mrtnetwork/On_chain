// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/algorand/src/rpc/core/core.dart';
import 'package:on_chain/algorand/src/rpc/models/types.dart';

/// POST /v2/transactions
class AlgoRestRequestRawTransaction
    extends
        AlgoRestRequest<
          AlgoRestTypesPostTransactionsResponse,
          Map<String, dynamic>
        > {
  final bool? skipPqAddressCheck;
  final BuBytes source;

  AlgoRestRequestRawTransaction({
    this.skipPqAddressCheck,
    required List<int> source,
  }) : source = source.asImmutableBytes;

  @override
  String get path => '/v2/transactions';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, String?> get queryParameters => {
    'skip-pq-address-check': skipPqAddressCheck?.toString(),
  };

  @override
  BuBytes body() => source;

  @override
  AlgoRestTypesPostTransactionsResponse onResponse(
    Map<String, dynamic> result,
  ) {
    return AlgoRestTypesPostTransactionsResponse.fromJson(result);
  }
}
