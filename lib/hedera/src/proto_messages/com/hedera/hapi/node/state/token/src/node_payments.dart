import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/timestamp.dart"
    as proto_timestamp;
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;

/// *
///  * # Node Payments
///  * This is a Singleton that stores node fees accumulated in the current staking period.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in [RFC2119](https://www.ietf.org/rfc/rfc2119)
///  * and clarified in [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.state.token"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * A singleton state object that accumulates node fees for distribution&lt;br/&gt;
///  * This is used to record the total amount of fees due to each node for distribution in current staking period
class HederaNodePayments extends HederaProtoMessage with Equality {
  /// *
  ///   * The time when the last node fees were distributed
  final proto_timestamp.HederaTimestamp? lastNodeFeeDistributionTime;

  /// *
  ///    * A list of node account id to the total amount of fees due to each node in the current staking period
  final List<HederaNodePayment> payments;

  const HederaNodePayments({
    this.lastNodeFeeDistributionTime,
    this.payments = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
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
  List<Object?> get protoValues => [lastNodeFeeDistributionTime, payments];

  HederaNodePayments copyWith({
    proto_timestamp.HederaTimestamp? lastNodeFeeDistributionTime,

    List<HederaNodePayment>? payments,
  }) {
    return HederaNodePayments(
      lastNodeFeeDistributionTime:
          lastNodeFeeDistributionTime ?? this.lastNodeFeeDistributionTime,
      payments: payments ?? this.payments,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'last_node_fee_distribution_time': config.encodeMessage(
        lastNodeFeeDistributionTime,
      ),
      'payments': payments.map((e) => config.encodeMessage(e)).toList(),
    };
  }

  factory HederaNodePayments.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaNodePayments(
      lastNodeFeeDistributionTime: json
          .valueTo<proto_timestamp.HederaTimestamp?, Object>(
            key: 'last_node_fee_distribution_time',
            parse:
                (v) => proto_timestamp.HederaTimestamp.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      payments:
          (json.valueEnsureAsList<dynamic>(
                'payments',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<HederaNodePayment, Object>(
                  value: e,
                  parse:
                      (v) => HederaNodePayment.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory HederaNodePayments.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaNodePayments(
      lastNodeFeeDistributionTime: decode
          .messageTo<proto_timestamp.HederaTimestamp?>(
            1,
            (b) => proto_timestamp.HederaTimestamp.deserialize(b),
          ),
      payments:
          decode
              .getListOfBytes(2)
              .map((b) => HederaNodePayment.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiNodeStateTokenNodePayments;
}

/// *
///  * A record of the total amount of fees due to a node
class HederaNodePayment extends HederaProtoMessage with Equality {
  /// *
  ///    * The node account id
  final proto_basic_types.HederaAccountID? nodeAccountId;

  /// *
  ///    * The total amount of fees due to the node in tinybars
  final BigInt? fees;

  const HederaNodePayment({this.nodeAccountId, this.fees});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.message(1), ProtoFieldConfig.uint64(2)],
    );
  }

  @override
  List<Object?> get protoValues => [nodeAccountId, fees];

  HederaNodePayment copyWith({
    proto_basic_types.HederaAccountID? nodeAccountId,

    BigInt? fees,
  }) {
    return HederaNodePayment(
      nodeAccountId: nodeAccountId ?? this.nodeAccountId,
      fees: fees ?? this.fees,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'node_account_id': config.encodeMessage(nodeAccountId),
      'fees': config.encodeBigint(fees),
    };
  }

  factory HederaNodePayment.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaNodePayment(
      nodeAccountId: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'node_account_id',
        parse:
            (v) => proto_basic_types.HederaAccountID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      fees: json.valueAsBigInt<BigInt?>(
        'fees',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaNodePayment.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaNodePayment(
      nodeAccountId: decode.messageTo<proto_basic_types.HederaAccountID?>(
        1,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
      fees: decode.getBigInt<BigInt?>(2),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiNodeStateTokenNodePayment;
}
