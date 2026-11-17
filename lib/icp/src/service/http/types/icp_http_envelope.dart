// icp_http_envelope.dart

import 'package:blockchain_utils/encoding/encoding.dart';
import 'package:blockchain_utils/utils/utils.dart';
import 'icp_http_base.dart';
import 'icp_http_content.dart';

/// Outer envelope that wraps every POST body.
/// Path: used for /call, /read_state, /query
class ICPHttpEnvelope extends ICPHttpRequest {
  final ICPHttpContent content;
  final List<int>? senderPubkey;
  final List<ICPHttpDelegation>? senderDelegation;
  final List<int>? senderSig;

  const ICPHttpEnvelope({
    required this.content,
    this.senderPubkey,
    this.senderDelegation,
    this.senderSig,
  });

  factory ICPHttpEnvelope.deserialize(List<int> bytes) {
    final content = CborObject.deserialize(bytes);
    final json = JsonParser.valueEnsureAsMap<String, dynamic>(
      content.getValue(),
    );
    return ICPHttpEnvelope.fromJson(json);
  }

  factory ICPHttpEnvelope.fromJson(Map<String, dynamic> json) {
    return ICPHttpEnvelope(
      content: ICPHttpContent.fromJson(
        json.valueEnsureAsMap<String, dynamic>('content'),
      ),
      senderPubkey: json.valueAsBytes('sender_pubkey'),
      senderDelegation:
          json
              .valueAsList<List?>('sender_delegation')
              ?.map(
                (e) => ICPHttpDelegation.fromJson(
                  JsonParser.valueEnsureAsMap<String, dynamic>(e),
                ),
              )
              .toList(),
      senderSig: json.valueAs('sender_sig'),
    );
  }

  @override
  CborTagValue toCbor() {
    final map = <CborObject, CborObject>{
      CborStringValue('content'): content.toCborMap(), // without outer tag
    };
    if (senderPubkey != null) {
      map[CborStringValue('sender_pubkey')] = CborBytesValue(senderPubkey!);
    }
    if (senderDelegation != null) {
      map[CborStringValue('sender_delegation')] = CborListValue.definite(
        senderDelegation!.map((d) => d.toCborMap()).toList(),
      );
    }
    if (senderSig != null) {
      map[CborStringValue('sender_sig')] = CborBytesValue(senderSig!);
    }
    return CborTagValue(CborMapValue.definite(map), [55799]);
  }
}

class ICPHttpDelegation {
  final ICPHttpDelegationBody delegation;
  final List<int> signature;

  const ICPHttpDelegation({required this.delegation, required this.signature});

  factory ICPHttpDelegation.fromJson(Map<String, dynamic> json) {
    return ICPHttpDelegation(
      delegation: ICPHttpDelegationBody.fromJson(
        json.valueEnsureAsMap<String, dynamic>('delegation'),
      ),
      signature: json.valueAsBytes('signature'),
    );
  }

  CborMapValue toCborMap() {
    return CborMapValue.definite({
      CborStringValue('delegation'): delegation.toCborMap(),
      CborStringValue('signature'): CborBytesValue(signature),
    });
  }
}

class ICPHttpDelegationBody {
  final List<int> pubkey;
  final BigInt expiration;
  final List<List<int>>? targets; // list of principals
  final String? permissions; // "queries" | "all"

  const ICPHttpDelegationBody({
    required this.pubkey,
    required this.expiration,
    this.targets,
    this.permissions,
  });

  factory ICPHttpDelegationBody.fromJson(Map<String, dynamic> json) {
    return ICPHttpDelegationBody(
      pubkey: json.valueAsBytes('pubkey'),
      expiration: json.valueAsBigInt('expiration'),
      targets:
          json
              .valueAsList<List?>('targets')
              ?.map((e) => List<int>.from(e as List))
              .toList(),
      permissions: json.valueAsString('permissions'),
    );
  }

  CborMapValue toCborMap() {
    final map = <CborObject, CborObject>{
      CborStringValue('pubkey'): CborBytesValue(pubkey),
      CborStringValue('expiration'): CborBigIntValue(expiration),
    };
    if (targets != null) {
      map[CborStringValue('targets')] = CborListValue.definite(
        targets!.map((p) => CborBytesValue(p)).toList(),
      );
    }
    if (permissions != null) {
      map[CborStringValue('permissions')] = CborStringValue(permissions!);
    }
    return CborMapValue.definite(map);
  }
}
