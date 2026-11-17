// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/algorand/src/rpc/core/core.dart';
import 'package:on_chain/algorand/src/rpc/models/types.dart';

/// GET /v2/accounts/{account-id}/transactions
class AlgoIndexerRequestLookupAccountTransactions
    extends
        AlgoIndexerRequest<
          AlgoRestTypesTransactionsResponse,
          Map<String, dynamic>
        > {
  final int? limit;
  final String? next;
  final String? notePrefix;
  final String? txType;
  final String? sigType;
  final String? txid;
  final int? round;
  final int? minRound;
  final int? maxRound;
  final int? assetId;
  final String? beforeTime;
  final String? afterTime;
  final int? currencyGreaterThan;
  final int? currencyLessThan;
  final String accountId;
  final bool? rekeyTo;

  const AlgoIndexerRequestLookupAccountTransactions({
    this.limit,
    this.next,
    this.notePrefix,
    this.txType,
    this.sigType,
    this.txid,
    this.round,
    this.minRound,
    this.maxRound,
    this.assetId,
    this.beforeTime,
    this.afterTime,
    this.currencyGreaterThan,
    this.currencyLessThan,
    required this.accountId,
    this.rekeyTo,
  });

  @override
  String get path => '/v2/accounts/$accountId/transactions';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'limit': limit?.toString(),
    'next': next,
    'note-prefix': notePrefix,
    'tx-type': txType?.toString(),
    'sig-type': sigType?.toString(),
    'txid': txid,
    'round': round?.toString(),
    'min-round': minRound?.toString(),
    'max-round': maxRound?.toString(),
    'asset-id': assetId?.toString(),
    'before-time': beforeTime,
    'after-time': afterTime,
    'currency-greater-than': currencyGreaterThan?.toString(),
    'currency-less-than': currencyLessThan?.toString(),
    'rekey-to': rekeyTo?.toString(),
  };

  @override
  AlgoRestTypesTransactionsResponse onResponse(Map<String, dynamic> result) {
    return AlgoRestTypesTransactionsResponse.fromJson(result);
  }
}
