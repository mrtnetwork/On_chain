import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/rpc/core/core.dart';
import 'package:on_chain/hedera/src/rpc/models/types.dart';

/// POST /api/v1/contracts/call
class HederaMirrorRequestContractCall
    extends
        HederaMirrorRequest<
          HederaMirrorTypesContractCallResponse,
          Map<String, dynamic>
        > {
  final HederaMirrorTypesContractCallRequest requestBody;

  const HederaMirrorRequestContractCall({required this.requestBody});

  @override
  String? get path => '/api/v1/contracts/call';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, String> get headers => ServiceConst.defaultPostHeaders;

  @override
  BuBytes body() {
    return StringUtils.encodeJson(
      requestBody.toJson(),
      options: JsonEncodeOptions(bigIntEncoding: BigIntEncoding.intOrString),
    ).asImmutableBytes;
  }

  @override
  HederaMirrorTypesContractCallResponse onResponse(
    Map<String, dynamic> result,
  ) {
    return HederaMirrorTypesContractCallResponse.fromJson(result);
  }
}
