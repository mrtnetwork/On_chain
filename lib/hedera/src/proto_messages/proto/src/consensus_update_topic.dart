import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;
import "package:on_chain/hedera/src/proto_messages/google/protobuf/src/wrappers.dart"
    as google_protobuf_wrappers;
import "package:on_chain/hedera/src/proto_messages/proto/src/timestamp.dart"
    as proto_timestamp;
import "package:on_chain/hedera/src/proto_messages/proto/src/duration.dart"
    as proto_duration;
import "package:on_chain/hedera/src/proto_messages/proto/src/custom_fees.dart"
    as proto_custom_fees;

/// *
///  * # Update Topic
///  * Update a topic for the Hedera Consensus Service (HCS).
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in
///  * [RFC2119](https://www.ietf.org/rfc/rfc2119) and clarified in
///  * [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.consensus"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * Update the fields of an existing HCS topic.
///  *
///  * The topicID field is REQUIRED. All other fields are OPTIONAL.&lt;br/&gt;
///  * Fields set on this transaction SHALL be updated.&lt;br/&gt;
///  * Fields _not_ set on this transaction SHALL NOT be updated.
///  *
///  * ### Block Stream Effects
///  * None
class HederaConsensusUpdateTopicTransactionBody extends HederaProtoMessage
    with Equality {
  /// *
  ///      * The topic ID specifying the topic to update.
  ///      * &lt;p&gt;
  ///      * A topic with this ID MUST exist and MUST NOT be deleted.&lt;br/&gt;
  ///      * This value is REQUIRED.
  final proto_basic_types.HederaTopicID? topicID;

  /// *
  ///      * An updated memo to be associated with this topic.
  ///      * &lt;p&gt;
  ///      * If this value is set, the current `adminKey` for the topic MUST sign
  ///      * this transaction.&lt;br/&gt;
  ///      * This value, if set, SHALL be encoded UTF-8 and SHALL NOT exceed
  ///      * 100 bytes when so encoded.
  final google_protobuf_wrappers.HederaStringValue? memo;

  /// *
  ///      * An updated expiration time for this topic, in seconds since the epoch.
  ///      * &lt;p&gt;
  ///      * For this purpose, `epoch` SHALL be the UNIX epoch
  ///      * with 0 at `1970-01-01T00:00:00.000Z`.&lt;br/&gt;
  ///      * The expirationTime MUST NOT be greater than the sum of
  ///      * `MAX_AUTORENEW_PERIOD` and the actual consensus timestamp of
  ///      * this transaction.&lt;br/&gt;
  ///      * If `adminKey` is &lt;b&gt;unset&lt;/b&gt; for the _topic_, this transaction MUST NOT
  ///      * modify any other field.
  final proto_timestamp.HederaTimestamp? expirationTime;

  /// *
  ///      * Updated access control for modification of the topic.
  ///      * &lt;p&gt;
  ///      * If this field is set, that key and the previously set key MUST both
  ///      * sign this transaction.&lt;br/&gt;
  ///      * If this value is an empty `KeyList`, the prior key MUST sign this
  ///      * transaction, and the topic SHALL be immutable after this transaction
  ///      * completes, except for expiration and renewal.
  final proto_basic_types.HederaKey? adminKey;

  /// *
  ///      * Updated access control for message submission to the topic.
  ///      * &lt;p&gt;
  ///      * If this value is set, the current `adminKey` for the topic MUST sign
  ///      * this transaction.&lt;br/&gt;
  ///      * If this value is set to an empty `KeyList`, the `submitKey` for the
  ///      * topic will be unset after this transaction completes. When the
  ///      * `submitKey` is unset, any account may submit a message on the topic,
  ///      * without restriction.
  final proto_basic_types.HederaKey? submitKey;

  /// * An updated value for the number of seconds by which the topic expiration
  ///      * will be automatically extended upon expiration, if it has a valid
  ///      * auto-renew account.
  ///      * &lt;p&gt;
  ///      * If this value is set, the current `adminKey` for the topic MUST sign
  ///      * this transaction.&lt;br/&gt;
  ///      * This value, if set, MUST be greater than the
  ///      * configured MIN_AUTORENEW_PERIOD.&lt;br/&gt;
  ///      * This value, if set, MUST be less than the
  ///      * configured MAX_AUTORENEW_PERIOD.
  final proto_duration.HederaDuration? autoRenewPeriod;

  /// *
  ///      * An updated ID for the account to be charged renewal fees at the topic's
  ///      * `expirationTime` to extend the lifetime of the topic.
  ///      * &lt;p&gt;
  ///      * If this value is set and not the "sentinel account", the referenced
  ///      * account MUST sign this transaction.&lt;br/&gt;
  ///      * If this value is set, the current `adminKey` for the topic MUST sign
  ///      * this transaction.&lt;br/&gt;
  ///      * If this value is set to the "sentinel account", which is `0.0.0`, the
  ///      * `autoRenewAccount` SHALL be removed from the topic.
  final proto_basic_types.HederaAccountID? autoRenewAccount;

  /// *
  ///      * Access control for update/delete of custom fees.
  ///      * &lt;p&gt;
  ///      * If set, subsequent consensus_update_topic transactions signed with this
  ///      * key MAY update or delete the custom fees for this topic.&lt;br/&gt;
  ///      * If this field is set, the admin key MUST sign this transaction.&lt;br/&gt;
  ///      * If this field is set, the previous value SHALL be replaced.&lt;br/&gt;
  ///      * If set to a 'Key' containing an empty 'KeyList', the previous value
  ///      * SHALL be cleared.&lt;br/&gt;
  ///      * If not set, the current key SHALL NOT change.&lt;br/&gt;
  ///      * If unset in state, this field MUST NOT be set in this transaction.&lt;br/&gt;
  ///      * If not set when the topic is created, this field CANNOT be set via
  ///      * update.&lt;br/&gt;
  final proto_basic_types.HederaKey? feeScheduleKey;

  /// *
  ///      * A set of keys&lt;br/&gt;
  ///      * Keys in this list are permitted to submit messages to this topic without
  ///      * paying custom fees associated with this topic.
  ///      * &lt;p&gt;
  ///      * If a submit transaction is signed by _any_ key included in this set,
  ///      * custom fees SHALL NOT be charged for that transaction.&lt;br/&gt;
  ///      * If this field is not set, the current set of keys SHALL NOT change.&lt;br/&gt;
  ///      * If this field is set, but contains an empty list, any existing fee-exempt
  ///      * keys SHALL be removed.&lt;br/&gt;
  ///      * A `fee_exempt_key_list` MUST NOT contain more than
  ///      * `MAX_ENTRIES_FOR_FEE_EXEMPT_KEY_LIST` keys.&lt;br/&gt;
  ///      * A `fee_exempt_key_list` MUST NOT contain any duplicate keys.&lt;br/&gt;
  ///      * A `fee_exempt_key_list` MAY contain keys for accounts that are inactive,
  ///      * deleted, or non-existent.
  final proto_custom_fees.HederaFeeExemptKeyList? feeExemptKeyList;

  /// *
  ///      * A set of custom fee definitions.&lt;br/&gt;
  ///      * These are fees to be assessed for each submit to this topic.
  ///      * &lt;p&gt;
  ///      * Each fee defined in this set SHALL be evaluated for
  ///      * each message submitted to this topic, and the resultant
  ///      * total assessed fees SHALL be charged.&lt;br/&gt;
  ///      * Custom fees defined here SHALL be assessed in addition to the base
  ///      * network and node fees.&lt;br/&gt;
  ///      * If this field is not set, the current set of custom fees
  ///      * SHALL NOT change.&lt;br/&gt;
  ///      * If this field is set, but contains an empty list, all current custom fees
  ///      * SHALL be removed.
  ///      * custom_fees list SHALL NOT contain more than
  ///      * `MAX_CUSTOM_FEE_ENTRIES_FOR_TOPICS` entries.
  final proto_custom_fees.HederaFixedCustomFeeList? customFees;

  const HederaConsensusUpdateTopicTransactionBody({
    this.topicID,
    this.memo,
    this.expirationTime,
    this.adminKey,
    this.submitKey,
    this.autoRenewPeriod,
    this.autoRenewAccount,
    this.feeScheduleKey,
    this.feeExemptKeyList,
    this.customFees,
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
        ProtoFieldConfig.message(4),
        ProtoFieldConfig.message(6),
        ProtoFieldConfig.message(7),
        ProtoFieldConfig.message(8),
        ProtoFieldConfig.message(9),
        ProtoFieldConfig.message(10),
        ProtoFieldConfig.message(11),
        ProtoFieldConfig.message(12),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    topicID,
    memo,
    expirationTime,
    adminKey,
    submitKey,
    autoRenewPeriod,
    autoRenewAccount,
    feeScheduleKey,
    feeExemptKeyList,
    customFees,
  ];

  HederaConsensusUpdateTopicTransactionBody copyWith({
    proto_basic_types.HederaTopicID? topicID,

    google_protobuf_wrappers.HederaStringValue? memo,

    proto_timestamp.HederaTimestamp? expirationTime,

    proto_basic_types.HederaKey? adminKey,

    proto_basic_types.HederaKey? submitKey,

    proto_duration.HederaDuration? autoRenewPeriod,

    proto_basic_types.HederaAccountID? autoRenewAccount,

    proto_basic_types.HederaKey? feeScheduleKey,

    proto_custom_fees.HederaFeeExemptKeyList? feeExemptKeyList,

    proto_custom_fees.HederaFixedCustomFeeList? customFees,
  }) {
    return HederaConsensusUpdateTopicTransactionBody(
      topicID: topicID ?? this.topicID,
      memo: memo ?? this.memo,
      expirationTime: expirationTime ?? this.expirationTime,
      adminKey: adminKey ?? this.adminKey,
      submitKey: submitKey ?? this.submitKey,
      autoRenewPeriod: autoRenewPeriod ?? this.autoRenewPeriod,
      autoRenewAccount: autoRenewAccount ?? this.autoRenewAccount,
      feeScheduleKey: feeScheduleKey ?? this.feeScheduleKey,
      feeExemptKeyList: feeExemptKeyList ?? this.feeExemptKeyList,
      customFees: customFees ?? this.customFees,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'topicID': config.encodeMessage(topicID),
      'memo': config.encodeMessage(memo),
      'expirationTime': config.encodeMessage(expirationTime),
      'adminKey': config.encodeMessage(adminKey),
      'submitKey': config.encodeMessage(submitKey),
      'autoRenewPeriod': config.encodeMessage(autoRenewPeriod),
      'autoRenewAccount': config.encodeMessage(autoRenewAccount),
      'fee_schedule_key': config.encodeMessage(feeScheduleKey),
      'fee_exempt_key_list': config.encodeMessage(feeExemptKeyList),
      'custom_fees': config.encodeMessage(customFees),
    };
  }

  factory HederaConsensusUpdateTopicTransactionBody.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaConsensusUpdateTopicTransactionBody(
      topicID: json.valueTo<proto_basic_types.HederaTopicID?, Object>(
        key: 'topicID',
        parse:
            (v) => proto_basic_types.HederaTopicID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      memo: json.valueTo<google_protobuf_wrappers.HederaStringValue?, Object>(
        key: 'memo',
        parse:
            (v) => google_protobuf_wrappers.HederaStringValue.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      expirationTime: json.valueTo<proto_timestamp.HederaTimestamp?, Object>(
        key: 'expirationTime',
        parse:
            (v) => proto_timestamp.HederaTimestamp.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      adminKey: json.valueTo<proto_basic_types.HederaKey?, Object>(
        key: 'adminKey',
        parse:
            (v) => proto_basic_types.HederaKey.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      submitKey: json.valueTo<proto_basic_types.HederaKey?, Object>(
        key: 'submitKey',
        parse:
            (v) => proto_basic_types.HederaKey.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      autoRenewPeriod: json.valueTo<proto_duration.HederaDuration?, Object>(
        key: 'autoRenewPeriod',
        parse:
            (v) => proto_duration.HederaDuration.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      autoRenewAccount: json
          .valueTo<proto_basic_types.HederaAccountID?, Object>(
            key: 'autoRenewAccount',
            parse:
                (v) => proto_basic_types.HederaAccountID.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      feeScheduleKey: json.valueTo<proto_basic_types.HederaKey?, Object>(
        key: 'fee_schedule_key',
        parse:
            (v) => proto_basic_types.HederaKey.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      feeExemptKeyList: json
          .valueTo<proto_custom_fees.HederaFeeExemptKeyList?, Object>(
            key: 'fee_exempt_key_list',
            parse:
                (v) => proto_custom_fees.HederaFeeExemptKeyList.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      customFees: json
          .valueTo<proto_custom_fees.HederaFixedCustomFeeList?, Object>(
            key: 'custom_fees',
            parse:
                (v) => proto_custom_fees.HederaFixedCustomFeeList.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
    );
  }

  factory HederaConsensusUpdateTopicTransactionBody.deserialize(
    List<int> bytes,
  ) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaConsensusUpdateTopicTransactionBody(
      topicID: decode.messageTo<proto_basic_types.HederaTopicID?>(
        1,
        (b) => proto_basic_types.HederaTopicID.deserialize(b),
      ),
      memo: decode.messageTo<google_protobuf_wrappers.HederaStringValue?>(
        2,
        (b) => google_protobuf_wrappers.HederaStringValue.deserialize(b),
      ),
      expirationTime: decode.messageTo<proto_timestamp.HederaTimestamp?>(
        4,
        (b) => proto_timestamp.HederaTimestamp.deserialize(b),
      ),
      adminKey: decode.messageTo<proto_basic_types.HederaKey?>(
        6,
        (b) => proto_basic_types.HederaKey.deserialize(b),
      ),
      submitKey: decode.messageTo<proto_basic_types.HederaKey?>(
        7,
        (b) => proto_basic_types.HederaKey.deserialize(b),
      ),
      autoRenewPeriod: decode.messageTo<proto_duration.HederaDuration?>(
        8,
        (b) => proto_duration.HederaDuration.deserialize(b),
      ),
      autoRenewAccount: decode.messageTo<proto_basic_types.HederaAccountID?>(
        9,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
      feeScheduleKey: decode.messageTo<proto_basic_types.HederaKey?>(
        10,
        (b) => proto_basic_types.HederaKey.deserialize(b),
      ),
      feeExemptKeyList: decode
          .messageTo<proto_custom_fees.HederaFeeExemptKeyList?>(
            11,
            (b) => proto_custom_fees.HederaFeeExemptKeyList.deserialize(b),
          ),
      customFees: decode.messageTo<proto_custom_fees.HederaFixedCustomFeeList?>(
        12,
        (b) => proto_custom_fees.HederaFixedCustomFeeList.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoConsensusUpdateTopicTransactionBody;
}
