import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart" as proto_basic_types;

/// *
///  * # Token Dissociate
///  * Remove association between an account and one or more Hedera Token
///  * Service (HTS) tokens.
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
///  * Dissociate an account from one or more HTS tokens.
///  *
///  * If the identified account is not found,
///  * the transaction SHALL return `INVALID_ACCOUNT_ID`.&lt;br/&gt;
///  * If the identified account has been deleted,
///  * the transaction SHALL return `ACCOUNT_DELETED`.&lt;br/&gt;
///  * If any of the identified tokens is not found,
///  * the transaction SHALL return `INVALID_TOKEN_REF`.&lt;br/&gt;
///  * If any of the identified tokens has been deleted,
///  * the transaction SHALL return `TOKEN_WAS_DELETED`.&lt;br/&gt;
///  * If an association does not exist for any of the identified tokens,
///  * the transaction SHALL return `TOKEN_NOT_ASSOCIATED_TO_ACCOUNT`.&lt;br/&gt;
///  * If the identified account has a nonzero balance for any of the identified
///  * tokens, and that token is neither deleted nor expired, the
///  * transaction SHALL return `TRANSACTION_REQUIRES_ZERO_TOKEN_BALANCES`.&lt;br/&gt;
///  * If one of the identified tokens is a fungible/common token that is expired,
///  * the account MAY disassociate from that token, even if that token balance is
///  * not zero for that account.&lt;br/&gt;
///  * If one of the identified tokens is a non-fungible/unique token that is
///  * expired, the account MUST NOT disassociate if that account holds any
///  * individual NFT of that token. In this situation the transaction SHALL
///  * return `TRANSACTION_REQUIRED_ZERO_TOKEN_BALANCES`.&lt;br/&gt;
///  * The identified account MUST sign this transaction.
///  *
///  * ### Block Stream Effects
///  * None
class HederaTokenDissociateTransactionBody extends HederaProtoMessage with Equality {
    /// *
  ///      * An account identifier.
  ///      * &lt;p&gt;
  ///      * The identified account SHALL be dissociated from each of the
  ///      * tokens identified in the `tokens` field.
  ///      * This field is REQUIRED and MUST be a valid account identifier.&lt;br/&gt;
  ///      * The identified account MUST exist in state.&lt;br/&gt;
  ///      * The identified account MUST NOT be deleted.&lt;br/&gt;
  ///      * The identified account MUST NOT be expired.
  final proto_basic_types.HederaAccountID? account;

    /// *
  ///      * A list of token identifiers.
  ///      * &lt;p&gt;
  ///      * Each token identified in this list SHALL be dissociated from
  ///      * the account identified in the `account` field.&lt;br/&gt;
  ///      * This list MUST NOT be empty.
  ///      * Each entry in this list MUST be a valid token identifier.&lt;br/&gt;
  ///      * Each entry in this list MUST be currently associated to the
  ///      * account identified in `account`.&lt;br/&gt;
  ///      * Entries in this list MAY be expired, if the token type is
  ///      * fungible/common.&lt;br/&gt;
  ///      * Each entry in this list MUST NOT be deleted.
  final List<proto_basic_types.HederaTokenID> tokens;

  const HederaTokenDissociateTransactionBody({
    this.account,
    this.tokens = const [],
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
  List<Object?> get protoValues => [
        account,
        tokens,
      ];


HederaTokenDissociateTransactionBody copyWith(
{proto_basic_types.HederaAccountID? account,

List<proto_basic_types.HederaTokenID>? tokens,

}) {
    return HederaTokenDissociateTransactionBody(
account: account ?? this.account,
tokens: tokens ?? this.tokens,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'account': config.encodeMessage(account),
      'tokens': tokens.map((e) => config.encodeMessage(e)).toList(),
    };
  }


  factory HederaTokenDissociateTransactionBody.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaTokenDissociateTransactionBody(
      account: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'account',
        parse: (v) => proto_basic_types.HederaAccountID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      tokens: (json.valueEnsureAsList<dynamic>('tokens', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<proto_basic_types.HederaTokenID, Object>(
          value: e,
          parse: (v) => proto_basic_types.HederaTokenID.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
    );
  }

  factory HederaTokenDissociateTransactionBody.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTokenDissociateTransactionBody(
      account: decode.messageTo<proto_basic_types.HederaAccountID?>(1, (b) => proto_basic_types.HederaAccountID.deserialize(b)),
      tokens: decode.getListOfBytes(2).map((b) => proto_basic_types.HederaTokenID.deserialize(b)).toList(),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoTokenDissociateTransactionBody;

}


