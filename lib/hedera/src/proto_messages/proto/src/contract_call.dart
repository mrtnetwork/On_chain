import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart" as proto_basic_types;

/// *
///  * # Contract Call
///  * Transaction body for calls to a Smart Contract.
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
///  * Call a function of a given smart contract, providing function parameter
///  * inputs as needed.
///  *
///  * Resource ("gas") charges SHALL include all relevant fees incurred by the
///  * contract execution, including any storage required.&lt;br/&gt;
///  * The total transaction fee SHALL incorporate all of the "gas" actually
///  * consumed as well as the standard fees for transaction handling, data
///  * transfers, signature verification, etc...&lt;br/&gt;
///  * The response SHALL contain the output returned by the function call.
///  *
///  * ### Block Stream Effects
///  * A `CallContractOutput` message SHALL be emitted for each transaction.
class HederaContractCallTransactionBody extends HederaProtoMessage with Equality {
    /// *
  ///      * The ID of a smart contract to call.
  final proto_basic_types.HederaContractID? contractID;

    /// *
  ///      * A maximum limit to the amount of gas to use for this call.
  ///      * &lt;p&gt;
  ///      * The network SHALL charge the greater of the following, but
  ///      * SHALL NOT charge more than the value of this field.
  ///      * &lt;ol&gt;
  ///      *   &lt;li&gt;The actual gas consumed by the smart contract call.&lt;/li&gt;
  ///      *   &lt;li&gt;`80%` of this value.&lt;/li&gt;
  ///      * &lt;/ol&gt;
  ///      * The `80%` factor encourages reasonable estimation, while allowing for
  ///      * some overage to ensure successful execution.
  final BigInt? gas;

    /// *
  ///      * An amount of tinybar sent via this contract call.
  ///      * &lt;p&gt;
  ///      * If this is non-zero, the function MUST be `payable`.
  final BigInt? amount;

    /// *
  ///      * The smart contract function to call.
  ///      * &lt;p&gt;
  ///      * This MUST contain The application binary interface (ABI) encoding of the
  ///      * function call per the Ethereum contract ABI standard, giving the
  ///      * function signature and arguments being passed to the function.
  final List<int>? functionParameters;

  const HederaContractCallTransactionBody({
    this.contractID,
    this.gas,
    this.amount,
    this.functionParameters,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.int64(2),
        ProtoFieldConfig.int64(3),
        ProtoFieldConfig.bytes(4),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        contractID,
        gas,
        amount,
        functionParameters,
      ];


HederaContractCallTransactionBody copyWith(
{proto_basic_types.HederaContractID? contractID,

BigInt? gas,

BigInt? amount,

List<int>? functionParameters,

}) {
    return HederaContractCallTransactionBody(
contractID: contractID ?? this.contractID,
gas: gas ?? this.gas,
amount: amount ?? this.amount,
functionParameters: functionParameters ?? this.functionParameters,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'contractID': config.encodeMessage(contractID),
      'gas': config.encodeBigint(gas),
      'amount': config.encodeBigint(amount),
      'functionParameters': config.encodeBinary(functionParameters),
    };
  }


  factory HederaContractCallTransactionBody.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaContractCallTransactionBody(
      contractID: json.valueTo<proto_basic_types.HederaContractID?, Object>(
        key: 'contractID',
        parse: (v) => proto_basic_types.HederaContractID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      gas: json.valueAsBigInt<BigInt?>('gas', normalizeKeyLookup: config.normalizeKeys),
      amount: json.valueAsBigInt<BigInt?>('amount', normalizeKeyLookup: config.normalizeKeys),
      functionParameters: config.decodeBinary<List<int>?>(json.valueAs('functionParameters', normalizeKeyLookup: config.normalizeKeys)),
    );
  }

  factory HederaContractCallTransactionBody.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaContractCallTransactionBody(
      contractID: decode.messageTo<proto_basic_types.HederaContractID?>(1, (b) => proto_basic_types.HederaContractID.deserialize(b)),
      gas: decode.getBigInt<BigInt?>(2),
      amount: decode.getBigInt<BigInt?>(3),
      functionParameters: decode.getBytes<List<int>?>(4),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoContractCallTransactionBody;

}


