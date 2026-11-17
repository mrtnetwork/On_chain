import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/sui/src/proto_messages/types.dart';
import 'package:on_chain/sui/src/serialization/protobuf/proto.dart';
import 'package:on_chain/sui/src/serialization/protobuf/wkt.dart';

import "package:on_chain/sui/src/proto_messages/google/protobuf/src/timestamp.dart" as google_protobuf_timestamp;

class SuiLookupNameRequest extends SuiProtoMessage with ISuiProtoServiceMessage<SuiLookupNameResponse> {
    /// Required. The SuiNS name to lookup.
  ///
  /// Supports both `@name` as well as `name.sui` formats.
  final String? name;

  const SuiLookupNameRequest({
    this.name,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(1, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        name,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'name': name,
    };
  }


  factory SuiLookupNameRequest.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiLookupNameRequest(
      name: json.valueAsString<String?>('name', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory SuiLookupNameRequest.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiLookupNameRequest(
      name: decode.getString<String?>(1),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2LookupNameRequest;
  @override
  SuiLookupNameResponse onServiceResponse(List<int> bytes) {
    return SuiLookupNameResponse.deserialize(bytes);
  }
  @override
  SuiLookupNameResponse onServiceResponseJson(Map<String, dynamic> json) {
    return SuiLookupNameResponse.fromJson(json);
  }

}


class SuiLookupNameResponse extends SuiProtoMessage {
    /// The record for the requested name
  final SuiNameRecord? record;

  const SuiLookupNameResponse({
    this.record,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        record,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'record': config.encodeMessage(record),
    };
  }


  factory SuiLookupNameResponse.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiLookupNameResponse(
      record: json.valueTo<SuiNameRecord?, Object>(
        key: 'record',
        parse: (v) => SuiNameRecord.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory SuiLookupNameResponse.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiLookupNameResponse(
      record: decode.messageTo<SuiNameRecord?>(1, (b) => SuiNameRecord.deserialize(b)),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2LookupNameResponse;

}


class SuiReverseLookupNameRequest extends SuiProtoMessage with ISuiProtoServiceMessage<SuiReverseLookupNameResponse> {
    /// Required. The address to perform a reverse lookup for.
  final String? address;

  const SuiReverseLookupNameRequest({
    this.address,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(1, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        address,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'address': address,
    };
  }


  factory SuiReverseLookupNameRequest.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiReverseLookupNameRequest(
      address: json.valueAsString<String?>('address', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory SuiReverseLookupNameRequest.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiReverseLookupNameRequest(
      address: decode.getString<String?>(1),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2ReverseLookupNameRequest;
  @override
  SuiReverseLookupNameResponse onServiceResponse(List<int> bytes) {
    return SuiReverseLookupNameResponse.deserialize(bytes);
  }
  @override
  SuiReverseLookupNameResponse onServiceResponseJson(Map<String, dynamic> json) {
    return SuiReverseLookupNameResponse.fromJson(json);
  }

}


class SuiReverseLookupNameResponse extends SuiProtoMessage {
    /// The record for the SuiNS name linked to the requested address
  final SuiNameRecord? record;

  const SuiReverseLookupNameResponse({
    this.record,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        record,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'record': config.encodeMessage(record),
    };
  }


  factory SuiReverseLookupNameResponse.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiReverseLookupNameResponse(
      record: json.valueTo<SuiNameRecord?, Object>(
        key: 'record',
        parse: (v) => SuiNameRecord.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory SuiReverseLookupNameResponse.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiReverseLookupNameResponse(
      record: decode.messageTo<SuiNameRecord?>(1, (b) => SuiNameRecord.deserialize(b)),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2ReverseLookupNameResponse;

}


class SuiNameRecord extends SuiProtoMessage {
    /// Id of this record.
  ///
  /// Note that records are stored on chain as dynamic fields of the type
  /// `Field&lt;Domain,NameRecord&gt;`.
  final String? id;

    /// The SuiNS name of this record
  final String? name;

    /// The ID of the `RegistrationNFT` assigned to this record.
  ///
  /// The owner of the corresponding `RegistrationNFT` has the rights to
  /// be able to change and adjust the `target_address` of this domain.
  ///
  /// It is possible that the ID changes if the record expires and is
  /// purchased by someone else.
  final String? registrationNftId;

    /// Timestamp when the record expires.
  ///
  /// This is either the expiration of the record itself or the expiration of
  /// this record's parent if this is a leaf record.
  final google_protobuf_timestamp.SuiTimestamp? expirationTimestamp;

    /// The target address that this name points to
  final String? targetAddress;

    /// Additional data which may be stored in a record
  final Map<String, String> data;

  const SuiNameRecord({
    this.id,
    this.name,
    this.registrationNftId,
    this.expirationTimestamp,
    this.targetAddress,
    this.data = const {},
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(1, hasOptionalFlags: true),
        ProtoFieldConfig.string(2, hasOptionalFlags: true),
        ProtoFieldConfig.string(3, hasOptionalFlags: true),
        ProtoFieldConfig.message(4, hasOptionalFlags: true),
        ProtoFieldConfig.string(5, hasOptionalFlags: true),
        ProtoFieldConfig.map(
          fieldNumber: 6,
          keyType: ProtoFieldType.string,
          valueType: ProtoFieldType.string,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        id,
        name,
        registrationNftId,
        expirationTimestamp,
        targetAddress,
        data,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'id': id,
      'name': name,
      'registration_nft_id': registrationNftId,
      'expiration_timestamp': expirationTimestamp?.toRfc3339(),
      'target_address': targetAddress,
      'data': data,
    };
  }


  factory SuiNameRecord.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiNameRecord(
      id: json.valueAsString<String?>('id', normalizeKeyLookup: config.normalizeKeys),
      name: json.valueAsString<String?>('name', normalizeKeyLookup: config.normalizeKeys),
      registrationNftId: json.valueAsString<String?>('registration_nft_id', normalizeKeyLookup: config.normalizeKeys),
      expirationTimestamp: json.valueTo<google_protobuf_timestamp.SuiTimestamp?, Object>(
        key: 'expiration_timestamp',
        parse: (v) => google_protobuf_timestamp.SuiTimestamp.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      targetAddress: json.valueAsString<String?>('target_address', normalizeKeyLookup: config.normalizeKeys),
      data: config.decodeMap(json.valueAs('data', normalizeKeyLookup: config.normalizeKeys),(k, v) => MapEntry(JsonParser.valueAsString<String>(k), JsonParser.valueAsString<String>(v))),
    );
  }

  factory SuiNameRecord.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiNameRecord(
      id: decode.getString<String?>(1),
      name: decode.getString<String?>(2),
      registrationNftId: decode.getString<String?>(3),
      expirationTimestamp: decode.messageTo<google_protobuf_timestamp.SuiTimestamp?>(4, (b) => google_protobuf_timestamp.SuiTimestamp.deserialize(b)),
      targetAddress: decode.getString<String?>(5),
      data: decode.getMap<String, String>(6),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2NameRecord;

}


