import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;
import "package:on_chain/hedera/src/proto_messages/proto/src/custom_fees.dart"
    as proto_custom_fees;

/// *
///  * # HCS Topic Information
///  * The current network state of an Hedera Consensus Service (HCS) Topic.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in [RFC2119](https://www.ietf.org/rfc/rfc2119)
///  * and clarified in [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.state.consensus"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * Representation of an Hedera Consensus Service(HCS) topic.
///  *
///  * As with all network entities, a topic has a unique entity number, which is
///  * usually given along with the network's shard and realm in the form of a
///  * shard.realm.number id.&lt;br/&gt;
///  * An HCS topic is an ordered logical stream of messages united and secured by
///  * a running hash of those messages. The integrity of any message on a topic,
///  * and the topic stream as a whole, can always be ascertained from block stream
///  * data by recomputing the running hash across any subset of messages on the
///  * topic.&lt;br/&gt;
///  * The messages on a topic SHALL NOT be stored in network state, but are
///  * available in the network block stream, and may be queried via the
///  * Mirror Node system.
class HederaTopic extends HederaProtoMessage with Equality {
  /// *
  ///      * The topic's ID.
  ///      * &lt;p&gt;
  ///      * This value SHALL be unique within the network.
  final proto_basic_types.HederaTopicID? topicId;

  /// *
  ///      * The number of messages sent to the topic.
  final BigInt? sequenceNumber;

  /// *
  ///      * The expiration time for this topic, in seconds since the epoch.
  ///      * &lt;p&gt;
  ///      * For this purpose, `epoch` SHALL be the UNIX epoch with 0 at `1970-01-01T00:00:00.000Z`.
  final BigInt? expirationSecond;

  /// *
  ///      * The number of seconds for which the topic will be automatically renewed
  ///      * upon expiring (if it has a valid auto-renew account).
  final BigInt? autoRenewPeriod;

  /// *
  ///      * The id of the account (if any) that the network will attempt to charge
  ///      * fees to complete auto-renewal of this topic, upon expiration.
  final proto_basic_types.HederaAccountID? autoRenewAccountId;

  /// *
  ///      * A flag indicating that this topic is deleted.
  final bool? deleted;

  /// *
  ///      * The current running hash of this topic.
  ///      * &lt;p&gt;
  ///      * This 48-byte field is the output of a SHA-384 digest with input data
  ///      * determined by the current version of the running hash algorithm used
  ///      * by the network.&lt;br/&gt;
  ///      * All topics in state SHALL use running hash algorithm version `3`.&lt;br/&gt;
  ///      * The bytes of each uint64 or uint32 encoded for the hash input MUST be in
  ///      * Big-Endian format.
  ///      * &lt;p&gt;
  ///      * &lt;hr/&gt;
  ///      * If the algorithm version is '3', then the input data to the SHA-384
  ///      * digest are, in order:
  ///      * &lt;ol&gt;
  ///      *   &lt;li&gt;The previous running hash of the topic (48 bytes)&lt;/li&gt;
  ///      *   &lt;li&gt;The `topicRunningHashVersion` (8 bytes)&lt;/li&gt;
  ///      *   &lt;li&gt;The payer account's shard (8 bytes)&lt;/li&gt;
  ///      *   &lt;li&gt;The payer account's realm (8 bytes)&lt;/li&gt;
  ///      *   &lt;li&gt;The payer account's number (8 bytes)&lt;/li&gt;
  ///      *   &lt;li&gt;The topic's shard (8 bytes)&lt;/li&gt;
  ///      *   &lt;li&gt;The topic's realm (8 bytes)&lt;/li&gt;
  ///      *   &lt;li&gt;The topic's number (8 bytes)&lt;/li&gt;
  ///      *   &lt;li&gt;The number of seconds since the epoch when the
  ///      *       `ConsensusSubmitMessage` reached consensus (8 bytes)&lt;/li&gt;
  ///      *   &lt;li&gt;The number of nanoseconds within the second when the
  ///      *       `ConsensusSubmitMessage` reached consensus (4 bytes)&lt;/li&gt;
  ///      *   &lt;li&gt;The `topicSequenceNumber` (8 bytes)&lt;/li&gt;
  ///      *   &lt;li&gt;The output of a SHA-384 digest of the message bytes from the
  ///      *       `ConsensusSubmitMessage` (48 bytes)&lt;/li&gt;
  ///      * &lt;/ol&gt;
  ///      * &lt;blockquote&gt;Note that older messages on a topic, which are available in
  ///      * the block stream, MAY use older algorithm versions, and the block stream
  ///      * record incorporates a running hash version field to ensure the correct
  ///      * hash calculation for each such historical message.&lt;/blockquote&gt;
  final List<int>? runningHash;

