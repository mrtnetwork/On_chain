// icp_http_responses.dart

import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/icp/src/address/address.dart';
import 'icp_http_base.dart';

// ---------------------------------------------------------------------------
// CALL (sync) responses
//
// Possible paths that return these response types:
//   POST /api/v3/canister/<'effective_canister_id>/call   (deprecated)
//   POST /api/v4/canister/<'effective_canister_id>/call
//   POST /api/v4/subnet/<'effective_subnet_id>/call       (restricted – create_canister only)
//
// HTTP status → response mapping:
//   200 + status "replied"                    → ICPHttpCallReplied
//   200 + status "non_replicated_rejection"   → ICPHttpCallNonReplicatedRejection
//   202 (empty body)                          → ICPHttpCallAccepted
//   4xx / 5xx                                 → transport / client error (not modelled here)
// ---------------------------------------------------------------------------
sealed class ICPHttpCallResponse extends ICPHttpResponse {
  const ICPHttpCallResponse();

  factory ICPHttpCallResponse.deserialize(List<int> bytes) {
    final content = CborObject.deserialize(bytes);
    final json = JsonParser.valueEnsureAsMap<String, dynamic>(
      content.getValue(),
    );
    return ICPHttpCallResponse.fromJson(json);
  }

  factory ICPHttpCallResponse.fromJson(Map<String, dynamic> json) {
    final status = json.valueAsString('status');
    return switch (status) {
      'replied' => ICPHttpCallReplied.fromJson(json),
      'non_replicated_rejection' => ICPHttpCallNonReplicatedRejection.fromJson(
        json,
      ),
      _ =>
        throw OnChainErrors.icpPlugin(
          "ICPHttpCallResponse.fromJson",
          reason: 'Unknown call response status.',
          details: {'status': status},
        ),
    };
  }
}

/// status = "replied"
///
/// Paths:
///   POST /api/v3/canister/<'effective_canister_id>/call
///   POST /api/v4/canister/<'effective_canister_id>/call
///   POST /api/v4/subnet/<'effective_subnet_id>/call
///
/// Body contains a certificate covering /request_status/<'request_id> and /time.
final class ICPHttpCallReplied extends ICPHttpCallResponse {
  final List<int> certificate;

  const ICPHttpCallReplied({required this.certificate});

  factory ICPHttpCallReplied.fromJson(Map<String, dynamic> json) {
    return ICPHttpCallReplied(certificate: json.valueAsBytes('certificate'));
  }

  @override
  CborTagValue toCbor() {
    return CborTagValue(
      CborMapValue.definite(<CborObject, CborObject>{
        CborStringValue('status'): CborStringValue('replied'),
        CborStringValue('certificate'): CborBytesValue(certificate),
      }),
      [55799],
    );
  }
}

/// status = "non_replicated_rejection"
///
/// Paths:
///   POST /api/v3/canister/<'effective_canister_id>/call
///   POST /api/v4/canister/<'effective_canister_id>/call
///   POST /api/v4/subnet/<'effective_subnet_id>/call
///
/// Returned when a non-replicated pre-processing error occurred
/// (e.g. canister inspect_message rejected the call).
final class ICPHttpCallNonReplicatedRejection extends ICPHttpCallResponse {
  final BigInt rejectCode;
  final String rejectMessage;
  final String? errorCode;

  const ICPHttpCallNonReplicatedRejection({
    required this.rejectCode,
    required this.rejectMessage,
    this.errorCode,
  });

  factory ICPHttpCallNonReplicatedRejection.fromJson(
    Map<String, dynamic> json,
  ) {
    return ICPHttpCallNonReplicatedRejection(
      rejectCode: json.valueAsBigInt('reject_code'),
      rejectMessage: json.valueAsString('reject_message'),
      errorCode: json.valueAsString('error_code'),
    );
  }

  @override
  CborTagValue toCbor() {
    final map = <CborObject, CborObject>{
      CborStringValue('status'): CborStringValue('non_replicated_rejection'),
      CborStringValue('reject_code'): CborBigIntValue(rejectCode),
      CborStringValue('reject_message'): CborStringValue(rejectMessage),
    };
    if (errorCode != null) {
      map[CborStringValue('error_code')] = CborStringValue(errorCode!);
    }
    return CborTagValue(CborMapValue.definite(map), [55799]);
  }
}

/// HTTP 202 – empty body (accepted, still processing)
///
/// Paths:
///   POST /api/v3/canister/<'effective_canister_id>/call
///   POST /api/v4/canister/<'effective_canister_id>/call
///   POST /api/v4/subnet/<'effective_subnet_id>/call
///
/// The replica timed out waiting for a terminal state.
/// Caller must poll with read_state using the request_id.
final class ICPHttpCallAccepted extends ICPHttpCallResponse {
  const ICPHttpCallAccepted();

  @override
  CborTagValue toCbor() {
    // empty body – callers usually just check HTTP status
    return CborTagValue(CborMapValue.definite(<CborObject, CborObject>{}), [
      55799,
    ]);
  }
}

