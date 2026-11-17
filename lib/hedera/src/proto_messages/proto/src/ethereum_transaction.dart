import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;

/// *
///  * # Ethereum Call
///  * Make an Ethereum transaction "call" with all data in Ethereum formats,
///  * including the contract alias. Call data may be in the transaction,
///  * or stored within an Hedera File.&lt;br/&gt;
///  * The caller MAY offer additional gas above what is offered in the call
///  * data, but MAY be charged up to 80% of that value if the amount required
///  * is less than this "floor" amount.
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
///  * A transaction in Ethereum format.&lt;br/&gt;
///  * Make an Ethereum transaction "call" with all data in Ethereum formats,
///  * including the contract alias. Call data may be in the transaction, or
///  * stored within an Hedera File.
///  *
///  * The caller MAY offer additional gas above what is offered in the call data,
///  * but MAY be charged up to 80% of that value if the amount required is less
///  * than this "floor" amount.
///  *
///  * ### Block Stream Effects
///  * An `EthereumOutput` message SHALL be emitted for each transaction.
class HederaEthereumTransactionBody extends HederaProtoMessage with Equality {
  /// *
  ///      * The raw Ethereum transaction data.
  ///      * &lt;p&gt;
  ///      * This transaction MUST be RLP encoded.&lt;br/&gt;
  ///      * This SHALL be the complete transaction data unless the `call_data`
  ///      * field is set.&lt;br/&gt;
  ///      * If `call_data` is set, this field SHALL be modified to replace the
  ///      * `callData` element with the content of the referenced file.&lt;br/&gt;
  ///      * The transaction signature SHALL be validated after `callData` is
  ///      * complete, if necessary.
  final List<int>? ethereumData;

  /// *
  ///      * The `callData` for the Ethereum transaction.
  ///      * &lt;p&gt;
  ///      * If this field is set, the data in the `ethereum_data` field SHALL be
  ///      * re-written to replace the `callData` element with the contents of this
  ///      * file at time of execution.&lt;br/&gt;
  ///      * The Ethereum transaction MUST be "rehydrated" with this modified
  ///      * `callData` before signature validation MAY be performed.
  final proto_basic_types.HederaFileID? callData;

  /// *
  ///      * A maximum amount of "gas" offered to pay the Ethereum transaction costs.
  ///      * &lt;p&gt;
  ///      * This gas offered is in addition to any gas supplied with the Ethereum
  ///      * transaction as declared in the `ethereum_data`.&lt;br/&gt;
  ///      * In most circumstances the account with an alias matching the public
  ///      * key available from the Ethereum transaction signature offers sufficient
  ///      * gas to power the transaction, but in some cases it MAY be desirable
  ///      * for the account submitting this transaction to either supplement
  ///      * or entirely fund the transaction cost.&lt;br/&gt;
  ///      * The amount of gas offered here SHALL be used to pay for
  ///      * transaction costs _in excess_ of any gas offered within
  ///      * the Ethereum transaction.&lt;br/&gt;
  ///      * If the gas offered within the Ethereum transaction is sufficient
  ///      * for all costs, the gas offered in this field SHALL NOT be expended.&lt;br/&gt;
  ///      * Regardless of actual transaction cost, the payer for this transaction
  ///      * SHALL NOT be charged more gas than the amount offered here.&lt;br/&gt;
  ///      * If the sum of both gas amounts is not sufficient to pay for the
  ///      * transaction, the entire total amount of gas offered SHALL be expended,
  ///      * the transaction SHALL fail, and the response code `INSUFFICIENT_GAS`
  ///      * SHALL be set.&lt;br/&gt;
  ///      * If any amount of gas is charged to the payer of this transaction,
  ///      * at least 80% of the value offered in this field SHALL be charged
  ///      * as a minimum fee.&lt;br/&gt;
  ///      * If the amount of gas authorized in the Ethereum transaction data is `0`,
  ///      * then the payer of this transaction SHALL be charged the entire cost of
  ///      * the Ethereum transaction, subject to the limit set in this field.
  final BigInt? maxGasAllowance;

  const HederaEthereumTransactionBody({
    this.ethereumData,
    this.callData,
    this.maxGasAllowance,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.message(2),
        ProtoFieldConfig.int64(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [ethereumData, callData, maxGasAllowance];

  HederaEthereumTransactionBody copyWith({
    List<int>? ethereumData,

    proto_basic_types.HederaFileID? callData,

    BigInt? maxGasAllowance,
  }) {
    return HederaEthereumTransactionBody(
      ethereumData: ethereumData ?? this.ethereumData,
      callData: callData ?? this.callData,
      maxGasAllowance: maxGasAllowance ?? this.maxGasAllowance,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'ethereum_data': config.encodeBinary(ethereumData),
      'call_data': config.encodeMessage(callData),
      'max_gas_allowance': config.encodeBigint(maxGasAllowance),
    };
  }

  factory HederaEthereumTransactionBody.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaEthereumTransactionBody(
      ethereumData: config.decodeBinary<List<int>?>(
        json.valueAs('ethereum_data', normalizeKeyLookup: config.normalizeKeys),
      ),
      callData: json.valueTo<proto_basic_types.HederaFileID?, Object>(
        key: 'call_data',
        parse:
            (v) => proto_basic_types.HederaFileID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      maxGasAllowance: json.valueAsBigInt<BigInt?>(
        'max_gas_allowance',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaEthereumTransactionBody.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaEthereumTransactionBody(
      ethereumData: decode.getBytes<List<int>?>(1),
      callData: decode.messageTo<proto_basic_types.HederaFileID?>(
        2,
        (b) => proto_basic_types.HederaFileID.deserialize(b),
      ),
      maxGasAllowance: decode.getBigInt<BigInt?>(3),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoEthereumTransactionBody;
}
