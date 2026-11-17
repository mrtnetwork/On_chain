import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/query_header.dart"
    as proto_query_header;
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;
import "package:on_chain/hedera/src/proto_messages/proto/src/response_header.dart"
    as proto_response_header;
import "package:on_chain/hedera/src/proto_messages/proto/src/contract_types.dart"
    as proto_contract_types;
import "package:on_chain/hedera/src/proto_messages/proto/src/query.dart"
    as proto_query;

/// *
///  * # Local Contract Call
///  * A Contract Call executed directly on the current node
///  * (that is, without consensus).
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in
///  * [RFC2119](https://www.ietf.org/rfc/rfc2119) and clarified in
///  * [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.contract"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * Call a view function of a given smart contract&lt;br/&gt;
///  * The call must provide function parameter inputs as needed.&lt;br/&gt;
///  * This is potentially useful for calling view functions that will not revert
///  * when executed in a static EVM context. Many such use cases will be better
///  * served by using a Mirror Node API, however.
///  *
///  * This is performed locally on the particular node that the client is
///  * communicating with. Executing the call locally is faster and less costly,
///  * but imposes certain restrictions.&lt;br/&gt;
///  * The call MUST NOT change the state of the contract instance. This also
///  * precludes any expenditure or transfer of HBAR or other tokens.&lt;br/&gt;
///  * The call SHALL NOT have a separate consensus timestamp.&lt;br/&gt;
///  * The call SHALL NOT generate a record nor a receipt.&lt;br/&gt;
///  * The response SHALL contain the output returned by the function call.&lt;br/&gt;
///  * Any contract call that would use the `STATICCALL` opcode MAY be called via
///  * contract call local with performance and cost benefits.
///  *
///  * Unlike a ContractCall transaction, the node SHALL always consume the
///  * _entire_ amount of offered "gas" in determining the fee for this query, so
///  * accurate gas estimation is important.
class HederaContractCallLocalQuery extends HederaProtoMessage
    with Equality, IHederaQuery<HederaContractCallLocalResponse> {
  /// *
  ///      * Standard information sent with every query operation.&lt;br/&gt;
  ///      * This includes the signed payment and what kind of response is requested
  ///      * (cost, state proof, both, or neither).
  ///      * &lt;p&gt;
  ///      * The payment MUST be sufficient for the base fees _and_ the full amount
  ///      * in the `gas` field.
  @override
  final proto_query_header.HederaQueryHeader? header;

  /// *
  ///      * The ID of a smart contract to call.
  final proto_basic_types.HederaContractID? contractID;

  /// *
  ///      * The amount of "gas" to use for this call.
  ///      * &lt;p&gt;
  ///      * This transaction SHALL consume all of the gas offered and charge the
  ///      * corresponding fee according to the current exchange rate between
  ///      * HBAR and "gas".
  final BigInt? gas;

  /// *
  ///      * The smart contract function to call, and the parameters to pass to that
  ///      * function.
  ///      * &lt;p&gt;
  ///      * These SHALL be presented in EVM bytecode function call format.
  final List<int>? functionParameters;

  /// *
  ///      * Do not use this field; it is ignored in the current software.
  ///      * &lt;p&gt;
  ///      * The maximum number of bytes that the result might include.&lt;br/&gt;
  ///      * The call will fail if it would have returned more than this number
  ///      * of bytes.
  final BigInt? maxResultSize;

  /// *
  ///      * The account that is the "sender" for this contract call.
  ///      * &lt;p&gt;
  ///      * If this is not set it SHALL be interpreted as the accountId from the
  ///      * associated transactionId.&lt;br/&gt;
  ///      * If this is set then either the associated transaction or the foreign
  ///      * transaction data MUST be signed by the referenced account.
  final proto_basic_types.HederaAccountID? senderId;

  const HederaContractCallLocalQuery({
    this.header,
    this.contractID,
    this.gas,
    this.functionParameters,
    this.maxResultSize,
    this.senderId,
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
        ProtoFieldConfig.int64(3),
        ProtoFieldConfig.bytes(4),
        ProtoFieldConfig.int64(
          5,
          options: [ProtoOptionBool(name: "deprecated", value: true)],
        ),
        ProtoFieldConfig.message(6),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    header,
    contractID,
    gas,
    functionParameters,
    maxResultSize,
    senderId,
  ];

  @override
  HederaContractCallLocalQuery copyWith({
    proto_query_header.HederaQueryHeader? header,

    proto_basic_types.HederaContractID? contractID,

    BigInt? gas,

    List<int>? functionParameters,

    BigInt? maxResultSize,

    proto_basic_types.HederaAccountID? senderId,
  }) {
    return HederaContractCallLocalQuery(
      header: header ?? this.header,
      contractID: contractID ?? this.contractID,
      gas: gas ?? this.gas,
      functionParameters: functionParameters ?? this.functionParameters,
      maxResultSize: maxResultSize ?? this.maxResultSize,
      senderId: senderId ?? this.senderId,
    );
  }

  @override
  proto_query.HederaQuery toQueryRequest({
    proto_query_header.HederaQueryHeader? header,
  }) => proto_query.HederaQuery(contractCallLocal: copyWith(header: header));
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'header': config.encodeMessage(header),
      'contractID': config.encodeMessage(contractID),
      'gas': config.encodeBigint(gas),
      'functionParameters': config.encodeBinary(functionParameters),
      'maxResultSize': config.encodeBigint(maxResultSize),
      'sender_id': config.encodeMessage(senderId),
    };
  }

  factory HederaContractCallLocalQuery.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaContractCallLocalQuery(
      header: json.valueTo<proto_query_header.HederaQueryHeader?, Object>(
        key: 'header',
        parse:
            (v) => proto_query_header.HederaQueryHeader.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      contractID: json.valueTo<proto_basic_types.HederaContractID?, Object>(
        key: 'contractID',
        parse:
            (v) => proto_basic_types.HederaContractID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      gas: json.valueAsBigInt<BigInt?>(
        'gas',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      functionParameters: config.decodeBinary<List<int>?>(
        json.valueAs(
          'functionParameters',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      maxResultSize: json.valueAsBigInt<BigInt?>(
        'maxResultSize',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      senderId: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'sender_id',
        parse:
            (v) => proto_basic_types.HederaAccountID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaContractCallLocalQuery.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaContractCallLocalQuery(
      header: decode.messageTo<proto_query_header.HederaQueryHeader?>(
        1,
        (b) => proto_query_header.HederaQueryHeader.deserialize(b),
      ),
      contractID: decode.messageTo<proto_basic_types.HederaContractID?>(
        2,
        (b) => proto_basic_types.HederaContractID.deserialize(b),
      ),
      gas: decode.getBigInt<BigInt?>(3),
      functionParameters: decode.getBytes<List<int>?>(4),
      maxResultSize: decode.getBigInt<BigInt?>(5),
      senderId: decode.messageTo<proto_basic_types.HederaAccountID?>(
        6,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoContractCallLocalQuery;
}

/// *
///  * The response returned by a `ContractCallLocalQuery` transaction.
class HederaContractCallLocalResponse extends HederaProtoMessage
    with Equality, IHederaQueryRespone {
  /// *
  ///      * The standard response information for queries.&lt;br/&gt;
  ///      * This includes the values requested in the `QueryHeader`
  ///      * (cost, state proof, both, or neither).
  @override
  final proto_response_header.HederaResponseHeader? header;

  /// *
  ///      * The result(s) returned by the function call, if successful.
  ///      * &lt;p&gt;
  ///      * If the call failed this value SHALL be unset.
  final proto_contract_types.HederaContractFunctionResult? functionResult;

  const HederaContractCallLocalResponse({this.header, this.functionResult});

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
  List<Object?> get protoValues => [header, functionResult];

  HederaContractCallLocalResponse copyWith({
    proto_response_header.HederaResponseHeader? header,

    proto_contract_types.HederaContractFunctionResult? functionResult,
  }) {
    return HederaContractCallLocalResponse(
      header: header ?? this.header,
      functionResult: functionResult ?? this.functionResult,
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
      'functionResult': config.encodeMessage(functionResult),
    };
  }

  factory HederaContractCallLocalResponse.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaContractCallLocalResponse(
      header: json.valueTo<proto_response_header.HederaResponseHeader?, Object>(
        key: 'header',
        parse:
            (v) => proto_response_header.HederaResponseHeader.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      functionResult: json
          .valueTo<proto_contract_types.HederaContractFunctionResult?, Object>(
            key: 'functionResult',
            parse:
                (v) =>
                    proto_contract_types.HederaContractFunctionResult.fromJson(
                      JsonParser.valueAs(v),
                      config: config,
                    ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
    );
  }

  factory HederaContractCallLocalResponse.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaContractCallLocalResponse(
      header: decode.messageTo<proto_response_header.HederaResponseHeader?>(
        1,
        (b) => proto_response_header.HederaResponseHeader.deserialize(b),
      ),
      functionResult: decode.messageTo<
        proto_contract_types.HederaContractFunctionResult?
      >(
        2,
        (b) => proto_contract_types.HederaContractFunctionResult.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoContractCallLocalResponse;
}
