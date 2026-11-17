import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;

/// *
///  * # Token Grant KYC
///  * Grant "KYC" status to an account with respect to a token.
///  *
///  * The "KYC' property is named for the "Know Your Customer" requirements in
///  * US federal regulations (FINRA 2090 and related US Code) that was subsequently
///  * incorporated into laws and regulations for many worldwide jurisdictions.
///  * The process requires a regulated financial entity to positively identify
///  * customers and certain other entities.
///  *
///  * This transaction enables a token administrator to track whether KYC
///  * requirements are met for a given account transacting in that token.
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
///  * Grant "Know Your Customer"(KYC) for one account for a single token.
///  *
///  * This transaction MUST be signed by the `kyc_key` for the token.&lt;br/&gt;
///  * The identified token MUST have a `kyc_key` set to a valid `Key` value.&lt;br/&gt;
///  * The token `kyc_key` MUST NOT be an empty `KeyList`.&lt;br/&gt;
///  * The identified token MUST exist and MUST NOT be deleted.&lt;br/&gt;
///  * The identified account MUST exist and MUST NOT be deleted.&lt;br/&gt;
///  * The identified account MUST have an association to the identified token.&lt;br/&gt;
///  * On success the association between the identified account and the identified
///  * token SHALL be marked as "KYC granted".
///  *
///  * ### Block Stream Effects
///  * None
class HederaTokenGrantKycTransactionBody extends HederaProtoMessage
    with Equality {
  /// *
  ///      * A token identifier.
  ///      * &lt;p&gt;
  ///      * The identified token SHALL grant "KYC" for the account
  ///      * identified by the `account` field.&lt;br/&gt;
  ///      * The identified token MUST be associated to the account identified
  ///      * by the `account` field.
  final proto_basic_types.HederaTokenID? token;

  /// *
  ///      * An account identifier.
  ///      * &lt;p&gt;
  ///      * The token identified by the `token` field SHALL grant "KYC" for the
  ///      * identified account.&lt;br/&gt;
  ///      * This account MUST be associated to the token identified
  ///      * by the `token` field.
  final proto_basic_types.HederaAccountID? account;

  const HederaTokenGrantKycTransactionBody({this.token, this.account});

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
  List<Object?> get protoValues => [token, account];

  HederaTokenGrantKycTransactionBody copyWith({
    proto_basic_types.HederaTokenID? token,

    proto_basic_types.HederaAccountID? account,
  }) {
    return HederaTokenGrantKycTransactionBody(
      token: token ?? this.token,
      account: account ?? this.account,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'token': config.encodeMessage(token),
      'account': config.encodeMessage(account),
    };
  }

  factory HederaTokenGrantKycTransactionBody.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaTokenGrantKycTransactionBody(
      token: json.valueTo<proto_basic_types.HederaTokenID?, Object>(
        key: 'token',
        parse:
            (v) => proto_basic_types.HederaTokenID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      account: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'account',
        parse:
            (v) => proto_basic_types.HederaAccountID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaTokenGrantKycTransactionBody.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTokenGrantKycTransactionBody(
      token: decode.messageTo<proto_basic_types.HederaTokenID?>(
        1,
        (b) => proto_basic_types.HederaTokenID.deserialize(b),
      ),
      account: decode.messageTo<proto_basic_types.HederaAccountID?>(
        2,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoTokenGrantKycTransactionBody;
}
