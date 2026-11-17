// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/algorand/src/rpc/core/core.dart';
import 'package:on_chain/algorand/src/rpc/models/types.dart';

/// GET /v2/accounts/{address}/transactions/pending
class AlgoRestRequestGetPendingTransactionsByAddress
    extends
        AlgoRestRequest<
          AlgoRestTypesPendingTransactionsResponse,
          Map<String, dynamic>
        > {
  final String address;
  final int? max;
  @override
  final RequestFormat responseFormat = RequestFormat.msgpack;
  const AlgoRestRequestGetPendingTransactionsByAddress({
    required this.address,
    this.max,
  });

  @override
  String get path => '/v2/accounts/$address/transactions/pending';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'max': max?.toString(),
    'format': responseFormat.name,
  };

  @override
  AlgoRestTypesPendingTransactionsResponse onResponse(
    Map<String, dynamic> result,
  ) {
    return AlgoRestTypesPendingTransactionsResponse.fromJson(result);
  }
}
