import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart" as proto_basic_types;
import "package:on_chain/hedera/src/proto_messages/proto/src/transaction_record.dart" as proto_transaction_record;
import "package:on_chain/hedera/src/proto_messages/proto/src/response_code.dart" as proto_response_code;

/// *
///  * # Record Cache
///  * The Record Cache holds transaction records for a short time, and is the
///  * source for responses to `transactionGetRecord` and `transactionGetReceipt`
///  * queries.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in [RFC2119](https://www.ietf.org/rfc/rfc2119)
///  * and clarified in [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.state.recordcache"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * As transactions are handled and records and receipts are created, they are
///  * stored in state for a configured time period (for example, 3 minutes).
///  * During this time, any client can query the node and get the record or receipt
///  * for the transaction. The `TransactionRecordEntry` is the object stored in
///  * state with this information.
class HederaTransactionRecordEntry extends HederaProtoMessage with Equality {
    /// *
  ///      * A node identifier.&lt;br/&gt;
  ///      * This identifier is the node, as known to the address book, that
  ///      * submitted the transaction for consensus.
  ///      * &lt;p&gt;
  ///      * This SHALL be a whole number.
  final BigInt? nodeId;

    /// *
  ///      * An Account identifier for the payer for the transaction.
  ///      * &lt;p&gt;
  ///      * This MAY be the same as the account ID within the Transaction ID of the
  ///      * record, or it MAY be the account ID of the node that submitted the
  ///      * transaction to consensus if the account ID in the Transaction ID was
  ///      * not able to pay.
  final proto_basic_types.HederaAccountID? payerAccountId;

    /// *
  ///      * A transaction record for the transaction.
  final proto_transaction_record.HederaTransactionRecord? transactionRecord;

