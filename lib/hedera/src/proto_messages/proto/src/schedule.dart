import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;
import "package:on_chain/hedera/src/proto_messages/proto/src/timestamp.dart"
    as proto_timestamp;
import "package:on_chain/hedera/src/proto_messages/proto/src/schedulable_transaction_body.dart"
    as proto_schedulable_transaction_body;
import "package:on_chain/hedera/src/proto_messages/proto/src/transaction.dart"
    as proto_transaction;

/// *
///  * # Scheduled Transaction
///  * Information regarding Scheduled Transactions.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in [RFC2119](https://www.ietf.org/rfc/rfc2119)
///  * and clarified in [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.state.schedule"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * Representation of a Hedera Schedule entry in the network Merkle tree.&lt;br/&gt;
///  * A Schedule represents a request to run a transaction _at some future time_
///  * either when the `Schedule` expires (if long term schedules are enabled and
///  * `wait_for_expiry` is true) or as soon as the `Schedule` has gathered
///  * enough signatures via any combination of the `scheduleCreate` and 0 or more
///  * subsequent `scheduleSign` transactions.
class HederaSchedule extends HederaProtoMessage with Equality {
  /// *
  ///      * This schedule's ID within the global network state.
  ///      * &lt;p&gt;
  ///      * This value SHALL be unique within the network.
  final proto_basic_types.HederaScheduleID? scheduleId;

  /// *
  ///      * A flag indicating this schedule is deleted.
  ///      * &lt;p&gt;
  ///      * A schedule SHALL either be executed or deleted, but never both.
  final bool? deleted;

  /// *
  ///      * A flag indicating this schedule has executed.
  ///      * &lt;p&gt;
  ///      * A schedule SHALL either be executed or deleted, but never both.
  final bool? executed;

  /// *
  ///      * A schedule flag to wait for expiration before executing.
  ///      * &lt;p&gt;
  ///      * A schedule SHALL be executed immediately when all necessary signatures
  ///      * are gathered, unless this flag is set.&lt;br/&gt;
  ///      * If this flag is set, the schedule SHALL wait until the consensus time
  ///      * reaches `expiration_time_provided`, when signatures MUST again be
  ///      * verified. If all required signatures are present at that time, the
  ///      * schedule SHALL be executed. Otherwise the schedule SHALL expire without
  ///      * execution.
  ///      * &lt;p&gt;
  ///      * Note that a schedule is always removed from state after it expires,
  ///      * regardless of whether it was executed or not.
  final bool? waitForExpiry;

  /// *
  ///      * A short description for this schedule.
  ///      * &lt;p&gt;
  ///      * This value, if set, MUST NOT exceed `transaction.maxMemoUtf8Bytes`
  ///      * (default 100) bytes when encoded as UTF-8.
  final String? memo;

  /// *
  ///      * The scheduler account for this schedule.
  ///      * &lt;p&gt;
  ///      * This SHALL be the account that submitted the original
  ///      * ScheduleCreate transaction.
  final proto_basic_types.HederaAccountID? schedulerAccountId;

  /// *
  ///      * The explicit payer account for the scheduled transaction.
  ///      * &lt;p&gt;
  ///      * If set, this account SHALL be added to the accounts that MUST sign the
  ///      * schedule before it may execute.
  final proto_basic_types.HederaAccountID? payerAccountId;

  /// *
  ///      * The admin key for this schedule.
  ///      * &lt;p&gt;
  ///      * This key, if set, MUST sign any `schedule_delete` transaction.&lt;br/&gt;
  ///      * If not set, then this schedule SHALL NOT be deleted, and any
  ///      * `schedule_delete` transaction for this schedule SHALL fail.
  final proto_basic_types.HederaKey? adminKey;

  /// *
  ///      * The transaction valid start value for this schedule.
  ///      * &lt;p&gt;
  ///      * This MUST be set, and SHALL be copied from the `TransactionID` of
  ///      * the original `schedule_create` transaction.
  final proto_timestamp.HederaTimestamp? scheduleValidStart;

  /// *
  ///      * The requested expiration time of the schedule if provided by the user.
  ///      * &lt;p&gt;
  ///      * If not provided in the `schedule_create` transaction, this SHALL be set
  ///      * to a default value equal to the current consensus time, forward offset by
  ///      * the maximum schedule expiration time in the current dynamic network
  ///      * configuration (typically 62 days).&lt;br/&gt;
  ///      * The actual `calculated_expiration_second` MAY be "earlier" than this,
  ///      * but MUST NOT be later.
  final BigInt? providedExpirationSecond;

