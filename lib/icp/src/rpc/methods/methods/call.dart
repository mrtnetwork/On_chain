import 'package:on_chain/icp/src/crypto/utils/utils.dart';
import 'package:on_chain/icp/src/rpc/core/core.dart';
import 'package:on_chain/icp/src/rpc/types/params.dart';
import 'package:on_chain/icp/src/rpc/types/types.dart';
import 'package:on_chain/icp/src/service/http/http.dart';
import 'package:on_chain/icp/src/service/core/service.dart';

abstract class BaseICPRequestCanisterCall<RESULT>
    extends ICPRequest<ICPDecodedCallResponse<RESULT>> {
  final ICPRequestCallParams params;
  final IICPUpdateMessage<RESULT> message;
  final ICPRequestContent content;
  BaseICPRequestCanisterCall({
    required this.content,
    required this.message,
    required this.params,
  });

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
}

class ICPRequestCanisterCall<RESULT>
    extends BaseICPRequestCanisterCall<RESULT> {
  ICPRequestCanisterCall({
    required super.message,
    required super.params,
    ICPRequestContent? content,
  }) : super(
         content:
             content ??
             ICPRequestContent.withId(
               message.generateContent(
                 canisterId: params.canisterId,
                 ingressExpiry: params.ingressExpiry,
                 nonce: params.getNonce(),
                 sender: params.sender,
               ),
             ),
       );

  @override
  String get path => params.path(synchronous: true);

  @override
  ICPDecodedCallResponse<RESULT> onResponse(List<int> result) {
    // HTTP 202 → empty body
    if (result.isEmpty) {
      return const ICPDecodedCallAccepted();
    }

    final decode = ICPHttpCallResponse.deserialize(result);
    final ICPDecodedCallResponse<RESULT> r = switch (decode) {
      ICPHttpCallReplied(:final certificate) => ICPDecodedCallReplied(
        certificate: ICPReadStateCertificate.fromBytes(certificate),
      ),
      ICPHttpCallNonReplicatedRejection err =>
        ICPDecodedCallNonReplicatedRejection(error: err),
      ICPHttpCallAccepted() => const ICPDecodedCallAccepted(),
    };
    return r.getResult(
      requestId: content.id ?? ICPCryptoUtils.hashContent(content.content),
      message: message,
    );
  }
}

class ICPRequestCanisterAsyncCall<RESULT>
    extends BaseICPRequestCanisterCall<RESULT> {
  ICPRequestCanisterAsyncCall({
    required super.message,
    required super.params,
    ICPRequestContent? content,
  }) : super(
         content:
             content ??
             ICPRequestContent.withId(
               message.generateContent(
                 canisterId: params.canisterId,
                 ingressExpiry: params.ingressExpiry,
                 nonce: params.getNonce(),
                 sender: params.sender,
               ),
             ),
       );

  @override
  String get path => params.path(synchronous: false);

  @override
  ICPDecodedCallResponse<RESULT> onResponse(List<int> result) {
    if (result.isEmpty) {
      return const ICPDecodedCallAccepted();
    }
    final decode = ICPHttpAsyncCallResponse.deserialize(result);
    return switch (decode) {
      ICPHttpAsyncCallAccepted() => const ICPDecodedCallAccepted(),
      ICPHttpAsyncCallRejection(
        :final errorCode,
        :final rejectCode,
        :final rejectMessage,
      ) =>
        ICPDecodedCallNonReplicatedRejection(
          error: ICPHttpCallNonReplicatedRejection(
            rejectCode: rejectCode,
            rejectMessage: rejectMessage,
            errorCode: errorCode,
          ),
        ),
    };
  }
}
