import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';

/// *
///  * # Tss Message Map Key
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
///  * A key for use in the Threshold Signature Scheme (TSS) TssMessageMaps.
///  *
///  * This key SHALL be used to uniquely identify entries in the Message Maps.
class HederaTssMessageMapKey extends HederaProtoMessage with Equality {
  /// *
  ///    * A hash that uniquely identifies the target roster for the associated value
  ///    * in the map.
  ///    * &lt;p&gt;
  ///    * This value MUST be set.&lt;br/&gt;
  ///    * This value MUST NOT be empty.&lt;br/&gt;
  ///    * This value MUST contain a valid hash.
  final List<int>? rosterHash;

  /// *
  ///    * A number representing consensus order.&lt;br/&gt;
  ///    * This declares the order in which the mapped value came to consensus.
  ///    * &lt;p&gt;This value MUST be set.&lt;br/&gt;
  ///    * This value MUST be a valid sequence number.
  final BigInt? sequenceNumber;

  const HederaTssMessageMapKey({this.rosterHash, this.sequenceNumber});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.bytes(1), ProtoFieldConfig.uint64(2)],
    );
  }

  @override
  List<Object?> get protoValues => [rosterHash, sequenceNumber];

  HederaTssMessageMapKey copyWith({
    List<int>? rosterHash,

    BigInt? sequenceNumber,
  }) {
    return HederaTssMessageMapKey(
      rosterHash: rosterHash ?? this.rosterHash,
      sequenceNumber: sequenceNumber ?? this.sequenceNumber,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'roster_hash': config.encodeBinary(rosterHash),
      'sequence_number': config.encodeBigint(sequenceNumber),
    };
  }

  factory HederaTssMessageMapKey.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaTssMessageMapKey(
      rosterHash: config.decodeBinary<List<int>?>(
        json.valueAs('roster_hash', normalizeKeyLookup: config.normalizeKeys),
      ),
      sequenceNumber: json.valueAsBigInt<BigInt?>(
        'sequence_number',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaTssMessageMapKey.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTssMessageMapKey(
      rosterHash: decode.getBytes<List<int>?>(1),
      sequenceNumber: decode.getBigInt<BigInt?>(2),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiNodeStateTssTssMessageMapKey;
}
