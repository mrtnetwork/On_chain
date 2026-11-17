import 'package:on_chain/hedera/src/rpc/core/core.dart';
import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/hedera/src/rpc/models/types.dart';

/// GET /api/v1/transactions
class HederaMirrorRequestGetTransactions
    extends
        HederaMirrorRequest<
          HederaMirrorTypesTransactionsResponse,
          Map<String, dynamic>
        > {
  final HederaMirrorTypesEntityIdQuery? accountId;
  final int? limit;
  final HederaMirrorTypesOrder? order;
  final List<String>? timestamp;
  final HederaMirrorTypesTransactionTypes? transactiontype;
  final HederaMirrorTypesResult? result;
  final HederaMirrorTypesType? type;

  const HederaMirrorRequestGetTransactions({
    this.accountId,
    this.limit,
    this.order,
    this.timestamp,
    this.transactiontype,
    this.result,
    this.type,
  });

  @override
  String? get path => '/api/v1/transactions';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'account.id': accountId,
    'limit': limit?.toString(),
    'order': order?.toJson(),
    'timestamp': timestamp?.join(','),
    'transactiontype': transactiontype?.toJson(),
    'result': result?.toJson(),
    'type': type?.toJson(),
  };

  @override
  HederaMirrorTypesTransactionsResponse onResponse(
    Map<String, dynamic> result,
  ) {
    return HederaMirrorTypesTransactionsResponse.fromJson(result);
  }
}

/// GET /api/v1/transactions/{transactionId}
class HederaMirrorRequestGetTransaction
    extends
        HederaMirrorRequest<
          HederaMirrorTypesTransactionByIdResponse,
          Map<String, dynamic>
        > {
  final String transactionId;
  final int? nonce;
  final bool? scheduled;

  const HederaMirrorRequestGetTransaction({
    required this.transactionId,
    this.nonce,
    this.scheduled,
  });

  @override
  String? get path => '/api/v1/transactions/$transactionId';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'nonce': nonce?.toString(),
    'scheduled': scheduled?.toString(),
  };

  @override
  HederaMirrorTypesTransactionByIdResponse onResponse(
    Map<String, dynamic> result,
  ) {
    return HederaMirrorTypesTransactionByIdResponse.fromJson(result);
  }
}
