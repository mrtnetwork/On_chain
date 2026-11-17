import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/icp/src/address/address.dart';

import 'package:on_chain/icp/src/crypto/types/types.dart';
import 'package:on_chain/icp/src/service/http/types/icp_http_content.dart';
import 'package:on_chain/icp/src/service/http/types/icp_http_envelope.dart';
import 'package:on_chain/icp/src/utils/utils.dart';

abstract class ICPMessage<RESULT> {
  String get methodName;
  RESULT onResponse(List<int> candidBytes);
  const ICPMessage();
  List<int> toCandidBytes();
  ICPHttpRequestType get type;
  ICPHttpContent generateContent({
    IcpPrincipalAddress? canisterId,
    IcpPrincipalAddress? sender,
    Duration? ingressExpiry,
    List<int>? nonce,
  });

  Future<ICPHttpEnvelope> generateEnvelope({
    IcpPrincipalAddress? canisterId,
    IcpPrincipalAddress? sender,
    Duration? ingressExpiry,
    List<int>? nonce,
    ICPSigner? signer,
  }) async {
    final content = generateContent(
      canisterId: canisterId,
      ingressExpiry: ingressExpiry,
      nonce: nonce,
      sender: sender,
    );
    if (type == ICPHttpRequestType.query) {
      if (sender == null ||
          sender == IcpPrincipalAddress.anonymous ||
          signer == null) {
        return ICPHttpEnvelope(content: content);
      }
    }
    if (signer == null) {
      throw OnChainErrors.icpPlugin(
        "generateEnvelope",
        reason: "Missing signer.",
      );
    }
    return await signer.signContent(content);
  }

  Future<ICPHttpEnvelope> generateContentEnvelope(
    ICPHttpContent content, {
    IcpPrincipalAddress? sender,
    ICPSigner? signer,
  }) async {
    sender ??= switch (content) {
      ICPHttpCallContent(:var sender) => sender,
      ICPHttpQueryContent(:var sender) => sender,
      _ => null,
    };
    if (content.type == ICPHttpRequestType.query ||
        content.type == ICPHttpRequestType.readState) {
      if (sender == null ||
          sender == IcpPrincipalAddress.anonymous ||
          signer == null) {
        return ICPHttpEnvelope(content: content);
      }
    }
    if (signer == null) {
      throw OnChainErrors.icpPlugin(
        "generateContentEnvelope",
        reason: "Missing signer.",
      );
    }
    return await signer.signContent(content);
  }
}

abstract class IICPUpdateMessage<RESULT> extends ICPMessage<RESULT> {
  const IICPUpdateMessage();
  @override
  ICPHttpRequestType get type => ICPHttpRequestType.call;

  @override
  ICPHttpContent generateContent({
    IcpPrincipalAddress? canisterId,
    IcpPrincipalAddress? sender,
    Duration? ingressExpiry,
    List<int>? nonce,
  }) {
    if (canisterId == null) {
      throw OnChainErrors.icpPlugin(
        "generateContent",
        reason: "Missing canister ID.",
      );
    }
    return ICPHttpCallContent(
      canisterId: canisterId,
      methodName: methodName,
      nonce: nonce,
      arg: toCandidBytes(),
      sender: sender ?? IcpPrincipalAddress.anonymous,
      ingressExpiry: ICPUtils.generateIngressExpiry(expiry: ingressExpiry),
    );
  }
}

abstract class IICPQueryMessage<RESULT> extends ICPMessage<RESULT> {
  const IICPQueryMessage();
  @override
  ICPHttpRequestType get type => ICPHttpRequestType.query;
  @override
  ICPHttpQueryContent generateContent({
    IcpPrincipalAddress? canisterId,
    IcpPrincipalAddress? sender,
    Duration? ingressExpiry,
    List<int>? nonce,
  }) {
    if (canisterId == null) {
      throw OnChainErrors.icpPlugin(
        "generateContent",
        reason: "Missing canister ID.",
      );
    }
    return ICPHttpQueryContent(
      canisterId: canisterId,
      methodName: methodName,
      nonce: nonce,
      arg: toCandidBytes(),
      sender: sender ?? IcpPrincipalAddress.anonymous,
      ingressExpiry: ICPUtils.generateIngressExpiry(expiry: ingressExpiry),
    );
  }
}
