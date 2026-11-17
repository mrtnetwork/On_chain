import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/schedulable_transaction_body.dart"
    as proto_schedulable_transaction_body;
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;
import "package:on_chain/hedera/src/proto_messages/proto/src/timestamp.dart"
    as proto_timestamp;

/// *
///  * # Schedule Create
///  * Message to create a schedule, which is an instruction to execute some other
///  * transaction (the scheduled transaction) at a future time, either when
///  * enough signatures are gathered (short term) or when the schedule expires
///  * (long term). In all cases the scheduled transaction is not executed if
///  * signature requirements are not met before the schedule expires.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in
///  * [RFC2119](https://www.ietf.org/rfc/rfc2119) and clarified in
///  * [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.scheduled"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * Create a new Schedule.
///  *
///  * #### Requirements
///  * This transaction SHALL create a new _schedule_ entity in network state.&lt;br/&gt;
///  * The schedule created SHALL contain the `scheduledTransactionBody` to be
///  * executed.&lt;br/&gt;
///  * If successful the receipt SHALL contain a `scheduleID` with the full
///  * identifier of the schedule created.&lt;br/&gt;
///  * When a schedule _executes_ successfully, the receipt SHALL include a
///  * `scheduledTransactionID` with the `TransactionID` of the transaction that
///  * executed.&lt;br/&gt;
///  * When a scheduled transaction is executed the network SHALL charge the
///  * regular _service_ fee for the transaction to the `payerAccountID` for
///  * that schedule, but SHALL NOT charge node or network fees.&lt;br/&gt;
///  * If the `payerAccountID` field is not set, the effective `payerAccountID`
///  * SHALL be the `payer` for this create transaction.&lt;br/&gt;
///  * If an `adminKey` is not specified, or is an empty `KeyList`, the schedule
///  * created SHALL be immutable.&lt;br/&gt;
///  * An immutable schedule MAY be signed, and MAY execute, but SHALL NOT be
///  * deleted.&lt;br/&gt;
///  * If two schedules have the same values for all fields except `payerAccountID`
///  * then those two schedules SHALL be deemed "identical".&lt;br/&gt;
///  * If a `scheduleCreate` requests a new schedule that is identical to an
///  * existing schedule, the transaction SHALL fail and SHALL return a status
///  * code of `IDENTICAL_SCHEDULE_ALREADY_CREATED` in the receipt.&lt;br/&gt;
///  * The receipt for a duplicate schedule SHALL include the `ScheduleID` of the
///  * existing schedule and the `TransactionID` of the earlier `scheduleCreate`
///  * so that the earlier schedule may be queried and/or referred to in a
///  * subsequent `scheduleSign`.
///  *
///  * #### Signature Requirements
///  * A `scheduleSign` transaction SHALL be used to add additional signatures
///  * to an existing schedule.&lt;br/&gt;
///  * Each signature SHALL "activate" the corresponding cryptographic("primitive")
///  * key for that schedule.&lt;br/&gt;
///  * Signature requirements SHALL be met when the set of active keys includes
///  * all keys required by the scheduled transaction.&lt;br/&gt;
///  * A scheduled transaction for a "long term" schedule SHALL NOT execute if
///  * the signature requirements for that transaction are not met when the
///  * network consensus time reaches the schedule `expiration_time`.&lt;br/&gt;
///  * A "short term" schedule SHALL execute immediately once signature
///  * requirements are met. This MAY be immediately when created.
///  *
///  * #### Long Term Schedules
///  * A "short term" schedule SHALL have the flag `wait_for_expiry` _unset_.&lt;br/&gt;
///  * A "long term" schedule SHALL have the flag  `wait_for_expiry` _set_.&lt;br/&gt;
///  * A "long term" schedule SHALL NOT be accepted if the network configuration
///  * `scheduling.longTermEnabled` is not enabled.&lt;br/&gt;
///  * A "long term" schedule SHALL execute when the current consensus time
///  * matches or exceeds the `expiration_time` for that schedule, if the
///  * signature requirements for the scheduled transaction
///  * are met at that instant.&lt;br/&gt;
///  * A "long term" schedule SHALL NOT execute before the current consensus time
///  * matches or exceeds the `expiration_time` for that schedule.&lt;br/&gt;
///  * A "long term" schedule SHALL expire, and be removed from state, after the
///  * network consensus time exceeds the schedule `expiration_time`.&lt;br/&gt;
///  * A short term schedule SHALL expire, and be removed from state,
///  * after the network consensus time exceeds the current network
///  * configuration for `ledger.scheduleTxExpiryTimeSecs`.
///  *
///  * &gt; Note
///  * &gt;&gt; Long term schedules are not (as of release 0.56.0) enabled. Any schedule
///  * &gt;&gt; created currently MUST NOT set the `wait_for_expiry` flag.&lt;br/&gt;
///  * &gt;&gt; When long term schedules are not enabled, schedules SHALL NOT be
///  * &gt;&gt; executed at expiration, and MUST meet signature requirements strictly
///  * &gt;&gt; before expiration to be executed.
///  *
///  * ### Block Stream Effects
///  * If the scheduled transaction is executed immediately, the transaction
///  * record SHALL include a `scheduleRef` with the schedule identifier of the
///  * schedule created.
class HederaScheduleCreateTransactionBody extends HederaProtoMessage
    with Equality {
  /// *
  ///      * A scheduled transaction.
  ///      * &lt;p&gt;
  ///      * This value is REQUIRED.&lt;br/&gt;
  ///      * This transaction body MUST be one of the types enabled in the
  ///      * network configuration value `scheduling.whitelist`.
  final proto_schedulable_transaction_body.HederaSchedulableTransactionBody?
  scheduledTransactionBody;

  /// *
  ///      * A short description of the schedule.
  ///      * &lt;p&gt;
  ///      * This value, if set, MUST NOT exceed `transaction.maxMemoUtf8Bytes`
  ///      * (default 100) bytes when encoded as UTF-8.
  final String? memo;

  /// *
  ///      * A `Key` required to delete this schedule.
  ///      * &lt;p&gt;
  ///      * If this is not set, or is an empty `KeyList`, this schedule SHALL be
  ///      * immutable and SHALL NOT be deleted.
  final proto_basic_types.HederaKey? adminKey;

  /// *
  ///      * An account identifier of a `payer` for the scheduled transaction.
  ///      * &lt;p&gt;
  ///      * This value MAY be unset. If unset, the `payer` for this `scheduleCreate`
  ///      * transaction SHALL be the `payer` for the scheduled transaction.&lt;br/&gt;
  ///      * If this is set, the identified account SHALL be charged the fees
  ///      * required for the scheduled transaction when it is executed.&lt;br/&gt;
  ///      * If the actual `payer` for the _scheduled_ transaction lacks
  ///      * sufficient HBAR balance to pay service fees for the scheduled
  ///      * transaction _when it executes_, the scheduled transaction
  ///      * SHALL fail with `INSUFFICIENT_PAYER_BALANCE`.&lt;br/&gt;
  final proto_basic_types.HederaAccountID? payerAccountID;

  /// *
  ///      * An expiration time.
  ///      * &lt;p&gt;
  ///      * If not set, the expiration SHALL default to the current consensus time
  ///      * advanced by either the network configuration value
  ///      * `scheduling.maxExpirationFutureSeconds`, if `wait_for_expiry` is set and
  ///      * "long term" schedules are enabled, or the network configuration value
  ///      * `ledger.scheduleTxExpiryTimeSecs` otherwise.
  final proto_timestamp.HederaTimestamp? expirationTime;

  /// *
  ///      * A flag to delay execution until expiration.
  ///      * &lt;p&gt;
  ///      * If this flag is set the scheduled transaction SHALL NOT be evaluated for
  ///      * execution before the network consensus time matches or exceeds the
  ///      * `expiration_time`.&lt;br/&gt;
  ///      * If this flag is not set, the scheduled transaction SHALL be executed
  ///      * immediately when all required signatures are received, whether in this
  ///      * `scheduleCreate` transaction or a later `scheduleSign` transaction.&lt;br/&gt;
  ///      * This value SHALL NOT be used and MUST NOT be set when the network
  ///      * configuration value `scheduling.longTermEnabled` is not enabled.
  final bool? waitForExpiry;

  const HederaScheduleCreateTransactionBody({
    this.scheduledTransactionBody,
    this.memo,
    this.adminKey,
    this.payerAccountID,
    this.expirationTime,
    this.waitForExpiry,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.string(2),
        ProtoFieldConfig.message(3),
        ProtoFieldConfig.message(4),
        ProtoFieldConfig.message(5),
        ProtoFieldConfig.bool(13),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    scheduledTransactionBody,
    memo,
    adminKey,
    payerAccountID,
    expirationTime,
    waitForExpiry,
  ];

  HederaScheduleCreateTransactionBody copyWith({
    proto_schedulable_transaction_body.HederaSchedulableTransactionBody?
    scheduledTransactionBody,

    String? memo,

    proto_basic_types.HederaKey? adminKey,

    proto_basic_types.HederaAccountID? payerAccountID,

    proto_timestamp.HederaTimestamp? expirationTime,

    bool? waitForExpiry,
  }) {
    return HederaScheduleCreateTransactionBody(
      scheduledTransactionBody:
          scheduledTransactionBody ?? this.scheduledTransactionBody,
      memo: memo ?? this.memo,
      adminKey: adminKey ?? this.adminKey,
      payerAccountID: payerAccountID ?? this.payerAccountID,
      expirationTime: expirationTime ?? this.expirationTime,
      waitForExpiry: waitForExpiry ?? this.waitForExpiry,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'scheduledTransactionBody': config.encodeMessage(
        scheduledTransactionBody,
      ),
      'memo': memo,
      'adminKey': config.encodeMessage(adminKey),
      'payerAccountID': config.encodeMessage(payerAccountID),
      'expiration_time': config.encodeMessage(expirationTime),
      'wait_for_expiry': waitForExpiry,
    };
  }

  factory HederaScheduleCreateTransactionBody.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaScheduleCreateTransactionBody(
      scheduledTransactionBody: json.valueTo<
        proto_schedulable_transaction_body.HederaSchedulableTransactionBody?,
        Object
      >(
        key: 'scheduledTransactionBody',
        parse:
            (v) => proto_schedulable_transaction_body
                .HederaSchedulableTransactionBody.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
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
      payerAccountID: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'payerAccountID',
        parse:
            (v) => proto_basic_types.HederaAccountID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      expirationTime: json.valueTo<proto_timestamp.HederaTimestamp?, Object>(
        key: 'expiration_time',
        parse:
            (v) => proto_timestamp.HederaTimestamp.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      waitForExpiry: json.valueAsBool<bool?>(
        'wait_for_expiry',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaScheduleCreateTransactionBody.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaScheduleCreateTransactionBody(
      scheduledTransactionBody: decode.messageTo<
        proto_schedulable_transaction_body.HederaSchedulableTransactionBody?
      >(
        1,
        (b) => proto_schedulable_transaction_body
            .HederaSchedulableTransactionBody.deserialize(b),
      ),
      memo: decode.getString<String?>(2),
      adminKey: decode.messageTo<proto_basic_types.HederaKey?>(
        3,
        (b) => proto_basic_types.HederaKey.deserialize(b),
      ),
      payerAccountID: decode.messageTo<proto_basic_types.HederaAccountID?>(
        4,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
      expirationTime: decode.messageTo<proto_timestamp.HederaTimestamp?>(
        5,
        (b) => proto_timestamp.HederaTimestamp.deserialize(b),
      ),
      waitForExpiry: decode.getBool<bool?>(13),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoScheduleCreateTransactionBody;
}
