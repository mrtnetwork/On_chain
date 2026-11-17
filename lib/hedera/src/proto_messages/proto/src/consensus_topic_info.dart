import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/timestamp.dart" as proto_timestamp;
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart" as proto_basic_types;
import "package:on_chain/hedera/src/proto_messages/proto/src/duration.dart" as proto_duration;
import "package:on_chain/hedera/src/proto_messages/proto/src/custom_fees.dart" as proto_custom_fees;

/// *
///  * # Topic Information
///  * Query response describing a topic of the Hedera Consensus Service (HCS).
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
///  * A query response describing the current state of a topic for the Hedera
///  * Consensus Service (HCS).
class HederaConsensusTopicInfo extends HederaProtoMessage with Equality {
    /// *
  ///      * A short description of this topic.
  ///      * &lt;p&gt;
  ///      * This value, if set, MUST NOT exceed `transaction.maxMemoUtf8Bytes`
  ///      * (default 100) bytes when encoded as UTF-8.
  final String? memo;

    /// *
  ///      * The latest running hash of the topic.
  ///      * &lt;p&gt;
  ///      * This 48-byte field is the output of a SHA-384 digest with input
  ///      * data determined by the current version of the running hash algorithm
  ///      * used by the network.&lt;br/&gt;
  ///      * All new transactions SHALL use algorithm version `3`.&lt;br/&gt;
  ///      * The bytes of each uint64 or uint32 encoded for the hash input
  ///      * MUST be in Big-Endian format.
  ///      * &lt;p&gt;
  ///      * &lt;hr/&gt;
  ///      * If the algorithm version is '3', then the input data to the
  ///      * SHA-384 digest are, in order:
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
  final List<int>? runningHash;

    /// *
  ///      * A current sequence number (starting at 1 for the first message)
  ///      * for messages on this topic.
  final BigInt? sequenceNumber;

    /// *
  ///      * An expiration time for this topic, in seconds since the epoch.
  ///      * &lt;p&gt;
  ///      * For this purpose, `epoch` SHALL be the UNIX epoch
  ///      * with 0 at `1970-01-01T00:00:00.000Z`.
  final proto_timestamp.HederaTimestamp? expirationTime;

    /// *
  ///      * A key that MUST sign any transaction to update or delete this topic.
  ///      * &lt;p&gt;
  ///      * If this value is not set (null) then the topic CANNOT be deleted,
  ///      * modified, or updated.
  final proto_basic_types.HederaKey? adminKey;

    /// *
  ///      * A key that MUST sign any transaction to submit a message to this topic.
  ///      * &lt;p&gt;
  ///      * If this value is not set (null) then any account MAY submit messages to
  ///      * this topic.
  final proto_basic_types.HederaKey? submitKey;

    /// *
  ///      * A duration, in seconds, to extend the `expirationTime` value when
  ///      * this topic is automatically renewed.
  ///      * &lt;p&gt;
  ///      * If the `autoRenewAccount` value for this topic is set to a valid account
  ///      * with sufficient HBAR balance to pay renewal fees when this topic
  ///      * expires, the system SHALL automatically renew this topic, extending the
  ///      * `expirationTime` value by the number of seconds described here.&lt;br/&gt;
  ///      * If, however, the `autoRenewAccount` lacks sufficient HBAR balance
  ///      * to pay renewal fees when this topic expires, this topic SHALL be
  ///      * deleted after the time period specified in the `AUTORENEW_GRACE_PERIOD`
  ///      * configuration value.
  final proto_duration.HederaDuration? autoRenewPeriod;

    /// *
  ///      * An account that is designated to pay automatic renewal fees.
  ///      * &lt;p&gt;
  ///      * If this value is a valid account ID when this topic expires,
  ///      * this account SHALL be charged the renewal fees for this topic,
  ///      * if it holds sufficient HBAR balance. If the account does not hold
  ///      * sufficient HBAR balance to pay renewal fees when necessary, then
  ///      * this topic SHALL be deleted.&lt;br/&gt;
  ///      * If this value is not set (null), or is not a valid account ID, when
  ///      * this topic expires, then this topic SHALL be deleted after the time
  ///      * period specified in the `AUTORENEW_GRACE_PERIOD` configuration value.
  final proto_basic_types.HederaAccountID? autoRenewAccount;

    /// *
  ///      * A ledger ID of the network that generated this response.
  ///      * &lt;p&gt;
  ///      * This value SHALL identify the distributed ledger that responded to
  ///      * this query.
  final List<int>? ledgerId;

