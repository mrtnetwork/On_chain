import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/icp/src/address/address.dart';
import 'package:on_chain/icp/src/crypto/types/types.dart';
import 'package:on_chain/icp/src/crypto/utils/utils.dart';
import 'package:on_chain/icp/src/did/ledger/src/types.dart';
import 'package:on_chain/icp/src/did/ledger/src/updates.dart';
import 'package:on_chain/icp/src/rpc/core/core.dart';
import 'package:on_chain/icp/src/rpc/methods/methods/call.dart';
import 'package:on_chain/icp/src/rpc/methods/methods/status.dart';
import 'package:on_chain/icp/src/rpc/methods/methods/query.dart';
import 'package:on_chain/icp/src/rpc/methods/methods/read_state.dart';
import 'package:on_chain/icp/src/rpc/types/params.dart';
import 'package:on_chain/icp/src/rpc/types/types.dart';
import 'package:on_chain/icp/src/service/certificate/src/icp_certificate.dart';
import 'package:on_chain/icp/src/service/http/types/icp_http_status.dart';
import 'package:on_chain/icp/src/service/core/service.dart';

abstract mixin class ICPQuickApi {
  const ICPQuickApi();
  IProvider<IServiceProvider, ICPRequestDetails> get provider;

  Future<List<int>?> rootKey();
  Future<ICPRequestQueryParams> createQueryParams(
    IcpPrincipalAddress canisterId,
  ) async => ICPRequestQueryParams.anonymous(canisterId);
  Future<ICPRequestCallParams> createCallParams({
    required IcpPrincipalAddress canisterId,
    required IcpPrincipalAddress sender,
    required IcpPrincipalAddress? effectiveCanisterId,
  });

  Future<ICPRequestReadStateParams> createReadStateParams(
    IcpPrincipalAddress canisterId,
  ) async => ICPRequestReadStateParams.anonymous(canisterId);

  Future<ICPCertificate> getCanisterSubnet(
    IcpPrincipalAddress canisterId, {
    ICPRequestReadStateParams? params,
  }) async {
    params ??= await createReadStateParams(canisterId);
    final result = await provider.request(
      ICPRequestCanisterReadCanisterSubnet(
        params: ICPRequestReadStateParams.anonymous(canisterId),
      ),
    );
    return result.certificate;
  }

  Future<ICPHttpStatusResponse> status({
    ICPApiVersion version = ICPApiVersion.v2,
  }) async {
    return provider.request(ICPRequestStatus(version: version));
  }

  Future<ICPDecodedCallResponse<RESULT>> callInternal<RESULT>({
    required IICPUpdateMessage<RESULT> message,
    required IcpPrincipalAddress sender,
    required IcpPrincipalAddress canisterId,
    IcpPrincipalAddress? effectiveCanisterId,
    ICPRequestCallParams? params,
  }) async {
    params ??= await createCallParams(
      canisterId: canisterId,
      effectiveCanisterId: effectiveCanisterId,
      sender: sender,
    );
    return await provider.request(
      ICPRequestCanisterCall(message: message, params: params),
    );
  }

  Future<ICPDecodedCallResponse<RESULT>> callWithResultInternal<RESULT>({
    required IICPUpdateMessage<RESULT> message,
    required IcpPrincipalAddress sender,
    required IcpPrincipalAddress canisterId,
    IcpPrincipalAddress? effectiveCanisterId,
    ICPRequestCallParams? params,
    Duration timeout = const Duration(seconds: 60),
    Duration pollInterval = const Duration(seconds: 1),
  }) async {
    params ??= await createCallParams(
      canisterId: canisterId,
      effectiveCanisterId: effectiveCanisterId,
      sender: sender,
    );
    final request = ICPRequestCanisterCall(message: message, params: params);
    final result = await provider.request(request);
    return _pool(
      message: message,
      sender: sender,
      effectiveCanisterId: effectiveCanisterId,
      requestId:
          request.content.id ??
          ICPCryptoUtils.hashContent(request.content.content),
      result: result,
      canisterId: canisterId,
      pollInterval: pollInterval,
      timeout: timeout,
      params: params,
    );
  }

  Future<ICPDecodedQueryResponse<RESULT>> queryInternal<RESULT>({
    required IICPQueryMessage<RESULT> message,
    required IcpPrincipalAddress canisterId,
    ICPRequestQueryParams? params,
  }) async {
    params ??= await createQueryParams(canisterId);
    return await provider.request(
      ICPRequestCanisterQuery(message: message, params: params),
    );
  }

  Future<ICPFullDecodedQueryResponse<RESULT>> queryFullInternal<RESULT>({
    required IICPQueryMessage<RESULT> message,
    required IcpPrincipalAddress canisterId,
    ICPRequestQueryParams? params,
  }) async {
    params ??= await createQueryParams(canisterId);
    return await provider.request(
      ICPRequestCanisterFullQuery(message: message, params: params),
    );
  }

  Future<ICPDecodedCallResponse<RESULT>> _pool<RESULT>({
    required IICPUpdateMessage<RESULT> message,
    required IcpPrincipalAddress sender,
    required List<int> requestId,
    required ICPDecodedCallResponse<RESULT> result,
    required IcpPrincipalAddress canisterId,
    ICPRequestCallParams? params,
    IcpPrincipalAddress? effectiveCanisterId,
    Duration timeout = const Duration(seconds: 60),
    Duration pollInterval = const Duration(milliseconds: 500),
  }) async {
    final deadline = DateTime.now().toUtc().add(timeout);

    while (DateTime.now().toUtc().isBefore(deadline)) {
      try {
        switch (result) {
          case ICPDecodedCallReplied<RESULT>():
          case ICPDecodedCallAccepted<RESULT>():
            params ??= await createCallParams(
              canisterId: canisterId,
              sender: sender,
              effectiveCanisterId: effectiveCanisterId,
            );
            result = await provider.request(
              ICPRequestCanisterReadStateCall(
                requestId: requestId,
                message: message,
                params: params,
              ),
            );
            break;
          case ICPDecodedCallRepliedWithResult<RESULT> result:
            return result;
          case ICPDecodedCallNonReplicatedRejection<RESULT> result:
            return result;
          case ICPDecodedCallUnknown<RESULT>():
            return result;
          case ICPDecodedCallDone<RESULT>():
            return result;
        }
      } catch (_) {}
      if (result case ICPDecodedCallRepliedWithResult()) continue;

      await Future<void>.delayed(pollInterval);
    }
    throw OnChainErrors.icpClient(
      "callWithResult",
      reason: "Timed out while waiting for canister call response.",
      details: {"timeout": "$timeout"},
    );
  }

  Future<bool> verify({
    required IcpPrincipalAddress canisterId,
    ICPCertificate? certificate,
    CbBlsVerificationKey? verificationKey,
    ICPFullDecodedQueryResponse? query,
  }) async {
    final rootKey = await this.rootKey();
    // result.response.signatures
    certificate ??= await getCanisterSubnet(canisterId);
    if (rootKey != null) {
      return await ICPCryptoUtils.verify(
        rootKey: rootKey,
        certificate: certificate,
        queries: [if (query != null) query],
        verificationKey: verificationKey,
      );
    }
    return true;
  }

  Future<RESULT> query<RESULT>({
    required IICPQueryMessage<RESULT> message,
    required IcpPrincipalAddress canisterId,
    ICPRequestQueryParams? params,
  }) async {
    final result = await queryFullInternal(
      message: message,
      canisterId: canisterId,
      params: params,
    );
    final verify = await this.verify(canisterId: canisterId, query: result);
    if (!verify) {
      throw OnChainErrors.icpClient(
        "query",
        reason: "Query response verification failed.",
      );
    }
    // response = result.response;
    return switch (result.response) {
      ICPDecodedQueryResponseErr<RESULT>(:final error) =>
        throw OnChainErrors.icpClient(
          "query",
          reason: "Query failed: ${error.rejectMessage}.",
          details: {
            "rejectCode": error.rejectCode.toString(),
            "errorCode": error.errorCode?.toString(),
          },
        ),
      ICPDecodedQueryResponseReplied<RESULT>(:final result) => result,
    };
  }

  Future<ICPDecodedCallResponse<RESULT>> call<RESULT>({
    required IICPUpdateMessage<RESULT> message,
    required IcpPrincipalAddress sender,
    required IcpPrincipalAddress canisterId,
    ICPRequestCallParams? params,
    IcpPrincipalAddress? effectiveCanisterId,
  }) async {
    final result = await callInternal(
      message: message,
      sender: sender,
      canisterId: canisterId,
      params: params,
      effectiveCanisterId: effectiveCanisterId,
    );
    switch (result) {
      case ICPDecodedCallReplied<RESULT>(:final certificate):
      case ICPDecodedCallRepliedWithResult<RESULT>(:final certificate):
        final verify = await this.verify(
          canisterId: canisterId,
          certificate: certificate.certificate,
        );
        if (!verify) {
          throw OnChainErrors.icpClient(
            "call",
            reason: "Call response verification failed.",
          );
        }
        return result;
      default:
        return result;
    }
  }

  Future<RESULT> callWithResult<RESULT>({
    required IICPUpdateMessage<RESULT> message,
    required IcpPrincipalAddress sender,
    required IcpPrincipalAddress canisterId,
    IcpPrincipalAddress? effectiveCanisterId,
    Duration timeout = const Duration(seconds: 60),
    Duration pollInterval = const Duration(seconds: 1),
    ICPRequestCallParams? params,
  }) async {
    final result = await callWithResultInternal(
      message: message,
      sender: sender,
      canisterId: canisterId,
      pollInterval: pollInterval,
      timeout: timeout,
      params: params,
      effectiveCanisterId: effectiveCanisterId,
    );
    switch (result) {
      case ICPDecodedCallAccepted<RESULT>():
        throw OnChainErrors.icpClient(
          "callWithResult",
          reason: "Unexpected result status: Accepted.",
        );
      case ICPDecodedCallReplied<RESULT>():
        throw OnChainErrors.icpClient(
          "callWithResult",
          reason: "Unexpected result status: Replied.",
        );
      case ICPDecodedCallDone<RESULT>():
        throw OnChainErrors.icpClient(
          "callWithResult",
          reason: "Request status became done before reply was read.",
        );

      case ICPDecodedCallRepliedWithResult<RESULT>(:final certificate):
        final verify = await this.verify(
          canisterId: canisterId,
          certificate: certificate.certificate,
        );
        if (!verify) {
          throw OnChainErrors.icpClient(
            "callWithResult",
            reason: "Result certificate verification failed.",
          );
        }
        return result.result;
      case ICPDecodedCallNonReplicatedRejection<RESULT>(:final error):
        throw OnChainErrors.icpClient(
          "callWithResult",
          reason: "Call request rejected: ${error.rejectMessage}",
          details: {
            "errorCode": error.errorCode,
            "rejectCode": error.rejectCode.toString(),
            "rejectMessage": error.rejectMessage,
          },
        );
      case ICPDecodedCallUnknown<RESULT>():
        throw OnChainErrors.icpClient(
          "callWithResult",
          reason: "Read state failed. Unknown call.",
        );
    }
  }

  Future<LEDGERIcrc21ConsentMessageResponse> getConsentMessage({
    required IcpPrincipalAddress canisterId,
    required String method,
    required List<int> arg,
    String language = "en-US",
    Duration timeout = const Duration(seconds: 30),
  }) async {
    const sender = IcpPrincipalAddress.anonymous;
    final message = LEDGERUpdateIcrc21CanisterCallConsentMessage(
      LEDGERIcrc21ConsentMessageRequest(
        method: method,
        arg: arg,
        userPreferences: LEDGERIcrc21ConsentMessageSpec(
          metadata: LEDGERIcrc21ConsentMessageMetadata(language: language),
        ),
      ),
    );
    final params = ICPRequestCallParams(canisterId: canisterId, sender: sender);
    final content = message.generateContent(
      canisterId: canisterId,
      ingressExpiry: params.ingressExpiry,
      nonce: params.getNonce(),
      sender: sender,
    );
    final requestContent = ICPRequestContent.withId(content);
    final response = await provider.request(
      ICPRequestCanisterCall(
        message: message,
        params: params,
        content: requestContent,
      ),
    );
    final requestId = requestContent.id ?? const [];
    ICPDecodedCallResponse<LEDGERIcrc21ConsentMessageResponse> result = response
        .getResult(requestId: requestId, message: message);
    final deadline = DateTime.now().toUtc().add(timeout);
    while (DateTime.now().toUtc().isBefore(deadline)) {
      switch (result) {
        case ICPDecodedCallRepliedWithResult(:final result):
          return result;
        case ICPDecodedCallNonReplicatedRejection(:final error):
          throw OnChainErrors.icpClient(
            "getConsentMessage",
            reason: "Consent request rejected: ${error.rejectMessage}",
            details: {
              "errorCode": error.errorCode,
              "rejectCode": error.rejectCode.toString(),
              "rejectMessage": error.rejectMessage,
            },
          );
        case ICPDecodedCallDone():
          throw OnChainErrors.icpClient(
            "getConsentMessage",
            reason: "Consent reply pruned before reading.",
          );
        case ICPDecodedCallReplied():
        case ICPDecodedCallAccepted():
        case ICPDecodedCallUnknown():
          break;
      }
      await Future<void>.delayed(const Duration(milliseconds: 500));
      result = await provider
          .request(
            ICPRequestCanisterReadStateCall(
              requestId: requestId,
              message: message,
              params: params,
            ),
          )
          .then((r) => r.getResult(requestId: requestId, message: message));
    }
    throw OnChainErrors.icpClient(
      "getConsentMessage",
      reason: "Consent request timed out waiting for read_state.",
    );
  }
}
