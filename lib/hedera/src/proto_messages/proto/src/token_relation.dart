import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;

/// *
///  * # Token Relationship.
///  * This is a connection between one Account, one _fungible_ Token, and
///  * associated balance within the Hedera network.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in [RFC2119](https://www.ietf.org/rfc/rfc2119)
///  * and clarified in [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.state.token"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * An Hedera Token Service token relationship.
///  *
///  * A token relationship connects an Account with a Token and is necessary for
///  * that Account to transact in that Token. TokenRelationship defines a
///  * connection between one account and one token type.
///  *
///  * A TokenRelation SHALL be identified by the combination of token_id and
///  * account_id.&lt;br/&gt;
///  * A TokenRelation SHALL contain, for the referenced token,&lt;br/&gt;
///  * The account's current balance, whether the account has KYC granted,
///  * and whether the assets are frozen.
///  *
///  * TokenRelation entries SHALL be connected via a "virtual linked list" with the
///  * next TokenID and previous TokenID stored in the TokenRelation.
///  * These TokenIDs MUST be combined with the AccountID to find the next or
///  * previous relationship in the list.
class HederaTokenRelation extends HederaProtoMessage with Equality {
  /// *
  ///      * A token identifier.
  ///      * &lt;p&gt;
  ///      * This SHALL identify the token involved in this association.
  final proto_basic_types.HederaTokenID? tokenId;

  /// *
  ///      * An account identifier.
  ///      * &lt;p&gt;
  ///      * This SHALL identify the account involved in this association.
  final proto_basic_types.HederaAccountID? accountId;

  /// *
  ///      * The fungible token balance of this token relationship.
  ///      * &lt;p&gt;
  ///      * This MUST be a whole number.
  final BigInt? balance;

  /// *
  ///      * A flag indicating that this token relationship is frozen.
  ///      * &lt;p&gt;
  ///      * When a token relationship is frozen the associated account SHALL NOT be
  ///      * permitted to transfer to or from the associated balance.
  ///      * &lt;p&gt;
  ///      * This flag is associated with the Token value `freeze_key`, and any
  ///      * transaction to set this flag MUST be signed by that key. If the Token
  ///      * does not have a `freeze_key` set, then this flag SHALL NOT be set true
  ///      * for relationships between accounts and that token.
  final bool? frozen;

  /// *
  ///      * A flag indicating that this token relationship has been granted KYC status.
  ///      * &lt;p&gt;
  ///      * If the token flag `accounts_kyc_granted_by_default` is set true, then
  ///      * this flag SHALL be set true for all accounts subsequently associated to
  ///      * that token. Otherwise this flag SHALL NOT be set until a transaction
  ///      * is submitted, and signed with the Token `kyc_key` to
  ///      * set the flag true.&lt;br/&gt;
  ///      * If the Token does not have a `kyc_key` set and the token flag
  ///      * `accounts_kyc_granted_by_default` is not set true, then this value MUST
  ///      * be false for all accounts subsequently associated to that token.
  ///      * &lt;p&gt;
  ///      * Typically a transaction to set this value to true is considered
  ///      * equivalent to asserting that the "Know Your Customer" (KYC) requirements
  ///      * have been met for this combination of account and token and the relevant
  ///      * records are available as required.
  final bool? kycGranted;

  /// *
  ///      * A flag indicating that this token relationship was created using
  ///      * automatic association.
  ///      * &lt;p&gt;
  ///      * If this is true then there MUST NOT exist a customer-signed transaction
  ///      * associating this account and token combination and the account
  ///      * `used_auto_associations` SHALL be incremented when this relationship
  ///      * is created.
  final bool? automaticAssociation;

  /// *
  ///      * The Token ID of the previous entry in the associated Account's
  ///      * "virtual double-linked list" of token relationships.
  ///      * &lt;p&gt;
  ///      * This must be combined with the value of `account_id` to identify the
  ///      * actual `TokenRelation` referenced.
  final proto_basic_types.HederaTokenID? previousToken;

