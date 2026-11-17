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
///  * # Get Fast Record
///  * Get a recent transaction record "fast".
///  *
///  * &gt; Important
///  * &gt;&gt; This query is obsolete and not supported.&lt;br/&gt;
///  * &gt;&gt; Any query of this type that is submitted SHALL fail with a `PRE_CHECK`
///  * &gt;&gt; result of `NOT_SUPPORTED`.
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
///  * Get the tx record of a transaction, given its transaction ID.
///  *
///  * Once a transaction reaches consensus, then information about whether it
///  * succeeded or failed will be available until the end of the receipt period.
///  * Before and after the receipt period, and for a transaction that was never
///  * submitted, the receipt is unknown.&lt;br/&gt;
///  * This query is free (the payment field is left empty).
class HederaTransactionGetFastRecordQuery extends HederaProtoMessage
    with Equality, IHederaQuery<HederaTransactionGetFastRecordResponse> {
  /// *
  ///      * Standard information sent with every query operation.&lt;br/&gt;
  ///      * This includes the signed payment and what kind of response is requested
  ///      * (cost, state proof, both, or neither).
  @override
  final proto_query_header.HederaQueryHeader? header;

  /// *
  ///      * The ID of the transaction for which the record is requested.
  final proto_basic_types.HederaTransactionID? transactionID;

  const HederaTransactionGetFastRecordQuery({this.header, this.transactionID});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: [ProtoOptionBool(name: "deprecated", value: true)],
      fields: [ProtoFieldConfig.message(1), ProtoFieldConfig.message(2)],
    );
  }

  @override
  List<Object?> get protoValues => [header, transactionID];

  @override
  HederaTransactionGetFastRecordQuery copyWith({
    proto_query_header.HederaQueryHeader? header,

    proto_basic_types.HederaTransactionID? transactionID,
  }) {
    return HederaTransactionGetFastRecordQuery(
      header: header ?? this.header,
      transactionID: transactionID ?? this.transactionID,
    );
  }

  @override
  proto_query.HederaQuery toQueryRequest({
    proto_query_header.HederaQueryHeader? header,
  }) => proto_query.HederaQuery(
    transactionGetFastRecord: copyWith(header: header),
  );
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'header': config.encodeMessage(header),
      'transactionID': config.encodeMessage(transactionID),
    };
  }

  factory HederaTransactionGetFastRecordQuery.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaTransactionGetFastRecordQuery(
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
    );
  }

  factory HederaTransactionGetFastRecordQuery.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTransactionGetFastRecordQuery(
      header: decode.messageTo<proto_query_header.HederaQueryHeader?>(
        1,
        (b) => proto_query_header.HederaQueryHeader.deserialize(b),
      ),
      transactionID: decode.messageTo<proto_basic_types.HederaTransactionID?>(
        2,
        (b) => proto_basic_types.HederaTransactionID.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoTransactionGetFastRecordQuery;
}

/// *
///  * Response when the client sends the node TransactionGetFastRecordQuery.
///  * If it created a new entity (account, file, or smart contract instance) then
///  * one of the three ID fields will be filled in with the ID of the new entity.
///  * Sometimes a single transaction will create more than one new entity, such
///  * as when a new contract instance is created, and this also creates the new
///  * account that it owned by that instance.
class HederaTransactionGetFastRecordResponse extends HederaProtoMessage
    with Equality, IHederaQueryRespone {
  /// *
  ///      * The standard response information for queries.&lt;br/&gt;
  ///      * This includes the values requested in the `QueryHeader`
  ///      * (cost, state proof, both, or neither).
  @override
  final proto_response_header.HederaResponseHeader? header;

  /// *
  ///      * The requested transaction records
  final proto_transaction_record.HederaTransactionRecord? transactionRecord;

  const HederaTransactionGetFastRecordResponse({
    this.header,
    this.transactionRecord,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: [ProtoOptionBool(name: "deprecated", value: true)],
      fields: [ProtoFieldConfig.message(1), ProtoFieldConfig.message(2)],
    );
  }

  @override
  List<Object?> get protoValues => [header, transactionRecord];

  HederaTransactionGetFastRecordResponse copyWith({
    proto_response_header.HederaResponseHeader? header,

    proto_transaction_record.HederaTransactionRecord? transactionRecord,
  }) {
    return HederaTransactionGetFastRecordResponse(
      header: header ?? this.header,
      transactionRecord: transactionRecord ?? this.transactionRecord,
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
    };
  }

  factory HederaTransactionGetFastRecordResponse.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaTransactionGetFastRecordResponse(
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
    );
  }

  factory HederaTransactionGetFastRecordResponse.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTransactionGetFastRecordResponse(
      header: decode.messageTo<proto_response_header.HederaResponseHeader?>(
        1,
        (b) => proto_response_header.HederaResponseHeader.deserialize(b),
      ),
      transactionRecord: decode
          .messageTo<proto_transaction_record.HederaTransactionRecord?>(
            2,
            (b) =>
                proto_transaction_record.HederaTransactionRecord.deserialize(b),
          ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoTransactionGetFastRecordResponse;
}