  /// *
  ///      * A short description of this topic.
  ///      * &lt;p&gt;
  ///      * This value, if set, MUST NOT exceed `transaction.maxMemoUtf8Bytes`
  ///      * (default 100) bytes when encoded as UTF-8.
  final String? memo;

  /// *
  ///      * Access control for modification of the topic.
  ///      * &lt;p&gt;
  ///      * If this field is set, that key MUST sign each message to update or delete
  ///      * this topic.&lt;br/&gt;
  ///      * A topic without an admin key SHALL be immutable, except for expiration
  ///      * and renewal.&lt;br/&gt;
  ///      * If this field is not set, the `auto_renew_account_id` MUST NOT be set.
  final proto_basic_types.HederaKey? adminKey;

  /// *
  ///      * Access control for message submission to the topic.
  ///      * &lt;p&gt;
  ///      * If this field is set, that key MUST sign each consensus submit message
  ///      * for this topic.
  final proto_basic_types.HederaKey? submitKey;

  /// *
  ///      * Access control for update/delete of custom fees.
  ///      * &lt;p&gt;
  ///      * If this field is unset, the current custom fees CANNOT be changed.&lt;br/&gt;
  ///      * If this field is set, that `Key` MUST sign any transaction to update
  ///      * the custom fee schedule for this topic.
  final proto_basic_types.HederaKey? feeScheduleKey;

  /// *
  ///      * A set of "privileged payer" keys&lt;br/&gt;
  ///      * Keys in this list are permitted to submit messages to this topic without
  ///      * paying custom fees associated with this topic.
  ///      * &lt;p&gt;
  ///      * If a submit transaction is signed by _any_ key included in this set,
  ///      * custom fees SHALL NOT be charged for that transaction.&lt;br/&gt;
  ///      * A `fee_exempt_key_list` MUST NOT contain more than
  ///      * `MAX_ENTRIES_FOR_FEE_EXEMPT_KEY_LIST` keys.&lt;br/&gt;
  ///      * A `fee_exempt_key_list` MUST NOT contain any duplicate keys.&lt;br/&gt;
  ///      * A `fee_exempt_key_list` MAY contain keys for accounts that are inactive,
  ///      * deleted, or non-existent.
  ///      * If not set, there SHALL NOT be any fee-exempt keys.  In particular, the
  ///      * following keys SHALL NOT be implicitly or automatically added to this
  ///      * list: `adminKey`, `submitKey`, `fee_schedule_key`.
  final List<proto_basic_types.HederaKey> feeExemptKeyList;

  /// *
  ///      * A set of custom fee definitions.&lt;br/&gt;
  ///      * These are fees to be assessed for each submit to this topic.
  ///      * &lt;p&gt;
  ///      * If this list is empty, the only fees charged for a submit to this
  ///      * topic SHALL be the network and node fees.&lt;br/&gt;
  ///      * If this list is not empty, each fee defined in this set SHALL
  ///      * be evaluated for each message submitted to this topic, and the
  ///      * resultant total assessed fees SHALL be charged.&lt;br/&gt;
  ///      * If this list is not empty, custom fees defined here SHALL be
  ///      * charged _in addition to_ the base network and node fees.
  final List<proto_custom_fees.HederaFixedCustomFee> customFees;

