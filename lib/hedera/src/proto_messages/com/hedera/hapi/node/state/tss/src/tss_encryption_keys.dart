import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';

/// *
///  * # Current and next TSS encryption keys
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in
///  * [RFC2119](https://www.ietf.org/rfc/rfc2119) and clarified in
///  * [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.state.tss"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * A message containing a node's current and next TSS encryption keys, where
///  * the next key (if present) will be switched to the node's current key during
///  * the first transaction at the beginning of a staking period.&lt;br/&gt;
class HederaTssEncryptionKeys extends HederaProtoMessage with Equality {
  /// *
  ///    * If non-empty, a node's current TSS encryption key.
  final List<int>? currentEncryptionKey;

  /// *
  ///    * If non-empty, the same node's next TSS encryption key.
  final List<int>? nextEncryptionKey;

  const HederaTssEncryptionKeys({
    this.currentEncryptionKey,
    this.nextEncryptionKey,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.bytes(1), ProtoFieldConfig.bytes(2)],
    );
  }

  @override
  List<Object?> get protoValues => [currentEncryptionKey, nextEncryptionKey];

  HederaTssEncryptionKeys copyWith({
    List<int>? currentEncryptionKey,

    List<int>? nextEncryptionKey,
  }) {
    return HederaTssEncryptionKeys(
      currentEncryptionKey: currentEncryptionKey ?? this.currentEncryptionKey,
      nextEncryptionKey: nextEncryptionKey ?? this.nextEncryptionKey,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'current_encryption_key': config.encodeBinary(currentEncryptionKey),
      'next_encryption_key': config.encodeBinary(nextEncryptionKey),
    };
  }

  factory HederaTssEncryptionKeys.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaTssEncryptionKeys(
      currentEncryptionKey: config.decodeBinary<List<int>?>(
        json.valueAs(
          'current_encryption_key',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      nextEncryptionKey: config.decodeBinary<List<int>?>(
        json.valueAs(
          'next_encryption_key',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
    );
  }

  factory HederaTssEncryptionKeys.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTssEncryptionKeys(
      currentEncryptionKey: decode.getBytes<List<int>?>(1),
      nextEncryptionKey: decode.getBytes<List<int>?>(2),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiNodeStateTssTssEncryptionKeys;
}
