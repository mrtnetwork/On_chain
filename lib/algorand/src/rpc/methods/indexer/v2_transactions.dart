// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/algorand/src/rpc/core/core.dart';
import 'package:on_chain/algorand/src/rpc/models/types.dart';

/// GET /v2/transactions
class AlgoIndexerRequestSearchForTransactions
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
  final String? groupId;
  final String? txid;
  final int? round;
  final int? minRound;
  final int? maxRound;
  final int? assetId;
  final String? beforeTime;
  final String? afterTime;
  final int? currencyGreaterThan;
  final int? currencyLessThan;
  final String? address;
  final String? addressRole;
  final bool? excludeCloseTo;
  final bool? rekeyTo;
  final int? applicationId;

  const AlgoIndexerRequestSearchForTransactions({
    this.limit,
    this.next,
    this.notePrefix,
    this.txType,
    this.sigType,
    this.groupId,
    this.txid,
    this.round,
    this.minRound,
    this.maxRound,
    this.assetId,
    this.beforeTime,
    this.afterTime,
    this.currencyGreaterThan,
    this.currencyLessThan,
    this.address,
    this.addressRole,
    this.excludeCloseTo,
    this.rekeyTo,
    this.applicationId,
  });

  @override
  String get path => '/v2/transactions';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'limit': limit?.toString(),
    'next': next,
    'note-prefix': notePrefix,
    'tx-type': txType?.toString(),
    'sig-type': sigType?.toString(),
    'group-id': groupId,
    'txid': txid,
    'round': round?.toString(),
    'min-round': minRound?.toString(),
    'max-round': maxRound?.toString(),
    'asset-id': assetId?.toString(),
    'before-time': beforeTime,
    'after-time': afterTime,
    'currency-greater-than': currencyGreaterThan?.toString(),
    'currency-less-than': currencyLessThan?.toString(),
    'address': address,
    'address-role': addressRole?.toString(),
    'exclude-close-to': excludeCloseTo?.toString(),
    'rekey-to': rekeyTo?.toString(),
    'application-id': applicationId?.toString(),
  };

  @override
  AlgoRestTypesTransactionsResponse onResponse(Map<String, dynamic> result) {
    return AlgoRestTypesTransactionsResponse.fromJson(result);
  }
}

/// GET /v2/transactions/{txid}
class AlgoIndexerRequestLookupTransaction
    extends
        AlgoIndexerRequest<
          AlgoRestTypesTransactionResponse,
          Map<String, dynamic>
        > {
  final String txid;

  const AlgoIndexerRequestLookupTransaction({required this.txid});

  @override
  String get path => '/v2/transactions/$txid';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  AlgoRestTypesTransactionResponse onResponse(Map<String, dynamic> result) {
    return AlgoRestTypesTransactionResponse.fromJson(result);
  }
}
