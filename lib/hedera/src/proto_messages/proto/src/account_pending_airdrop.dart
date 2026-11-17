import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;

/// *
///  * # Account Pending Airdrop.
///  * A single pending airdrop awaiting claim by the recipient.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in
///  * [RFC2119](https://www.ietf.org/rfc/rfc2119) and clarified in
///  * [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.state.token"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * A node within a doubly linked list of pending airdrop references.&lt;br/&gt;
///  * This internal state message forms the entries in a doubly-linked list
///  * of references to pending airdrop entries that are "owed" by a particular
///  * account as "sender".
///  *
///  * Each entry in this list MUST refer to an existing pending airdrop.&lt;br/&gt;
///  * The pending airdrop MUST NOT be claimed.&lt;br/&gt;
///  * The pending airdrop MUST NOT be canceled.&lt;br/&gt;
///  * The pending airdrop `sender` account's `head_pending_airdrop_id` field
///  * MUST match the `pending_airdrop_id` field in this message.
class HederaAccountPendingAirdrop extends HederaProtoMessage with Equality {
  /// *
  ///      * An amount of fungible tokens to be sent for this pending airdrop.
  ///      * &lt;p&gt;
  ///      * This field SHALL NOT be set for non-fungible/unique tokens.
  final proto_basic_types.HederaPendingAirdropValue? pendingAirdropValue;

  /// *
  ///      * A pending airdrop identifier.
  ///      * &lt;p&gt;
  ///      * This field SHALL identify the specific pending airdrop that
  ///      * precedes this position within the doubly linked list of pending
  ///      * airdrops "owed" by the sending account associated with this
  ///      * account airdrop "list".&lt;br/&gt;
  ///      * This SHALL match `pending_airdrop_id` if this is the only entry
  ///      * in the "list".
  final proto_basic_types.HederaPendingAirdropId? previousAirdrop;

  /// *
  ///      * A pending airdrop identifier.&lt;br/&gt;
  ///      * &lt;p&gt;
  ///      * This field SHALL identify the specific pending airdrop that
  ///      * follows this position within the doubly linked list of pending
  ///      * airdrops "owed" by the sending account associated with this
  ///      * account airdrop "list".&lt;br/&gt;
  ///      * This SHALL match `pending_airdrop_id` if this is the only entry
  ///      * in the "list".
  final proto_basic_types.HederaPendingAirdropId? nextAirdrop;

  const HederaAccountPendingAirdrop({
    this.pendingAirdropValue,
    this.previousAirdrop,
    this.nextAirdrop,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.message(2),
        ProtoFieldConfig.message(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    pendingAirdropValue,
    previousAirdrop,
    nextAirdrop,
  ];

  HederaAccountPendingAirdrop copyWith({
    proto_basic_types.HederaPendingAirdropValue? pendingAirdropValue,

    proto_basic_types.HederaPendingAirdropId? previousAirdrop,

    proto_basic_types.HederaPendingAirdropId? nextAirdrop,
  }) {
    return HederaAccountPendingAirdrop(
      pendingAirdropValue: pendingAirdropValue ?? this.pendingAirdropValue,
      previousAirdrop: previousAirdrop ?? this.previousAirdrop,
      nextAirdrop: nextAirdrop ?? this.nextAirdrop,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'pending_airdrop_value': config.encodeMessage(pendingAirdropValue),
      'previous_airdrop': config.encodeMessage(previousAirdrop),
      'next_airdrop': config.encodeMessage(nextAirdrop),
    };
  }

  factory HederaAccountPendingAirdrop.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaAccountPendingAirdrop(
      pendingAirdropValue: json
          .valueTo<proto_basic_types.HederaPendingAirdropValue?, Object>(
            key: 'pending_airdrop_value',
            parse:
                (v) => proto_basic_types.HederaPendingAirdropValue.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      previousAirdrop: json
          .valueTo<proto_basic_types.HederaPendingAirdropId?, Object>(
            key: 'previous_airdrop',
            parse:
                (v) => proto_basic_types.HederaPendingAirdropId.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      nextAirdrop: json
          .valueTo<proto_basic_types.HederaPendingAirdropId?, Object>(
            key: 'next_airdrop',
            parse:
                (v) => proto_basic_types.HederaPendingAirdropId.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
    );
  }

  factory HederaAccountPendingAirdrop.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaAccountPendingAirdrop(
      pendingAirdropValue: decode
          .messageTo<proto_basic_types.HederaPendingAirdropValue?>(
            1,
            (b) => proto_basic_types.HederaPendingAirdropValue.deserialize(b),
          ),
      previousAirdrop: decode
          .messageTo<proto_basic_types.HederaPendingAirdropId?>(
            2,
            (b) => proto_basic_types.HederaPendingAirdropId.deserialize(b),
          ),
      nextAirdrop: decode.messageTo<proto_basic_types.HederaPendingAirdropId?>(
        3,
        (b) => proto_basic_types.HederaPendingAirdropId.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoAccountPendingAirdrop;
}
