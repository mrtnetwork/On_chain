import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;
import "package:on_chain/hedera/src/proto_messages/proto/src/duration.dart"
    as proto_duration;
import "package:on_chain/hedera/src/proto_messages/proto/src/custom_fees.dart"
    as proto_custom_fees;

/// *
///  * # Create Topic
///  * Create a new topic for the Hedera Consensus Service (HCS).
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
///  * Create a topic to accept and group consensus messages.
///  *
///  * If `autoRenewAccount` is specified, that account Key MUST also sign this
///  * transaction.&lt;br/&gt;
///  * If `adminKey` is set, that Key MUST sign the transaction.&lt;br/&gt;
///  * On success, the resulting `TransactionReceipt` SHALL contain the newly
///  * created `TopicId`.
///  *
///  * The `autoRenewPeriod` on a topic MUST be set to a value between
///  * `autoRenewPeriod.minDuration` and `autoRenewPeriod.maxDuration`. These
///  * values are configurable, typically 30 and 92 days.&lt;br/&gt;
///  * This also sets the initial expirationTime of the topic.
///  *
///  * If no `adminKey` is set on a topic
///  *   -`autoRenewAccount` SHALL NOT be set on the topic.
///  *   - A `deleteTopic` transaction SHALL fail.
///  *   - An `updateTopic` transaction that only extends the expirationTime MAY
///  *     succeed.
///  *   - Any other `updateTopic` transaction SHALL fail.
///  *
///  * If the topic expires and is not automatically renewed, the topic SHALL enter
///  * the `EXPIRED` state.
///  *   - All transactions on the topic SHALL fail with TOPIC_EXPIRED
///  *      - Except an updateTopic() call that only extends the expirationTime.
///  *   - getTopicInfo() SHALL succeed, and show the topic is expired.
///  * The topic SHALL remain in the `EXPIRED` state for a time determined by the
///  * `autorenew.gracePeriod` (configurable, originally 7 days).&lt;br/&gt;
///  * After the grace period, if the topic's expirationTime is not extended, the
///  * topic SHALL be automatically deleted from state entirely, and cannot be
///  * recovered or recreated.
///  *
///  * ### Block Stream Effects
///  * None
class HederaConsensusCreateTopicTransactionBody extends HederaProtoMessage
    with Equality {
  /// *
  ///      * A short memo for this topic.
  ///      * &lt;p&gt;
  ///      * This value, if set, MUST NOT exceed `transaction.maxMemoUtf8Bytes`
  ///      * (default 100) bytes when encoded as UTF-8.
  final String? memo;

  /// *
  ///      * Access control for modification of the topic after it is created.
  ///      * &lt;p&gt;
  ///      * If this field is set, that key MUST sign this transaction.&lt;br/&gt;
  ///      * If this field is set, that key MUST sign each future transaction to
  ///      * update or delete the topic.&lt;br/&gt;
  ///      * An updateTopic transaction that _only_ extends the topic expirationTime
  ///      * (a "manual renewal" transaction) SHALL NOT require admin key
  ///      * signature.&lt;br/&gt;
  ///      * A topic without an admin key SHALL be immutable, except for expiration
  ///      * and renewal.&lt;br/&gt;
  ///      * If adminKey is not set, then `autoRenewAccount` SHALL NOT be set.
  final proto_basic_types.HederaKey? adminKey;

  /// *
  ///      * Access control for message submission to the topic.
  ///      * &lt;p&gt;
  ///      * If this field is set, that key MUST sign each consensus submit message
  ///      * for this topic.&lt;br/&gt;
  ///      * If this field is not set then any account may submit a message on the
  ///      * topic, without restriction.
  final proto_basic_types.HederaKey? submitKey;

  /// *
  ///      * The initial lifetime, in seconds, for the topic.&lt;br/&gt;
  ///      * This is also the number of seconds for which the topic SHALL be
  ///      * automatically renewed upon expiring, if it has a valid auto-renew
  ///      * account.
  ///      * &lt;p&gt;
  ///      * This value MUST be set.&lt;br/&gt;
  ///      * This value MUST be greater than the configured
  ///      * MIN_AUTORENEW_PERIOD.&lt;br/&gt;
  ///      * This value MUST be less than the configured MAX_AUTORENEW_PERIOD.
  final proto_duration.HederaDuration? autoRenewPeriod;

  /// *
  ///      * The ID of the account to be charged renewal fees at the topic's
  ///      * expirationTime to extend the lifetime of the topic.
  ///      * &lt;p&gt;
  ///      * The topic lifetime SHALL be extended by the smallest of the following:
  ///      * &lt;ul&gt;
  ///      *   &lt;li&gt;The current `autoRenewPeriod` duration.&lt;/li&gt;
  ///      *   &lt;li&gt;The maximum duration that this account has funds to purchase.&lt;/li&gt;
  ///      *   &lt;li&gt;The configured MAX_AUTORENEW_PERIOD at the time of automatic
  ///      *       renewal.&lt;/li&gt;
  ///      * &lt;/ul&gt;
  ///      * If this value is set, the referenced account MUST sign this
  ///      * transaction.&lt;br/&gt;
  ///      * If this value is set, the `adminKey` field MUST also be set (though that
  ///      * key MAY not have any correlation to this account).
  final proto_basic_types.HederaAccountID? autoRenewAccount;

  /// *
  ///      * Access control for update or delete of custom fees.
  ///      * &lt;p&gt;
  ///      * If set, subsequent `consensus_update_topic` transactions signed with this
  ///      * key MAY update or delete the custom fees for this topic.&lt;br/&gt;
  ///      * If not set, the custom fees for this topic SHALL BE immutable.&lt;br/&gt;
  ///      * If not set when the topic is created, this field CANNOT be set via
  ///      * update.&lt;br/&gt;
  ///      * If set when the topic is created, this field MAY be changed via update.
  final proto_basic_types.HederaKey? feeScheduleKey;

  /// *
  ///      * A set of keys.&lt;br/&gt;
  ///      * Keys in this list are permitted to submit messages to this topic without
  ///      * paying custom fees associated with this topic.
  ///      * &lt;p&gt;
  ///      * If a submit transaction is signed by _any_ key included in this set,
  ///      * custom fees SHALL NOT be charged for that transaction.&lt;br/&gt;
  ///      * This field MUST NOT contain more than 10 keys.&lt;br/&gt;
  ///      * fee_exempt_key_list SHALL NOT contain any duplicate keys.&lt;br/&gt;
  ///      * fee_exempt_key_list MAY contain keys for accounts that are inactive,
  ///      * deleted, or non-existent.&lt;br/&gt;
  ///      * If fee_exempt_key_list is unset in this transaction, there SHALL NOT be
  ///      * any fee-exempt keys.  In particular, the following keys SHALL NOT be
  ///      * implicitly or automatically added to this list:
  ///      * `adminKey`, `submitKey`, `fee_schedule_key`.
  final List<proto_basic_types.HederaKey> feeExemptKeyList;

  /// *
  ///      * A set of custom fee definitions.&lt;br/&gt;
  ///      * These are fees to be assessed for each submit to this topic.
  ///      * &lt;p&gt;
  ///      * Each fee defined in this set SHALL be evaluated for
  ///      * each message submitted to this topic, and the resultant
  ///      * total assessed fees SHALL be charged.&lt;br/&gt;
  ///      * Custom fees defined here SHALL be assessed in addition to the base
  ///      * network and node fees.&lt;br/&gt;
  ///      * custom_fees list SHALL NOT contain more than
  ///      * `MAX_CUSTOM_FEE_ENTRIES_FOR_TOPICS` entries.
  final List<proto_custom_fees.HederaFixedCustomFee> customFees;

  const HederaConsensusCreateTopicTransactionBody({
    this.memo,
    this.adminKey,
    this.submitKey,
    this.autoRenewPeriod,
    this.autoRenewAccount,
    this.feeScheduleKey,
    this.feeExemptKeyList = const [],
    this.customFees = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(1),
        ProtoFieldConfig.message(2),
        ProtoFieldConfig.message(3),
        ProtoFieldConfig.message(6),
        ProtoFieldConfig.message(7),
        ProtoFieldConfig.message(8),
        ProtoFieldConfig.repeated(
          fieldNumber: 9,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.repeated(
          fieldNumber: 10,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    memo,
    adminKey,
    submitKey,
    autoRenewPeriod,
    autoRenewAccount,
    feeScheduleKey,
    feeExemptKeyList,
    customFees,
  ];

  HederaConsensusCreateTopicTransactionBody copyWith({
    String? memo,

    proto_basic_types.HederaKey? adminKey,

    proto_basic_types.HederaKey? submitKey,

    proto_duration.HederaDuration? autoRenewPeriod,

    proto_basic_types.HederaAccountID? autoRenewAccount,

    proto_basic_types.HederaKey? feeScheduleKey,

    List<proto_basic_types.HederaKey>? feeExemptKeyList,

    List<proto_custom_fees.HederaFixedCustomFee>? customFees,
  }) {
    return HederaConsensusCreateTopicTransactionBody(
      memo: memo ?? this.memo,
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
      'memo': memo,
      'adminKey': config.encodeMessage(adminKey),
      'submitKey': config.encodeMessage(submitKey),
      'autoRenewPeriod': config.encodeMessage(autoRenewPeriod),
      'autoRenewAccount': config.encodeMessage(autoRenewAccount),
      'fee_schedule_key': config.encodeMessage(feeScheduleKey),
      'fee_exempt_key_list':
          feeExemptKeyList.map((e) => config.encodeMessage(e)).toList(),
      'custom_fees': customFees.map((e) => config.encodeMessage(e)).toList(),
    };
  }

  factory HederaConsensusCreateTopicTransactionBody.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaConsensusCreateTopicTransactionBody(
      memo: json.valueAsString<String?>(
        'memo',
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
      feeExemptKeyList:
          (json.valueEnsureAsList<dynamic>(
                'fee_exempt_key_list',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<proto_basic_types.HederaKey, Object>(
                  value: e,
                  parse:
                      (v) => proto_basic_types.HederaKey.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      customFees:
          (json.valueEnsureAsList<dynamic>(
                'custom_fees',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<
                  proto_custom_fees.HederaFixedCustomFee,
                  Object
                >(
                  value: e,
                  parse:
                      (v) => proto_custom_fees.HederaFixedCustomFee.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory HederaConsensusCreateTopicTransactionBody.deserialize(
    List<int> bytes,
  ) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaConsensusCreateTopicTransactionBody(
      memo: decode.getString<String?>(1),
      adminKey: decode.messageTo<proto_basic_types.HederaKey?>(
        2,
        (b) => proto_basic_types.HederaKey.deserialize(b),
      ),
      submitKey: decode.messageTo<proto_basic_types.HederaKey?>(
        3,
        (b) => proto_basic_types.HederaKey.deserialize(b),
      ),
      autoRenewPeriod: decode.messageTo<proto_duration.HederaDuration?>(
        6,
        (b) => proto_duration.HederaDuration.deserialize(b),
      ),
      autoRenewAccount: decode.messageTo<proto_basic_types.HederaAccountID?>(
        7,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
      feeScheduleKey: decode.messageTo<proto_basic_types.HederaKey?>(
        8,
        (b) => proto_basic_types.HederaKey.deserialize(b),
      ),
      feeExemptKeyList:
          decode
              .getListOfBytes(9)
              .map((b) => proto_basic_types.HederaKey.deserialize(b))
              .toList(),
      customFees:
          decode
              .getListOfBytes(10)
              .map((b) => proto_custom_fees.HederaFixedCustomFee.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoConsensusCreateTopicTransactionBody;
}