  /// *
  ///      * The Token ID of the next entry in the associated Account's "virtual
  ///      * double-linked list" of token relationships.
  ///      * &lt;p&gt;
  ///      * This must be combined with the value of `account_id` to identify the
  ///      * actual `TokenRelation` referenced.
  final proto_basic_types.HederaTokenID? nextToken;

  const HederaTokenRelation({
    this.tokenId,
    this.accountId,
    this.balance,
    this.frozen,
    this.kycGranted,
    this.automaticAssociation,
    this.previousToken,
    this.nextToken,
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
        ProtoFieldConfig.bool(4),
        ProtoFieldConfig.bool(5),
        ProtoFieldConfig.bool(6),
        ProtoFieldConfig.message(7),
        ProtoFieldConfig.message(8),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    tokenId,
    accountId,
    balance,
    frozen,
    kycGranted,
    automaticAssociation,
    previousToken,
    nextToken,
  ];

  HederaTokenRelation copyWith({
    proto_basic_types.HederaTokenID? tokenId,

    proto_basic_types.HederaAccountID? accountId,

    BigInt? balance,

    bool? frozen,

    bool? kycGranted,

    bool? automaticAssociation,

    proto_basic_types.HederaTokenID? previousToken,

    proto_basic_types.HederaTokenID? nextToken,
  }) {
    return HederaTokenRelation(
      tokenId: tokenId ?? this.tokenId,
      accountId: accountId ?? this.accountId,
      balance: balance ?? this.balance,
      frozen: frozen ?? this.frozen,
      kycGranted: kycGranted ?? this.kycGranted,
      automaticAssociation: automaticAssociation ?? this.automaticAssociation,
      previousToken: previousToken ?? this.previousToken,
      nextToken: nextToken ?? this.nextToken,
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
      'account_id': config.encodeMessage(accountId),
      'balance': config.encodeBigint(balance),
      'frozen': frozen,
      'kyc_granted': kycGranted,
      'automatic_association': automaticAssociation,
      'previous_token': config.encodeMessage(previousToken),
      'next_token': config.encodeMessage(nextToken),
    };
  }

  factory HederaTokenRelation.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaTokenRelation(
      tokenId: json.valueTo<proto_basic_types.HederaTokenID?, Object>(
        key: 'token_id',
        parse:
            (v) => proto_basic_types.HederaTokenID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      accountId: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'account_id',
        parse:
            (v) => proto_basic_types.HederaAccountID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      balance: json.valueAsBigInt<BigInt?>(
        'balance',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      frozen: json.valueAsBool<bool?>(
        'frozen',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      kycGranted: json.valueAsBool<bool?>(
        'kyc_granted',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      automaticAssociation: json.valueAsBool<bool?>(
        'automatic_association',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      previousToken: json.valueTo<proto_basic_types.HederaTokenID?, Object>(
        key: 'previous_token',
        parse:
            (v) => proto_basic_types.HederaTokenID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      nextToken: json.valueTo<proto_basic_types.HederaTokenID?, Object>(
        key: 'next_token',
        parse:
            (v) => proto_basic_types.HederaTokenID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaTokenRelation.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTokenRelation(
      tokenId: decode.messageTo<proto_basic_types.HederaTokenID?>(
        1,
        (b) => proto_basic_types.HederaTokenID.deserialize(b),
      ),
      accountId: decode.messageTo<proto_basic_types.HederaAccountID?>(
        2,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
      balance: decode.getBigInt<BigInt?>(3),
      frozen: decode.getBool<bool?>(4),
      kycGranted: decode.getBool<bool?>(5),
      automaticAssociation: decode.getBool<bool?>(6),
      previousToken: decode.messageTo<proto_basic_types.HederaTokenID?>(
        7,
        (b) => proto_basic_types.HederaTokenID.deserialize(b),
      ),
      nextToken: decode.messageTo<proto_basic_types.HederaTokenID?>(
        8,
        (b) => proto_basic_types.HederaTokenID.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoTokenRelation;
}
