import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';

/// *
///  * # Event Descriptor
///  * Unique identifier for an event.
///  *
///  * Contains the hash of the event, the creator identifier, the birth round, and the generation.
///  *
///  * An event's descriptor is constructed individually by each node that receives a `GossipEvent`,
///  * to uniquely identify that event. An event's descriptor isn't part of the `GossipEvent` itself,
///  * since the descriptor contains the fields `hash` and `generation`, which can be computed locally.
///  * Nodes receiving a `GossipEvent` have the required information to construct the event descriptor
///  * immediately upon receiving the event, without needing to wait for the event to reach consensus.
///  *
///  * Aside from being a unique identifier for events that have been received through gossip,
///  * the event descriptor contains the necessary information to describe an event's parents,
///  * in the `parents` field of `GossipEvent`.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in [RFC2119](https://www.ietf.org/rfc/rfc2119).
/// * Hedera Network Services Protobuf
///  *
///  * Copyright (C) 2024 Hedera Hashgraph, LLC
///  *
///  * Licensed under the Apache License, Version 2.0 (the "License");
///  * you may not use this file except in compliance with the License.
///  * You may obtain a copy of the License at
///  *
///  *      http://www.apache.org/licenses/LICENSE-2.0
///  *
///  * Unless required by applicable law or agreed to in writing, software
///  * distributed under the License is distributed on an "AS IS" BASIS,
///  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
///  * See the License for the specific language governing permissions and
///  * limitations under the License.
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.platform.event"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * Unique identifier for an event.
class HederaEventDescriptor extends HederaProtoMessage with Equality {
    /// *
  ///    * The hash of the event.&lt;br/&gt;
  ///    * The hash SHALL be a SHA-384 hash.&lt;br/&gt;
  ///    * The hash SHALL have the following inputs, in the specified order:&lt;br/&gt;
  ///    * 1. The bytes of the `EventCore` protobuf&lt;br/&gt;
  ///    * 2. The SHA-384 hash of each individual `EventTransaction`, in the order the transactions appear in the `event_transactions` field of the `GossipEvent` protobuf
  final List<int>? hash;

    /// *
  ///    * The creator node identifier.&lt;br/&gt;
  ///    * This SHALL be the unique identifier for the node that created the event.&lt;br/&gt;
  ///    * This SHALL match the ID of the node as it appears in the address book.
  final BigInt? creatorNodeId;

    /// *
  ///    * The birth round of the event.&lt;br/&gt;
  ///    * The birth round SHALL be the pending consensus round at the time the event is created.&lt;br/&gt;
  ///    * The pending consensus round SHALL be **one greater** than the latest round to reach consensus.
  final BigInt? birthRound;

    /// *
  ///   * The generation of the event.&lt;br/&gt;
  ///   * This value SHALL be **one greater** than the _maximum_ generation of all parents.&lt;br/&gt;
  final BigInt? generation;

  const HederaEventDescriptor({
    this.hash,
    this.creatorNodeId,
    this.birthRound,
    this.generation,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.int64(2),
        ProtoFieldConfig.int64(3),
        ProtoFieldConfig.int64(17),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        hash,
        creatorNodeId,
        birthRound,
        generation,
      ];


HederaEventDescriptor copyWith(
{List<int>? hash,

BigInt? creatorNodeId,

BigInt? birthRound,

BigInt? generation,

}) {
    return HederaEventDescriptor(
hash: hash ?? this.hash,
creatorNodeId: creatorNodeId ?? this.creatorNodeId,
birthRound: birthRound ?? this.birthRound,
generation: generation ?? this.generation,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'hash': config.encodeBinary(hash),
      'creator_node_id': config.encodeBigint(creatorNodeId),
      'birth_round': config.encodeBigint(birthRound),
      'generation': config.encodeBigint(generation),
    };
  }


  factory HederaEventDescriptor.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaEventDescriptor(
      hash: config.decodeBinary<List<int>?>(json.valueAs('hash', normalizeKeyLookup: config.normalizeKeys)),
      creatorNodeId: json.valueAsBigInt<BigInt?>('creator_node_id', normalizeKeyLookup: config.normalizeKeys),
      birthRound: json.valueAsBigInt<BigInt?>('birth_round', normalizeKeyLookup: config.normalizeKeys),
      generation: json.valueAsBigInt<BigInt?>('generation', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaEventDescriptor.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaEventDescriptor(
      hash: decode.getBytes<List<int>?>(1),
      creatorNodeId: decode.getBigInt<BigInt?>(2),
      birthRound: decode.getBigInt<BigInt?>(3),
      generation: decode.getBigInt<BigInt?>(17),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiPlatformEventEventDescriptor;

}


