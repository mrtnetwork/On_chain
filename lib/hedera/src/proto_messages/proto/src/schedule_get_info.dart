import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/query_header.dart"
    as proto_query_header;
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;
import "package:on_chain/hedera/src/proto_messages/proto/src/timestamp.dart"
    as proto_timestamp;
import "package:on_chain/hedera/src/proto_messages/proto/src/schedulable_transaction_body.dart"
    as proto_schedulable_transaction_body;
import "package:on_chain/hedera/src/proto_messages/proto/src/response_header.dart"
    as proto_response_header;
import "package:on_chain/hedera/src/proto_messages/proto/src/query.dart"
    as proto_query;

/// *
///  * # Schedule Get Information
///  * Query body and response to retrieve information about a scheduled
///  * transaction.
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
///  * Request for information about a scheduled transaction.
///  *
///  * If the requested schedule does not exist, the network SHALL respond
///  * with `INVALID_SCHEDULE_ID`.
class HederaScheduleGetInfoQuery extends HederaProtoMessage
    with Equality, IHederaQuery<HederaScheduleGetInfoResponse> {
  /// *
  ///      * Standard information sent with every query operation.&lt;br/&gt;
  ///      * This includes the signed payment and what kind of response is requested
  ///      * (cost, state proof, both, or neither).
  @override
  final proto_query_header.HederaQueryHeader? header;

  /// *
  ///      * A schedule identifier.
  ///      * &lt;p&gt;
  ///      * This SHALL identify the schedule to retrieve.&lt;br/&gt;
  ///      * This field is REQUIRED.
  final proto_basic_types.HederaScheduleID? scheduleID;

  const HederaScheduleGetInfoQuery({this.header, this.scheduleID});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.message(1), ProtoFieldConfig.message(2)],
    );
  }

  @override
  List<Object?> get protoValues => [header, scheduleID];

  @override
  HederaScheduleGetInfoQuery copyWith({
    proto_query_header.HederaQueryHeader? header,

    proto_basic_types.HederaScheduleID? scheduleID,
  }) {
    return HederaScheduleGetInfoQuery(
      header: header ?? this.header,
      scheduleID: scheduleID ?? this.scheduleID,
    );
  }

  @override
  proto_query.HederaQuery toQueryRequest({
    proto_query_header.HederaQueryHeader? header,
  }) => proto_query.HederaQuery(scheduleGetInfo: copyWith(header: header));
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'header': config.encodeMessage(header),
      'scheduleID': config.encodeMessage(scheduleID),
    };
  }

  factory HederaScheduleGetInfoQuery.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaScheduleGetInfoQuery(
      header: json.valueTo<proto_query_header.HederaQueryHeader?, Object>(
        key: 'header',
        parse:
            (v) => proto_query_header.HederaQueryHeader.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      scheduleID: json.valueTo<proto_basic_types.HederaScheduleID?, Object>(
        key: 'scheduleID',
        parse:
            (v) => proto_basic_types.HederaScheduleID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaScheduleGetInfoQuery.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaScheduleGetInfoQuery(
      header: decode.messageTo<proto_query_header.HederaQueryHeader?>(
        1,
        (b) => proto_query_header.HederaQueryHeader.deserialize(b),
      ),
      scheduleID: decode.messageTo<proto_basic_types.HederaScheduleID?>(
        2,
        (b) => proto_basic_types.HederaScheduleID.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoScheduleGetInfoQuery;
}

/// *
///  * Information summarizing schedule state
class HederaScheduleInfo extends HederaProtoMessage with Equality {
  /// *
  ///      * A schedule identifier.
  ///      * &lt;p&gt;
  ///      * This SHALL identify the schedule retrieved.
  final proto_basic_types.HederaScheduleID? scheduleID;

  /// *
  ///          * A deletion timestamp.
  ///          * &lt;p&gt;
  ///          * If the schedule was deleted, this SHALL be set to the consensus
  ///          * timestamp of the `deleteSchedule` transaction.&lt;br/&gt;
  ///          * If the schedule is _not_ deleted, this field SHALL NOT be set.
  final proto_timestamp.HederaTimestamp? deletionTime;

  /// *
  ///          * An execution timestamp.
  ///          * &lt;p&gt;
  ///          * If the schedule was completed, and the _scheduled_ transaction
  ///          * executed, this SHALL be set to the consensus timestamp of the
  ///          * transaction that initiated that execution.&lt;br/&gt;
  ///          * If the schedule is _not_ complete, this field SHALL NOT be set.
  final proto_timestamp.HederaTimestamp? executionTime;

  /// *
  ///      * An expiration timestamp.&lt;br/&gt;
  ///      * This represents the time at which the schedule will expire. For a
  ///      * long-term schedule (if enabled) this is when the schedule will be
  ///      * executed, assuming it meets signature requirements at that time.
  ///      * For a short-term schedule, this is the deadline to complete the
  ///      * signature requirements for the scheduled transaction to execute.
  ///      * Regardless of schedule type, the schedule will be removed from
  ///      * state when it expires.
  ///      * &lt;p&gt;
  ///      * A schedule SHALL be removed from state when it expires.&lt;br/&gt;
  ///      * A short-term schedule MUST meet signature requirements strictly
  ///      * before expiration or it SHALL NOT be executed.&lt;br/&gt;
  ///      * A long-term schedule SHALL be executed if, and only if, all signature
  ///      * requirements for the scheduled transaction are met at expiration.&lt;br/&gt;
  ///      * A long-term schedule SHALL NOT be executed if any signature requirement
  ///      * for the scheduled transaction are not met at expiration.&lt;br/&gt;
  final proto_timestamp.HederaTimestamp? expirationTime;

  /// *
  ///      * A scheduled transaction.
  ///      * &lt;p&gt;
  ///      * This SHALL be a transaction type enabled in the network property
  ///      * `scheduling.whitelist`, and SHALL NOT be any other
  ///      * transaction type.&lt;br/&gt;
  ///      * This transaction SHALL be executed if the schedule meets all signature
  ///      * and execution time requirements for this transaction.&lt;br/&gt;
  ///      * The signature requirements for this transaction SHALL be evaluated
  ///      * at schedule creation, SHALL be reevaluated with each `signSchedule`
  ///      * transaction, and, for long-term schedules, SHALL be reevaluated when
  ///      * the schedule expires.&lt;br/&gt;
  final proto_schedulable_transaction_body.HederaSchedulableTransactionBody?
  scheduledTransactionBody;

  /// *
  ///      * A short description for this schedule.
  ///      * &lt;p&gt;
  ///      * This value, if set, MUST NOT exceed `transaction.maxMemoUtf8Bytes`
  ///      * (default 100) bytes when encoded as UTF-8.
  final String? memo;

  /// *
  ///      * The key used to delete the schedule from state
  final proto_basic_types.HederaKey? adminKey;

  /// *
  ///      * A list of "valid" signatures for this schedule.&lt;br/&gt;
  ///      * This list contains only "primitive" (i.e. cryptographic or contract)
  ///      * signatures. The full signature requirements for the scheduled
  ///      * transaction are evaluated as if this list of keys had signed the
  ///      * scheduled transaction directly.
  ///      * &lt;p&gt;
  ///      * This list SHALL contain every "primitive" key that has signed the
  ///      * original `createSchedule`, or any subsequent
  ///      * `signSchedule` transaction.&lt;br/&gt;
  ///      * This list MAY elide any signature not likely to be required by the
  ///      * scheduled transaction. Such requirement SHOULD be evaluated when the
  ///      * signature is presented (i.e. during evaluation of a `createSchedule` or
  ///      * `signSchedule` transaction).
  final proto_basic_types.HederaKeyList? signers;

  /// *
  ///      * An account identifier.
  ///      * &lt;p&gt;
  ///      * This SHALL identify the account that created this schedule.
  final proto_basic_types.HederaAccountID? creatorAccountID;

  /// *
  ///      * An account identifier.
  ///      * &lt;p&gt;
  ///      * The identified account SHALL pay the full transaction fee for the
  ///      * scheduled transaction _when it executes_.
  final proto_basic_types.HederaAccountID? payerAccountID;

  /// *
  ///      * A transaction identifier.
  ///      * &lt;p&gt;
  ///      * This SHALL be recorded as the transaction identifier for the
  ///      * _scheduled_ transaction, if (and when) it is executed.
  final proto_basic_types.HederaTransactionID? scheduledTransactionID;

  /// *
  ///      * The ledger ID of the network that generated this response.
  ///      * &lt;p&gt;
  ///      * This value SHALL identify the distributed ledger that responded to
  ///      * this query.
  final List<int>? ledgerId;

  /// *
  ///      * A flag indicating this schedule will execute when it expires.
  ///      * &lt;p&gt;
  ///      * If this field is set
  ///      * &lt;ul&gt;
  ///      *   &lt;li&gt;This schedule SHALL be considered a "long-term" schedule.&lt;/li&gt;
  ///      *   &lt;li&gt;This schedule SHALL be evaluated when the network consensus time
  ///      *       reaches the `expirationTime`, and if the signature requirements
  ///      *       for the scheduled transaction are met at that time, the
  ///      *       scheduled transaction SHALL be executed.&lt;/li&gt;
  ///      *   &lt;li&gt;This schedule SHALL NOT be executed before the network consensus
  ///      *       time reaches the `expirationTime`.&lt;/li&gt;
  ///      * &lt;/ul&gt;
  ///      * If this field is not set
  ///      * &lt;ul&gt;
  ///      *   &lt;li&gt;This schedule SHALL be considered a "short-term" schedule.&lt;/li&gt;
  ///      *   &lt;li&gt;This schedule SHALL be evaluated when created, and reevaluated
  ///      *       with each `signSchedule` transaction, and if the signature
  ///      *       requirements for the scheduled transaction are met at that time,
  ///      *       the scheduled transaction SHALL be executed immediately.&lt;/li&gt;
  ///      *   &lt;li&gt;This schedule SHALL be executed as soon as the signature
  ///      *       requirements are met, and MUST be executed before the network
  ///      *       consensus time reaches the `expirationTime`, if at all.&lt;/li&gt;
  ///      * &lt;/ul&gt;
  final bool? waitForExpiry;

  const HederaScheduleInfo({
    this.scheduleID,
    this.deletionTime,
    this.executionTime,
    this.expirationTime,
    this.scheduledTransactionBody,
    this.memo,
    this.adminKey,
    this.signers,
    this.creatorAccountID,
    this.payerAccountID,
    this.scheduledTransactionID,
    this.ledgerId,
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
        ProtoFieldConfig.message(2),
        ProtoFieldConfig.message(3),
        ProtoFieldConfig.message(4),
        ProtoFieldConfig.message(5),
        ProtoFieldConfig.string(6),
        ProtoFieldConfig.message(7),
        ProtoFieldConfig.message(8),
        ProtoFieldConfig.message(9),
        ProtoFieldConfig.message(10),
        ProtoFieldConfig.message(11),
        ProtoFieldConfig.bytes(12),
        ProtoFieldConfig.bool(13),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    scheduleID,
    deletionTime,
    executionTime,
    expirationTime,
    scheduledTransactionBody,
    memo,
    adminKey,
    signers,
    creatorAccountID,
    payerAccountID,
    scheduledTransactionID,
    ledgerId,
    waitForExpiry,
  ];

  HederaScheduleInfo copyWith({
    proto_basic_types.HederaScheduleID? scheduleID,

    proto_timestamp.HederaTimestamp? deletionTime,

    proto_timestamp.HederaTimestamp? executionTime,

    proto_timestamp.HederaTimestamp? expirationTime,

    proto_schedulable_transaction_body.HederaSchedulableTransactionBody?
    scheduledTransactionBody,

    String? memo,

    proto_basic_types.HederaKey? adminKey,

    proto_basic_types.HederaKeyList? signers,

    proto_basic_types.HederaAccountID? creatorAccountID,

    proto_basic_types.HederaAccountID? payerAccountID,

    proto_basic_types.HederaTransactionID? scheduledTransactionID,

    List<int>? ledgerId,

    bool? waitForExpiry,
  }) {
    return HederaScheduleInfo(
      scheduleID: scheduleID ?? this.scheduleID,
      deletionTime: deletionTime ?? this.deletionTime,
      executionTime: executionTime ?? this.executionTime,
      expirationTime: expirationTime ?? this.expirationTime,
      scheduledTransactionBody:
          scheduledTransactionBody ?? this.scheduledTransactionBody,
      memo: memo ?? this.memo,
      adminKey: adminKey ?? this.adminKey,
      signers: signers ?? this.signers,
      creatorAccountID: creatorAccountID ?? this.creatorAccountID,
      payerAccountID: payerAccountID ?? this.payerAccountID,
      scheduledTransactionID:
          scheduledTransactionID ?? this.scheduledTransactionID,
      ledgerId: ledgerId ?? this.ledgerId,
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
      'scheduleID': config.encodeMessage(scheduleID),
      'deletion_time': config.encodeMessage(deletionTime),
      'execution_time': config.encodeMessage(executionTime),
      'expirationTime': config.encodeMessage(expirationTime),
      'scheduledTransactionBody': config.encodeMessage(
        scheduledTransactionBody,
      ),
      'memo': memo,
      'adminKey': config.encodeMessage(adminKey),
      'signers': config.encodeMessage(signers),
      'creatorAccountID': config.encodeMessage(creatorAccountID),
      'payerAccountID': config.encodeMessage(payerAccountID),
      'scheduledTransactionID': config.encodeMessage(scheduledTransactionID),
      'ledger_id': config.encodeBinary(ledgerId),
      'wait_for_expiry': waitForExpiry,
    };
  }

  factory HederaScheduleInfo.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaScheduleInfo(
      scheduleID: json.valueTo<proto_basic_types.HederaScheduleID?, Object>(
        key: 'scheduleID',
        parse:
            (v) => proto_basic_types.HederaScheduleID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      deletionTime: json.valueTo<proto_timestamp.HederaTimestamp?, Object>(
        key: 'deletion_time',
        parse:
            (v) => proto_timestamp.HederaTimestamp.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      executionTime: json.valueTo<proto_timestamp.HederaTimestamp?, Object>(
        key: 'execution_time',
        parse:
            (v) => proto_timestamp.HederaTimestamp.fromJson(
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
      signers: json.valueTo<proto_basic_types.HederaKeyList?, Object>(
        key: 'signers',
        parse:
            (v) => proto_basic_types.HederaKeyList.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      creatorAccountID: json
          .valueTo<proto_basic_types.HederaAccountID?, Object>(
            key: 'creatorAccountID',
            parse:
                (v) => proto_basic_types.HederaAccountID.fromJson(
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
      scheduledTransactionID: json
          .valueTo<proto_basic_types.HederaTransactionID?, Object>(
            key: 'scheduledTransactionID',
            parse:
                (v) => proto_basic_types.HederaTransactionID.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      ledgerId: config.decodeBinary<List<int>?>(
        json.valueAs('ledger_id', normalizeKeyLookup: config.normalizeKeys),
      ),
      waitForExpiry: json.valueAsBool<bool?>(
        'wait_for_expiry',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaScheduleInfo.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaScheduleInfo(
      scheduleID: decode.messageTo<proto_basic_types.HederaScheduleID?>(
        1,
        (b) => proto_basic_types.HederaScheduleID.deserialize(b),
      ),
      deletionTime: decode.messageTo<proto_timestamp.HederaTimestamp?>(
        2,
        (b) => proto_timestamp.HederaTimestamp.deserialize(b),
      ),
      executionTime: decode.messageTo<proto_timestamp.HederaTimestamp?>(
        3,
        (b) => proto_timestamp.HederaTimestamp.deserialize(b),
      ),
      expirationTime: decode.messageTo<proto_timestamp.HederaTimestamp?>(
        4,
        (b) => proto_timestamp.HederaTimestamp.deserialize(b),
      ),
      scheduledTransactionBody: decode.messageTo<
        proto_schedulable_transaction_body.HederaSchedulableTransactionBody?
      >(
        5,
        (b) => proto_schedulable_transaction_body
            .HederaSchedulableTransactionBody.deserialize(b),
      ),
      memo: decode.getString<String?>(6),
      adminKey: decode.messageTo<proto_basic_types.HederaKey?>(
        7,
        (b) => proto_basic_types.HederaKey.deserialize(b),
      ),
      signers: decode.messageTo<proto_basic_types.HederaKeyList?>(
        8,
        (b) => proto_basic_types.HederaKeyList.deserialize(b),
      ),
      creatorAccountID: decode.messageTo<proto_basic_types.HederaAccountID?>(
        9,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
      payerAccountID: decode.messageTo<proto_basic_types.HederaAccountID?>(
        10,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
      scheduledTransactionID: decode
          .messageTo<proto_basic_types.HederaTransactionID?>(
            11,
            (b) => proto_basic_types.HederaTransactionID.deserialize(b),
          ),
      ledgerId: decode.getBytes<List<int>?>(12),
      waitForExpiry: decode.getBool<bool?>(13),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoScheduleInfo;
}

/// *
///  * A response message for a `getScheduleInfo` query.
class HederaScheduleGetInfoResponse extends HederaProtoMessage
    with Equality, IHederaQueryRespone {
  /// *
  ///      * The standard response information for queries.&lt;br/&gt;
  ///      * This includes the values requested in the `QueryHeader`
  ///      * (cost, state proof, both, or neither).
  @override
  final proto_response_header.HederaResponseHeader? header;

  /// *
  ///      * Detail information for a schedule.
  ///      * &lt;p&gt;
  ///      * This field SHALL contain all available schedule detail.
  final HederaScheduleInfo? scheduleInfo;

  const HederaScheduleGetInfoResponse({this.header, this.scheduleInfo});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.message(1), ProtoFieldConfig.message(2)],
    );
  }

  @override
  List<Object?> get protoValues => [header, scheduleInfo];

  HederaScheduleGetInfoResponse copyWith({
    proto_response_header.HederaResponseHeader? header,

    HederaScheduleInfo? scheduleInfo,
  }) {
    return HederaScheduleGetInfoResponse(
      header: header ?? this.header,
      scheduleInfo: scheduleInfo ?? this.scheduleInfo,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'header': config.encodeMessage(header),
      'scheduleInfo': config.encodeMessage(scheduleInfo),
    };
  }

  factory HederaScheduleGetInfoResponse.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaScheduleGetInfoResponse(
      header: json.valueTo<proto_response_header.HederaResponseHeader?, Object>(
        key: 'header',
        parse:
            (v) => proto_response_header.HederaResponseHeader.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      scheduleInfo: json.valueTo<HederaScheduleInfo?, Object>(
        key: 'scheduleInfo',
        parse:
            (v) => HederaScheduleInfo.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaScheduleGetInfoResponse.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaScheduleGetInfoResponse(
      header: decode.messageTo<proto_response_header.HederaResponseHeader?>(
        1,
        (b) => proto_response_header.HederaResponseHeader.deserialize(b),
      ),
      scheduleInfo: decode.messageTo<HederaScheduleInfo?>(
        2,
        (b) => HederaScheduleInfo.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoScheduleGetInfoResponse;
}