    /// *
  ///      * Access control for update/delete of custom fees.
  ///      * &lt;p&gt;
  ///      * If unset, custom fees CANNOT be set for this topic.&lt;br/&gt;
  ///      * If not set when the topic is created, this field CANNOT be set via
  ///      * update.&lt;br/&gt;
  ///      * If set when the topic is created, this field MAY be changed via update.
  final proto_basic_types.HederaKey? feeScheduleKey;

    /// *
  ///      * A set of keys.&lt;br/&gt;
  ///      * Keys in this list are permitted to submit messages to this topic without
  ///      * paying custom fees associated with this topic.
  ///      * &lt;p&gt;
  ///      * If a topic submit message is signed by _any_ key included in this set,
  ///      * custom fees SHALL NOT be charged for that transaction.&lt;br/&gt;
  ///      * `fee_exempt_key_list` MAY contain keys for accounts that are inactive,
  ///      * deleted, or non-existent.&lt;br/&gt;
  ///      * If not set, there SHALL NOT be any fee-exempt keys.  In particular, the
  ///      * following keys SHALL NOT be implicitly or automatically added to this
  ///      * list: `adminKey`, `submitKey`, `fee_schedule_key`.
  ///      * A `fee_exempt_key_list` MUST NOT contain more than
  ///      * `MAX_ENTRIES_FOR_FEE_EXEMPT_KEY_LIST` keys.
  ///      * A `fee_exempt_key_list` MUST NOT contain any duplicate keys.
  final List<proto_basic_types.HederaKey> feeExemptKeyList;

    /// *
  ///      * A set of custom fee definitions.&lt;br/&gt;
  ///      * These are fees to be assessed for each submit to this topic.
  ///      * &lt;p&gt;
  ///      * Each fee defined in this set SHALL be evaluated for
  ///      * each message submitted to this topic, and the resultant
  ///      * total assessed fees SHALL be charged.&lt;br/&gt;
  ///      * Custom fees defined here SHALL be assessed in addition to the base
  ///      * network and node fees.
  final List<proto_custom_fees.HederaFixedCustomFee> customFees;