  const HederaTopic({
    this.topicId,
    this.sequenceNumber,
    this.expirationSecond,
    this.autoRenewPeriod,
    this.autoRenewAccountId,
    this.deleted,
    this.runningHash,
    this.memo,
    this.adminKey,
    this.submitKey,
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
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.int64(2),
        ProtoFieldConfig.int64(3),
        ProtoFieldConfig.int64(4),
        ProtoFieldConfig.message(5),
        ProtoFieldConfig.bool(6),
        ProtoFieldConfig.bytes(7),
        ProtoFieldConfig.string(8),
        ProtoFieldConfig.message(9),
        ProtoFieldConfig.message(10),
        ProtoFieldConfig.message(11),
        ProtoFieldConfig.repeated(
          fieldNumber: 12,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.repeated(
          fieldNumber: 13,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    topicId,
    sequenceNumber,
    expirationSecond,
    autoRenewPeriod,
    autoRenewAccountId,
    deleted,
    runningHash,
    memo,
    adminKey,
    submitKey,
    feeScheduleKey,
    feeExemptKeyList,
    customFees,
  ];

  HederaTopic copyWith({
    proto_basic_types.HederaTopicID? topicId,

    BigInt? sequenceNumber,

    BigInt? expirationSecond,

    BigInt? autoRenewPeriod,

    proto_basic_types.HederaAccountID? autoRenewAccountId,

    bool? deleted,

    List<int>? runningHash,

    String? memo,

    proto_basic_types.HederaKey? adminKey,

    proto_basic_types.HederaKey? submitKey,

    proto_basic_types.HederaKey? feeScheduleKey,

    List<proto_basic_types.HederaKey>? feeExemptKeyList,

    List<proto_custom_fees.HederaFixedCustomFee>? customFees,
  }) {
    return HederaTopic(
      topicId: topicId ?? this.topicId,
      sequenceNumber: sequenceNumber ?? this.sequenceNumber,
      expirationSecond: expirationSecond ?? this.expirationSecond,
      autoRenewPeriod: autoRenewPeriod ?? this.autoRenewPeriod,
      autoRenewAccountId: autoRenewAccountId ?? this.autoRenewAccountId,
      deleted: deleted ?? this.deleted,
      runningHash: runningHash ?? this.runningHash,
      memo: memo ?? this.memo,
      adminKey: adminKey ?? this.adminKey,
      submitKey: submitKey ?? this.submitKey,
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
      'topic_id': config.encodeMessage(topicId),
      'sequence_number': config.encodeBigint(sequenceNumber),
      'expiration_second': config.encodeBigint(expirationSecond),
      'auto_renew_period': config.encodeBigint(autoRenewPeriod),
      'auto_renew_account_id': config.encodeMessage(autoRenewAccountId),
      'deleted': deleted,
      'running_hash': config.encodeBinary(runningHash),
      'memo': memo,
      'admin_key': config.encodeMessage(adminKey),
      'submit_key': config.encodeMessage(submitKey),
      'fee_schedule_key': config.encodeMessage(feeScheduleKey),
      'fee_exempt_key_list':
          feeExemptKeyList.map((e) => config.encodeMessage(e)).toList(),
      'custom_fees': customFees.map((e) => config.encodeMessage(e)).toList(),
    };
  }

  factory HederaTopic.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaTopic(
      topicId: json.valueTo<proto_basic_types.HederaTopicID?, Object>(
        key: 'topic_id',
        parse:
            (v) => proto_basic_types.HederaTopicID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      sequenceNumber: json.valueAsBigInt<BigInt?>(
        'sequence_number',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      expirationSecond: json.valueAsBigInt<BigInt?>(
        'expiration_second',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      autoRenewPeriod: json.valueAsBigInt<BigInt?>(
        'auto_renew_period',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      autoRenewAccountId: json
          .valueTo<proto_basic_types.HederaAccountID?, Object>(
            key: 'auto_renew_account_id',
            parse:
                (v) => proto_basic_types.HederaAccountID.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      deleted: json.valueAsBool<bool?>(
        'deleted',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      runningHash: config.decodeBinary<List<int>?>(
        json.valueAs('running_hash', normalizeKeyLookup: config.normalizeKeys),
      ),
      memo: json.valueAsString<String?>(
        'memo',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      adminKey: json.valueTo<proto_basic_types.HederaKey?, Object>(
        key: 'admin_key',
        parse:
            (v) => proto_basic_types.HederaKey.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      submitKey: json.valueTo<proto_basic_types.HederaKey?, Object>(
        key: 'submit_key',
        parse:
            (v) => proto_basic_types.HederaKey.fromJson(
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

  factory HederaTopic.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTopic(
      topicId: decode.messageTo<proto_basic_types.HederaTopicID?>(
        1,
        (b) => proto_basic_types.HederaTopicID.deserialize(b),
      ),
      sequenceNumber: decode.getBigInt<BigInt?>(2),
      expirationSecond: decode.getBigInt<BigInt?>(3),
      autoRenewPeriod: decode.getBigInt<BigInt?>(4),
      autoRenewAccountId: decode.messageTo<proto_basic_types.HederaAccountID?>(
        5,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
      deleted: decode.getBool<bool?>(6),
      runningHash: decode.getBytes<List<int>?>(7),
      memo: decode.getString<String?>(8),
      adminKey: decode.messageTo<proto_basic_types.HederaKey?>(
        9,
        (b) => proto_basic_types.HederaKey.deserialize(b),
      ),
      submitKey: decode.messageTo<proto_basic_types.HederaKey?>(
        10,
        (b) => proto_basic_types.HederaKey.deserialize(b),
      ),
      feeScheduleKey: decode.messageTo<proto_basic_types.HederaKey?>(
        11,
        (b) => proto_basic_types.HederaKey.deserialize(b),
      ),
      feeExemptKeyList:
          decode
              .getListOfBytes(12)
              .map((b) => proto_basic_types.HederaKey.deserialize(b))
              .toList(),
      customFees:
          decode
              .getListOfBytes(13)
              .map((b) => proto_custom_fees.HederaFixedCustomFee.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoTopic;
}
