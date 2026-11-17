import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/platform/event/src/event_core.dart"
    as com_hedera_hapi_platform_event_event_core;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/platform/event/src/event_descriptor.dart"
    as com_hedera_hapi_platform_event_event_descriptor;

/// *
///  * # Event Header
///  * This header precedes the event messages that contain transactions.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in
///  * [RFC2119](https://www.ietf.org/rfc/rfc2119) and clarified in
///  * [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// * Copyright (C) 2024 Hedera Hashgraph, LLC
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
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.block.stream.input"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * A header for a single event.&lt;br/&gt;
///  * This message delivers information about an event and its parents.
class HederaEventHeader extends HederaProtoMessage with Equality {
  /// *
  ///      * An event core value.&lt;br/&gt;
  final com_hedera_hapi_platform_event_event_core.HederaEventCore? eventCore;

  /// *
  ///     * A list of references to parent events. &lt;br/&gt;
  final List<HederaParentEventReference> parents;

  /// *
  ///      * The middle bit of the node's signature on the event.&lt;br/&gt;
  final bool? signatureMiddleBit;

  const HederaEventHeader({
    this.eventCore,
    this.parents = const [],
    this.signatureMiddleBit,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.repeated(
          fieldNumber: 2,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.bool(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [eventCore, parents, signatureMiddleBit];

  HederaEventHeader copyWith({
    com_hedera_hapi_platform_event_event_core.HederaEventCore? eventCore,

    List<HederaParentEventReference>? parents,

    bool? signatureMiddleBit,
  }) {
    return HederaEventHeader(
      eventCore: eventCore ?? this.eventCore,
      parents: parents ?? this.parents,
      signatureMiddleBit: signatureMiddleBit ?? this.signatureMiddleBit,
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
      'parents': parents.map((e) => config.encodeMessage(e)).toList(),
      'signature_middle_bit': signatureMiddleBit,
    };
  }

  factory HederaEventHeader.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaEventHeader(
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
      parents:
          (json.valueEnsureAsList<dynamic>(
                'parents',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<HederaParentEventReference, Object>(
                  value: e,
                  parse:
                      (v) => HederaParentEventReference.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      signatureMiddleBit: json.valueAsBool<bool?>(
        'signature_middle_bit',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaEventHeader.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaEventHeader(
      eventCore: decode.messageTo<
        com_hedera_hapi_platform_event_event_core.HederaEventCore?
      >(
        1,
        (b) => com_hedera_hapi_platform_event_event_core
            .HederaEventCore.deserialize(b),
      ),
      parents:
          decode
              .getListOfBytes(2)
              .map((b) => HederaParentEventReference.deserialize(b))
              .toList(),
      signatureMiddleBit: decode.getBool<bool?>(3),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiBlockStreamInputEventHeader;
}

/// * A reference to a parent event.
class HederaParentEventReference extends HederaProtoMessage with Equality {
  /// *
  ///          * An EventDescriptor for the parent event outside of the containing block.
  final com_hedera_hapi_platform_event_event_descriptor.HederaEventDescriptor?
  eventDescriptor;

  /// *
  ///          * An index of the parent event within the containing block.
  final int? index;

  const HederaParentEventReference({this.eventDescriptor, this.index});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.message(1), ProtoFieldConfig.uint32(2)],
    );
  }

  @override
  List<Object?> get protoValues => [eventDescriptor, index];

  HederaParentEventReference copyWith({
    com_hedera_hapi_platform_event_event_descriptor.HederaEventDescriptor?
    eventDescriptor,

    int? index,
  }) {
    return HederaParentEventReference(
      eventDescriptor: eventDescriptor ?? this.eventDescriptor,
      index: index ?? this.index,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'event_descriptor': config.encodeMessage(eventDescriptor),
      'index': index,
    };
  }

  factory HederaParentEventReference.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaParentEventReference(
      eventDescriptor: json.valueTo<
        com_hedera_hapi_platform_event_event_descriptor.HederaEventDescriptor?,
        Object
      >(
        key: 'event_descriptor',
        parse:
            (v) => com_hedera_hapi_platform_event_event_descriptor
                .HederaEventDescriptor.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      index: json.valueAsInt<int?>(
        'index',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaParentEventReference.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaParentEventReference(
      eventDescriptor: decode.messageTo<
        com_hedera_hapi_platform_event_event_descriptor.HederaEventDescriptor?
      >(
        1,
        (b) => com_hedera_hapi_platform_event_event_descriptor
            .HederaEventDescriptor.deserialize(b),
      ),
      index: decode.getInt<int?>(2),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl
          .comHederaHapiBlockStreamInputParentEventReference;
}
