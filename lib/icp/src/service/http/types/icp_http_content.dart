import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/icp/src/address/address.dart';
import 'icp_http_base.dart';

enum ICPHttpRequestType {
  query("query"),
  call("call"),
  readState("read_state");

  final String value;
  const ICPHttpRequestType(this.value);

  static ICPHttpRequestType fromValue(String? value) => values.firstWhere(
    (e) => e.value == value,
    orElse:
        () =>
            throw OnChainErrors.icpPlugin(
              "ICPHttpRequestType.fromValue",
              reason: "Invalid ICP request type.",
              details: {"value": value},
            ),
  );
}

/// Base for the inner `content` map.
sealed class ICPHttpContent extends ICPHttpRequest {
  final ICPHttpRequestType type;
  final IcpPrincipalAddress sender; // principal
  final List<int>? nonce; // ≤ 32 bytes
  final BigInt ingressExpiry; // nanoseconds

  const ICPHttpContent({
    required this.type,
    required this.sender,
    this.nonce,
    required this.ingressExpiry,
  });

  /// Factory that dispatches on `request_type`.
  factory ICPHttpContent.fromJson(Map<String, dynamic> json) {
    final type = ICPHttpRequestType.fromValue(
      json.valueAsString('request_type'),
    );
    return switch (type) {
      ICPHttpRequestType.call => ICPHttpCallContent.fromJson(json),
      ICPHttpRequestType.readState => ICPHttpReadStateContent.fromJson(json),
      ICPHttpRequestType.query => ICPHttpQueryContent.fromJson(json),
    };
  }

  /// Returns the inner CBOR map (no outer tag). Used by the envelope.
  CborMapValue toCborMap();

  @override
  CborTagValue toCbor() => CborTagValue(toCborMap(), [55799]);
}

// ---------------------------------------------------------------------------
// CALL
// Paths:
//   /api/v2/canister/<id>/call
//   /api/v3/canister/<id>/call  (deprecated)
//   /api/v4/canister/<id>/call
//   /api/v4/subnet/<id>/call
// ---------------------------------------------------------------------------
final class ICPHttpCallContent extends ICPHttpContent {
  final IcpPrincipalAddress canisterId;
  final String methodName;
  final List<int> arg;
  final ICPHttpSenderInfo? senderInfo;

  const ICPHttpCallContent({
    required super.sender,
    super.nonce,
    required super.ingressExpiry,
    required this.canisterId,
    required this.methodName,
    required this.arg,
    this.senderInfo,
  }) : super(type: ICPHttpRequestType.call);

  factory ICPHttpCallContent.fromJson(Map<String, dynamic> json) {
    return ICPHttpCallContent(
      sender: IcpPrincipalAddress.fromBytes(json.valueAsBytes('sender')),
      nonce: json.valueAsBytes('nonce'),
      ingressExpiry: json.valueAsBigInt('ingress_expiry'),
      canisterId: IcpPrincipalAddress.fromBytes(
        json.valueAsBytes('canister_id'),
      ),
      methodName: json.valueAsString('method_name'),
      arg: json.valueAsBytes('arg'),
      senderInfo: json.valueTo<ICPHttpSenderInfo?, Map<String, dynamic>>(
        key: "sender_info",
        parse: (v) => ICPHttpSenderInfo.fromJson(v),
      ),
    );
  }

  @override
  CborMapValue toCborMap() {
    final map = <CborObject, CborObject>{
      CborStringValue('request_type'): CborStringValue(type.value),
      CborStringValue('canister_id'): CborBytesValue(canisterId.toBytes()),
      CborStringValue('method_name'): CborStringValue(methodName),
      CborStringValue('arg'): CborBytesValue(arg),
      CborStringValue('sender'): CborBytesValue(sender.toBytes()),
      CborStringValue('ingress_expiry'): CborSafeIntValue(ingressExpiry),
    };
    if (nonce != null) {
      map[CborStringValue('nonce')] = CborBytesValue(nonce!);
    }
    if (senderInfo != null) {
      map[CborStringValue('sender_info')] = senderInfo!.toCborMap();
    }
    return CborMapValue.definite(map);
  }
}

class ICPHttpSenderInfo {
  final List<int> info; // arbitrary blob passed to the canister
  final IcpPrincipalAddress
  signer; // Principal (canister ID) – must match the canister that produced the signature
  final List<int> sig; // canister signature over  \x0Eic-sender-info  ‖  info

  const ICPHttpSenderInfo({
    required this.info,
    required this.signer,
    required this.sig,
  });

