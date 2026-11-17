import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/rpc/core/core.dart';
import 'package:on_chain/hedera/src/rpc/models/types.dart';

/// GET /api/v1/network/fees
class HederaMirrorRequestGetNetworkFees
    extends
        HederaMirrorRequest<
          HederaMirrorTypesNetworkFeesResponse,
          Map<String, dynamic>
        > {
  final HederaMirrorTypesOrder? order;
  final List<String>? timestamp;

  const HederaMirrorRequestGetNetworkFees({this.order, this.timestamp});

  @override
  String? get path => '/api/v1/network/fees';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'order': order?.toJson(),
    'timestamp': timestamp?.join(','),
  };

  @override
  HederaMirrorTypesNetworkFeesResponse onResponse(Map<String, dynamic> result) {
    return HederaMirrorTypesNetworkFeesResponse.fromJson(result);
  }
}

/// POST /api/v1/network/fees
class HederaMirrorRequestEstimateFees
    extends
        HederaMirrorRequest<
          HederaMirrorTypesFeeEstimateResponse,
          Map<String, dynamic>
        > {
  final HederaMirrorTypesFeeEstimateMode? mode;
  final int? highVolumeThrottle;
  final BuBytes txBody;

  HederaMirrorRequestEstimateFees({
    this.mode,
    this.highVolumeThrottle,
    required List<int> txBody,
  }) : txBody = txBody.asImmutableBytes;

  @override
  String? get path => '/api/v1/network/fees';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, String?> get queryParameters => {
    'mode': mode?.toJson(),
    'high_volume_throttle': highVolumeThrottle?.toString(),
  };

  @override
  Map<String, String> get headers => {"Content-Type": "application/protobuf"};

  @override
  BuBytes body() => txBody;

  @override
  HederaMirrorTypesFeeEstimateResponse onResponse(Map<String, dynamic> result) {
    return HederaMirrorTypesFeeEstimateResponse.fromJson(result);
  }
}
