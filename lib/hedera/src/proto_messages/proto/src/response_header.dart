import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/response_code.dart"
    as proto_response_code;
import "package:on_chain/hedera/src/proto_messages/proto/src/query_header.dart"
    as proto_query_header;

/// *
///  * # Response Header
///  * A standard header for all query responses.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in
///  * [RFC2119](https://www.ietf.org/rfc/rfc2119) and clarified in
///  * [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.base"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * A standard header returned with every query response.
///  *
///  * The fields for `cost` or `stateProof` MAY be unset if the requested
///  * `ResponseType` does not request those values.&lt;br/&gt;
///  * The `responseType` SHALL match the request response type.&lt;br/&gt;
///  * The `nodeTransactionPrecheckCode` field SHALL contain the result code
///  * for the query.
class HederaResponseHeader extends HederaProtoMessage with Equality {
  /// *
  ///      * The result code for this query.
  ///      * &lt;p&gt;
  ///      * This value SHALL indicate either success or the reason for failure.
  final proto_response_code.HederaResponseCodeEnum? nodeTransactionPrecheckCode;

  /// *
  ///      * The response type requested for this query.
  ///      * &lt;p&gt;
  ///      * This SHALL be the response type requested in the query header.
  final proto_query_header.HederaResponseType? responseType;

  /// *
  ///      * Requested cost estimate.&lt;br/&gt;
  ///      * This is the fee that _would be_ charged if the query was executed.
  ///      * &lt;p&gt;
  ///      * This value SHALL be set if the response type requested requires cost
  ///      * information, and SHALL NOT be set otherwise.&lt;br/&gt;
  ///      * This value SHALL include the query fee, but SHALL NOT include the
  ///      * transfer fee required to execute the fee payment transaction.
  final BigInt? cost;

  /// *
  ///      * A state proof for the information requested.
  ///      *
  ///      * This field SHALL NOT be set if the response type does not require
  ///      * a state proof.&lt;br/&gt;
  ///      * This field SHALL NOT be set if a state proof is not available for
  ///      * the query type.&lt;br/&gt;
  ///      * This field SHALL be set if the response type requested a state proof
  ///      * and a state proof is available.
  final List<int>? stateProof;

  const HederaResponseHeader({
    this.nodeTransactionPrecheckCode,
    this.responseType,
    this.cost,
    this.stateProof,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.enumType(1),
        ProtoFieldConfig.enumType(2),
        ProtoFieldConfig.uint64(3),
        ProtoFieldConfig.bytes(4),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    nodeTransactionPrecheckCode,
    responseType,
    cost,
    stateProof,
  ];

  HederaResponseHeader copyWith({
    proto_response_code.HederaResponseCodeEnum? nodeTransactionPrecheckCode,

    proto_query_header.HederaResponseType? responseType,

    BigInt? cost,

    List<int>? stateProof,
  }) {
    return HederaResponseHeader(
      nodeTransactionPrecheckCode:
          nodeTransactionPrecheckCode ?? this.nodeTransactionPrecheckCode,
      responseType: responseType ?? this.responseType,
      cost: cost ?? this.cost,
      stateProof: stateProof ?? this.stateProof,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'nodeTransactionPrecheckCode': config.encodeEnum(
        nodeTransactionPrecheckCode,
      ),
      'responseType': config.encodeEnum(responseType),
      'cost': config.encodeBigint(cost),
      'stateProof': config.encodeBinary(stateProof),
    };
  }

  factory HederaResponseHeader.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaResponseHeader(
      nodeTransactionPrecheckCode: json
          .valueTo<proto_response_code.HederaResponseCodeEnum?, Object?>(
            key: 'nodeTransactionPrecheckCode',
            parse: (v) => proto_response_code.HederaResponseCodeEnum.from(v),
          ),
      responseType: json
          .valueTo<proto_query_header.HederaResponseType?, Object?>(
            key: 'responseType',
            parse: (v) => proto_query_header.HederaResponseType.from(v),
          ),
      cost: json.valueAsBigInt<BigInt?>(
        'cost',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      stateProof: config.decodeBinary<List<int>?>(
        json.valueAs('stateProof', normalizeKeyLookup: config.normalizeKeys),
      ),
    );
  }

  factory HederaResponseHeader.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaResponseHeader(
      nodeTransactionPrecheckCode: decode
          .getEnum<proto_response_code.HederaResponseCodeEnum?>(
            1,
            proto_response_code.HederaResponseCodeEnum.values,
          ),
      responseType: decode.getEnum<proto_query_header.HederaResponseType?>(
        2,
        proto_query_header.HederaResponseType.values,
      ),
      cost: decode.getBigInt<BigInt?>(3),
      stateProof: decode.getBytes<List<int>?>(4),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoResponseHeader;
}