  const HederaTransactionRecordEntry({
    this.nodeId,
    this.payerAccountId,
    this.transactionRecord,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.int64(1),
        ProtoFieldConfig.message(2),
        ProtoFieldConfig.message(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        nodeId,
        payerAccountId,
        transactionRecord,
      ];


HederaTransactionRecordEntry copyWith(
{BigInt? nodeId,

proto_basic_types.HederaAccountID? payerAccountId,

proto_transaction_record.HederaTransactionRecord? transactionRecord,

}) {
    return HederaTransactionRecordEntry(
nodeId: nodeId ?? this.nodeId,
payerAccountId: payerAccountId ?? this.payerAccountId,
transactionRecord: transactionRecord ?? this.transactionRecord,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'node_id': config.encodeBigint(nodeId),
      'payer_account_id': config.encodeMessage(payerAccountId),
      'transaction_record': config.encodeMessage(transactionRecord),
    };
  }


  factory HederaTransactionRecordEntry.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaTransactionRecordEntry(
      nodeId: json.valueAsBigInt<BigInt?>('node_id', normalizeKeyLookup: config.normalizeKeys),
      payerAccountId: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'payer_account_id',
        parse: (v) => proto_basic_types.HederaAccountID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      transactionRecord: json.valueTo<proto_transaction_record.HederaTransactionRecord?, Object>(
        key: 'transaction_record',
        parse: (v) => proto_transaction_record.HederaTransactionRecord.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory HederaTransactionRecordEntry.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTransactionRecordEntry(
      nodeId: decode.getBigInt<BigInt?>(1),
      payerAccountId: decode.messageTo<proto_basic_types.HederaAccountID?>(2, (b) => proto_basic_types.HederaAccountID.deserialize(b)),
      transactionRecord: decode.messageTo<proto_transaction_record.HederaTransactionRecord?>(3, (b) => proto_transaction_record.HederaTransactionRecord.deserialize(b)),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoTransactionRecordEntry;

}


/// *
///  * An entry in the record cache with the receipt for a transaction.
///  * This is the entry stored in state that enables returning the receipt
///  * information when queried by clients.
///  *
///  * When a transaction is handled a receipt SHALL be created.&lt;br/&gt;
///  * This receipt MUST be stored in state for a configured time limit
///  * (e.g. 3 minutes).&lt;br/&gt;
///  * While a receipt is stored, a client MAY query the node and retrieve
///  * the receipt.
class HederaTransactionReceiptEntry extends HederaProtoMessage with Equality {
    /// *
  ///      * A node identifier.&lt;br/&gt;
  ///      * This identifies the node that submitted the transaction to consensus.
  ///      * The value is the identifier as known to the current address book.
  ///      * &lt;p&gt;
  ///      * Valid node identifiers SHALL be between 0 and &lt;tt&gt;2&lt;sup&gt;63-1&lt;/sup&gt;&lt;/tt&gt;,
  ///      * inclusive.
  final BigInt? nodeId;

    /// *
  ///      * A transaction identifier.&lt;br/&gt;
  ///      * This identifies the submitted transaction for this receipt.
  final proto_basic_types.HederaTransactionID? transactionId;

    /// *
  ///      * A status result.&lt;br/&gt;
  ///      * This is the final status after handling the transaction.
  final proto_response_code.HederaResponseCodeEnum? status;

  const HederaTransactionReceiptEntry({
    this.nodeId,
    this.transactionId,
    this.status,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.uint64(1),
        ProtoFieldConfig.message(2),
        ProtoFieldConfig.enumType(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        nodeId,
        transactionId,
        status,
      ];


HederaTransactionReceiptEntry copyWith(
{BigInt? nodeId,

proto_basic_types.HederaTransactionID? transactionId,

proto_response_code.HederaResponseCodeEnum? status,

}) {
    return HederaTransactionReceiptEntry(
nodeId: nodeId ?? this.nodeId,
transactionId: transactionId ?? this.transactionId,
status: status ?? this.status,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'node_id': config.encodeBigint(nodeId),
      'transaction_id': config.encodeMessage(transactionId),
      'status': config.encodeEnum(status),
    };
  }


  factory HederaTransactionReceiptEntry.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaTransactionReceiptEntry(
      nodeId: json.valueAsBigInt<BigInt?>('node_id', normalizeKeyLookup: config.normalizeKeys),
      transactionId: json.valueTo<proto_basic_types.HederaTransactionID?, Object>(
        key: 'transaction_id',
        parse: (v) => proto_basic_types.HederaTransactionID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      status: json.valueTo<proto_response_code.HederaResponseCodeEnum?, Object?>(
        key: 'status',
        parse: (v) => proto_response_code.HederaResponseCodeEnum.from(v),
      ),
    );
  }

  factory HederaTransactionReceiptEntry.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTransactionReceiptEntry(
      nodeId: decode.getBigInt<BigInt?>(1),
      transactionId: decode.messageTo<proto_basic_types.HederaTransactionID?>(2, (b) => proto_basic_types.HederaTransactionID.deserialize(b)),
      status: decode.getEnum<proto_response_code.HederaResponseCodeEnum?>(3, proto_response_code.HederaResponseCodeEnum.values),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoTransactionReceiptEntry;

}


/// *
///  * A cache of transaction receipts.&lt;br/&gt;
///  * As transactions are handled and receipts are created, they are stored in
///  * state for a configured time limit (perhaps, for example, 3 minutes).
///  * During this time window, any client can query the node and get the receipt
///  * for the transaction. The `TransactionReceiptEntries` is the object stored in
///  * state with this information.
///  *
///  * This message SHALL contain a list of `TransactionReceiptEntry` objects.
class HederaTransactionReceiptEntries extends HederaProtoMessage with Equality {
  final List<HederaTransactionReceiptEntry> entries;

  const HederaTransactionReceiptEntries({
    this.entries = const [],
  });

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
  List<Object?> get protoValues => [
        entries,
      ];


HederaTransactionReceiptEntries copyWith(
{List<HederaTransactionReceiptEntry>? entries,

}) {
    return HederaTransactionReceiptEntries(
entries: entries ?? this.entries,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'entries': entries.map((e) => config.encodeMessage(e)).toList(),
    };
  }


  factory HederaTransactionReceiptEntries.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaTransactionReceiptEntries(
      entries: (json.valueEnsureAsList<dynamic>('entries', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<HederaTransactionReceiptEntry, Object>(
          value: e,
          parse: (v) => HederaTransactionReceiptEntry.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
    );
  }

  factory HederaTransactionReceiptEntries.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTransactionReceiptEntries(
      entries: decode.getListOfBytes(1).map((b) => HederaTransactionReceiptEntry.deserialize(b)).toList(),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoTransactionReceiptEntries;

}