  factory ICPHttpSenderInfo.fromJson(Map<String, dynamic> json) {
    return ICPHttpSenderInfo(
      info: json.valueAsBytes('info'),
      signer: IcpPrincipalAddress.fromBytes(json.valueAsBytes('signer')),
      sig: json.valueAsBytes('sig'),
    );
  }

  CborMapValue toCborMap() {
    return CborMapValue.definite({
      CborStringValue('info'): CborBytesValue(info),
      CborStringValue('signer'): CborBytesValue(signer.toBytes()),
      CborStringValue('sig'): CborBytesValue(sig),
    });
  }
}

// ---------------------------------------------------------------------------
// READ_STATE
// Paths:
//   /api/v2|v3/canister/<id>/read_state
//   /api/v2|v3/subnet/<id>/read_state
// ---------------------------------------------------------------------------
final class ICPHttpReadStateContent extends ICPHttpContent {
  /// List of paths, each path is a list of blobs.
  final List<List<List<int>>> paths;

  const ICPHttpReadStateContent({
    required super.sender,
    super.nonce,
    required super.ingressExpiry,
    required this.paths,
  }) : super(type: ICPHttpRequestType.readState);

  factory ICPHttpReadStateContent.fromJson(Map<String, dynamic> json) {
    final rawPaths = json.valueEnsureAsList<List>('paths');
    final paths =
        rawPaths.map((p) {
          return p
              .map((seg) => JsonParser.valueAsBytes<List<int>>(seg))
              .toList();
        }).toList();

    return ICPHttpReadStateContent(
      sender: IcpPrincipalAddress.fromBytes(json.valueAsBytes('sender')),
      nonce: json.valueAsBytes('nonce'),
      ingressExpiry: json.valueAsBigInt('ingress_expiry'),
      paths: paths,
    );
  }

  @override
  CborMapValue toCborMap() {
    final map = <CborObject, CborObject>{
      CborStringValue('request_type'): CborStringValue(type.value),
      CborStringValue('sender'): CborBytesValue(sender.toBytes()),
      CborStringValue('ingress_expiry'): CborSafeIntValue(ingressExpiry),
      CborStringValue('paths'): CborListValue.definite(
        paths
            .map(
              (path) => CborListValue.definite(
                path.map((seg) => CborBytesValue(seg)).toList(),
              ),
            )
            .toList(),
      ),
    };
    if (nonce != null) {
      map[CborStringValue('nonce')] = CborBytesValue(nonce!);
    }
    return CborMapValue.definite(map);
  }
}

// ---------------------------------------------------------------------------
// QUERY
// Paths:
//   /api/v2|v3/canister/<id>/query
//   /api/v3/subnet/<id>/query
// ---------------------------------------------------------------------------
final class ICPHttpQueryContent extends ICPHttpContent {
  final IcpPrincipalAddress canisterId;
  final String methodName;
  final List<int> arg;
  final ICPHttpSenderInfo? senderInfo;

  const ICPHttpQueryContent({
    required super.sender,
    super.nonce,
    required super.ingressExpiry,
    required this.canisterId,
    required this.methodName,
    required this.arg,
    this.senderInfo,
  }) : super(type: ICPHttpRequestType.query);

  factory ICPHttpQueryContent.fromJson(Map<String, dynamic> json) {
    return ICPHttpQueryContent(
      sender: IcpPrincipalAddress.fromBytes(json.valueAsBytes('sender')),
      nonce: json.valueAsBytes('nonce'),
      ingressExpiry: json.valueAsBigInt('ingress_expiry'),
      canisterId: IcpPrincipalAddress.fromBytes(
        json.valueAsBytes('canister_id'),
      ),
      methodName: json.valueAsString('method_name'),
      arg: json.valueAsBytes('arg'),
      senderInfo: json.valueTo<ICPHttpSenderInfo?, Map<String, dynamic>>(
        key: "sender_info",
        parse: (v) => ICPHttpSenderInfo.fromJson(v),
      ),
    );
  }

  @override
  CborMapValue toCborMap() {
    final map = <CborObject, CborObject>{
      CborStringValue('request_type'): CborStringValue(type.value),
      CborStringValue('canister_id'): CborBytesValue(canisterId.toBytes()),
      CborStringValue('method_name'): CborStringValue(methodName),
      CborStringValue('arg'): CborBytesValue(arg),
      CborStringValue('sender'): CborBytesValue(sender.toBytes()),
      CborStringValue('ingress_expiry'): CborSafeIntValue(ingressExpiry),
    };
    if (nonce != null) {
      map[CborStringValue('nonce')] = CborBytesValue(nonce!);
    }
    if (senderInfo != null) {
      map[CborStringValue('sender_info')] = senderInfo!.toCborMap();
    }
    return CborMapValue.definite(map);
  }
}
