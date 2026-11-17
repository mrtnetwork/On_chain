import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/query_header.dart"
    as proto_query_header;
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;
import "package:on_chain/hedera/src/proto_messages/proto/src/response_header.dart"
    as proto_response_header;
import "package:on_chain/hedera/src/proto_messages/proto/src/query.dart"
    as proto_query;

/// *
///  * # Get Execution Time
///  * Given a list of transaction identifiers, return the time required to
///  * process each transaction, excluding pre-consensus processing, consensus,
///  * and post-processing (e.g. record stream generation).
///  *
///  * &gt; Important
///  * &gt;&gt; This query is obsolete and not supported.&lt;br/&gt;
///  * &gt;&gt; Any query of this type that is submitted SHALL fail with a `PRE_CHECK`
///  * &gt;&gt; result of `NOT_SUPPORTED`.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in
///  * [RFC2119](https://www.ietf.org/rfc/rfc2119) and clarified in
///  * [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.network"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * Retrieve the time, in nanoseconds, spent in direct processing for one
///  * or more recent transactions.
///  *
///  * For each transaction identifier provided, if that transaction is
///  * sufficiently recent (that is, it is within the range of the configuration
///  * value `stats.executionTimesToTrack`), the node SHALL return the time, in
///  * nanoseconds, spent to directly process that transaction.&lt;br/&gt;
///  * This time will generally correspond to the time spent in a `handle` call
///  * within the workflow.
///  *
///  * Note that because each node processes every transaction for the Hedera
///  * network, this query MAY be sent to any node, and results MAY be different
///  * between different nodes.
///  *
class HederaNetworkGetExecutionTimeQuery extends HederaProtoMessage
    with Equality, IHederaQuery<HederaNetworkGetExecutionTimeResponse> {
  /// *
  ///      * Standard information sent with every query operation.&lt;br/&gt;
  ///      * This includes the signed payment and what kind of response is requested
  ///      * (cost, state proof, both, or neither).
  @override
  final proto_query_header.HederaQueryHeader? header;

  /// *
  ///      * A list of transaction identifiers to query.
  ///      * &lt;p&gt;
  ///      * All of the queried transaction identifiers MUST have execution time
  ///      * available. If any identifier does not have available execution time,
  ///      * the query SHALL fail with an `INVALID_TRANSACTION_ID` response.
  final List<proto_basic_types.HederaTransactionID> transactionIds;

  const HederaNetworkGetExecutionTimeQuery({
    this.header,
    this.transactionIds = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: [ProtoOptionBool(name: "deprecated", value: true)],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.repeated(
          fieldNumber: 2,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [header, transactionIds];

  @override
  HederaNetworkGetExecutionTimeQuery copyWith({
    proto_query_header.HederaQueryHeader? header,

    List<proto_basic_types.HederaTransactionID>? transactionIds,
  }) {
    return HederaNetworkGetExecutionTimeQuery(
      header: header ?? this.header,
      transactionIds: transactionIds ?? this.transactionIds,
    );
  }

  @override
  proto_query.HederaQuery toQueryRequest({
    proto_query_header.HederaQueryHeader? header,
  }) => proto_query.HederaQuery(
    networkGetExecutionTime: copyWith(header: header),
  );
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'header': config.encodeMessage(header),
      'transaction_ids':
          transactionIds.map((e) => config.encodeMessage(e)).toList(),
    };
  }

  factory HederaNetworkGetExecutionTimeQuery.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaNetworkGetExecutionTimeQuery(
      header: json.valueTo<proto_query_header.HederaQueryHeader?, Object>(
        key: 'header',
        parse:
            (v) => proto_query_header.HederaQueryHeader.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      transactionIds:
          (json.valueEnsureAsList<dynamic>(
                'transaction_ids',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<
                  proto_basic_types.HederaTransactionID,
                  Object
                >(
                  value: e,
                  parse:
                      (v) => proto_basic_types.HederaTransactionID.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory HederaNetworkGetExecutionTimeQuery.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaNetworkGetExecutionTimeQuery(
      header: decode.messageTo<proto_query_header.HederaQueryHeader?>(
        1,
        (b) => proto_query_header.HederaQueryHeader.deserialize(b),
      ),
      transactionIds:
          decode
              .getListOfBytes(2)
              .map((b) => proto_basic_types.HederaTransactionID.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoNetworkGetExecutionTimeQuery;
}

/// *
///  * A response to a `networkGetExecutionTime` query.
class HederaNetworkGetExecutionTimeResponse extends HederaProtoMessage
    with Equality, IHederaQueryRespone {
  /// *
  ///      * The standard response information for queries.&lt;br/&gt;
  ///      * This includes the values requested in the `QueryHeader`
  ///      * (cost, state proof, both, or neither).
  @override
  final proto_response_header.HederaResponseHeader? header;

  /// *
  ///      * A list of execution times, in nanoseconds.
  ///      * &lt;p&gt;
  ///      * This list SHALL be in the same order as the transaction
  ///      * identifiers were presented in the query.
  final List<BigInt> executionTimes;

  const HederaNetworkGetExecutionTimeResponse({
    this.header,
    this.executionTimes = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: [ProtoOptionBool(name: "deprecated", value: true)],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.repeated(
          fieldNumber: 2,
          elementType: ProtoFieldType.uint64,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [header, executionTimes];

  HederaNetworkGetExecutionTimeResponse copyWith({
    proto_response_header.HederaResponseHeader? header,

    List<BigInt>? executionTimes,
  }) {
    return HederaNetworkGetExecutionTimeResponse(
      header: header ?? this.header,
      executionTimes: executionTimes ?? this.executionTimes,
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
      'execution_times':
          executionTimes.map((e) => config.encodeBigint(e)).toList(),
    };
  }

  factory HederaNetworkGetExecutionTimeResponse.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaNetworkGetExecutionTimeResponse(
      header: json.valueTo<proto_response_header.HederaResponseHeader?, Object>(
        key: 'header',
        parse:
            (v) => proto_response_header.HederaResponseHeader.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      executionTimes:
          (json.valueEnsureAsList<dynamic>(
            'execution_times',
            normalizeKeyLookup: config.normalizeKeys,
            onMissing: () => [],
          )).map((e) => JsonParser.valueAsBigInt<BigInt>(e)).toList(),
    );
  }

  factory HederaNetworkGetExecutionTimeResponse.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaNetworkGetExecutionTimeResponse(
      header: decode.messageTo<proto_response_header.HederaResponseHeader?>(
        1,
        (b) => proto_response_header.HederaResponseHeader.deserialize(b),
      ),
      executionTimes: decode.getListOrEmpty<BigInt>(2),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoNetworkGetExecutionTimeResponse;
}