  /// *
  ///      * The calculated expiration time of the schedule.
  ///      * &lt;p&gt;
  ///      * This SHALL be calculated from the requested expiration time in the
  ///      * `schedule_create` transaction, and limited by the maximum expiration time
  ///      * in the current dynamic network configuration (typically 62 days).
  ///      * &lt;p&gt;
  ///      * The schedule SHALL be removed from global network state after the network
  ///      * reaches a consensus time greater than or equal to this value.
  final BigInt? calculatedExpirationSecond;

  /// *
  ///      * The consensus timestamp of the transaction that executed or deleted this schedule.
  ///      * &lt;p&gt;
  ///      * This value SHALL be set to the `current_consensus_time` when a
  ///      * `schedule_delete` transaction is completed.&lt;br/&gt;
  ///      * This value SHALL be set to the `current_consensus_time` when the
  ///      * scheduled transaction is executed, either as a result of gathering the
  ///      * final required signature, or, if long-term schedule execution is enabled,
  ///      * at the requested execution time.
  final proto_timestamp.HederaTimestamp? resolutionTime;

  /// *
  ///      * The scheduled transaction to execute.
  ///      * &lt;p&gt;
  ///      * This MUST be one of the transaction types permitted in the current value
  ///      * of the `schedule.whitelist` in the dynamic network configuration.
  final proto_schedulable_transaction_body.HederaSchedulableTransactionBody?
  scheduledTransaction;

  /// *
  ///      * The full transaction that created this schedule.
  ///      * &lt;p&gt;
  ///      * This is primarily used for duplicate schedule create detection. This is
  ///      * also the source of the parent transaction ID, from which the child
  ///      * transaction ID is derived when the `scheduled_transaction` is executed.
  final proto_transaction.HederaTransactionBody? originalCreateTransaction;

  /// *
  ///      * All of the "primitive" keys that have already signed this schedule.
  ///      * &lt;p&gt;
  ///      * The scheduled transaction SHALL NOT be executed before this list is
  ///      * sufficient to "activate" the required keys for the scheduled transaction.&lt;br/&gt;
  ///      * A Key SHALL NOT be stored in this list unless the corresponding private
  ///      * key has signed either the original `schedule_create` transaction or a
  ///      * subsequent `schedule_sign` transaction intended for, and referencing to,
  ///      * this specific schedule.
  ///      * &lt;p&gt;
  ///      * The only keys stored are "primitive" keys (ED25519 or ECDSA_SECP256K1) in
  ///      * order to ensure that any key list or threshold keys are correctly handled,
  ///      * regardless of signing order, intervening changes, or other situations.
  ///      * The `scheduled_transaction` SHALL execute only if, at the time of
  ///      * execution, this list contains sufficient public keys to satisfy the
  ///      * full requirements for signature on that transaction.
  final List<proto_basic_types.HederaKey> signatories;

