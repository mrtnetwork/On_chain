import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/response_code.dart"
    as proto_response_code;

/// *
///  * # Transaction Response
///  * Message(s) sent in response to submitting a transaction.
///  * The response(s) detailed here SHALL only represent that the transaction
///  * was received and checked by the single node to which it was submitted.&lt;br/&gt;
///  * To obtain the result from _network consensus_, a client MUST submit a
///  * `getTransactionReceipts` query.
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
///  * A message sent by a node in response to a transaction submission.&lt;br/&gt;
///  * This message only acknowledges that the individual node has checked
///  * the transaction, completed pre-check, and checked the fee offered.
///  *
///  * If the transaction fee is not sufficient, the `nodeTransactionPrecheckCode`
///  * value SHALL be `INSUFFICIENT_TX_FEE` and the `cost` field SHALL be the
///  * actual transaction fee, in tinybar, required.&lt;br/&gt;
///  * If the client requires acknowledgement of the network consensus result
///  * for a transaction, the client SHOULD request a transaction receipt or
///  * detailed transaction record. A client MAY also obtain network consensus
///  * results from a mirror node.
class HederaTransactionResponse extends HederaProtoMessage with Equality {
  /// *
  ///      * A pre-consensus response code.
  ///      * &lt;p&gt;
  ///      * This response SHALL represent the response of the individual node, and
  ///      * SHALL NOT represent the consensus of the network.
  final proto_response_code.HederaResponseCodeEnum? nodeTransactionPrecheckCode;

  /// *
  ///      * An approximate transaction fee.
  ///      * &lt;p&gt;
  ///      * This value SHALL be `0` unless the `nodeTransactionPrecheckCode` is
  ///      * `INSUFFICIENT_TX_FEE`.&lt;br/&gt;
  ///      * This value SHOULD be an amount, in tinybar, that _would have_ succeeded
  ///      * at the time the transaction was submitted.&lt;br/&gt;
  ///      * Note that this amount is not guaranteed to succeed in a future
  ///      * transaction due to uncontrolled variables, such as network congestion,
  ///      * but should be considered a close approximation.
  final BigInt? cost;

  const HederaTransactionResponse({
    this.nodeTransactionPrecheckCode,
    this.cost,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.enumType(1), ProtoFieldConfig.uint64(2)],
    );
  }

  @override
  List<Object?> get protoValues => [nodeTransactionPrecheckCode, cost];

  HederaTransactionResponse copyWith({
    proto_response_code.HederaResponseCodeEnum? nodeTransactionPrecheckCode,

    BigInt? cost,
  }) {
    return HederaTransactionResponse(
      nodeTransactionPrecheckCode:
          nodeTransactionPrecheckCode ?? this.nodeTransactionPrecheckCode,
      cost: cost ?? this.cost,
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
      'cost': config.encodeBigint(cost),
    };
  }

  factory HederaTransactionResponse.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaTransactionResponse(
      nodeTransactionPrecheckCode: json
          .valueTo<proto_response_code.HederaResponseCodeEnum?, Object?>(
            key: 'nodeTransactionPrecheckCode',
            parse: (v) => proto_response_code.HederaResponseCodeEnum.from(v),
          ),
      cost: json.valueAsBigInt<BigInt?>(
        'cost',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaTransactionResponse.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTransactionResponse(
      nodeTransactionPrecheckCode: decode
          .getEnum<proto_response_code.HederaResponseCodeEnum?>(
            1,
            proto_response_code.HederaResponseCodeEnum.values,
          ),
      cost: decode.getBigInt<BigInt?>(2),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoTransactionResponse;
}
