// icp_request_canister.dart

import 'package:blockchain_utils/helper/helper.dart';
import 'package:on_chain/icp/src/rpc/core/core.dart';
import 'package:on_chain/icp/src/rpc/types/params.dart';
import 'package:on_chain/icp/src/rpc/types/types.dart';
import 'package:on_chain/icp/src/service/http/http.dart';
import 'package:on_chain/icp/src/service/core/service.dart';
import 'package:on_chain/icp/src/utils/utils.dart';

// ---------------------------------------------------------------------------
// READ_STATE
// ---------------------------------------------------------------------------
class ICPRequestCanisterReadStateCall<RESULT>
    extends ICPRequest<ICPDecodedCallResponse<RESULT>> {
  final ICPRequestCallParams params;
  final IICPUpdateMessage<RESULT> message;
  final List<int> requestId;
  final ICPRequestContent content;
  ICPRequestCanisterReadStateCall({
    required this.message,
    required this.params,
    required List<int> requestId,
    List<List<List<int>>>? paths,
    ICPRequestContent? content,
  }) : requestId = requestId.asImmutableBytes,
       content =
           content ??
           ICPRequestContent(
             content: ICPHttpReadStateContent(
               nonce: params.getNonce(),
               paths: paths ?? ICPUtils.requestStatusPaths(requestId),
               sender: params.sender,
               ingressExpiry: ICPUtils.generateIngressExpiry(
                 expiry: params.ingressExpiry,
               ),
             ),
           );

  @override
  String get path => ICPUtils.generateCanisterPath(
    canisterId: params.canisterId,
    type: ICPHttpRequestType.readState,
    version: params.version ?? ICPApiVersion.forReadState(),
  );

  @override
  Future<List<int>?> body() async {
    final envelope =
        content.envelope ??
        await message.generateContentEnvelope(
          content.content,
          sender: params.sender,
          signer: params.signer,
        );
    return envelope.toCbor().encode();
  }

  @override
  ICPDecodedCallResponse<RESULT> onResponse(List<int> result) {
    final decode = ICPHttpReadStateResponse.deserialize(result);
    final r = ICPReadStateCertificate.fromBytes(decode.certificate);
    return r.decodeResult(requestId: requestId, message: message);
  }
}

class ICPRequestCanisterReadState extends ICPRequest<ICPReadStateCertificate> {
  final ICPRequestReadStateParams params;
  final ICPRequestContent content;
  ICPRequestCanisterReadState({
    required this.params,
    required List<List<List<int>>> paths,
    ICPRequestContent? content,
  }) : content =
           content ??= ICPRequestContent(
             content: ICPHttpReadStateContent(
               sender: params.sender,
               ingressExpiry: ICPUtils.generateIngressExpiry(
                 expiry: params.ingressExpiry,
               ),
               paths: paths,
             ),
           );

  @override
  String get path => params.path();

  @override
  Future<List<int>?> body() async {
    final envelope =
        content.envelope ??
        await ICPUtils.generateContentEnvelope(content.content);

    return envelope.toCbor().encode();
  }

  @override
  ICPReadStateCertificate onResponse(List<int> result) {
    final decode = ICPHttpReadStateResponse.deserialize(result);
    return ICPReadStateCertificate.fromBytes(decode.certificate);
  }
}

class ICPRequestCanisterReadCanisterSubnet extends ICPRequestCanisterReadState {
  ICPRequestCanisterReadCanisterSubnet({required super.params, super.content})
    : super(
        paths: [
          ["subnet".codeUnits],
        ],
      );
}
