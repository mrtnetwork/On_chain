import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart" as proto_basic_types;

/// *
///  * # Token Wipe Account
///  * Administratively burn tokens owned by a single, non-treasury, account.
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
///  * Wipe (administratively burn) tokens held by a non-treasury account.&lt;br/&gt;
///  * On success, the requested tokens will be removed from the identified account
///  * and the token supply will be reduced by the amount "wiped".
///  *
///  * This transaction MUST be signed by the token `wipe_key`.&lt;br/&gt;
///  * The identified token MUST exist, MUST NOT be deleted,
///  * and MUST NOT be paused.&lt;br/&gt;
///  * The identified token MUST have a valid `Key` set for the `wipe_key` field,
///  * and that key MUST NOT be an empty `KeyList`.&lt;br/&gt;
///  * The identified account MUST exist, MUST NOT be deleted, MUST be
///  * associated to the identified token, MUST NOT be frozen for the identified
///  * token, MUST NOT be the token `treasury`, and MUST hold a balance for the
///  * token or the specific serial numbers provided.&lt;br/&gt;
///  * This transaction SHOULD provide a value for `amount` or `serialNumbers`,
///  * but MUST NOT set both fields.
///  *
///  * ### Block Stream Effects
///  * The new total supply for the wiped token type SHALL be recorded.
class HederaTokenWipeAccountTransactionBody extends HederaProtoMessage with Equality {
    /// *
  ///      * A token identifier.
  ///      * &lt;p&gt;
  ///      * This field is REQUIRED.&lt;br/&gt;
  ///      * The identified token MUST exist, MUST NOT be paused, MUST NOT be
  ///      * deleted, and MUST NOT be expired.
  final proto_basic_types.HederaTokenID? token;

    /// *
  ///      * An account identifier.&lt;br/&gt;
  ///      * This identifies the account from which tokens will be wiped.
  ///      * &lt;p&gt;
  ///      * This field is REQUIRED.&lt;br/&gt;
  ///      * The identified account MUST NOT be deleted or expired.&lt;br/&gt;
  ///      * If the identified token `kyc_key` is set to a valid key, the
  ///      * identified account MUST have "KYC" granted.&lt;br/&gt;
  ///      * The identified account MUST NOT be the `treasury` account for the
  ///      * identified token.
  final proto_basic_types.HederaAccountID? account;

    /// *
  ///      * An amount of fungible/common tokens to wipe.
  ///      * &lt;p&gt;
  ///      * If the identified token is a non-fungible/unique token type,
  ///      * this value MUST be exactly zero(`0`).&lt;br/&gt;
  ///      * If the identified token type is fungible/common:
  ///      * &lt;ul&gt;
  ///      *   &lt;li&gt;This value SHALL be specified in units of the smallest
  ///      *       denomination possible for the identified token
  ///      *       (&lt;tt&gt;10&lt;sup&gt;-decimals&lt;/sup&gt;&lt;/tt&gt; whole tokens).&lt;/li&gt;
  ///      *   &lt;li&gt;This value MUST be strictly less than `Long.MAX_VALUE`.&lt;/li&gt;
  ///      *   &lt;li&gt;This value MUST be less than or equal to the current total
  ///      *       supply for the identified token.&lt;/li&gt;
  ///      *   &lt;li&gt;This value MUST be less than or equal to the current balance
  ///      *       held by the identified account.&lt;/li&gt;
  ///      *   &lt;li&gt;This value MAY be zero(`0`).&lt;/li&gt;
  ///      * &lt;/ul&gt;
  final BigInt? amount;

    /// *
  ///      * A list of serial numbers to wipe.&lt;br/&gt;
  ///      * The non-fungible/unique tokens with these serial numbers will be
  ///      * destroyed and cannot be recovered or reused.
  ///      * &lt;p&gt;
  ///      * If the identified token type is a fungible/common type, this
  ///      * list MUST be empty.&lt;br/&gt;
  ///      * If the identified token type is non-fungible/unique:
  ///      * &lt;ul&gt;
  ///      *   &lt;li&gt;This list MUST contain at least one entry if the identified token
  ///      *       type is non-fungible/unique.&gt;/li&gt;
  ///      *   &lt;li&gt;This list MUST NOT contain more entries than the current total
  ///      *       supply for the identified token.&lt;/li&gt;
  ///      *   &lt;li&gt;Every entry in this list MUST be a valid serial number for the
  ///      *       identified token (i.e. "collection").&lt;/li&gt;
  ///      *   &lt;li&gt;Every entry in this list MUST be owned by the
  ///      *       identified account&lt;/li&gt;
  ///      *   &lt;li&gt;&lt;/li&gt;
  ///      * &lt;/ul&gt;
  ///      * This list MUST NOT contain more entries than the network configuration
  ///      * value for batch size limit, typically ten(`10`).
  final List<BigInt> serialNumbers;

  const HederaTokenWipeAccountTransactionBody({
    this.token,
    this.account,
    this.amount,
    this.serialNumbers = const [],
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
        ProtoFieldConfig.uint64(3),
        ProtoFieldConfig.repeated(
          fieldNumber: 4,
          elementType: ProtoFieldType.int64,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        token,
        account,
        amount,
        serialNumbers,
      ];


HederaTokenWipeAccountTransactionBody copyWith(
{proto_basic_types.HederaTokenID? token,

proto_basic_types.HederaAccountID? account,

BigInt? amount,

List<BigInt>? serialNumbers,

}) {
    return HederaTokenWipeAccountTransactionBody(
token: token ?? this.token,
account: account ?? this.account,
amount: amount ?? this.amount,
serialNumbers: serialNumbers ?? this.serialNumbers,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'token': config.encodeMessage(token),
      'account': config.encodeMessage(account),
      'amount': config.encodeBigint(amount),
      'serialNumbers': serialNumbers.map((e) => config.encodeBigint(e)).toList(),
    };
  }


  factory HederaTokenWipeAccountTransactionBody.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaTokenWipeAccountTransactionBody(
      token: json.valueTo<proto_basic_types.HederaTokenID?, Object>(
        key: 'token',
        parse: (v) => proto_basic_types.HederaTokenID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      account: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'account',
        parse: (v) => proto_basic_types.HederaAccountID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      amount: json.valueAsBigInt<BigInt?>('amount', normalizeKeyLookup: config.normalizeKeys),
      serialNumbers: (json.valueEnsureAsList<dynamic>('serialNumbers', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueAsBigInt<BigInt>(e)).toList(),
    );
  }

  factory HederaTokenWipeAccountTransactionBody.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTokenWipeAccountTransactionBody(
      token: decode.messageTo<proto_basic_types.HederaTokenID?>(1, (b) => proto_basic_types.HederaTokenID.deserialize(b)),
      account: decode.messageTo<proto_basic_types.HederaAccountID?>(2, (b) => proto_basic_types.HederaAccountID.deserialize(b)),
      amount: decode.getBigInt<BigInt?>(3),
      serialNumbers: decode.getListOrEmpty<BigInt>(4),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoTokenWipeAccountTransactionBody;

}


