import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart" as proto_basic_types;
import "package:on_chain/hedera/src/proto_messages/google/protobuf/src/wrappers.dart" as google_protobuf_wrappers;

/// *
///  * # Approve Allowance
///  * This transaction body provides a mechanism to add "allowance" entries
///  * for an account. These allowances enable one account to spend or transfer
///  * token balances (for fungible/common tokens), individual tokens (for
///  * non-fungible/unique tokens), or all non-fungible tokens owned by the
///  * account, now or in the future (if `approved_for_all` is set).
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
///  * Create ("Approve") allowances for one account to transfer tokens owned
///  * by a different account.&lt;br/&gt;
///  * An allowance permits a "spender" account to independently transfer tokens
///  * owned by a separate "owner" account. Each such allowance permits spending
///  * any amount, up to a specified limit, for fungible/common tokens; a single
///  * specified non-fungible/unique token, or all non-fungible/unique tokens
///  * of a particular token type held by the "owner" account.
///  *
///  * If the "owner" account is not specified for any allowance in this
///  * transaction (the `owner` field is not set), the `payer` account for this
///  * transaction SHALL be owner for that allowance.&lt;br/&gt;
///  * Each `owner` account specified in any allowance approved in this
///  * transaction MUST sign this transaction.&lt;br/&gt;
///  * If the `amount` field for any fungible/common allowance in this
///  * transaction is `0`, then that allowance SHOULD match an existing,
///  * previously approved, allowance which SHALL be removed.&lt;br/&gt;
///  * There are three lists in this message. Each list MAY be empty, but
///  * _at least one_ list MUST contain _at least one_ entry.
///  *
///  * Example for the `payer` rule.&lt;br/&gt;
///  *  - Given an account `0.0.X` that pays for this transaction, and owner
///  *    is not specified in an allowance of `200` HBAR to spender account
///  *    `0.0.Y`. At consensus the spender account `0.0.Y` will have a new
///  *    allowance to spend `200` HBAR from the balance of account `0.0.X`.
///  *
///  * ### Block Stream Effects
///  * None
class HederaCryptoApproveAllowanceTransactionBody extends HederaProtoMessage with Equality {
    /// *
  ///      * List of hbar allowances approved by the account owner.
  ///      * &lt;p&gt;
  ///      * This list MAY be empty, provided at least one other list is
  ///      * not empty.
  final List<HederaCryptoAllowance> cryptoAllowances;

    /// *
  ///      * List of non-fungible token allowances approved by the account owner.
  ///      * &lt;p&gt;
  ///      * This list MAY be empty, provided at least one other list is
  ///      * not empty.
  final List<HederaNftAllowance> nftAllowances;

    /// *
  ///      * List of fungible token allowances approved by the account owner.
  ///      * &lt;p&gt;
  ///      * This list MAY be empty, provided at least one other list is
  ///      * not empty.
  final List<HederaTokenAllowance> tokenAllowances;

