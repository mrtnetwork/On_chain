import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/query_header.dart"
    as proto_query_header;
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;
import "package:on_chain/hedera/src/proto_messages/proto/src/response_header.dart"
    as proto_response_header;
import "package:on_chain/hedera/src/proto_messages/proto/src/transaction_record.dart"
    as proto_transaction_record;
import "package:on_chain/hedera/src/proto_messages/proto/src/query.dart"
    as proto_query;

/// *
///  * # Get Transaction Record
///  * Messages for a query to obtain a transaction record. This particular
///  * query is used by `getTxRecordByTxID` in the "Crypto" service API.
///  *
///  * &gt; Note
///  * &gt;&gt; Much more detailed information for transaction records is available
///  * &gt;&gt; from a mirror node, and the mirror node retains transaction records
///  * &gt;&gt; long term, rather than for a short "cache" duration. Clients may
///  * &gt;&gt; prefer the mirror node graph API to query transaction records, rather
///  * &gt;&gt; than this query.
///  *
///  * &gt; Implementation Note
///  * &gt;&gt; This query is _defined_ for "Crypto" service, but is _implemented_ by
///  * &gt;&gt; the "Network Admin" service.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in
///  * [RFC2119](https://www.ietf.org/rfc/rfc2119) and clarified in
///  * [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.transaction"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * Request for a `TransactionGetRecord` (a.k.a. `getTxRecordByTxID`) query.
///  * &lt;p&gt;
///  * A transaction record SHALL be available after the network reaches
///  * consensus and completes execution for a transaction.&lt;br/&gt;
///  * A transaction record SHALL NOT be available after the end of the network
///  * configured "record cache duration".
///  *
///  * &lt;dl&gt;
///  *   &lt;dt&gt;What is the "first" transaction?&lt;/dt&gt;
///  *   &lt;dd&gt;The "first" transaction SHALL be the the transaction with
///  *       the earliest consensus time and a status that is neither
///  *       `INVALID_NODE_ACCOUNT` nor `INVALID_PAYER_SIGNATURE`.&lt;br/&gt;
///  *       If no transaction is found meeting this status criteria, the
///  *       "first" transaction SHALL be the transaction with the earliest
///  *       consensus time.&lt;/dd&gt;
///  *  &lt;dt&gt;What is a "child" transaction?&lt;/dt&gt;
///  *  &lt;dd&gt;A "child" transaction is any transaction created in the process of
///  *      completing another transaction. These are most common with a smart
///  *      contract call, where a call to a contract may initiate one or more
///  *      additional transactions to complete a complex process.&lt;/dd&gt;
///  * &lt;/dl&gt;
class HederaTransactionGetRecordQuery extends HederaProtoMessage
    with Equality, IHederaQuery<HederaTransactionGetRecordResponse> {
  /// *
  ///      * Standard information sent with every query operation.&lt;br/&gt;
  ///      * This includes the signed payment and what kind of response is requested
  ///      * (cost, state proof, both, or neither).
  @override
  final proto_query_header.HederaQueryHeader? header;

  /// *
  ///      * A transaction identifier.
  ///      * &lt;p&gt;
  ///      * This MUST contain the full identifier, as submitted, for the
  ///      * transaction to query.
  final proto_basic_types.HederaTransactionID? transactionID;

  /// *
  ///      * A flag to request duplicates.
  ///      * &lt;p&gt;
  ///      * If set, every transaction record within the record cache duration that
  ///      * matches the requested transaction identifier SHALL be returned.&lt;br/&gt;
  ///      * If not set, duplicate transactions SHALL NOT be returned.&lt;br/&gt;
  ///      * If not set, only the record for the first matching transaction to
  ///      * reach consensus SHALL be returned.
  final bool? includeDuplicates;

  /// *
  ///      * A flag to request "child" records.
  ///      * &lt;p&gt;
  ///      * If set, the response SHALL include records for each child transaction
  ///      * executed as part of the requested parent transaction.&lt;br/&gt;
  ///      * If not set, the response SHALL NOT include any records for child
  ///      * transactions.
  final bool? includeChildRecords;

  const HederaTransactionGetRecordQuery({
    this.header,
    this.transactionID,
    this.includeDuplicates,
    this.includeChildRecords,
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
        ProtoFieldConfig.bool(3),
        ProtoFieldConfig.bool(4),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    header,
    transactionID,
    includeDuplicates,
    includeChildRecords,
  ];

  @override
  HederaTransactionGetRecordQuery copyWith({
    proto_query_header.HederaQueryHeader? header,

    proto_basic_types.HederaTransactionID? transactionID,

    bool? includeDuplicates,

    bool? includeChildRecords,
  }) {
    return HederaTransactionGetRecordQuery(
      header: header ?? this.header,
      transactionID: transactionID ?? this.transactionID,
      includeDuplicates: includeDuplicates ?? this.includeDuplicates,
      includeChildRecords: includeChildRecords ?? this.includeChildRecords,
    );
  }

  @override
  proto_query.HederaQuery toQueryRequest({
    proto_query_header.HederaQueryHeader? header,
  }) => proto_query.HederaQuery(transactionGetRecord: copyWith(header: header));
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'header': config.encodeMessage(header),
      'transactionID': config.encodeMessage(transactionID),
      'includeDuplicates': includeDuplicates,
      'include_child_records': includeChildRecords,
    };
  }

  factory HederaTransactionGetRecordQuery.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaTransactionGetRecordQuery(
      header: json.valueTo<proto_query_header.HederaQueryHeader?, Object>(
        key: 'header',
        parse:
            (v) => proto_query_header.HederaQueryHeader.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      transactionID: json
          .valueTo<proto_basic_types.HederaTransactionID?, Object>(
            key: 'transactionID',
            parse:
                (v) => proto_basic_types.HederaTransactionID.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      includeDuplicates: json.valueAsBool<bool?>(
        'includeDuplicates',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      includeChildRecords: json.valueAsBool<bool?>(
        'include_child_records',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaTransactionGetRecordQuery.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTransactionGetRecordQuery(
      header: decode.messageTo<proto_query_header.HederaQueryHeader?>(
        1,
        (b) => proto_query_header.HederaQueryHeader.deserialize(b),
      ),
      transactionID: decode.messageTo<proto_basic_types.HederaTransactionID?>(
        2,
        (b) => proto_basic_types.HederaTransactionID.deserialize(b),
      ),
      includeDuplicates: decode.getBool<bool?>(3),
      includeChildRecords: decode.getBool<bool?>(4),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoTransactionGetRecordQuery;
}

/// *
///  * Response message for a `getTxRecordByTxID` query.
///  *
///  * The `transactionRecord` field SHALL return the record for the "first"
///  * transaction that matches the transaction identifier requested.&lt;br/&gt;
///  * If records for duplicate transactions are requested, those duplicate
///  * records SHALL be present in the `duplicateTransactionReceipts` list.&lt;br/&gt;
///  * If records for child transactions are requested, those child records SHALL
///  * be present in the `child_transaction_records` list.&lt;br/&gt;
///  * A state proof MAY be provided for this response; provided the record is
///  * still available from the consensus nodes.
///  *
///  * &lt;dl&gt;
///  *   &lt;dt&gt;What is the "first" transaction?&lt;/dt&gt;
///  *   &lt;dd&gt;The "first" transaction receipt SHALL be the receipt for the
///  *       first transaction with status that is neither
///  *       `INVALID_NODE_ACCOUNT` nor `INVALID_PAYER_SIGNATURE`.&lt;br/&gt;
///  *       If no transaction is found meeting the status criteria, the
///  *       "first" transaction SHALL be the first transaction by
///  *       consensus time.&lt;/dd&gt;
///  *  &lt;dt&gt;What is a "child" transaction?&lt;/dt&gt;
///  *  &lt;dd&gt;A "child" transaction is any transaction created in the process of
///  *      completing another transaction. These are most common with a smart
///  *      contract call, where a call to a contract may initiate one or more
///  *      additional transactions to complete a complex process.&lt;/dd&gt;
///  * &lt;/dl&gt;
///  *
class HederaTransactionGetRecordResponse extends HederaProtoMessage
    with Equality, IHederaQueryRespone {
  /// *
  ///      * The standard response information for queries.&lt;br/&gt;
  ///      * This includes the values requested in the `QueryHeader`
  ///      * (cost, state proof, both, or neither).
  @override
  final proto_response_header.HederaResponseHeader? header;

  /// *
  ///      * A transaction record.
  ///      * &lt;p&gt;
  ///      * This SHALL be the record for the "first" transaction that matches
  ///      * the transaction identifier requested.&lt;br/&gt;
  ///      * If the identified transaction has not reached consensus, this
  ///      * record SHALL have a `status` of `UNKNOWN`.&lt;br/&gt;
  ///      * If the identified transaction reached consensus prior to the
  ///      * current configured record cache duration, this record SHALL
  ///      * have a `status` of `UNKNOWN`.
  final proto_transaction_record.HederaTransactionRecord? transactionRecord;

  /// *
  ///      * A list of duplicate transaction records.
  ///      * &lt;p&gt;
  ///      * If the request set the `includeDuplicates` flat, this list SHALL
  ///      * include the records for each duplicate transaction associated to the
  ///      * requested transaction identifier.
  ///      * If the request did not set the `includeDuplicates` flag, this list
  ///      * SHALL be empty.&lt;br/&gt;
  ///      * If the `transactionRecord` status is `UNKNOWN`, this list
  ///      * SHALL be empty.&lt;br/&gt;
  ///      * This list SHALL be in order by consensus timestamp.
  final List<proto_transaction_record.HederaTransactionRecord>
  duplicateTransactionRecords;

  /// *
  ///      * A list of records for all child transactions spawned by the requested
  ///      * transaction.
  ///      * &lt;p&gt;
  ///      * If the request set the `include_child_records` flag, this list SHALL
  ///      * include records for each child transaction executed as part of the
  ///      * requested parent transaction.&lt;br/&gt;
  ///      * If the request did not set the `include_child_records` flag, this
  ///      * list SHALL be empty. &lt;br/&gt;
  ///      * If the parent transaction did not initiate any child transactions
  ///      * this list SHALL be empty.&lt;br/&gt;
  ///      * If the `transactionRecord` status is `UNKNOWN`, this list
  ///      * SHALL be empty.&lt;br/&gt;
  ///      * This list SHALL be in order by consensus timestamp.
  final List<proto_transaction_record.HederaTransactionRecord>
  childTransactionRecords;

  const HederaTransactionGetRecordResponse({
    this.header,
    this.transactionRecord,
    this.duplicateTransactionRecords = const [],
    this.childTransactionRecords = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.message(3),
        ProtoFieldConfig.repeated(
          fieldNumber: 4,
          elementType: ProtoFieldType.message,
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
    header,
    transactionRecord,
    duplicateTransactionRecords,
    childTransactionRecords,
  ];

  HederaTransactionGetRecordResponse copyWith({
    proto_response_header.HederaResponseHeader? header,

    proto_transaction_record.HederaTransactionRecord? transactionRecord,

    List<proto_transaction_record.HederaTransactionRecord>?
    duplicateTransactionRecords,

    List<proto_transaction_record.HederaTransactionRecord>?
    childTransactionRecords,
  }) {
    return HederaTransactionGetRecordResponse(
      header: header ?? this.header,
      transactionRecord: transactionRecord ?? this.transactionRecord,
      duplicateTransactionRecords:
          duplicateTransactionRecords ?? this.duplicateTransactionRecords,
      childTransactionRecords:
          childTransactionRecords ?? this.childTransactionRecords,
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
      'transactionRecord': config.encodeMessage(transactionRecord),
      'duplicateTransactionRecords':
          duplicateTransactionRecords
              .map((e) => config.encodeMessage(e))
              .toList(),
      'child_transaction_records':
          childTransactionRecords.map((e) => config.encodeMessage(e)).toList(),
    };
  }

  factory HederaTransactionGetRecordResponse.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaTransactionGetRecordResponse(
      header: json.valueTo<proto_response_header.HederaResponseHeader?, Object>(
        key: 'header',
        parse:
            (v) => proto_response_header.HederaResponseHeader.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      transactionRecord: json
          .valueTo<proto_transaction_record.HederaTransactionRecord?, Object>(
            key: 'transactionRecord',
            parse:
                (v) =>
                    proto_transaction_record.HederaTransactionRecord.fromJson(
                      JsonParser.valueAs(v),
                      config: config,
                    ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      duplicateTransactionRecords:
          (json.valueEnsureAsList<dynamic>(
                'duplicateTransactionRecords',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<
                  proto_transaction_record.HederaTransactionRecord,
                  Object
                >(
                  value: e,
                  parse:
                      (v) => proto_transaction_record
                          .HederaTransactionRecord.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      childTransactionRecords:
          (json.valueEnsureAsList<dynamic>(
                'child_transaction_records',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<
                  proto_transaction_record.HederaTransactionRecord,
                  Object
                >(
                  value: e,
                  parse:
                      (v) => proto_transaction_record
                          .HederaTransactionRecord.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory HederaTransactionGetRecordResponse.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTransactionGetRecordResponse(
      header: decode.messageTo<proto_response_header.HederaResponseHeader?>(
        1,
        (b) => proto_response_header.HederaResponseHeader.deserialize(b),
      ),
      transactionRecord: decode
          .messageTo<proto_transaction_record.HederaTransactionRecord?>(
            3,
            (b) =>
                proto_transaction_record.HederaTransactionRecord.deserialize(b),
          ),
      duplicateTransactionRecords:
          decode
              .getListOfBytes(4)
              .map(
                (b) => proto_transaction_record
                    .HederaTransactionRecord.deserialize(b),
              )
              .toList(),
      childTransactionRecords:
          decode
              .getListOfBytes(5)
              .map(
                (b) => proto_transaction_record
                    .HederaTransactionRecord.deserialize(b),
              )
              .toList(),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoTransactionGetRecordResponse;
}
