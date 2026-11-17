import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart" as proto_basic_types;

/// *
///  * # Token Associate
///  * Transaction to associate an Hedera Token Service (HTS) token with an
///  * account.&lt;br/&gt;
///  * Accounts cannot transact in a token (send or receive) until the account
///  * and token are associated.
///  *
///  * &gt; Note
///  * &gt;&gt; An "airdrop" transaction MAY initiate sending tokens to an
///  * &gt;&gt; unassociated account, but the transfer remains in a "pending"
///  * &gt;&gt; state until the recipient executes a "claim" transaction
///  * &gt;&gt; that both accepts the tokens and associates that account
///  * &gt;&gt; with the token type.
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
///  * Associate an Hedera Token Service (HTS) token and an account.
///  *
///  * An association MUST exist between an account and a token before that
///  * account may transfer or receive that token.&lt;br/&gt;
///  * If the identified account is not found,
///  * the transaction SHALL return `INVALID_ACCOUNT_ID`.&lt;br/&gt;
///  * If the identified account has been deleted,
///  * the transaction SHALL return `ACCOUNT_DELETED`.&lt;br/&gt;
///  * If any of the identified tokens is not found,
///  * the transaction SHALL return `INVALID_TOKEN_REF`.&lt;br/&gt;
///  * If any of the identified tokens has been deleted,
///  * the transaction SHALL return `TOKEN_WAS_DELETED`.&lt;br/&gt;
///  * If an association already exists for any of the identified tokens,
///  * the transaction SHALL return `TOKEN_ALREADY_ASSOCIATED_TO_ACCOUNT`.&lt;br/&gt;
///  * The identified account MUST sign this transaction.
///  *
///  * ### Block Stream Effects
///  * None
class HederaTokenAssociateTransactionBody extends HederaProtoMessage with Equality {
    /// *
  ///      * An account identifier.
  ///      * &lt;p&gt;
  ///      * The identified account SHALL be associated to each of the
  ///      * tokens identified in the `tokens` field.&lt;br/&gt;
  ///      * This field is REQUIRED and MUST be a valid account identifier.&lt;br/&gt;
  ///      * The identified account MUST exist in state.&lt;br/&gt;
  ///      * The identified account MUST NOT be deleted.&lt;br/&gt;
  ///      * The identified account MUST NOT be expired.
  final proto_basic_types.HederaAccountID? account;

    /// *
  ///      * A list of token identifiers.
  ///      * &lt;p&gt;
  ///      * Each token identified in this list SHALL be separately associated with
  ///      * the account identified in the `account` field.&lt;br/&gt;
  ///      * This list MUST NOT be empty.
  ///      * Each entry in this list MUST be a valid token identifier.&lt;br/&gt;
  ///      * Each entry in this list MUST NOT be currently associated to the
  ///      * account identified in `account`.&lt;br/&gt;
  ///      * Each entry in this list MUST NOT be expired.&lt;br/&gt;
  ///      * Each entry in this list MUST NOT be deleted.
  final List<proto_basic_types.HederaTokenID> tokens;

  const HederaTokenAssociateTransactionBody({
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


HederaTokenAssociateTransactionBody copyWith(
{proto_basic_types.HederaAccountID? account,

List<proto_basic_types.HederaTokenID>? tokens,

}) {
    return HederaTokenAssociateTransactionBody(
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


  factory HederaTokenAssociateTransactionBody.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaTokenAssociateTransactionBody(
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

  factory HederaTokenAssociateTransactionBody.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTokenAssociateTransactionBody(
      account: decode.messageTo<proto_basic_types.HederaAccountID?>(1, (b) => proto_basic_types.HederaAccountID.deserialize(b)),
      tokens: decode.getListOfBytes(2).map((b) => proto_basic_types.HederaTokenID.deserialize(b)).toList(),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoTokenAssociateTransactionBody;

}