// ---------------------------------------------------------------------------
// ASYNC CALL (/api/v2) responses
//
// Possible paths that return these response types:
//   POST /api/v2/canister/<'effective_canister_id>/call
//
// HTTP status → response mapping:
//   202 (empty body)   → ICPHttpAsyncCallAccepted
//   200 + body         → ICPHttpAsyncCallRejection  (pre-processing error)
//   4xx / 5xx          → transport / client error (not modelled here)
// ---------------------------------------------------------------------------
sealed class ICPHttpAsyncCallResponse extends ICPHttpResponse {
  const ICPHttpAsyncCallResponse();

  factory ICPHttpAsyncCallResponse.deserialize(List<int> bytes) {
    if (bytes.isEmpty) return const ICPHttpAsyncCallAccepted();
    final content = CborObject.deserialize(bytes);
    final json = JsonParser.valueEnsureAsMap<String, dynamic>(
      content.getValue(),
    );
    return ICPHttpAsyncCallRejection.fromJson(json);
  }
}

/// HTTP 202 – empty body
///
/// Path:
///   POST /api/v2/canister/<'effective_canister_id>/call
///
/// Request was accepted for further processing.
/// Caller must poll with read_state.
final class ICPHttpAsyncCallAccepted extends ICPHttpAsyncCallResponse {
  const ICPHttpAsyncCallAccepted();

  @override
  CborTagValue toCbor() =>
      CborTagValue(CborMapValue.definite(<CborObject, CborObject>{}), [55799]);
}

/// HTTP 200 – pre-processing rejection
///
/// Path:
///   POST /api/v2/canister/<'effective_canister_id>/call
///
/// Returned when a non-replicated pre-processing error occurred
/// (e.g. inspect_message, invalid signature, frozen canister, …).
final class ICPHttpAsyncCallRejection extends ICPHttpAsyncCallResponse {
  final BigInt rejectCode;
  final String rejectMessage;
  final String? errorCode;

  const ICPHttpAsyncCallRejection({
    required this.rejectCode,
    required this.rejectMessage,
    this.errorCode,
  });

  factory ICPHttpAsyncCallRejection.fromJson(Map<String, dynamic> json) {
    return ICPHttpAsyncCallRejection(
      rejectCode: json.valueAsBigInt('reject_code'),
      rejectMessage: json.valueAsString('reject_message'),
      errorCode: json.valueAsString('error_code'),
    );
  }

  @override
  CborTagValue toCbor() {
    final map = <CborObject, CborObject>{
      CborStringValue('reject_code'): CborBigIntValue(rejectCode),
      CborStringValue('reject_message'): CborStringValue(rejectMessage),
    };
    if (errorCode != null) {
      map[CborStringValue('error_code')] = CborStringValue(errorCode!);
    }
    return CborTagValue(CborMapValue.definite(map), [55799]);
  }
}

// ---------------------------------------------------------------------------
// READ_STATE response
//
// Possible paths that return this response type:
//   POST /api/v2/canister/<'effective_canister_id>/read_state   (deprecated)
//   POST /api/v3/canister/<'effective_canister_id>/read_state
//   POST /api/v2/subnet/<'effective_subnet_id>/read_state       (deprecated)
//   POST /api/v3/subnet/<'effective_subnet_id>/read_state
//
// Always HTTP 200 with a certificate (or 4xx/5xx on error).
// ---------------------------------------------------------------------------
class ICPHttpReadStateResponse extends ICPHttpResponse {
  final List<int> certificate;

  const ICPHttpReadStateResponse({required this.certificate});

  factory ICPHttpReadStateResponse.deserialize(List<int> bytes) {
    final content = CborObject.deserialize(bytes);
    final json = JsonParser.valueEnsureAsMap<String, dynamic>(
      content.getValue(),
    );
    return ICPHttpReadStateResponse.fromJson(json);
  }

  factory ICPHttpReadStateResponse.fromJson(Map<String, dynamic> json) {
    return ICPHttpReadStateResponse(
      certificate: json.valueAsBytes('certificate'),
    );
  }

  @override
  CborTagValue toCbor() {
    return CborTagValue(
      CborMapValue.definite({
        CborStringValue('certificate'): CborBytesValue(certificate),
      }),
      [55799],
    );
  }
}

// ---------------------------------------------------------------------------
// QUERY responses
//
// Possible paths that return these response types:
//   POST /api/v2/canister/<'effective_canister_id>/query   (deprecated)
//   POST /api/v3/canister/<'effective_canister_id>/query
//   POST /api/v3/subnet/<'effective_subnet_id>/query       (restricted – list_canisters only)
//
// HTTP status → response mapping:
//   200 + status "replied"   → ICPHttpQueryReplied
//   200 + status "rejected"  → ICPHttpQueryRejected
//   4xx / 5xx                → transport / client error (not modelled here)
// ---------------------------------------------------------------------------
sealed class ICPHttpQueryResponse extends ICPHttpResponse {
  final List<ICPHttpNodeSignature> signatures;

  const ICPHttpQueryResponse({required this.signatures});

