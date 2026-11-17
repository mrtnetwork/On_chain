import 'package:on_chain/icp/src/crypto/utils/utils.dart';
import 'package:on_chain/icp/src/rpc/core/core.dart';
import 'package:on_chain/icp/src/rpc/types/params.dart';
import 'package:on_chain/icp/src/rpc/types/types.dart';
import 'package:on_chain/icp/src/service/http/http.dart';
import 'package:on_chain/icp/src/service/core/service.dart';

class ICPRequestCanisterQuery<RESULT>
    extends ICPRequest<ICPDecodedQueryResponse<RESULT>> {
  final IICPQueryMessage<RESULT> message;
  final ICPRequestQueryParams params;
  final ICPRequestContent content;

  ICPRequestCanisterQuery({
    required this.message,
    required this.params,
    ICPRequestContent? content,
  }) : content =
           content ??= ICPRequestContent(
             content: message.generateContent(
               canisterId: params.canisterId,
               ingressExpiry: params.ingressExpiry,
               nonce: params.getNonce(),
               sender: params.sender,
             ),
           );

  @override
  String get path => params.path();

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
  ICPDecodedQueryResponse<RESULT> onResponse(List<int> result) {
    final decode = ICPHttpQueryResponse.deserialize(result);
    return switch (decode) {
      ICPHttpQueryReplied(:final arg) => ICPDecodedQueryResponseReplied(
        result: message.onResponse(arg),
        signatures: decode.signatures,
        arg: arg,
      ),
      ICPHttpQueryRejected err => ICPDecodedQueryResponseErr(
        error: err,
        signatures: decode.signatures,
      ),
    };
  }
}

class ICPRequestCanisterFullQuery<RESULT>
    extends ICPRequest<ICPFullDecodedQueryResponse<RESULT>> {
  final IICPQueryMessage<RESULT> message;
  final ICPRequestQueryParams params;
  final ICPRequestContent content;

  ICPRequestCanisterFullQuery({
    required this.message,
    required this.params,
    ICPRequestContent? content,
  }) : content =
           content ??= ICPRequestContent.withId(
             message.generateContent(
               canisterId: params.canisterId,
               ingressExpiry: params.ingressExpiry,
               nonce: params.getNonce(),
               sender: params.sender,
             ),
           );

  @override
  String get path => params.path();

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
  ICPFullDecodedQueryResponse<RESULT> onResponse(List<int> result) {
    final decode = ICPHttpQueryResponse.deserialize(result);
    return ICPFullDecodedQueryResponse(
      response: switch (decode) {
        ICPHttpQueryReplied(:final arg) => ICPDecodedQueryResponseReplied(
          result: message.onResponse(arg),
          signatures: decode.signatures,
          arg: arg,
        ),
        ICPHttpQueryRejected err => ICPDecodedQueryResponseErr(
          error: err,
          signatures: decode.signatures,
        ),
      },
      content: content.content,
      id: content.id ?? ICPCryptoUtils.hashContent(content.content),
    );
  }
}
