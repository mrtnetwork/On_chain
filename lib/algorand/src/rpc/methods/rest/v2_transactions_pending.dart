// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/algorand/src/rpc/core/core.dart';
import 'package:on_chain/algorand/src/rpc/models/types.dart';

/// GET /v2/transactions/pending
class AlgoRestRequestGetPendingTransactions
    extends
        AlgoRestRequest<
          AlgoRestTypesPendingTransactionsResponse,
          Map<String, dynamic>
        > {
  final int? max;
  // final Format? format;

  const AlgoRestRequestGetPendingTransactions({this.max});

  @override
  String get path => '/v2/transactions/pending';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  final RequestFormat responseFormat = RequestFormat.msgpack;

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

/// GET /v2/transactions/pending/{txid}
class AlgoRestRequestPendingTransactionInformation
    extends
        AlgoRestRequest<
          AlgoRestTypesPendingTransactionResponse,
          Map<String, dynamic>
        > {
  final String txid;

  const AlgoRestRequestPendingTransactionInformation({required this.txid});

  @override
  String get path => '/v2/transactions/pending/$txid';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {'format': responseFormat.name};

  @override
  final RequestFormat responseFormat = RequestFormat.msgpack;
  @override
  AlgoRestTypesPendingTransactionResponse onResponse(
    Map<String, dynamic> result,
  ) {
    return AlgoRestTypesPendingTransactionResponse.fromJson(result);
  }
}
