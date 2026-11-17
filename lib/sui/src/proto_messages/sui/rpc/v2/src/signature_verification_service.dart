import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/sui/src/proto_messages/types.dart';
import 'package:on_chain/sui/src/serialization/protobuf/proto.dart';
import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/bcs.dart" as sui_rpc_v2_bcs;
import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/signature.dart" as sui_rpc_v2_signature;
import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/transaction.dart" as sui_rpc_v2_transaction;

class SuiVerifySignatureRequest extends SuiProtoMessage with ISuiProtoServiceMessage<SuiVerifySignatureResponse> {
    /// The message to verify against.
  ///
  /// Today the only supported message types are `PersonalMessage` and
  /// `TransactionData` and the `Bcs.name` must be set to indicate which type of
  /// message is being verified.
  final sui_rpc_v2_bcs.SuiBcs? message;

    /// The signature to verify.
  final sui_rpc_v2_signature.SuiUserSignature? signature;

    /// Optional. Address to validate against the provided signature.
  ///
  /// If provided, this address will be compared against the the address derived
  /// from the provide signature and a successful response will only be returned
  /// if they match.
  final String? address;

    /// The set of JWKs to use when verifying Zklogin signatures.
  /// If this is empty the current set of valid JWKs stored onchain will be used
  final List<sui_rpc_v2_transaction.SuiActiveJwk> jwks;

  const SuiVerifySignatureRequest({
    this.message,
    this.signature,
    this.address,
    this.jwks = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1, hasOptionalFlags: true),
        ProtoFieldConfig.message(2, hasOptionalFlags: true),
        ProtoFieldConfig.string(3, hasOptionalFlags: true),
        ProtoFieldConfig.repeated(
          fieldNumber: 4,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        message,
        signature,
        address,
        jwks,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'message': config.encodeMessage(message),
      'signature': config.encodeMessage(signature),
      'address': address,
      'jwks': jwks.map((e) => config.encodeMessage(e)).toList(),
    };
  }


  factory SuiVerifySignatureRequest.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiVerifySignatureRequest(
      message: json.valueTo<sui_rpc_v2_bcs.SuiBcs?, Object>(
        key: 'message',
        parse: (v) => sui_rpc_v2_bcs.SuiBcs.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      signature: json.valueTo<sui_rpc_v2_signature.SuiUserSignature?, Object>(
        key: 'signature',
        parse: (v) => sui_rpc_v2_signature.SuiUserSignature.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      address: json.valueAsString<String?>('address', normalizeKeyLookup: config.normalizeKeys),
      jwks: (json.valueEnsureAsList<dynamic>('jwks', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<sui_rpc_v2_transaction.SuiActiveJwk, Object>(
          value: e,
          parse: (v) => sui_rpc_v2_transaction.SuiActiveJwk.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
    );
  }

  factory SuiVerifySignatureRequest.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiVerifySignatureRequest(
      message: decode.messageTo<sui_rpc_v2_bcs.SuiBcs?>(1, (b) => sui_rpc_v2_bcs.SuiBcs.deserialize(b)),
      signature: decode.messageTo<sui_rpc_v2_signature.SuiUserSignature?>(2, (b) => sui_rpc_v2_signature.SuiUserSignature.deserialize(b)),
      address: decode.getString<String?>(3),
      jwks: decode.getListOfBytes(4).map((b) => sui_rpc_v2_transaction.SuiActiveJwk.deserialize(b)).toList(),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2VerifySignatureRequest;
  @override
  SuiVerifySignatureResponse onServiceResponse(List<int> bytes) {
    return SuiVerifySignatureResponse.deserialize(bytes);
  }
  @override
  SuiVerifySignatureResponse onServiceResponseJson(Map<String, dynamic> json) {
    return SuiVerifySignatureResponse.fromJson(json);
  }

}


/// The epoch to use
/// optional uint64 epoch = 5;
class SuiVerifySignatureResponse extends SuiProtoMessage {
    /// Indicates if the provided signature was valid given the requested parameters.
  final bool? isValid;

    /// If `is_valid` is `false`, this is the reason for why the signature verification failed.
  final String? reason;

  const SuiVerifySignatureResponse({
    this.isValid,
    this.reason,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bool(1, hasOptionalFlags: true),
        ProtoFieldConfig.string(2, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        isValid,
        reason,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'is_valid': isValid,
      'reason': reason,
    };
  }


  factory SuiVerifySignatureResponse.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiVerifySignatureResponse(
      isValid: json.valueAsBool<bool?>('is_valid', normalizeKeyLookup: config.normalizeKeys),
      reason: json.valueAsString<String?>('reason', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory SuiVerifySignatureResponse.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiVerifySignatureResponse(
      isValid: decode.getBool<bool?>(1),
      reason: decode.getString<String?>(2),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2VerifySignatureResponse;

}