  const HederaConsensusTopicInfo({
    this.memo,
    this.runningHash,
    this.sequenceNumber,
    this.expirationTime,
    this.adminKey,
    this.submitKey,
    this.autoRenewPeriod,
    this.autoRenewAccount,
    this.ledgerId,
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
        ProtoFieldConfig.bytes(2),
        ProtoFieldConfig.uint64(3),
        ProtoFieldConfig.message(4),
        ProtoFieldConfig.message(5),
        ProtoFieldConfig.message(6),
        ProtoFieldConfig.message(7),
        ProtoFieldConfig.message(8),
        ProtoFieldConfig.bytes(9),
        ProtoFieldConfig.message(10),
        ProtoFieldConfig.repeated(
          fieldNumber: 11,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.repeated(
          fieldNumber: 12,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        memo,
        runningHash,
        sequenceNumber,
        expirationTime,
        adminKey,
        submitKey,
        autoRenewPeriod,
        autoRenewAccount,
        ledgerId,
        feeScheduleKey,
        feeExemptKeyList,
        customFees,
      ];


HederaConsensusTopicInfo copyWith(
{String? memo,

List<int>? runningHash,

BigInt? sequenceNumber,

proto_timestamp.HederaTimestamp? expirationTime,

proto_basic_types.HederaKey? adminKey,

proto_basic_types.HederaKey? submitKey,

proto_duration.HederaDuration? autoRenewPeriod,

proto_basic_types.HederaAccountID? autoRenewAccount,

List<int>? ledgerId,

proto_basic_types.HederaKey? feeScheduleKey,

List<proto_basic_types.HederaKey>? feeExemptKeyList,

List<proto_custom_fees.HederaFixedCustomFee>? customFees,

}) {
    return HederaConsensusTopicInfo(
memo: memo ?? this.memo,
runningHash: runningHash ?? this.runningHash,
sequenceNumber: sequenceNumber ?? this.sequenceNumber,
expirationTime: expirationTime ?? this.expirationTime,
adminKey: adminKey ?? this.adminKey,
submitKey: submitKey ?? this.submitKey,
autoRenewPeriod: autoRenewPeriod ?? this.autoRenewPeriod,
autoRenewAccount: autoRenewAccount ?? this.autoRenewAccount,
ledgerId: ledgerId ?? this.ledgerId,
feeScheduleKey: feeScheduleKey ?? this.feeScheduleKey,
feeExemptKeyList: feeExemptKeyList ?? this.feeExemptKeyList,
customFees: customFees ?? this.customFees,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'memo': memo,
      'runningHash': config.encodeBinary(runningHash),
      'sequenceNumber': config.encodeBigint(sequenceNumber),
      'expirationTime': config.encodeMessage(expirationTime),
      'adminKey': config.encodeMessage(adminKey),
      'submitKey': config.encodeMessage(submitKey),
      'autoRenewPeriod': config.encodeMessage(autoRenewPeriod),
      'autoRenewAccount': config.encodeMessage(autoRenewAccount),
      'ledger_id': config.encodeBinary(ledgerId),
      'fee_schedule_key': config.encodeMessage(feeScheduleKey),
      'fee_exempt_key_list': feeExemptKeyList.map((e) => config.encodeMessage(e)).toList(),
      'custom_fees': customFees.map((e) => config.encodeMessage(e)).toList(),
    };
  }


  factory HederaConsensusTopicInfo.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaConsensusTopicInfo(
      memo: json.valueAsString<String?>('memo', normalizeKeyLookup: config.normalizeKeys),
      runningHash: config.decodeBinary<List<int>?>(json.valueAs('runningHash', normalizeKeyLookup: config.normalizeKeys)),
      sequenceNumber: json.valueAsBigInt<BigInt?>('sequenceNumber', normalizeKeyLookup: config.normalizeKeys),
      expirationTime: json.valueTo<proto_timestamp.HederaTimestamp?, Object>(
        key: 'expirationTime',
        parse: (v) => proto_timestamp.HederaTimestamp.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      adminKey: json.valueTo<proto_basic_types.HederaKey?, Object>(
        key: 'adminKey',
        parse: (v) => proto_basic_types.HederaKey.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      submitKey: json.valueTo<proto_basic_types.HederaKey?, Object>(
        key: 'submitKey',
        parse: (v) => proto_basic_types.HederaKey.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      autoRenewPeriod: json.valueTo<proto_duration.HederaDuration?, Object>(
        key: 'autoRenewPeriod',
        parse: (v) => proto_duration.HederaDuration.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      autoRenewAccount: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'autoRenewAccount',
        parse: (v) => proto_basic_types.HederaAccountID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      ledgerId: config.decodeBinary<List<int>?>(json.valueAs('ledger_id', normalizeKeyLookup: config.normalizeKeys)),
      feeScheduleKey: json.valueTo<proto_basic_types.HederaKey?, Object>(
        key: 'fee_schedule_key',
        parse: (v) => proto_basic_types.HederaKey.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      feeExemptKeyList: (json.valueEnsureAsList<dynamic>('fee_exempt_key_list', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<proto_basic_types.HederaKey, Object>(
          value: e,
          parse: (v) => proto_basic_types.HederaKey.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
      customFees: (json.valueEnsureAsList<dynamic>('custom_fees', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<proto_custom_fees.HederaFixedCustomFee, Object>(
          value: e,
          parse: (v) => proto_custom_fees.HederaFixedCustomFee.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
    );
  }

  factory HederaConsensusTopicInfo.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaConsensusTopicInfo(
      memo: decode.getString<String?>(1),
      runningHash: decode.getBytes<List<int>?>(2),
      sequenceNumber: decode.getBigInt<BigInt?>(3),
      expirationTime: decode.messageTo<proto_timestamp.HederaTimestamp?>(4, (b) => proto_timestamp.HederaTimestamp.deserialize(b)),
      adminKey: decode.messageTo<proto_basic_types.HederaKey?>(5, (b) => proto_basic_types.HederaKey.deserialize(b)),
      submitKey: decode.messageTo<proto_basic_types.HederaKey?>(6, (b) => proto_basic_types.HederaKey.deserialize(b)),
      autoRenewPeriod: decode.messageTo<proto_duration.HederaDuration?>(7, (b) => proto_duration.HederaDuration.deserialize(b)),
      autoRenewAccount: decode.messageTo<proto_basic_types.HederaAccountID?>(8, (b) => proto_basic_types.HederaAccountID.deserialize(b)),
      ledgerId: decode.getBytes<List<int>?>(9),
      feeScheduleKey: decode.messageTo<proto_basic_types.HederaKey?>(10, (b) => proto_basic_types.HederaKey.deserialize(b)),
      feeExemptKeyList: decode.getListOfBytes(11).map((b) => proto_basic_types.HederaKey.deserialize(b)).toList(),
      customFees: decode.getListOfBytes(12).map((b) => proto_custom_fees.HederaFixedCustomFee.deserialize(b)).toList(),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoConsensusTopicInfo;

}


