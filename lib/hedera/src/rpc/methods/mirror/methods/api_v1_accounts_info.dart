import 'package:on_chain/hedera/src/rpc/core/core.dart';
import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/hedera/src/rpc/models/types.dart';

/// GET /api/v1/accounts/{idOrAliasOrEvmAddress}
class HederaMirrorRequestGetAccountInfo
    extends
        HederaMirrorRequest<
          HederaMirrorTypesAccountInfo,
          Map<String, dynamic>
        > {
  final String idOrAliasOrEvmAddress;

  const HederaMirrorRequestGetAccountInfo({
    required this.idOrAliasOrEvmAddress,
  });

  @override
  String? get path => '/api/v1/accounts/$idOrAliasOrEvmAddress';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => const {};

  @override
  HederaMirrorTypesAccountInfo onResponse(Map<String, dynamic> result) {
    return HederaMirrorTypesAccountInfo.fromJson(result);
  }
}
