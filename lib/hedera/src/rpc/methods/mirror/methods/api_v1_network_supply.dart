import 'package:on_chain/hedera/src/rpc/core/core.dart';
import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/hedera/src/rpc/models/types.dart';

/// GET /api/v1/network/supply
class HederaMirrorRequestGetNetworkSupply
    extends
        HederaMirrorRequest<
          HederaMirrorTypesNetworkSupplyResponse,
          Map<String, dynamic>
        > {
  final List<String>? timestamp;

  const HederaMirrorRequestGetNetworkSupply({this.timestamp});

  @override
  String? get path => '/api/v1/network/supply';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'timestamp': timestamp?.join(','),
  };

  @override
  HederaMirrorTypesNetworkSupplyResponse onResponse(
    Map<String, dynamic> result,
  ) {
    return HederaMirrorTypesNetworkSupplyResponse.fromJson(result);
  }
}
