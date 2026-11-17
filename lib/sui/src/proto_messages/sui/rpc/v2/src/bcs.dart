import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/sui/src/proto_messages/types.dart';
import 'package:on_chain/sui/src/serialization/protobuf/proto.dart';

/// Copyright (c) Mysten Labs, Inc.
/// SPDX-License-Identifier: Apache-2.0
/// `Bcs` contains an arbitrary type that is serialized using the
/// [BCS](https://mystenlabs.github.io/sui-rust-sdk/sui_sdk_types/index.html#bcs)
/// format as well as a name that identifies the type of the serialized value.
class SuiBcs extends SuiProtoMessage {
    /// Name that identifies the type of the serialized value.
  final String? name;

    /// Bytes of a BCS serialized value.
  final BuBytes? value;

  SuiBcs({
    this.name,
    List<int>? value,
  }) : 
    value = value?.asImmutableBytes;

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(1, hasOptionalFlags: true),
        ProtoFieldConfig.bytes(2, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        name,
        value,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'name': name,
      'value': config.encodeBinary(value),
    };
  }


  factory SuiBcs.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiBcs(
      name: json.valueAsString<String?>('name', normalizeKeyLookup: config.normalizeKeys),
      value: config.decodeBinary<List<int>?>(json.valueAs('value', normalizeKeyLookup: config.normalizeKeys)),
    );
  }

  factory SuiBcs.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiBcs(
      name: decode.getString<String?>(1),
      value: decode.getBytes<List<int>?>(2),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2Bcs;

}


