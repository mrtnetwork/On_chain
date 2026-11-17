import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;
import "package:on_chain/hedera/src/proto_messages/proto/src/custom_fees.dart"
    as proto_custom_fees;

/// *
///  * # Fee Schedule Update
///  * Transaction to update the fee schedule for a token. A token creator may
///  * wish to charge custom transaction fees for a token type, and if a
///  * `fee_schedule_key` is assigned, this transaction enables adding, removing,
///  * or updating those custom transaction fees.
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
///  * Update the custom fee schedule for a token type.
///  *
///  * The token MUST have a `fee_schedule_key` set and that key MUST NOT
///  * be an empty `KeyList`.&lt;br/&gt;
///  * The token `fee_schedule_key` MUST sign this transaction.&lt;br/&gt;
///  * The token MUST exist, MUST NOT be deleted, and MUST NOT be expired.&lt;br/&gt;
///  *
///  * If the custom_fees list is empty, clears the fee schedule or resolves to
///  * CUSTOM_SCHEDULE_ALREADY_HAS_NO_FEES if the fee schedule was already empty.
///  *
///  * ### Block Stream Effects
///  * None
class HederaTokenFeeScheduleUpdateTransactionBody extends HederaProtoMessage
    with Equality {
  /// *
  ///      * A token identifier.
  ///      * &lt;p&gt;
  ///      * This SHALL identify the token type to modify with an updated
  ///      * custom fee schedule.&lt;br/&gt;
  ///      * The identified token MUST exist, and MUST NOT be deleted.
  final proto_basic_types.HederaTokenID? tokenId;

  /// *
  ///      * A list of custom fees representing a fee schedule.
  ///      * &lt;p&gt;
  ///      * This list MAY be empty to remove custom fees from a token.&lt;br/&gt;
  ///      * If the identified token is a non-fungible/unique type, the entries
  ///      * in this list MUST NOT declare a `fractional_fee`.&lt;br/&gt;
  ///      * If the identified token is a fungible/common type, the entries in this
  ///      * list MUST NOT declare a `royalty_fee`.&lt;br/&gt;
  ///      * Any token type MAY include entries that declare a `fixed_fee`.
  final List<proto_custom_fees.HederaCustomFee> customFees;

  const HederaTokenFeeScheduleUpdateTransactionBody({
    this.tokenId,
    this.customFees = const [],
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
  List<Object?> get protoValues => [tokenId, customFees];

  HederaTokenFeeScheduleUpdateTransactionBody copyWith({
    proto_basic_types.HederaTokenID? tokenId,

    List<proto_custom_fees.HederaCustomFee>? customFees,
  }) {
    return HederaTokenFeeScheduleUpdateTransactionBody(
      tokenId: tokenId ?? this.tokenId,
      customFees: customFees ?? this.customFees,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'token_id': config.encodeMessage(tokenId),
      'custom_fees': customFees.map((e) => config.encodeMessage(e)).toList(),
    };
  }

  factory HederaTokenFeeScheduleUpdateTransactionBody.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaTokenFeeScheduleUpdateTransactionBody(
      tokenId: json.valueTo<proto_basic_types.HederaTokenID?, Object>(
        key: 'token_id',
        parse:
            (v) => proto_basic_types.HederaTokenID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      customFees:
          (json.valueEnsureAsList<dynamic>(
                'custom_fees',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<
                  proto_custom_fees.HederaCustomFee,
                  Object
                >(
                  value: e,
                  parse:
                      (v) => proto_custom_fees.HederaCustomFee.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory HederaTokenFeeScheduleUpdateTransactionBody.deserialize(
    List<int> bytes,
  ) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTokenFeeScheduleUpdateTransactionBody(
      tokenId: decode.messageTo<proto_basic_types.HederaTokenID?>(
        1,
        (b) => proto_basic_types.HederaTokenID.deserialize(b),
      ),
      customFees:
          decode
              .getListOfBytes(2)
              .map((b) => proto_custom_fees.HederaCustomFee.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoTokenFeeScheduleUpdateTransactionBody;
}
