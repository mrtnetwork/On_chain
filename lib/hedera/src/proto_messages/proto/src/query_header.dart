import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/transaction.dart"
    as proto_transaction;

/// *
///  * # Query Header
///  * Messages that comprise a header sent with each query request.
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
///  * The type of query response.&lt;br/&gt;
///  *
///  * This SHALL be answer-only as a default.&lt;br/&gt;
///  * This value SHALL support an "estimated cost" type.&lt;br/&gt;
///  * This value SHOULD support a "state proof" type, when available.
enum HederaResponseType implements ProtoEnumVariant {
  /// *
  ///      * A response with the query answer.
  answerOnly(0, 'ANSWER_ONLY'),

  /// *
  ///      * A response with both the query answer and a state proof.
  answerStateProof(1, 'ANSWER_STATE_PROOF'),

  /// *
  ///      * A response with the estimated cost to answer the query.
  costAnswer(2, 'COST_ANSWER'),

  /// *
  ///      * A response with the estimated cost to answer and a state proof.
  costAnswerStateProof(3, 'COST_ANSWER_STATE_PROOF');

  const HederaResponseType(this.value, this.protoName);

  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static HederaResponseType fromValue(int? value) {
    value ??= 0;
    return HederaResponseType.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching HederaResponseType found for the given value. $value",
                details: {
                  "name": "HederaResponseType",
                  "value": value?.toString(),
                },
              ),
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static HederaResponseType from(Object? value) {
    value ??= 0;
    return HederaResponseType.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching HederaResponseType found for the given value. $value",
                details: {
                  "name": "HederaResponseType",
                  "value": value?.toString(),
                },
              ),
    );
  }
}

/// *
///  * A standard query header.&lt;br/&gt;
///  * Each query from the client to the node must contain a QueryHeader, which
///  * specifies the desired response type, and includes a payment transaction
///  * that will compensate the network for responding to the query.
///  * The payment may be blank if the query is free.
///  *
///  * The payment transaction MUST be a `cryptoTransfer` from the payer account
///  * to the account of the node where the query is submitted.&lt;br/&gt;
///  * If the payment is sufficient, the network SHALL respond with the response
///  * type requested.&lt;br/&gt;
///  * If the response type is `COST_ANSWER` the payment MUST be unset.
///  * A state proof SHALL be available for some types of information.&lt;br/&gt;
///  * A state proof SHALL be available for a Record, but not a receipt, and the
///  * response entry for each supported "get info" query.
class HederaQueryHeader extends HederaProtoMessage with Equality {
  /// *
  ///      * A signed `CryptoTransferTransaction` to pay query fees.
  ///      * &lt;p&gt;
  ///      * This MUST transfer HBAR from the "payer" to the responding node account
  ///      * sufficient to pay the query fees.
  final proto_transaction.HederaTransaction? payment;

  /// *
  ///      * A type of query response requested.
  final HederaResponseType? responseType;

  const HederaQueryHeader({this.payment, this.responseType});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.message(1), ProtoFieldConfig.enumType(2)],
    );
  }

  @override
  List<Object?> get protoValues => [payment, responseType];

  HederaQueryHeader copyWith({
    proto_transaction.HederaTransaction? payment,

    HederaResponseType? responseType,
  }) {
    return HederaQueryHeader(
      payment: payment ?? this.payment,
      responseType: responseType ?? this.responseType,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'payment': config.encodeMessage(payment),
      'responseType': config.encodeEnum(responseType),
    };
  }

  factory HederaQueryHeader.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaQueryHeader(
      payment: json.valueTo<proto_transaction.HederaTransaction?, Object>(
        key: 'payment',
        parse:
            (v) => proto_transaction.HederaTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      responseType: json.valueTo<HederaResponseType?, Object?>(
        key: 'responseType',
        parse: (v) => HederaResponseType.from(v),
      ),
    );
  }

  factory HederaQueryHeader.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaQueryHeader(
      payment: decode.messageTo<proto_transaction.HederaTransaction?>(
        1,
        (b) => proto_transaction.HederaTransaction.deserialize(b),
      ),
      responseType: decode.getEnum<HederaResponseType?>(
        2,
        HederaResponseType.values,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoQueryHeader;
}
