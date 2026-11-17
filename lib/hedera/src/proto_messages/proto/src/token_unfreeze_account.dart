import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;

/// *
///  * # Token Unfreeze
///  * Release a freeze on tokens of an identified type for an identified account.
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
///  * Resume transfers of a token type for an account.&lt;br/&gt;
///  * This releases previously frozen assets of one account with respect to
///  * one token type. Once unfrozen, that account can once again send or
///  * receive tokens of the identified type.
///  *
///  * The token MUST have a `freeze_key` set and that key MUST NOT
///  * be an empty `KeyList`.&lt;br/&gt;
///  * The token `freeze_key` MUST sign this transaction.&lt;br/&gt;
///  * The identified token MUST exist, MUST NOT be deleted, MUST NOT be paused,
///  * and MUST NOT be expired.&lt;br/&gt;
///  * The identified account MUST exist, MUST NOT be deleted, and
///  * MUST NOT be expired.&lt;br/&gt;
///  * If the identified account is not frozen with respect to the identified
///  * token, the transaction SHALL succeed, but no change SHALL be made.&lt;br/&gt;
///  * An association between the identified account and the identified
///  * token MUST exist.
///  *
///  * ### Block Stream Effects
///  * None
class HederaTokenUnfreezeAccountTransactionBody extends HederaProtoMessage
    with Equality {
  /// *
  ///      * A token identifier.
  ///      * &lt;p&gt;
  ///      * This SHALL identify the token type to "unfreeze".&lt;br/&gt;
  ///      * The identified token MUST exist, MUST NOT be deleted, and MUST be
  ///      * associated to the identified account.
  final proto_basic_types.HederaTokenID? token;

  /// *
  ///      * An account identifier.
  ///      * &lt;p&gt;
  ///      * This shall identify the account to "unfreeze".&lt;br/&gt;
  ///      * The identified account MUST exist, MUST NOT be deleted, MUST NOT be
  ///      * expired, and MUST be associated to the identified token.&lt;br/&gt;
  ///      * The identified account SHOULD be "frozen" with respect to the
  ///      * identified token.
  final proto_basic_types.HederaAccountID? account;

  const HederaTokenUnfreezeAccountTransactionBody({this.token, this.account});

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

  HederaTokenUnfreezeAccountTransactionBody copyWith({
    proto_basic_types.HederaTokenID? token,

    proto_basic_types.HederaAccountID? account,
  }) {
    return HederaTokenUnfreezeAccountTransactionBody(
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

  factory HederaTokenUnfreezeAccountTransactionBody.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaTokenUnfreezeAccountTransactionBody(
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

  factory HederaTokenUnfreezeAccountTransactionBody.deserialize(
    List<int> bytes,
  ) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTokenUnfreezeAccountTransactionBody(
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
      DefaultHederaProtoTypeUrl.protoTokenUnfreezeAccountTransactionBody;
}
