import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';

/// *
///  * # Tss Vote Map Key
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
///  * A key for use in the Threshold Signature Scheme (TSS) TssVoteMaps.
///  *
///  * This key SHALL be used to uniquely identify entries in the Vote Maps.
class HederaTssVoteMapKey extends HederaProtoMessage with Equality {
    /// *
  ///      * A hash of the target roster for the associated value in the map. &lt;br/&gt;
  ///      * This hash uniquely identifies the target roster.
  ///      * &lt;p&gt;
  ///      * This value MUST be set.&lt;br/&gt;
  ///      * This value MUST contain a valid hash.
  final List<int>? rosterHash;

    /// * The node id of the node that created the TssVote.&lt;br/&gt;
  ///      * This id uniquely identifies the node.
  ///      * &lt;p&gt;
  ///      * This value MUST be set.&lt;br/&gt;
  ///      * This value MUST be a valid node id.
  final BigInt? nodeId;

  const HederaTssVoteMapKey({
    this.rosterHash,
    this.nodeId,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.uint64(2),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        rosterHash,
        nodeId,
      ];


HederaTssVoteMapKey copyWith(
{List<int>? rosterHash,

BigInt? nodeId,

}) {
    return HederaTssVoteMapKey(
rosterHash: rosterHash ?? this.rosterHash,
nodeId: nodeId ?? this.nodeId,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'roster_hash': config.encodeBinary(rosterHash),
      'node_id': config.encodeBigint(nodeId),
    };
  }


  factory HederaTssVoteMapKey.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaTssVoteMapKey(
      rosterHash: config.decodeBinary<List<int>?>(json.valueAs('roster_hash', normalizeKeyLookup: config.normalizeKeys)),
      nodeId: json.valueAsBigInt<BigInt?>('node_id', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaTssVoteMapKey.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTssVoteMapKey(
      rosterHash: decode.getBytes<List<int>?>(1),
      nodeId: decode.getBigInt<BigInt?>(2),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiNodeStateTssTssVoteMapKey;

}


