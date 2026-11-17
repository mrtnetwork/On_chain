import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/icp/src/crypto/types/types.dart';
import 'package:on_chain/icp/src/crypto/utils/utils.dart';
import 'package:on_chain/icp/src/service/certificate/src/icp_certificate.dart';
import 'package:on_chain/icp/src/service/http/http.dart';
import 'package:on_chain/icp/src/service/http/types/icp_request_status.dart';
import 'package:on_chain/icp/src/service/core/service.dart';

/// Decoded IC **query** response (status is already known from the HTTP body).
///
/// [RESULT] is the application-level type after Candid (or custom) decoding.
/// [signatures] are node signatures attached to the query response (v3+).
sealed class ICPDecodedQueryResponse<RESULT> {
  /// Node signatures over the query response (may be empty on older APIs).
  final List<ICPHttpNodeSignature> signatures;

  const ICPDecodedQueryResponse({required this.signatures});

  /// Debug / logging JSON (not wire CBOR).
  Map<String, dynamic> toJson();
}

/// Query failed with a canister/system reject.
class ICPDecodedQueryResponseErr<RESULT>
    extends ICPDecodedQueryResponse<RESULT> {
  /// Reject details (`reject_code`, `reject_message`, optional `error_code`).
  final ICPHttpQueryRejected error;

  const ICPDecodedQueryResponseErr({
    required this.error,
    required super.signatures,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      "error": {
        "rejectMessage": error.rejectMessage,
        "errorCode": error.errorCode,
        "rejectCode": error.rejectCode,
      },
    };
  }
}

/// Query succeeded; [result] is the decoded return value, [arg] is raw reply bytes.
class ICPDecodedQueryResponseReplied<RESULT>
    extends ICPDecodedQueryResponse<RESULT> {
  /// Application result after decoding [arg] (e.g. via Candid).
  final RESULT result;

  /// Raw reply blob from the replica (before decoding).
  final List<int> arg;

  const ICPDecodedQueryResponseReplied({
    required this.result,
    required super.signatures,
    required this.arg,
  });

  @override
  Map<String, dynamic> toJson() {
    return {"result": result};
  }
}

/// Full query package used for verification: decoded body + original content + request id.
class ICPFullDecodedQueryResponse<RESULT> {
  /// Err or replied variant of the query response.
  final ICPDecodedQueryResponse<RESULT> response;

  /// Original `content` map of the query request (needed to bind signatures).
  final ICPHttpContent content;

  /// Request id (representation-independent hash of [content]).
  final List<int> id;

  ICPFullDecodedQueryResponse({
    required this.response,
    required this.content,
    required List<int> id,
  }) : id =
           id
               .exc(
                 length: QuickCrypto.sha256DigestSize,
                 operation:
                     "Invalid id bytes length: expected 32, got ${id.length}.",
               )
               .asImmutableBytes;
}

/// Decoded **update/call** response (sync v3/v4 call or after polling read_state).
///
/// Sync call may return a certificate immediately; async call returns accepted
/// and the client must poll `/request_status/<request_id>` via read_state.
sealed class ICPDecodedCallResponse<RESULT> {
  const ICPDecodedCallResponse();

  Map<String, dynamic> toJson();

  /// If this is a certificate-bearing reply, extract request status and decode
  /// the result using [message.onResponse]; otherwise returns [this] unchanged.
  ///
  /// Used after a sync call or after a read_state poll that returned a cert.
  ICPDecodedCallResponse<RESULT> getResult({
    required List<int> requestId,
    required IICPUpdateMessage<RESULT> message,
  }) {
    switch (this) {
      case ICPDecodedCallReplied<RESULT>(:final certificate):
        final status = ICPRequestStatusResult.extractRequestStatus(
          cert: certificate.certificate,
          requestId: requestId,
        );
        return switch (status) {
          // Terminal success: decode reply blob → RESULT
          ICPRequestStatusReplied(:final reply) => () {
            return ICPDecodedCallRepliedWithResult(
              certificate: certificate,
              result: message.onResponse(reply),
            );
          }(),
          // Terminal reject from the IC / canister
          ICPRequestStatusRejected(
            :final rejectCode,
            :final rejectMessage,
            :final errorCode,
          ) =>
            ICPDecodedCallNonReplicatedRejection(
              error: ICPHttpCallNonReplicatedRejection(
                rejectCode: rejectCode,
                rejectMessage: rejectMessage,
                errorCode: errorCode,
              ),
            ),
          // Status not present in this certificate yet
          ICPRequestStatusUnknown() => const ICPDecodedCallUnknown(),
          // Reply already pruned from the state tree
          ICPRequestStatusDone() =>
            throw OnChainErrors.icpPlugin(
              "ICPDecodedCallResponse.getResult",
              reason: "Reply pruned before reading.",
            ),
          // Still received / processing
          _ => const ICPDecodedCallAccepted(),
        };
      default:
        return this;
    }
  }
}

/// Sync call returned a certificate; status must still be read from the tree.
///
/// Does not yet contain a decoded [RESULT] — use [getResult] or
/// [ICPReadStateCertificate.decodeResult].
class ICPDecodedCallReplied<RESULT> extends ICPDecodedCallResponse<RESULT> {
  /// Certificate from the call (or read_state) response body.
  final ICPReadStateCertificate certificate;

  const ICPDecodedCallReplied({required this.certificate});

  @override
  Map<String, dynamic> toJson() => {
    'status': 'replied',
    'certificate': certificate,
  };
}

