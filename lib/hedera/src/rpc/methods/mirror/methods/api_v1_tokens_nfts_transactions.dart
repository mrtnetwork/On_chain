import 'package:on_chain/hedera/src/rpc/core/core.dart';
import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/hedera/src/rpc/models/types.dart';

/// GET /api/v1/tokens/{tokenId}/nfts/{serialNumber}/transactions
class HederaMirrorRequestGetNftTransactions
    extends
        HederaMirrorRequest<
          HederaMirrorTypesNftTransactionHistory,
          Map<String, dynamic>
        > {
  final HederaMirrorTypesEntityId tokenId;
  final int serialNumber;
  final int? limit;
  final HederaMirrorTypesOrder? order;
  final List<String>? timestamp;

  const HederaMirrorRequestGetNftTransactions({
    required this.tokenId,
    required this.serialNumber,
    this.limit,
    this.order,
    this.timestamp,
  });

  @override
  String? get path => '/api/v1/tokens/$tokenId/nfts/$serialNumber/transactions';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'limit': limit?.toString(),
    'order': order?.toJson(),
    'timestamp': timestamp?.join(','),
  };

  @override
  HederaMirrorTypesNftTransactionHistory onResponse(
    Map<String, dynamic> result,
  ) {
    return HederaMirrorTypesNftTransactionHistory.fromJson(result);
  }
}