  factory ICPHttpQueryResponse.deserialize(List<int> bytes) {
    final content = CborObject.deserialize(bytes);
    final json = JsonParser.valueEnsureAsMap<String, dynamic>(
      content.getValue(),
    );
    return ICPHttpQueryResponse.fromJson(json);
  }

  factory ICPHttpQueryResponse.fromJson(Map<String, dynamic> json) {
    final status = json.valueAsString('status');
    final sigs =
        (json.valueAsList('signatures') as List)
            .map(
              (e) => ICPHttpNodeSignature.fromJson(
                JsonParser.valueEnsureAsMap<String, dynamic>(e),
              ),
            )
            .toList();

    return switch (status) {
      'replied' => ICPHttpQueryReplied.fromJson(json, sigs),
      'rejected' => ICPHttpQueryRejected.fromJson(json, sigs),
      _ =>
        throw OnChainErrors.icpPlugin(
          "ICPHttpQueryResponse.fromJson",
          reason: 'Unknown query response status.',
          details: {'status': status},
        ),
    };
  }
}

/// status = "replied"
///
/// Paths:
///   POST /api/v2/canister/<'effective_canister_id>/query
///   POST /api/v3/canister/<'effective_canister_id>/query
///   POST /api/v3/subnet/<'effective_subnet_id>/query
///
/// Successful query result. Contains the reply data + node signature(s).
final class ICPHttpQueryReplied extends ICPHttpQueryResponse {
  final List<int> arg; // reply data

  const ICPHttpQueryReplied({required this.arg, required super.signatures});

  factory ICPHttpQueryReplied.fromJson(
    Map<String, dynamic> json,
    List<ICPHttpNodeSignature> sigs,
  ) {
    final reply = json.valueEnsureAsMap<String, dynamic>('reply');
    return ICPHttpQueryReplied(
      arg: reply.valueAsBytes('arg'),
      signatures: sigs,
    );
  }

  @override
  CborTagValue toCbor() {
    return CborTagValue(
      CborMapValue.definite(<CborObject, CborObject>{
        CborStringValue('status'): CborStringValue('replied'),
        CborStringValue('reply'): CborMapValue.definite({
          CborStringValue('arg'): CborBytesValue(arg),
        }),
        CborStringValue('signatures'): CborListValue.definite(
          signatures.map((s) => s.toCborMap()).toList(),
        ),
      }),
      [55799],
    );
  }
}

/// status = "rejected"
///
/// Paths:
///   POST /api/v2/canister/<'effective_canister_id>/query
///   POST /api/v3/canister/<'effective_canister_id>/query
///   POST /api/v3/subnet/<'effective_subnet_id>/query
///
/// Query was rejected (by the IC or by the canister).
final class ICPHttpQueryRejected extends ICPHttpQueryResponse {
  final BigInt rejectCode;
  final String rejectMessage;
  final String? errorCode;

  const ICPHttpQueryRejected({
    required this.rejectCode,
    required this.rejectMessage,
    this.errorCode,
    required super.signatures,
  });

  factory ICPHttpQueryRejected.fromJson(
    Map<String, dynamic> json,
    List<ICPHttpNodeSignature> sigs,
  ) {
    return ICPHttpQueryRejected(
      rejectCode: json.valueAsBigInt('reject_code'),
      rejectMessage: json.valueAsString('reject_message'),
      errorCode: json.valueAsString('error_code'),
      signatures: sigs,
    );
  }

  @override
  CborTagValue toCbor() {
    final map = <CborObject, CborObject>{
      CborStringValue('status'): CborStringValue('rejected'),
      CborStringValue('reject_code'): CborBigIntValue(rejectCode),
      CborStringValue('reject_message'): CborStringValue(rejectMessage),
      CborStringValue('signatures'): CborListValue.definite(
        signatures.map((s) => s.toCborMap()).toList(),
      ),
    };
    if (errorCode != null) {
      map[CborStringValue('error_code')] = CborStringValue(errorCode!);
    }
    return CborTagValue(CborMapValue.definite(map), [55799]);
  }
}

/// Node signature that accompanies every successful query response.
///
/// Produced by the replica that evaluated the query.
/// Verified against the node public key obtained from a separate read_state
/// of the /subnet tree.
class ICPHttpNodeSignature {
  final BigInt timestamp;
  final List<int> signature;
  final IcpPrincipalAddress identity; // node principal

  const ICPHttpNodeSignature({
    required this.timestamp,
    required this.signature,
    required this.identity,
  });

  factory ICPHttpNodeSignature.fromJson(Map<String, dynamic> json) {
    return ICPHttpNodeSignature(
      timestamp: json.valueAsBigInt('timestamp'),
      signature: json.valueAsBytes('signature'),
      identity: IcpPrincipalAddress.fromBytes(json.valueAsBytes('identity')),
    );
  }

  CborMapValue toCborMap() {
    return CborMapValue.definite({
      CborStringValue('timestamp'): CborBigIntValue(timestamp),
      CborStringValue('signature'): CborBytesValue(signature),
      CborStringValue('identity'): CborBytesValue(identity.toBytes()),
    });
  }
}
