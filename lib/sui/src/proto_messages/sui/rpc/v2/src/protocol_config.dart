import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/sui/src/proto_messages/types.dart';
import 'package:on_chain/sui/src/serialization/protobuf/proto.dart';
import "package:on_chain/sui/src/proto_messages/google/protobuf/src/struct.dart" as google_protobuf_struct;

/// Copyright (c) Mysten Labs, Inc.
/// SPDX-License-Identifier: Apache-2.0
class SuiProtocolConfig extends SuiProtoMessage {
  final BigInt? protocolVersion;

    /// Deprecated in favor of the lossless `configs` field.
  final Map<String, bool> featureFlags;

    /// Deprecated in favor of the lossless `configs` field.
  final Map<String, String> attributes;

  final Map<String, google_protobuf_struct.SuiValue> configs;

  const SuiProtocolConfig({
    this.protocolVersion,
    this.featureFlags = const {},
    this.attributes = const {},
    this.configs = const {},
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.uint64(1, hasOptionalFlags: true),
        ProtoFieldConfig.map(
          fieldNumber: 2,
          keyType: ProtoFieldType.string,
          valueType: ProtoFieldType.bool,
          options: [ProtoOptionBool(name: "deprecated", value: true)],
        ),
        ProtoFieldConfig.map(
          fieldNumber: 3,
          keyType: ProtoFieldType.string,
          valueType: ProtoFieldType.string,
          options: [ProtoOptionBool(name: "deprecated", value: true)],
        ),
        ProtoFieldConfig.map(
          fieldNumber: 4,
          keyType: ProtoFieldType.string,
          valueType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        protocolVersion,
        featureFlags,
        attributes,
        configs,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'protocol_version': config.encodeBigint(protocolVersion),
      'feature_flags': featureFlags,
      'attributes': attributes,
      'configs': config.encodeMap(configs,(k, v) => MapEntry(k, config.encodeMessage(v))),
    };
  }


  factory SuiProtocolConfig.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiProtocolConfig(
      protocolVersion: json.valueAsBigInt<BigInt?>('protocol_version', normalizeKeyLookup: config.normalizeKeys),
      featureFlags: config.decodeMap(json.valueAs('feature_flags', normalizeKeyLookup: config.normalizeKeys),(k, v) => MapEntry(JsonParser.valueAsString<String>(k), JsonParser.valueAsBool<bool>(v))),
      attributes: config.decodeMap(json.valueAs('attributes', normalizeKeyLookup: config.normalizeKeys),(k, v) => MapEntry(JsonParser.valueAsString<String>(k), JsonParser.valueAsString<String>(v))),
      configs: config.decodeMap(json.valueAs('configs', normalizeKeyLookup: config.normalizeKeys),(k, v) => MapEntry(JsonParser.valueAsString<String>(k), JsonParser.valueTo<google_protobuf_struct.SuiValue, Object>(
          value: v,
          parse: (v) => google_protobuf_struct.SuiValue.fromJson(JsonParser.valueAs(v), config: config),
        ))),
    );
  }

  factory SuiProtocolConfig.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiProtocolConfig(
      protocolVersion: decode.getBigInt<BigInt?>(1),
      featureFlags: decode.getMap<String, bool>(2),
      attributes: decode.getMap<String, String>(3),
      configs: decode.getMapField<String, google_protobuf_struct.SuiValue>(        fieldNumber: 4,
        keyMapper: (v) => JsonParser.valueAs<String>(v),
        valueMapper: (v) => google_protobuf_struct.SuiValue.deserialize(JsonParser.valueAsBytes<List<int>>(v)))
,
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2ProtocolConfig;

}


