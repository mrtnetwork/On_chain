// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/algorand/src/rpc/core/core.dart';
import 'package:on_chain/algorand/src/rpc/models/types.dart';

/// GET /v2/accounts
class AlgoIndexerRequestSearchForAccounts
    extends
        AlgoIndexerRequest<
          AlgoRestTypesAccountsResponse,
          Map<String, dynamic>
        > {
  final int? assetId;
  final int? limit;
  final String? next;
  final int? currencyGreaterThan;
  final bool? includeAll;
  final List<String>? exclude;
  final int? currencyLessThan;
  final String? authAddr;
  final int? round;
  final int? applicationId;
  final bool? onlineOnly;

  const AlgoIndexerRequestSearchForAccounts({
    this.assetId,
    this.limit,
    this.next,
    this.currencyGreaterThan,
    this.includeAll,
    this.exclude,
    this.currencyLessThan,
    this.authAddr,
    this.round,
    this.applicationId,
    this.onlineOnly,
  });

  @override
  String get path => '/v2/accounts';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'asset-id': assetId?.toString(),
    'limit': limit?.toString(),
    'next': next,
    'currency-greater-than': currencyGreaterThan?.toString(),
    'include-all': includeAll?.toString(),
    'exclude': exclude?.join(','),
    'currency-less-than': currencyLessThan?.toString(),
    'auth-addr': authAddr,
    'round': round?.toString(),
    'application-id': applicationId?.toString(),
    'online-only': onlineOnly?.toString(),
  };

  @override
  AlgoRestTypesAccountsResponse onResponse(Map<String, dynamic> result) {
    return AlgoRestTypesAccountsResponse.fromJson(result);
  }
}

/// GET /v2/accounts/{account-id}
class AlgoIndexerRequestLookupAccountByID
    extends AlgoIndexerRequest<AlgoRestTypesAccount, Map<String, dynamic>> {
  final String accountId;
  final int? round;
  final bool? includeAll;
  final List<String>? exclude;

  const AlgoIndexerRequestLookupAccountByID({
    required this.accountId,
    this.round,
    this.includeAll,
    this.exclude,
  });

  @override
  String get path => '/v2/accounts/$accountId';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'round': round?.toString(),
    'include-all': includeAll?.toString(),
    'exclude': exclude?.join(','),
  };

  @override
  AlgoRestTypesAccount onResponse(Map<String, dynamic> result) {
    return AlgoRestTypesAccount.fromJson(result);
  }
}
