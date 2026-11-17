import 'package:on_chain/hedera/src/rpc/core/core.dart';
import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/hedera/src/rpc/models/types.dart';

/// GET /api/v1/network/exchangerate
class HederaMirrorRequestGetNetworkExchangeRate
    extends
        HederaMirrorRequest<
          HederaMirrorTypesNetworkExchangeRateSetResponse,
          Map<String, dynamic>
        > {
  final List<String>? timestamp;

  const HederaMirrorRequestGetNetworkExchangeRate({this.timestamp});

  @override
  String? get path => '/api/v1/network/exchangerate';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'timestamp': timestamp?.join(','),
  };

  @override
  HederaMirrorTypesNetworkExchangeRateSetResponse onResponse(
    Map<String, dynamic> result,
  ) {
    return HederaMirrorTypesNetworkExchangeRateSetResponse.fromJson(result);
  }
}
