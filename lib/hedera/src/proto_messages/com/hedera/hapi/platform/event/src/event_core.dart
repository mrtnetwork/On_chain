import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/timestamp.dart"
    as proto_timestamp;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/platform/event/src/event_descriptor.dart"
    as com_hedera_hapi_platform_event_event_descriptor;
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;

/// *
///  * # Core Event Data
///  * A message that describes the metadata for an event.
///  *
///  * The `EventCore` contains a list of the event's parents, as well as the software
///  * version, an identifier for the node that created this event, the birth round, and
///  * the creation timestamp for the event.
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
///  * Contains information about an event and its parents.
class HederaEventCore extends HederaProtoMessage with Equality {
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
  ///    * The wall clock time at which the event was created, according to the node creating the event.&lt;br/&gt;
  ///    * If the event has a self parent, this timestamp MUST be strictly greater than the `time_created` of the self parent.
  final proto_timestamp.HederaTimestamp? timeCreated;

  /// *
  ///    * A list of EventDescriptors representing the parents of this event.&lt;br/&gt;
  ///    * The list of parents SHALL include zero or one self parents, and zero or more other parents.&lt;br/&gt;
  ///    * The first element of the list SHALL be the self parent, if one exists.&lt;br/&gt;
  ///    * The list of parents SHALL NOT include more than one parent from the same creator.
  ///    * &lt;p&gt;
  ///    * This field is deprecated and can be removed in release 0.62
  final List<
    com_hedera_hapi_platform_event_event_descriptor.HederaEventDescriptor
  >
  parents;

  /// *
  ///    * The event specification version.&lt;br/&gt;
  ///    * The specification described by this version SHALL encompass the format of the `GossipEvent` message, and also the
  ///    * format of all contained messages.&lt;br/&gt;
  ///    * This SHALL exactly match the specification version passed into the platform at construction.
  final proto_basic_types.HederaSemanticVersion? version;

  const HederaEventCore({
    this.creatorNodeId,
    this.birthRound,
    this.timeCreated,
    this.parents = const [],
    this.version,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.int64(1),
        ProtoFieldConfig.int64(2),
        ProtoFieldConfig.message(3),
        ProtoFieldConfig.repeated(
          fieldNumber: 4,
          elementType: ProtoFieldType.message,
          options: [ProtoOptionBool(name: "deprecated", value: true)],
        ),
        ProtoFieldConfig.message(17),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    creatorNodeId,
    birthRound,
    timeCreated,
    parents,
    version,
  ];

  HederaEventCore copyWith({
    BigInt? creatorNodeId,

    BigInt? birthRound,

    proto_timestamp.HederaTimestamp? timeCreated,

    List<com_hedera_hapi_platform_event_event_descriptor.HederaEventDescriptor>?
    parents,

    proto_basic_types.HederaSemanticVersion? version,
  }) {
    return HederaEventCore(
      creatorNodeId: creatorNodeId ?? this.creatorNodeId,
      birthRound: birthRound ?? this.birthRound,
      timeCreated: timeCreated ?? this.timeCreated,
      parents: parents ?? this.parents,
      version: version ?? this.version,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'creator_node_id': config.encodeBigint(creatorNodeId),
      'birth_round': config.encodeBigint(birthRound),
      'time_created': config.encodeMessage(timeCreated),
      'parents': parents.map((e) => config.encodeMessage(e)).toList(),
      'version': config.encodeMessage(version),
    };
  }

  factory HederaEventCore.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaEventCore(
      creatorNodeId: json.valueAsBigInt<BigInt?>(
        'creator_node_id',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      birthRound: json.valueAsBigInt<BigInt?>(
        'birth_round',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      timeCreated: json.valueTo<proto_timestamp.HederaTimestamp?, Object>(
        key: 'time_created',
        parse:
            (v) => proto_timestamp.HederaTimestamp.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      parents:
          (json.valueEnsureAsList<dynamic>(
                'parents',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<
                  com_hedera_hapi_platform_event_event_descriptor.HederaEventDescriptor,
                  Object
                >(
                  value: e,
                  parse:
                      (v) => com_hedera_hapi_platform_event_event_descriptor
                          .HederaEventDescriptor.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      version: json.valueTo<proto_basic_types.HederaSemanticVersion?, Object>(
        key: 'version',
        parse:
            (v) => proto_basic_types.HederaSemanticVersion.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaEventCore.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaEventCore(
      creatorNodeId: decode.getBigInt<BigInt?>(1),
      birthRound: decode.getBigInt<BigInt?>(2),
      timeCreated: decode.messageTo<proto_timestamp.HederaTimestamp?>(
        3,
        (b) => proto_timestamp.HederaTimestamp.deserialize(b),
      ),
      parents:
          decode
              .getListOfBytes(4)
              .map(
                (b) => com_hedera_hapi_platform_event_event_descriptor
                    .HederaEventDescriptor.deserialize(b),
              )
              .toList(),
      version: decode.messageTo<proto_basic_types.HederaSemanticVersion?>(
        17,
        (b) => proto_basic_types.HederaSemanticVersion.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiPlatformEventEventCore;
}
