import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/query_header.dart"
    as proto_query_header;
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;
import "package:on_chain/hedera/src/proto_messages/proto/src/response_header.dart"
    as proto_response_header;
import "package:on_chain/hedera/src/proto_messages/proto/src/transaction_receipt.dart"
    as proto_transaction_receipt;
import "package:on_chain/hedera/src/proto_messages/proto/src/query.dart"
    as proto_query;

/// *
///  * # Get Transaction Receipt
///  * This query is central to client interactions. A client must query
///  * the network for the "receipt" after a transaction is submitted to know
///  * whether the transaction succeeded and the consensus result.
///  *
///  * &gt; Implementation Note
///  * &gt;&gt; This query is _defined_ for "Crypto" service, but is _implemented_ by
///  * &gt;&gt; the "Network Admin" service.
///  *
///  * &gt; Note
///  * &gt;&gt; The mechanism for transaction receipts and results is subject to
///  * &gt;&gt; considerable change in the near future. Clients heavily dependent
///  * &gt;&gt; on direct network queries for transaction receipts may consider
///  * &gt;&gt; changes needed to query a mirror node for transaction receipts
///  * &gt;&gt; and results instead.
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
///  * A query to retrieve a transaction receipt.
///  * This query retrieves the post-consensus (final) result of a transaction.
///  * A transaction receipt may not be available if queried too early
///  * (less than 5-10 seconds), or too late (more than 3 minutes). If a receipt
///  * is available, it contains basic transaction results. A query to a mirror
///  * node (or other archival system) is required to obtain full detail for a
///  * transaction, or any result after the basic receipt time period.
///  *
///  * This query is "free". The payment field in the header MUST be empty.&lt;br/&gt;
///  * If a receipt is not available, the response SHALL be `UNKNOWN`.&lt;br/&gt;
///  * A transaction receipt SHALL be available after the network reaches
///  * consensus for a transaction.&lt;br/&gt;
///  * A transaction receipt SHALL NOT be available after the end of the network
///  * configured "receipt period", typically three(3) minutes.
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
class HederaTransactionGetReceiptQuery extends HederaProtoMessage
    with Equality, IHederaQuery<HederaTransactionGetReceiptResponse> {
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
  ///      * If set, every transaction receipt within the receipt period that
  ///      * matches the requested transaction identifier SHALL be returned.&lt;br/&gt;
  ///      * If not set, duplicate transactions SHALL NOT be returned.&lt;br/&gt;
  ///      * If not set, only the receipt for the first matching transaction to
  ///      * reach consensus SHALL be returned.
  final bool? includeDuplicates;

  /// *
  ///      * A flag to request "child" receipts.
  ///      * &lt;p&gt;
  ///      * If set, the response SHALL include receipts for each child transaction
  ///      * executed as part of the requested parent transaction.&lt;br/&gt;
  ///      * If not set, the response SHALL NOT include any receipts for child
  ///      * transactions.
  final bool? includeChildReceipts;

  const HederaTransactionGetReceiptQuery({
    this.header,
    this.transactionID,
    this.includeDuplicates,
    this.includeChildReceipts,
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
    includeChildReceipts,
  ];

  @override
  HederaTransactionGetReceiptQuery copyWith({
    proto_query_header.HederaQueryHeader? header,

    proto_basic_types.HederaTransactionID? transactionID,

    bool? includeDuplicates,

    bool? includeChildReceipts,
  }) {
    return HederaTransactionGetReceiptQuery(
      header: header ?? this.header,
      transactionID: transactionID ?? this.transactionID,
      includeDuplicates: includeDuplicates ?? this.includeDuplicates,
      includeChildReceipts: includeChildReceipts ?? this.includeChildReceipts,
    );
  }

  @override
  proto_query.HederaQuery toQueryRequest({
    proto_query_header.HederaQueryHeader? header,
  }) =>
      proto_query.HederaQuery(transactionGetReceipt: copyWith(header: header));
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
      'include_child_receipts': includeChildReceipts,
    };
  }

  factory HederaTransactionGetReceiptQuery.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaTransactionGetReceiptQuery(
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
      includeChildReceipts: json.valueAsBool<bool?>(
        'include_child_receipts',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaTransactionGetReceiptQuery.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTransactionGetReceiptQuery(
      header: decode.messageTo<proto_query_header.HederaQueryHeader?>(
        1,
        (b) => proto_query_header.HederaQueryHeader.deserialize(b),
      ),
      transactionID: decode.messageTo<proto_basic_types.HederaTransactionID?>(
        2,
        (b) => proto_basic_types.HederaTransactionID.deserialize(b),
      ),
      includeDuplicates: decode.getBool<bool?>(3),
      includeChildReceipts: decode.getBool<bool?>(4),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoTransactionGetReceiptQuery;
}

/// *
///  * Response message for a `getTransactionReceipts` query.
///  *
///  * The `receipt` field SHALL return the receipt for the "first" transaction
///  * that matches the transaction identifier requested.&lt;br/&gt;
///  * If receipts for duplicate transactions are requested, those duplicate
///  * receipts SHALL be present in the `duplicateTransactionReceipts` list.&lt;br/&gt;
///  * If receipts for child transactions are requested, those child receipts
///  * SHALL be present in the `child_transaction_receipts` list.&lt;br/&gt;
///  * A state proof SHALL NOT be provided for this response; transaction receipts
///  * are not retained in network state.
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
class HederaTransactionGetReceiptResponse extends HederaProtoMessage
    with Equality, IHederaQueryRespone {
  /// *
  ///      * The standard response information for queries.&lt;br/&gt;
  ///      * This includes the values requested in the `QueryHeader`
  ///      * (cost, state proof, both, or neither).
  @override
  final proto_response_header.HederaResponseHeader? header;

  /// *
  ///      * A transaction receipt.
  ///      * &lt;p&gt;
  ///      * This SHALL be the receipt for the "first" transaction that matches
  ///      * the transaction identifier requested.&lt;br/&gt;
  ///      * If the identified transaction has not reached consensus, this receipt
  ///      * SHALL have a `status` of `UNKNOWN`.&lt;br/&gt;
  ///      * If the identified transaction reached consensus prior to the current
  ///      * configured receipt period (typically the last 180 seconds), this receipt
  ///      * SHALL have a `status` of `UNKNOWN`.
  final proto_transaction_receipt.HederaTransactionReceipt? receipt;

  /// *
  ///      * A list of duplicate transaction receipts.
  ///      * &lt;p&gt;
  ///      * If the request set the `includeDuplicates` flat, this list SHALL
  ///      * include the receipts for each duplicate transaction associated to the
  ///      * requested transaction identifier.
  ///      * If the request did not set the `includeDuplicates` flag, this list
  ///      * SHALL be empty.&lt;br/&gt;
  ///      * If the `receipt` status is `UNKNOWN`, this list SHALL be empty.&lt;br/&gt;
  ///      * This list SHALL be in order by consensus timestamp.
  final List<proto_transaction_receipt.HederaTransactionReceipt>
  duplicateTransactionReceipts;

  /// *
  ///      * A list of receipts for all child transactions spawned by the requested
  ///      * transaction.
  ///      * &lt;p&gt;
  ///      * If the request set the `include_child_receipts` flag, this list SHALL
  ///      * include receipts for each child transaction executed as part of the
  ///      * requested parent transaction.&lt;br/&gt;
  ///      * If the request did not set the `include_child_receipts` flag, this
  ///      * list SHALL be empty. &lt;br/&gt;
  ///      * If the parent transaction did not initiate any child transactions
  ///      * this list SHALL be empty.&lt;br/&gt;
  ///      * If the `receipt` status is `UNKNOWN`, this list SHALL be empty.&lt;br/&gt;
  ///      * This list SHALL be in order by consensus timestamp.
  final List<proto_transaction_receipt.HederaTransactionReceipt>
  childTransactionReceipts;

  const HederaTransactionGetReceiptResponse({
    this.header,
    this.receipt,
    this.duplicateTransactionReceipts = const [],
    this.childTransactionReceipts = const [],
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
    receipt,
    duplicateTransactionReceipts,
    childTransactionReceipts,
  ];

  HederaTransactionGetReceiptResponse copyWith({
    proto_response_header.HederaResponseHeader? header,

    proto_transaction_receipt.HederaTransactionReceipt? receipt,

    List<proto_transaction_receipt.HederaTransactionReceipt>?
    duplicateTransactionReceipts,

    List<proto_transaction_receipt.HederaTransactionReceipt>?
    childTransactionReceipts,
  }) {
    return HederaTransactionGetReceiptResponse(
      header: header ?? this.header,
      receipt: receipt ?? this.receipt,
      duplicateTransactionReceipts:
          duplicateTransactionReceipts ?? this.duplicateTransactionReceipts,
      childTransactionReceipts:
          childTransactionReceipts ?? this.childTransactionReceipts,
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
      'receipt': config.encodeMessage(receipt),
      'duplicateTransactionReceipts':
          duplicateTransactionReceipts
              .map((e) => config.encodeMessage(e))
              .toList(),
      'child_transaction_receipts':
          childTransactionReceipts.map((e) => config.encodeMessage(e)).toList(),
    };
  }

  factory HederaTransactionGetReceiptResponse.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaTransactionGetReceiptResponse(
      header: json.valueTo<proto_response_header.HederaResponseHeader?, Object>(
        key: 'header',
        parse:
            (v) => proto_response_header.HederaResponseHeader.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      receipt: json
          .valueTo<proto_transaction_receipt.HederaTransactionReceipt?, Object>(
            key: 'receipt',
            parse:
                (v) =>
                    proto_transaction_receipt.HederaTransactionReceipt.fromJson(
                      JsonParser.valueAs(v),
                      config: config,
                    ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      duplicateTransactionReceipts:
          (json.valueEnsureAsList<dynamic>(
                'duplicateTransactionReceipts',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<
                  proto_transaction_receipt.HederaTransactionReceipt,
                  Object
                >(
                  value: e,
                  parse:
                      (v) => proto_transaction_receipt
                          .HederaTransactionReceipt.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      childTransactionReceipts:
          (json.valueEnsureAsList<dynamic>(
                'child_transaction_receipts',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<
                  proto_transaction_receipt.HederaTransactionReceipt,
                  Object
                >(
                  value: e,
                  parse:
                      (v) => proto_transaction_receipt
                          .HederaTransactionReceipt.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory HederaTransactionGetReceiptResponse.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTransactionGetReceiptResponse(
      header: decode.messageTo<proto_response_header.HederaResponseHeader?>(
        1,
        (b) => proto_response_header.HederaResponseHeader.deserialize(b),
      ),
      receipt: decode
          .messageTo<proto_transaction_receipt.HederaTransactionReceipt?>(
            2,
            (b) => proto_transaction_receipt
                .HederaTransactionReceipt.deserialize(b),
          ),
      duplicateTransactionReceipts:
          decode
              .getListOfBytes(4)
              .map(
                (b) => proto_transaction_receipt
                    .HederaTransactionReceipt.deserialize(b),
              )
              .toList(),
      childTransactionReceipts:
          decode
              .getListOfBytes(5)
              .map(
                (b) => proto_transaction_receipt
                    .HederaTransactionReceipt.deserialize(b),
              )
              .toList(),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoTransactionGetReceiptResponse;
}