  const HederaCryptoApproveAllowanceTransactionBody({
    this.cryptoAllowances = const [],
    this.nftAllowances = const [],
    this.tokenAllowances = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.repeated(
          fieldNumber: 1,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.repeated(
          fieldNumber: 2,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.repeated(
          fieldNumber: 3,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        cryptoAllowances,
        nftAllowances,
        tokenAllowances,
      ];


HederaCryptoApproveAllowanceTransactionBody copyWith(
{List<HederaCryptoAllowance>? cryptoAllowances,

List<HederaNftAllowance>? nftAllowances,

List<HederaTokenAllowance>? tokenAllowances,

}) {
    return HederaCryptoApproveAllowanceTransactionBody(
cryptoAllowances: cryptoAllowances ?? this.cryptoAllowances,
nftAllowances: nftAllowances ?? this.nftAllowances,
tokenAllowances: tokenAllowances ?? this.tokenAllowances,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'cryptoAllowances': cryptoAllowances.map((e) => config.encodeMessage(e)).toList(),
      'nftAllowances': nftAllowances.map((e) => config.encodeMessage(e)).toList(),
      'tokenAllowances': tokenAllowances.map((e) => config.encodeMessage(e)).toList(),
    };
  }


  factory HederaCryptoApproveAllowanceTransactionBody.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaCryptoApproveAllowanceTransactionBody(
      cryptoAllowances: (json.valueEnsureAsList<dynamic>('cryptoAllowances', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<HederaCryptoAllowance, Object>(
          value: e,
          parse: (v) => HederaCryptoAllowance.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
      nftAllowances: (json.valueEnsureAsList<dynamic>('nftAllowances', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<HederaNftAllowance, Object>(
          value: e,
          parse: (v) => HederaNftAllowance.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
      tokenAllowances: (json.valueEnsureAsList<dynamic>('tokenAllowances', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<HederaTokenAllowance, Object>(
          value: e,
          parse: (v) => HederaTokenAllowance.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
    );
  }

  factory HederaCryptoApproveAllowanceTransactionBody.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaCryptoApproveAllowanceTransactionBody(
      cryptoAllowances: decode.getListOfBytes(1).map((b) => HederaCryptoAllowance.deserialize(b)).toList(),
      nftAllowances: decode.getListOfBytes(2).map((b) => HederaNftAllowance.deserialize(b)).toList(),
      tokenAllowances: decode.getListOfBytes(3).map((b) => HederaTokenAllowance.deserialize(b)).toList(),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoCryptoApproveAllowanceTransactionBody;

}


/// *
///  * An approved allowance of hbar transfers.
///  * This message specifies one allowance for a single, unique, combination
///  * of owner, spender, and amount.
///  *
///  * If `owner` is not set, the effective `owner` SHALL be the `payer` for the
///  * enclosing transaction.&lt;br/&gt;
///  * The `spender` MUST be specified and MUST be a valid account.&lt;br/&gt;
///  * The `amount` MUST be a whole number, and SHOULD be greater than `0` unless
///  * this allowance is intended to _remove_ a previously approved allowance.
class HederaCryptoAllowance extends HederaProtoMessage with Equality {
    /// *
  ///      * An owner account identifier.&lt;br/&gt;
  ///      * This is the account identifier of the account granting an allowance
  ///      * for the `spender` to transfer tokens held by this account.
  final proto_basic_types.HederaAccountID? owner;

    /// *
  ///      * A spender account identifier.&lt;br/&gt;
  ///      * This is the account identifier of the account permitted to transfer
  ///      * tokens held by the `owner`.
  final proto_basic_types.HederaAccountID? spender;

    /// *
  ///      * An amount of tinybar (10&lt;sup&gt;-8&lt;/sup&gt; HBAR).&lt;br/&gt;
  ///      * This is the amount of HBAR held by the `owner` that the
  ///      * `spender` is permitted to transfer.
  ///      * &lt;p&gt;
  ///      * This value MUST be a whole number.&lt;br/&gt;
  ///      * This value MUST be greater than 0 to create a new allowance.&lt;br/&gt;
  ///      * This value MAY be exactly `0` to _remove_ an existing allowance.&lt;br/&gt;
  final BigInt? amount;

  const HederaCryptoAllowance({
    this.owner,
    this.spender,
    this.amount,
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
        ProtoFieldConfig.int64(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        owner,
        spender,
        amount,
      ];


HederaCryptoAllowance copyWith(
{proto_basic_types.HederaAccountID? owner,

proto_basic_types.HederaAccountID? spender,

BigInt? amount,

}) {
    return HederaCryptoAllowance(
owner: owner ?? this.owner,
spender: spender ?? this.spender,
amount: amount ?? this.amount,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'owner': config.encodeMessage(owner),
      'spender': config.encodeMessage(spender),
      'amount': config.encodeBigint(amount),
    };
  }


  factory HederaCryptoAllowance.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaCryptoAllowance(
      owner: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'owner',
        parse: (v) => proto_basic_types.HederaAccountID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      spender: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'spender',
        parse: (v) => proto_basic_types.HederaAccountID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      amount: json.valueAsBigInt<BigInt?>('amount', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaCryptoAllowance.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaCryptoAllowance(
      owner: decode.messageTo<proto_basic_types.HederaAccountID?>(1, (b) => proto_basic_types.HederaAccountID.deserialize(b)),
      spender: decode.messageTo<proto_basic_types.HederaAccountID?>(2, (b) => proto_basic_types.HederaAccountID.deserialize(b)),
      amount: decode.getBigInt<BigInt?>(3),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoCryptoAllowance;

}


/// *
///  * An approved allowance of non-fungible tokens.&lt;br/&gt;
///  * This type of allowance may permit transfers for one or more individual
///  * unique tokens, or may permit transfers for all unique tokens of the
///  * specified type.
///  *
///  * If `owner` is not set, the effective `owner` SHALL be the `payer` for the
///  * enclosing transaction.&lt;br/&gt;
///  * The `spender` MUST be specified and MUST be a valid account.&lt;br/&gt;
///  * If `approve_for_all` is set, then `serial_numbers` SHOULD be empty
///  * and SHALL be ignored.
///  * If `approve_for_all` is unset, then `serial_numbers` MUST NOT be empty.
class HederaNftAllowance extends HederaProtoMessage with Equality {
    /// *
  ///      * A token identifier.&lt;br/&gt;
  ///      * This identifies the type of token the `spender` is permitted to
  ///      * transfer from the `owner`.
  ///      * &lt;p&gt;
  ///      * The identified token type MUST be a non-fungible/unique token.
  final proto_basic_types.HederaTokenID? tokenId;

    /// *
  ///      * An owner account identifier.&lt;br/&gt;
  ///      * This is the account identifier of the account granting an allowance
  ///      * for the `spender` to transfer tokens held by this account.
  final proto_basic_types.HederaAccountID? owner;

    /// *
  ///      * A spender account identifier.&lt;br/&gt;
  ///      * This is the account identifier of the account permitted to transfer
  ///      * tokens held by the `owner`.
  final proto_basic_types.HederaAccountID? spender;

    /// *
  ///      * A list of token serial numbers.&lt;br/&gt;
  ///      * The list of serial numbers that the spender is permitted to transfer.
  ///      * &lt;p&gt;
  ///      * The `owner` MUST currently hold each token identified in this list.
  final List<BigInt> serialNumbers;

    /// *
  ///      * A flag indicating this allowance applies to all tokens of the
  ///      * specified (non-fungible/unique) type.
  ///      * &lt;p&gt;
  ///      * If true, the `spender` SHALL be permitted to transfer any or all
  ///      * of the `owner`'s tokens of the specified token type.
  ///      * This SHALL apply not only to currently owned tokens, but to all
  ///      * such tokens acquired in the future, unless the
  ///      * allowance is `delete`d.
  final google_protobuf_wrappers.HederaBoolValue? approvedForAll;

    /// *
  ///      * A spender-owner account identifier.&lt;br/&gt;
  ///      * This account identifier identifies a `spender` for whom an existing
  ///      * `approved_for_all` allowance was previously created. This enables
  ///      * an account with such broad access to grant allowances to transfer
  ///      * individual tokens from the original owner without involving that
  ///      * original owner.
  ///      * &lt;p&gt;
  ///      * If this is set, the account identified MUST sign this transaction, but
  ///      * the `owner` account MAY NOT sign this transaction.&lt;br/&gt;
  ///      * If this is set, there MUST exist an active `approved_for_all`
  ///      * allowance from the `owner` for the `delegating_spender` to transfer
  ///      * all tokens of the type identified by the `tokenId` field.&lt;br/&gt;
  ///      * If this value is set, the `approved_for_all` flag MUST be `false`.
  final proto_basic_types.HederaAccountID? delegatingSpender;

  const HederaNftAllowance({
    this.tokenId,
    this.owner,
    this.spender,
    this.serialNumbers = const [],
    this.approvedForAll,
    this.delegatingSpender,
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
        ProtoFieldConfig.message(3),
        ProtoFieldConfig.repeated(
          fieldNumber: 4,
          elementType: ProtoFieldType.int64,
        ),
        ProtoFieldConfig.message(5),
        ProtoFieldConfig.message(6),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        tokenId,
        owner,
        spender,
        serialNumbers,
        approvedForAll,
        delegatingSpender,
      ];


HederaNftAllowance copyWith(
{proto_basic_types.HederaTokenID? tokenId,

proto_basic_types.HederaAccountID? owner,

proto_basic_types.HederaAccountID? spender,

List<BigInt>? serialNumbers,

google_protobuf_wrappers.HederaBoolValue? approvedForAll,

proto_basic_types.HederaAccountID? delegatingSpender,

}) {
    return HederaNftAllowance(
tokenId: tokenId ?? this.tokenId,
owner: owner ?? this.owner,
spender: spender ?? this.spender,
serialNumbers: serialNumbers ?? this.serialNumbers,
approvedForAll: approvedForAll ?? this.approvedForAll,
delegatingSpender: delegatingSpender ?? this.delegatingSpender,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'tokenId': config.encodeMessage(tokenId),
      'owner': config.encodeMessage(owner),
      'spender': config.encodeMessage(spender),
      'serial_numbers': serialNumbers.map((e) => config.encodeBigint(e)).toList(),
      'approved_for_all': config.encodeMessage(approvedForAll),
      'delegating_spender': config.encodeMessage(delegatingSpender),
    };
  }


  factory HederaNftAllowance.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaNftAllowance(
      tokenId: json.valueTo<proto_basic_types.HederaTokenID?, Object>(
        key: 'tokenId',
        parse: (v) => proto_basic_types.HederaTokenID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      owner: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'owner',
        parse: (v) => proto_basic_types.HederaAccountID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      spender: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'spender',
        parse: (v) => proto_basic_types.HederaAccountID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      serialNumbers: (json.valueEnsureAsList<dynamic>('serial_numbers', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueAsBigInt<BigInt>(e)).toList(),
      approvedForAll: json.valueTo<google_protobuf_wrappers.HederaBoolValue?, Object>(
        key: 'approved_for_all',
        parse: (v) => google_protobuf_wrappers.HederaBoolValue.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      delegatingSpender: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'delegating_spender',
        parse: (v) => proto_basic_types.HederaAccountID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory HederaNftAllowance.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaNftAllowance(
      tokenId: decode.messageTo<proto_basic_types.HederaTokenID?>(1, (b) => proto_basic_types.HederaTokenID.deserialize(b)),
      owner: decode.messageTo<proto_basic_types.HederaAccountID?>(2, (b) => proto_basic_types.HederaAccountID.deserialize(b)),
      spender: decode.messageTo<proto_basic_types.HederaAccountID?>(3, (b) => proto_basic_types.HederaAccountID.deserialize(b)),
      serialNumbers: decode.getListOrEmpty<BigInt>(4),
      approvedForAll: decode.messageTo<google_protobuf_wrappers.HederaBoolValue?>(5, (b) => google_protobuf_wrappers.HederaBoolValue.deserialize(b)),
      delegatingSpender: decode.messageTo<proto_basic_types.HederaAccountID?>(6, (b) => proto_basic_types.HederaAccountID.deserialize(b)),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoNftAllowance;

}


/// *
///  * An approved allowance of fungible/common token transfers.
///  * This message specifies one allowance for a single, unique, combination
///  * of token, owner, spender, and amount.
///  *
///  * If `owner` is not set, the effective `owner` SHALL be the `payer` for the
///  * enclosing transaction.&lt;br/&gt;
///  * The `tokenId` MUST be specified and MUST be a valid
///  * fungible/common token type.&lt;br/&gt;
///  * The `spender` MUST be specified and MUST be a valid account.&lt;br/&gt;
///  * The `amount` MUST be a whole number, and SHOULD be greater than `0` unless
///  * this allowance is intended to _remove_ a previously approved allowance.
class HederaTokenAllowance extends HederaProtoMessage with Equality {
    /// *
  ///      * A token identifier.&lt;br/&gt;
  ///      * This identifies the type of token the `spender` is permitted to
  ///      * transfer from the `owner`.
  ///      * &lt;p&gt;
  ///      * The identified token type MUST be a fungible/common token.
  final proto_basic_types.HederaTokenID? tokenId;

    /// *
  ///      * An owner account identifier.&lt;br/&gt;
  ///      * This is the account identifier of the account granting an allowance
  ///      * for the `spender` to transfer tokens held by this account.
  final proto_basic_types.HederaAccountID? owner;

    /// *
  ///      * A spender account identifier.&lt;br/&gt;
  ///      * This is the account identifier of the account permitted to transfer
  ///      * tokens held by the `owner`.
  final proto_basic_types.HederaAccountID? spender;

    /// *
  ///      * An amount of fractional tokens (10&lt;sup&gt;-decimals&lt;/sup&gt; tokens).&lt;br/&gt;
  ///      * This is the amount of tokens held by the `owner` that the
  ///      * `spender` is permitted to transfer.
  ///      * &lt;p&gt;
  ///      * This value MUST be a whole number.&lt;br/&gt;
  ///      * This value MUST be greater than 0 to create a new allowance.&lt;br/&gt;
  ///      * This value MAY be exactly `0` to _remove_ an existing allowance.&lt;br/&gt;
  final BigInt? amount;

  const HederaTokenAllowance({
    this.tokenId,
    this.owner,
    this.spender,
    this.amount,
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
        ProtoFieldConfig.message(3),
        ProtoFieldConfig.int64(4),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        tokenId,
        owner,
        spender,
        amount,
      ];


HederaTokenAllowance copyWith(
{proto_basic_types.HederaTokenID? tokenId,

proto_basic_types.HederaAccountID? owner,

proto_basic_types.HederaAccountID? spender,

BigInt? amount,

}) {
    return HederaTokenAllowance(
tokenId: tokenId ?? this.tokenId,
owner: owner ?? this.owner,
spender: spender ?? this.spender,
amount: amount ?? this.amount,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'tokenId': config.encodeMessage(tokenId),
      'owner': config.encodeMessage(owner),
      'spender': config.encodeMessage(spender),
      'amount': config.encodeBigint(amount),
    };
  }


  factory HederaTokenAllowance.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaTokenAllowance(
      tokenId: json.valueTo<proto_basic_types.HederaTokenID?, Object>(
        key: 'tokenId',
        parse: (v) => proto_basic_types.HederaTokenID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      owner: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'owner',
        parse: (v) => proto_basic_types.HederaAccountID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      spender: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'spender',
        parse: (v) => proto_basic_types.HederaAccountID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      amount: json.valueAsBigInt<BigInt?>('amount', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaTokenAllowance.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTokenAllowance(
      tokenId: decode.messageTo<proto_basic_types.HederaTokenID?>(1, (b) => proto_basic_types.HederaTokenID.deserialize(b)),
      owner: decode.messageTo<proto_basic_types.HederaAccountID?>(2, (b) => proto_basic_types.HederaAccountID.deserialize(b)),
      spender: decode.messageTo<proto_basic_types.HederaAccountID?>(3, (b) => proto_basic_types.HederaAccountID.deserialize(b)),
      amount: decode.getBigInt<BigInt?>(4),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoTokenAllowance;

}


