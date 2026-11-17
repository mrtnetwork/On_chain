import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/platform/event/src/event_core.dart"
    as com_hedera_hapi_platform_event_event_core;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/platform/event/src/event_descriptor.dart"
    as com_hedera_hapi_platform_event_event_descriptor;

/// *
///  * # Gossip Event
///  * An event that is sent and received via gossip
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
///  * An event that is sent and received via gossip
class HederaGossipEvent extends HederaProtoMessage with Equality {
  /// The EventTransaction field has been reserved because it is no longer
  /// required to be stored in the GossipEvent.
  /// *
  ///    * The core event data
  final com_hedera_hapi_platform_event_event_core.HederaEventCore? eventCore;

  /// *
  ///    * A node signature on the event hash.&lt;br/&gt;
  ///    * The signature SHALL be created with the SHA384withRSA algorithm.&lt;br/&gt;
  ///    * The signature MUST verify using the public key belonging to the `event_creator`.&lt;br/&gt;
  ///    * The `event_creator` public key SHALL be read from the address book that corresponds to the event's birth round.&lt;br/&gt;
  ///    * The signed event hash SHALL be a SHA-384 hash.&lt;br/&gt;
  ///    * The signed event hash SHALL have the following inputs, in the specified order:&lt;br/&gt;
  ///    * 1. The bytes of the `event_core` field&lt;br/&gt;
  ///    * 2. The SHA-384 hash of each individual `EventTransaction`, in the order the transaction appear in the `event_transaction` field
  final List<int>? signature;

  /// *
  ///    * A list of serialized transactions.
  ///    * &lt;p&gt;
  ///    * This field MAY contain zero transactions.&lt;br/&gt;
  ///    * Each transaction in this list SHALL be presented exactly as
  ///    * it was supplied to the consensus algorithm.&lt;br/&gt;
  ///    * This field MUST contain one entry for each transaction
  ///    * included in this gossip event.
  final List<List<int>> transactions;

  /// *
  ///    * A list of EventDescriptors representing the parents of this event.&lt;br/&gt;
  ///    * The list of parents SHALL include zero or one self parents, and zero or more other parents.&lt;br/&gt;
  ///    * The first element of the list SHALL be the self parent, if one exists.&lt;br/&gt;
  ///    * The list of parents SHALL NOT include more than one parent from the same creator.
  ///    * &lt;p&gt;
  ///    * NOTE: This field is currently being migrated from EventCore to GossipEvent.
  ///    * Once the migration is complete, this field will be removed from EventCore.
  ///    * While migration is ongoing, the expectation is that only one of the two
  ///    * fields will be set, but not both.
  final List<
    com_hedera_hapi_platform_event_event_descriptor.HederaEventDescriptor
  >
  parents;

  const HederaGossipEvent({
    this.eventCore,
    this.signature,
    this.transactions = const [],
    this.parents = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.bytes(2),
        ProtoFieldConfig.repeated(
          fieldNumber: 4,
          elementType: ProtoFieldType.bytes,
        ),
        ProtoFieldConfig.repeated(
          fieldNumber: 5,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    eventCore,
    signature,
    transactions,
    parents,
  ];

  HederaGossipEvent copyWith({
    com_hedera_hapi_platform_event_event_core.HederaEventCore? eventCore,

    List<int>? signature,

    List<List<int>>? transactions,

    List<com_hedera_hapi_platform_event_event_descriptor.HederaEventDescriptor>?
    parents,
  }) {
    return HederaGossipEvent(
      eventCore: eventCore ?? this.eventCore,
      signature: signature ?? this.signature,
      transactions: transactions ?? this.transactions,
      parents: parents ?? this.parents,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'event_core': config.encodeMessage(eventCore),
      'signature': config.encodeBinary(signature),
      'transactions': transactions.map((e) => config.encodeBinary(e)).toList(),
      'parents': parents.map((e) => config.encodeMessage(e)).toList(),
    };
  }

  factory HederaGossipEvent.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaGossipEvent(
      eventCore: json.valueTo<
        com_hedera_hapi_platform_event_event_core.HederaEventCore?,
        Object
      >(
        key: 'event_core',
        parse:
            (v) => com_hedera_hapi_platform_event_event_core
                .HederaEventCore.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      signature: config.decodeBinary<List<int>?>(
        json.valueAs('signature', normalizeKeyLookup: config.normalizeKeys),
      ),
      transactions:
          (json.valueEnsureAsList<dynamic>(
            'transactions',
            normalizeKeyLookup: config.normalizeKeys,
            onMissing: () => [],
          )).map((e) => config.decodeBinary<List<int>>(e)).toList(),
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
    );
  }

  factory HederaGossipEvent.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaGossipEvent(
      eventCore: decode.messageTo<
        com_hedera_hapi_platform_event_event_core.HederaEventCore?
      >(
        1,
        (b) => com_hedera_hapi_platform_event_event_core
            .HederaEventCore.deserialize(b),
      ),
      signature: decode.getBytes<List<int>?>(2),
      transactions: decode.getListOfBytes(4),
      parents:
          decode
              .getListOfBytes(5)
              .map(
                (b) => com_hedera_hapi_platform_event_event_descriptor
                    .HederaEventDescriptor.deserialize(b),
              )
              .toList(),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiPlatformEventGossipEvent;
}
