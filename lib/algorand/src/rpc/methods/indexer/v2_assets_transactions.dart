// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/algorand/src/rpc/core/core.dart';
import 'package:on_chain/algorand/src/rpc/models/types.dart';

/// GET /v2/assets/{asset-id}/transactions
class AlgoIndexerRequestLookupAssetTransactions
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
  final String? beforeTime;
  final String? afterTime;
  final int? currencyGreaterThan;
  final int? currencyLessThan;
  final String? address;
  final String? addressRole;
  final bool? excludeCloseTo;
  final int assetId;
  final bool? rekeyTo;

  const AlgoIndexerRequestLookupAssetTransactions({
    this.limit,
    this.next,
    this.notePrefix,
    this.txType,
    this.sigType,
    this.txid,
    this.round,
    this.minRound,
    this.maxRound,
    this.beforeTime,
    this.afterTime,
    this.currencyGreaterThan,
    this.currencyLessThan,
    this.address,
    this.addressRole,
    this.excludeCloseTo,
    required this.assetId,
    this.rekeyTo,
  });

  @override
  String get path => '/v2/assets/$assetId/transactions';

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
    'before-time': beforeTime,
    'after-time': afterTime,
    'currency-greater-than': currencyGreaterThan?.toString(),
    'currency-less-than': currencyLessThan?.toString(),
    'address': address,
    'address-role': addressRole?.toString(),
    'exclude-close-to': excludeCloseTo?.toString(),
    'rekey-to': rekeyTo?.toString(),
  };

  @override
  AlgoRestTypesTransactionsResponse onResponse(Map<String, dynamic> result) {
    return AlgoRestTypesTransactionsResponse.fromJson(result);
  }
}
