import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/sui/src/proto_messages/types.dart';
import 'package:on_chain/sui/src/serialization/protobuf/proto.dart';

/// Copyright (c) Mysten Labs, Inc.
/// SPDX-License-Identifier: Apache-2.0
/// Reference to an object.
class SuiObjectReference extends SuiProtoMessage {
  /// The object id of this object.
  final String? objectId;

  /// The version of this object.
  final BigInt? version;

  /// The digest of this object.
  final String? digest;

  const SuiObjectReference({this.objectId, this.version, this.digest});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(1, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(2, hasOptionalFlags: true),
        ProtoFieldConfig.string(3, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [objectId, version, digest];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'object_id': objectId,
      'version': config.encodeBigint(version),
      'digest': digest,
    };
  }

  factory SuiObjectReference.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiObjectReference(
      objectId: json.valueAsString<String?>(
        'object_id',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      version: json.valueAsBigInt<BigInt?>(
        'version',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      digest: json.valueAsString<String?>(
        'digest',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiObjectReference.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiObjectReference(
      objectId: decode.getString<String?>(1),
      version: decode.getBigInt<BigInt?>(2),
      digest: decode.getString<String?>(3),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2ObjectReference;
}