/// Call completed successfully with a decoded application [result].
class ICPDecodedCallRepliedWithResult<RESULT>
    extends ICPDecodedCallResponse<RESULT> {
  final ICPReadStateCertificate certificate;
  final RESULT result;

  const ICPDecodedCallRepliedWithResult({
    required this.certificate,
    required this.result,
  });

  @override
  Map<String, dynamic> toJson() => {
    'status': 'replied',
    'certificate': certificate,
    if (result != null) 'result': result,
  };
}

/// Call rejected before or during execution (reject in HTTP body or state tree).
class ICPDecodedCallNonReplicatedRejection<RESULT>
    extends ICPDecodedCallResponse<RESULT> {
  final ICPHttpCallNonReplicatedRejection error;

  const ICPDecodedCallNonReplicatedRejection({required this.error});

  @override
  Map<String, dynamic> toJson() => {
    'status': 'non_replicated_rejection',
    'rejectCode': error.rejectCode,
    'rejectMessage': error.rejectMessage,
    'errorCode': error.errorCode,
  };
}

/// HTTP 202 Accepted — ingress was received; poll read_state for status.
class ICPDecodedCallAccepted<RESULT> extends ICPDecodedCallResponse<RESULT> {
  const ICPDecodedCallAccepted();

  @override
  Map<String, dynamic> toJson() => {'status': 'accepted'};
}

/// Request status path not found / not yet known in the certificate.
///
class ICPDecodedCallUnknown<RESULT> extends ICPDecodedCallResponse<RESULT> {
  const ICPDecodedCallUnknown();

  @override
  Map<String, dynamic> toJson() => {'status': 'unknown'};
}

/// Request reached terminal `done` (reply pruned; too late to read the result).
class ICPDecodedCallDone<RESULT> extends ICPDecodedCallResponse<RESULT> {
  const ICPDecodedCallDone();

  @override
  Map<String, dynamic> toJson() => {'status': 'done'};
}

/// Decoded **async** `/api/v2/.../call` HTTP response (no certificate in body).
///
/// v2 call only accepts or rejects at the HTTP layer; success means poll later.
sealed class ICPDecodedAsyncCallResponse {
  const ICPDecodedAsyncCallResponse();
  Map<String, dynamic> toJson();
}

/// Async call accepted (typically HTTP 202); client must poll request status.
class ICPDecodedAsyncCallAccepted extends ICPDecodedAsyncCallResponse {
  const ICPDecodedAsyncCallAccepted();

  @override
  Map<String, dynamic> toJson() => {'status': 'accepted'};
}

/// Async call rejected at the HTTP / pre-processing layer (4xx body with reject).
class ICPDecodedAsyncCallRejection extends ICPDecodedAsyncCallResponse {
  final ICPHttpAsyncCallRejection error;

  const ICPDecodedAsyncCallRejection({required this.error});

  @override
  Map<String, dynamic> toJson() => {
    'rejectCode': error.rejectCode,
    'rejectMessage': error.rejectMessage,
    'errorCode': error.errorCode,
  };
}

/// Wrapper around an [ICPCertificate] from a call or read_state response.
class ICPReadStateCertificate {
  final ICPCertificate certificate;

  const ICPReadStateCertificate({required this.certificate});

  /// Deserialize certificate CBOR bytes (often from read_state `certificate` field).
  factory ICPReadStateCertificate.fromBytes(List<int> bytes) =>
      ICPReadStateCertificate(certificate: ICPCertificate.deserialize(bytes));

  Map<String, dynamic> toJson() => {
    'certificate': certificate.toCbor().encode(),
  };

  /// Look up `/request_status/<requestId>/...` in [certificate] and decode RESULT.
  ///
  /// Maps IC status to [ICPDecodedCallResponse] variants (replied, reject,
  /// pending, done, unknown).
  ICPDecodedCallResponse<RESULT> decodeResult<RESULT>({
    required List<int> requestId,
    required IICPUpdateMessage<RESULT> message,
  }) {
    final status = ICPRequestStatusResult.extractRequestStatus(
      cert: certificate,
      requestId: requestId,
    );
    return switch (status) {
      ICPRequestStatusReplied(:final reply) => () {
        return ICPDecodedCallRepliedWithResult(
          certificate: this,
          result: message.onResponse(reply),
        );
      }(),
      ICPRequestStatusRejected(
        :final rejectCode,
        :final rejectMessage,
        :final errorCode,
      ) =>
        ICPDecodedCallNonReplicatedRejection(
          error: ICPHttpCallNonReplicatedRejection(
            rejectCode: rejectCode,
            rejectMessage: rejectMessage,
            errorCode: errorCode,
          ),
        ),
      // Still received/processing — keep certificate for further polling
      ICPRequestStatusPending() => ICPDecodedCallReplied<RESULT>(
        certificate: this,
      ),
      ICPRequestStatusDone() => const ICPDecodedCallDone(),
      ICPRequestStatusUnknown() => const ICPDecodedCallUnknown(),
    };
  }

  /// Verify this certificate under [rootKey] (and optional query signatures).
  Future<bool> verify({
    required List<int> rootKey,
    CbBlsVerificationKey? verificationKey,
    List<ICPFullDecodedQueryResponse> queries = const [],
  }) async {
    return ICPCryptoUtils.verify(
      certificate: certificate,
      rootKey: rootKey,
      queries: queries,
      verificationKey: verificationKey,
    );
  }
}
