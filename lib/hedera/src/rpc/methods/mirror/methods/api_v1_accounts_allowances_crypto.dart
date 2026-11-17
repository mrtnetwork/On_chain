import 'package:on_chain/hedera/src/rpc/core/core.dart';
import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/hedera/src/rpc/models/types.dart';

/// GET /api/v1/accounts/{idOrAliasOrEvmAddress}/allowances/crypto
class HederaMirrorRequestGetCryptoAllowances
    extends
        HederaMirrorRequest<
          HederaMirrorTypesCryptoAllowancesResponse,
          Map<String, dynamic>
        > {
  final String idOrAliasOrEvmAddress;
  final int? limit;
  final HederaMirrorTypesOrder? order;
  final HederaMirrorTypesEntityIdQuery? spenderId;

  const HederaMirrorRequestGetCryptoAllowances({
    required this.idOrAliasOrEvmAddress,
    this.limit,
    this.order,
    this.spenderId,
  });

  @override
  String? get path =>
      '/api/v1/accounts/$idOrAliasOrEvmAddress/allowances/crypto';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'limit': limit?.toString(),
    'order': order?.toJson(),
    'spender.id': spenderId,
  };

  @override
  HederaMirrorTypesCryptoAllowancesResponse onResponse(
    Map<String, dynamic> result,
  ) {
    return HederaMirrorTypesCryptoAllowancesResponse.fromJson(result);
  }
}
