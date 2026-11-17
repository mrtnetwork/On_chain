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
///  * # Crypto Get Account Records
///  * Messages for a query to retrieve recent transaction records involving a
///  * specified account as effective `payer`.&lt;br/&gt;
///  * A "recent" transaction is typically one that reached consensus within
///  * the previous three(`3`) minutes of _consensus_ time. Additionally, the
///   * network only stores records in state when
///  * `ledger.keepRecordsInState=true` was true during transaction handling.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in
///  * [RFC2119](https://www.ietf.org/rfc/rfc2119) and clarified in
///  * [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.token"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * Request records of all "recent" transactions for which the specified
///  * account is the effective payer.
class HederaCryptoGetAccountRecordsQuery extends HederaProtoMessage
    with Equality, IHederaQuery<HederaCryptoGetAccountRecordsResponse> {
  /// *
  ///      * Standard information sent with every query operation.&lt;br/&gt;
  ///      * This includes the signed payment and what kind of response is requested
  ///      * (cost, state proof, both, or neither).
  @override
  final proto_query_header.HederaQueryHeader? header;

  /// *
  ///      * An account identifier.&lt;br/&gt;
  ///      * This identifies the account to use when filtering the
  ///      * transaction record lists.
  ///      * &lt;p&gt;
  ///      * This field is REQUIRED.
  final proto_basic_types.HederaAccountID? accountID;

  const HederaCryptoGetAccountRecordsQuery({this.header, this.accountID});

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
  List<Object?> get protoValues => [header, accountID];

  @override
  HederaCryptoGetAccountRecordsQuery copyWith({
    proto_query_header.HederaQueryHeader? header,

    proto_basic_types.HederaAccountID? accountID,
  }) {
    return HederaCryptoGetAccountRecordsQuery(
      header: header ?? this.header,
      accountID: accountID ?? this.accountID,
    );
  }

  @override
  proto_query.HederaQuery toQueryRequest({
    proto_query_header.HederaQueryHeader? header,
  }) => proto_query.HederaQuery(
    cryptoGetAccountRecords: copyWith(header: header),
  );
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'header': config.encodeMessage(header),
      'accountID': config.encodeMessage(accountID),
    };
  }

  factory HederaCryptoGetAccountRecordsQuery.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaCryptoGetAccountRecordsQuery(
      header: json.valueTo<proto_query_header.HederaQueryHeader?, Object>(
        key: 'header',
        parse:
            (v) => proto_query_header.HederaQueryHeader.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      accountID: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'accountID',
        parse:
            (v) => proto_basic_types.HederaAccountID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaCryptoGetAccountRecordsQuery.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaCryptoGetAccountRecordsQuery(
      header: decode.messageTo<proto_query_header.HederaQueryHeader?>(
        1,
        (b) => proto_query_header.HederaQueryHeader.deserialize(b),
      ),
      accountID: decode.messageTo<proto_basic_types.HederaAccountID?>(
        2,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoCryptoGetAccountRecordsQuery;
}

/// *
///  * Return records of all "recent" transactions for which the specified
///  * account is the effective payer.
class HederaCryptoGetAccountRecordsResponse extends HederaProtoMessage
    with Equality, IHederaQueryRespone {
  /// *
  ///      * The standard response information for queries.&lt;br/&gt;
  ///      * This includes the values requested in the `QueryHeader`
  ///      * (cost, state proof, both, or neither).
  @override
  final proto_response_header.HederaResponseHeader? header;

  /// *
  ///      * An account identifier.&lt;br/&gt;
  ///      * This identifies the account used when filtering the
  ///      * transaction record lists.
  ///      * &lt;p&gt;
  ///      * This field SHALL match the requested account identifier.
  final proto_basic_types.HederaAccountID? accountID;

  /// *
  ///      * A list of records.
  ///      * &lt;p&gt;
  ///      * This list SHALL contain all available and "recent" records in which
  ///      * the account identified in the `accountID` field acted as effective payer.
  final List<proto_transaction_record.HederaTransactionRecord> records;

  const HederaCryptoGetAccountRecordsResponse({
    this.header,
    this.accountID,
    this.records = const [],
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
          fieldNumber: 3,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [header, accountID, records];

  HederaCryptoGetAccountRecordsResponse copyWith({
    proto_response_header.HederaResponseHeader? header,

    proto_basic_types.HederaAccountID? accountID,

    List<proto_transaction_record.HederaTransactionRecord>? records,
  }) {
    return HederaCryptoGetAccountRecordsResponse(
      header: header ?? this.header,
      accountID: accountID ?? this.accountID,
      records: records ?? this.records,
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
      'accountID': config.encodeMessage(accountID),
      'records': records.map((e) => config.encodeMessage(e)).toList(),
    };
  }

  factory HederaCryptoGetAccountRecordsResponse.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaCryptoGetAccountRecordsResponse(
      header: json.valueTo<proto_response_header.HederaResponseHeader?, Object>(
        key: 'header',
        parse:
            (v) => proto_response_header.HederaResponseHeader.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      accountID: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'accountID',
        parse:
            (v) => proto_basic_types.HederaAccountID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      records:
          (json.valueEnsureAsList<dynamic>(
                'records',
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

  factory HederaCryptoGetAccountRecordsResponse.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaCryptoGetAccountRecordsResponse(
      header: decode.messageTo<proto_response_header.HederaResponseHeader?>(
        1,
        (b) => proto_response_header.HederaResponseHeader.deserialize(b),
      ),
      accountID: decode.messageTo<proto_basic_types.HederaAccountID?>(
        2,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
      records:
          decode
              .getListOfBytes(3)
              .map(
                (b) => proto_transaction_record
                    .HederaTransactionRecord.deserialize(b),
              )
              .toList(),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoCryptoGetAccountRecordsResponse;
}