  const HederaSchedule({
    this.scheduleId,
    this.deleted,
    this.executed,
    this.waitForExpiry,
    this.memo,
    this.schedulerAccountId,
    this.payerAccountId,
    this.adminKey,
    this.scheduleValidStart,
    this.providedExpirationSecond,
    this.calculatedExpirationSecond,
    this.resolutionTime,
    this.scheduledTransaction,
    this.originalCreateTransaction,
    this.signatories = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.bool(2),
        ProtoFieldConfig.bool(3),
        ProtoFieldConfig.bool(4),
        ProtoFieldConfig.string(5),
        ProtoFieldConfig.message(6),
        ProtoFieldConfig.message(7),
        ProtoFieldConfig.message(8),
        ProtoFieldConfig.message(9),
        ProtoFieldConfig.int64(10),
        ProtoFieldConfig.int64(11),
        ProtoFieldConfig.message(12),
        ProtoFieldConfig.message(13),
        ProtoFieldConfig.message(14),
        ProtoFieldConfig.repeated(
          fieldNumber: 15,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    scheduleId,
    deleted,
    executed,
    waitForExpiry,
    memo,
    schedulerAccountId,
    payerAccountId,
    adminKey,
    scheduleValidStart,
    providedExpirationSecond,
    calculatedExpirationSecond,
    resolutionTime,
    scheduledTransaction,
    originalCreateTransaction,
    signatories,
  ];

  HederaSchedule copyWith({
    proto_basic_types.HederaScheduleID? scheduleId,

    bool? deleted,

    bool? executed,

    bool? waitForExpiry,

    String? memo,

    proto_basic_types.HederaAccountID? schedulerAccountId,

    proto_basic_types.HederaAccountID? payerAccountId,

    proto_basic_types.HederaKey? adminKey,

    proto_timestamp.HederaTimestamp? scheduleValidStart,

    BigInt? providedExpirationSecond,

    BigInt? calculatedExpirationSecond,

    proto_timestamp.HederaTimestamp? resolutionTime,

    proto_schedulable_transaction_body.HederaSchedulableTransactionBody?
    scheduledTransaction,

    proto_transaction.HederaTransactionBody? originalCreateTransaction,

    List<proto_basic_types.HederaKey>? signatories,
  }) {
    return HederaSchedule(
      scheduleId: scheduleId ?? this.scheduleId,
      deleted: deleted ?? this.deleted,
      executed: executed ?? this.executed,
      waitForExpiry: waitForExpiry ?? this.waitForExpiry,
      memo: memo ?? this.memo,
      schedulerAccountId: schedulerAccountId ?? this.schedulerAccountId,
      payerAccountId: payerAccountId ?? this.payerAccountId,
      adminKey: adminKey ?? this.adminKey,
      scheduleValidStart: scheduleValidStart ?? this.scheduleValidStart,
      providedExpirationSecond:
          providedExpirationSecond ?? this.providedExpirationSecond,
      calculatedExpirationSecond:
          calculatedExpirationSecond ?? this.calculatedExpirationSecond,
      resolutionTime: resolutionTime ?? this.resolutionTime,
      scheduledTransaction: scheduledTransaction ?? this.scheduledTransaction,
      originalCreateTransaction:
          originalCreateTransaction ?? this.originalCreateTransaction,
      signatories: signatories ?? this.signatories,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'schedule_id': config.encodeMessage(scheduleId),
      'deleted': deleted,
      'executed': executed,
      'wait_for_expiry': waitForExpiry,
      'memo': memo,
      'scheduler_account_id': config.encodeMessage(schedulerAccountId),
      'payer_account_id': config.encodeMessage(payerAccountId),
      'admin_key': config.encodeMessage(adminKey),
      'schedule_valid_start': config.encodeMessage(scheduleValidStart),
      'provided_expiration_second': config.encodeBigint(
        providedExpirationSecond,
      ),
      'calculated_expiration_second': config.encodeBigint(
        calculatedExpirationSecond,
      ),
      'resolution_time': config.encodeMessage(resolutionTime),
      'scheduled_transaction': config.encodeMessage(scheduledTransaction),
      'original_create_transaction': config.encodeMessage(
        originalCreateTransaction,
      ),
      'signatories': signatories.map((e) => config.encodeMessage(e)).toList(),
    };
  }

  factory HederaSchedule.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaSchedule(
      scheduleId: json.valueTo<proto_basic_types.HederaScheduleID?, Object>(
        key: 'schedule_id',
        parse:
            (v) => proto_basic_types.HederaScheduleID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      deleted: json.valueAsBool<bool?>(
        'deleted',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      executed: json.valueAsBool<bool?>(
        'executed',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      waitForExpiry: json.valueAsBool<bool?>(
        'wait_for_expiry',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      memo: json.valueAsString<String?>(
        'memo',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      schedulerAccountId: json
          .valueTo<proto_basic_types.HederaAccountID?, Object>(
            key: 'scheduler_account_id',
            parse:
                (v) => proto_basic_types.HederaAccountID.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      payerAccountId: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'payer_account_id',
        parse:
            (v) => proto_basic_types.HederaAccountID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
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
      scheduleValidStart: json
          .valueTo<proto_timestamp.HederaTimestamp?, Object>(
            key: 'schedule_valid_start',
            parse:
                (v) => proto_timestamp.HederaTimestamp.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      providedExpirationSecond: json.valueAsBigInt<BigInt?>(
        'provided_expiration_second',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      calculatedExpirationSecond: json.valueAsBigInt<BigInt?>(
        'calculated_expiration_second',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      resolutionTime: json.valueTo<proto_timestamp.HederaTimestamp?, Object>(
        key: 'resolution_time',
        parse:
            (v) => proto_timestamp.HederaTimestamp.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      scheduledTransaction: json.valueTo<
        proto_schedulable_transaction_body.HederaSchedulableTransactionBody?,
        Object
      >(
        key: 'scheduled_transaction',
        parse:
            (v) => proto_schedulable_transaction_body
                .HederaSchedulableTransactionBody.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      originalCreateTransaction: json
          .valueTo<proto_transaction.HederaTransactionBody?, Object>(
            key: 'original_create_transaction',
            parse:
                (v) => proto_transaction.HederaTransactionBody.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      signatories:
          (json.valueEnsureAsList<dynamic>(
                'signatories',
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
    );
  }

  factory HederaSchedule.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaSchedule(
      scheduleId: decode.messageTo<proto_basic_types.HederaScheduleID?>(
        1,
        (b) => proto_basic_types.HederaScheduleID.deserialize(b),
      ),
      deleted: decode.getBool<bool?>(2),
      executed: decode.getBool<bool?>(3),
      waitForExpiry: decode.getBool<bool?>(4),
      memo: decode.getString<String?>(5),
      schedulerAccountId: decode.messageTo<proto_basic_types.HederaAccountID?>(
        6,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
      payerAccountId: decode.messageTo<proto_basic_types.HederaAccountID?>(
        7,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
      adminKey: decode.messageTo<proto_basic_types.HederaKey?>(
        8,
        (b) => proto_basic_types.HederaKey.deserialize(b),
      ),
      scheduleValidStart: decode.messageTo<proto_timestamp.HederaTimestamp?>(
        9,
        (b) => proto_timestamp.HederaTimestamp.deserialize(b),
      ),
      providedExpirationSecond: decode.getBigInt<BigInt?>(10),
      calculatedExpirationSecond: decode.getBigInt<BigInt?>(11),
      resolutionTime: decode.messageTo<proto_timestamp.HederaTimestamp?>(
        12,
        (b) => proto_timestamp.HederaTimestamp.deserialize(b),
      ),
      scheduledTransaction: decode.messageTo<
        proto_schedulable_transaction_body.HederaSchedulableTransactionBody?
      >(
        13,
        (b) => proto_schedulable_transaction_body
            .HederaSchedulableTransactionBody.deserialize(b),
      ),
      originalCreateTransaction: decode
          .messageTo<proto_transaction.HederaTransactionBody?>(
            14,
            (b) => proto_transaction.HederaTransactionBody.deserialize(b),
          ),
      signatories:
          decode
              .getListOfBytes(15)
              .map((b) => proto_basic_types.HederaKey.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoSchedule;
}

/// *
///  * A message for storing a list of schedules in state.&lt;br/&gt;
///  * This is used to store lists of `Schedule` values.
///  * One example is all schedules that expire at a particular time.
class HederaScheduleList extends HederaProtoMessage with Equality {
  /// *
  ///      * a list of schedules, in no particular order.
  ///      * &lt;p&gt;
  ///      * While the order is not _specified_, it MUST be deterministic.
  final List<HederaSchedule> schedules;

  const HederaScheduleList({this.schedules = const []});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.repeated(
          fieldNumber: 1,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [schedules];

  HederaScheduleList copyWith({List<HederaSchedule>? schedules}) {
    return HederaScheduleList(schedules: schedules ?? this.schedules);
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'schedules': schedules.map((e) => config.encodeMessage(e)).toList(),
    };
  }

  factory HederaScheduleList.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaScheduleList(
      schedules:
          (json.valueEnsureAsList<dynamic>(
                'schedules',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<HederaSchedule, Object>(
                  value: e,
                  parse:
                      (v) => HederaSchedule.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory HederaScheduleList.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaScheduleList(
      schedules:
          decode
              .getListOfBytes(1)
              .map((b) => HederaSchedule.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoScheduleList;
}

/// *
///  * A message for storing a list of schedule identifiers in state.&lt;br/&gt;
///  * This is used to store lists of `ScheduleID` values.
///  * One example is all schedules that expire at a particular time.
class HederaScheduleIdList extends HederaProtoMessage with Equality {
  /// *
  ///      * A list of schedule identifiers, in no particular order.
  ///      * &lt;p&gt;
  ///      * While the order is not _specified_, it MUST be deterministic.
  final List<proto_basic_types.HederaScheduleID> scheduleIds;

  const HederaScheduleIdList({this.scheduleIds = const []});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.repeated(
          fieldNumber: 1,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [scheduleIds];

  HederaScheduleIdList copyWith({
    List<proto_basic_types.HederaScheduleID>? scheduleIds,
  }) {
    return HederaScheduleIdList(scheduleIds: scheduleIds ?? this.scheduleIds);
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'schedule_ids': scheduleIds.map((e) => config.encodeMessage(e)).toList(),
    };
  }

  factory HederaScheduleIdList.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaScheduleIdList(
      scheduleIds:
          (json.valueEnsureAsList<dynamic>(
                'schedule_ids',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<
                  proto_basic_types.HederaScheduleID,
                  Object
                >(
                  value: e,
                  parse:
                      (v) => proto_basic_types.HederaScheduleID.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory HederaScheduleIdList.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaScheduleIdList(
      scheduleIds:
          decode
              .getListOfBytes(1)
              .map((b) => proto_basic_types.HederaScheduleID.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoScheduleIdList;
}

/// *
///  * A count of schedules scheduled and processed.
///  * This value summarizes the counts of scheduled and processed transactions
///  * within a particular consensus second.
class HederaScheduledCounts extends HederaProtoMessage with Equality {
  /// *
  ///      * A number of transactions scheduled to expire at a consensus second.
  final int? numberScheduled;

  /// *
  ///      * A number of scheduled transactions that have been processed at
  ///      * a consensus second.
  final int? numberProcessed;

  const HederaScheduledCounts({this.numberScheduled, this.numberProcessed});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.uint32(1), ProtoFieldConfig.uint32(2)],
    );
  }

  @override
  List<Object?> get protoValues => [numberScheduled, numberProcessed];

  HederaScheduledCounts copyWith({int? numberScheduled, int? numberProcessed}) {
    return HederaScheduledCounts(
      numberScheduled: numberScheduled ?? this.numberScheduled,
      numberProcessed: numberProcessed ?? this.numberProcessed,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'number_scheduled': numberScheduled,
      'number_processed': numberProcessed,
    };
  }

  factory HederaScheduledCounts.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaScheduledCounts(
      numberScheduled: json.valueAsInt<int?>(
        'number_scheduled',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      numberProcessed: json.valueAsInt<int?>(
        'number_processed',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaScheduledCounts.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaScheduledCounts(
      numberScheduled: decode.getInt<int?>(1),
      numberProcessed: decode.getInt<int?>(2),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoScheduledCounts;
}

/// *
///  * An ordering for a scheduled transaction.&lt;br/&gt;
///  * This establishes the order in which scheduled transactions intended to
///  * execute at a particular consensus second will be executed.
///  *
///  * Scheduled transactions that have the same `expiry_second` SHALL execute
///  * in ascending order of `order_number`.
class HederaScheduledOrder extends HederaProtoMessage with Equality {
  /// *
  ///      * A consensus second in which the transaction is to be executed.
  ///      * This is _also_ the consensus time when the transaction will expire
  ///      * if it has not gathered enough signatures in time.
  final BigInt? expirySecond;

  /// * An ordered position within a conceptual list.&lt;br/&gt;
  ///      * This is the ordered position within the consensus second when
  ///      * the associated transaction will be executed.
  final int? orderNumber;

  const HederaScheduledOrder({this.expirySecond, this.orderNumber});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.uint64(1), ProtoFieldConfig.uint32(2)],
    );
  }

  @override
  List<Object?> get protoValues => [expirySecond, orderNumber];

  HederaScheduledOrder copyWith({BigInt? expirySecond, int? orderNumber}) {
    return HederaScheduledOrder(
      expirySecond: expirySecond ?? this.expirySecond,
      orderNumber: orderNumber ?? this.orderNumber,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'expiry_second': config.encodeBigint(expirySecond),
      'order_number': orderNumber,
    };
  }

  factory HederaScheduledOrder.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaScheduledOrder(
      expirySecond: json.valueAsBigInt<BigInt?>(
        'expiry_second',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      orderNumber: json.valueAsInt<int?>(
        'order_number',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaScheduledOrder.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaScheduledOrder(
      expirySecond: decode.getBigInt<BigInt?>(1),
      orderNumber: decode.getInt<int?>(2),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoScheduledOrder;
}
