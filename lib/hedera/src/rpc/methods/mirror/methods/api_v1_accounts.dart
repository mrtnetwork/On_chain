import 'package:on_chain/hedera/src/rpc/core/core.dart';
import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/hedera/src/rpc/models/types.dart';

/// GET /api/v1/accounts
class HederaMirrorRequestGetAccounts
    extends
        HederaMirrorRequest<
          HederaMirrorTypesAccountsResponse,
          Map<String, dynamic>
        > {
  final String? accountBalance;
  final HederaMirrorTypesEntityIdQuery? accountId;
  final String? accountPublickey;
  final bool? balance;
  final int? limit;
  final HederaMirrorTypesOrder? order;

  const HederaMirrorRequestGetAccounts({
    this.accountBalance,
    this.accountId,
    this.accountPublickey,
    this.balance,
    this.limit,
    this.order,
  });

  @override
  String? get path => '/api/v1/accounts';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'account.balance': accountBalance,
    'account.id': accountId,
    'account.publickey': accountPublickey,
    'balance': balance?.toString(),
    'limit': limit?.toString(),
    'order': order?.toJson(),
  };

  @override
  HederaMirrorTypesAccountsResponse onResponse(Map<String, dynamic> result) {
    return HederaMirrorTypesAccountsResponse.fromJson(result);
  }
}

/// GET /api/v1/accounts/{idOrAliasOrEvmAddress}
class HederaMirrorRequestGetAccount
    extends
        HederaMirrorRequest<
          HederaMirrorTypesAccountBalanceTransactions,
          Map<String, dynamic>
        > {
  final String idOrAliasOrEvmAddress;
  final int? limit;
  final HederaMirrorTypesOrder? order;
  final List<String>? timestamp;
  final HederaMirrorTypesTransactionTypes? transactiontype;
  final bool? transactions;

  const HederaMirrorRequestGetAccount({
    required this.idOrAliasOrEvmAddress,
    this.limit,
    this.order,
    this.timestamp,
    this.transactiontype,
    this.transactions,
  });

  @override
  String? get path => '/api/v1/accounts/$idOrAliasOrEvmAddress';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'limit': limit?.toString(),
    'order': order?.toJson(),
    'timestamp': timestamp?.join(','),
    'transactiontype': transactiontype?.toJson(),
    'transactions': transactions?.toString(),
  };

  @override
  HederaMirrorTypesAccountBalanceTransactions onResponse(
    Map<String, dynamic> result,
  ) {
    return HederaMirrorTypesAccountBalanceTransactions.fromJson(result);
  }
}
