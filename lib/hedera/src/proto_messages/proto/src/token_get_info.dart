import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/query_header.dart"
    as proto_query_header;
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;
import "package:on_chain/hedera/src/proto_messages/proto/src/duration.dart"
    as proto_duration;
import "package:on_chain/hedera/src/proto_messages/proto/src/timestamp.dart"
    as proto_timestamp;
import "package:on_chain/hedera/src/proto_messages/proto/src/custom_fees.dart"
    as proto_custom_fees;
import "package:on_chain/hedera/src/proto_messages/proto/src/response_header.dart"
    as proto_response_header;
import "package:on_chain/hedera/src/proto_messages/proto/src/query.dart"
    as proto_query;

/// *
///  * # Get Token Info
///  * Query to retrieve information for a single token.
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
///  * Request information for a token.
class HederaTokenGetInfoQuery extends HederaProtoMessage
    with Equality, IHederaQuery<HederaTokenGetInfoResponse> {
  /// *
  ///      * Standard information sent with every query operation.&lt;br/&gt;
  ///      * This includes the signed payment and what kind of response is requested
  ///      * (cost, state proof, both, or neither).
  @override
  final proto_query_header.HederaQueryHeader? header;

  /// *
  ///      * A token identifier.
  ///      * &lt;p&gt;
  ///      * This SHALL identify the token to query.&lt;br/&gt;
  ///      * The identified token MUST exist, and MUST NOT be deleted.
  final proto_basic_types.HederaTokenID? token;

  const HederaTokenGetInfoQuery({this.header, this.token});

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
  List<Object?> get protoValues => [header, token];

  @override
  HederaTokenGetInfoQuery copyWith({
    proto_query_header.HederaQueryHeader? header,

    proto_basic_types.HederaTokenID? token,
  }) {
    return HederaTokenGetInfoQuery(
      header: header ?? this.header,
      token: token ?? this.token,
    );
  }

  @override
  proto_query.HederaQuery toQueryRequest({
    proto_query_header.HederaQueryHeader? header,
  }) => proto_query.HederaQuery(tokenGetInfo: copyWith(header: header));
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'header': config.encodeMessage(header),
      'token': config.encodeMessage(token),
    };
  }

  factory HederaTokenGetInfoQuery.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaTokenGetInfoQuery(
      header: json.valueTo<proto_query_header.HederaQueryHeader?, Object>(
        key: 'header',
        parse:
            (v) => proto_query_header.HederaQueryHeader.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      token: json.valueTo<proto_basic_types.HederaTokenID?, Object>(
        key: 'token',
        parse:
            (v) => proto_basic_types.HederaTokenID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaTokenGetInfoQuery.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTokenGetInfoQuery(
      header: decode.messageTo<proto_query_header.HederaQueryHeader?>(
        1,
        (b) => proto_query_header.HederaQueryHeader.deserialize(b),
      ),
      token: decode.messageTo<proto_basic_types.HederaTokenID?>(
        2,
        (b) => proto_basic_types.HederaTokenID.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoTokenGetInfoQuery;
}

/// *
///  * An Hedera Token Service(HTS) token.
///  *
///  * A token SHALL represent a fungible or non-fungible unit of exchange.&lt;br/&gt;
///  * The specified Treasury Account SHALL receive the initial supply of tokens and
///  * SHALL determine distribution of all tokens once minted.
class HederaTokenInfo extends HederaProtoMessage with Equality {
  /// *
  ///      * A unique identifier for this token.
  final proto_basic_types.HederaTokenID? tokenId;

  /// *
  ///      * A human-readable name for this token.
  ///      * &lt;p&gt;
  ///      * This value MAY NOT be unique.&lt;br/&gt;
  ///      * This value SHALL NOT exceed 100 bytes when encoded as UTF-8.
  final String? name;

  /// *
  ///      * A human-readable symbol for the token.
  ///      * &lt;p&gt;
  ///      * This value SHALL NOT be unique.&lt;br/&gt;
  ///      * This value SHALL NOT exceed 100 bytes when encoded as UTF-8.
  final String? symbol;

  /// *
  ///      * A number of decimal places for this token.
  ///      * &lt;p&gt;
  ///      * If decimals are 8 or 11, then the number of whole tokens can be at most
  ///      * billions or millions, respectively. More decimals allows for a more
  ///      * finely-divided token, but also limits the maximum total supply.
  ///      * &lt;p&gt;
  ///      * Examples
  ///      * &lt;ul&gt;
  ///      *   &lt;li&gt;Bitcoin satoshis (21 million whole tokens with 8 decimals).&lt;/li&gt;
  ///      *   &lt;li&gt;Hedera tinybar (50 billion whole tokens with 8 decimals).&lt;/li&gt;
  ///      *   &lt;li&gt;Bitcoin milli-satoshis (21 million whole tokens with 11
  ///      *       decimals).&lt;/li&gt;
  ///      *   &lt;li&gt;Theoretical limit is roughly 92.2 billion with 8 decimals, or
  ///      *       92.2 million with 11 decimals.&lt;/li&gt;
  ///      * &lt;/ul&gt;
  ///      * All token amounts in the network are stored as integer amounts, with
  ///      * each unit representing 10&lt;sup&gt;-decimals&lt;/sup&gt; whole tokens.
  ///      * &lt;p&gt;
  ///      * For tokens with `token_type` set to `NON_FUNGIBLE_UNIQUE` this MUST be 0.
  final int? decimals;

  /// *
  ///      * A _current_ total supply of this token, expressed in the smallest unit
  ///      * of the token.
  ///      * &lt;p&gt;
  ///      * The number of _whole_ tokens this represents is (total_supply /
  ///      * 10&lt;sup&gt;decimals&lt;/sup&gt;). The value of total supply, MUST be within the
  ///      * positive range of a twos-compliment signed 64-bit integer.
  ///      * The `total_supply`, therefore MUST be between 1, and
  ///      * 9,223,372,036,854,775,807, inclusive.
  ///      * &lt;p&gt;
  ///      * This value SHALL be reduced when a `token_burn` or `token_wipe_account`
  ///      * operation is executed, and SHALL be increased when a `token_mint`
  ///      * operation is executed.
  final BigInt? totalSupply;

  /// *
  ///      * A treasury account identifier for this token.
  ///      * &lt;p&gt;
  ///      * When the token is created, the initial supply given in the token create
  ///      * transaction SHALL be minted and deposited in the treasury account.&lt;br/&gt;
  ///      * All token mint transactions for this token SHALL deposit the new minted
  ///      * tokens in the treasury account.&lt;br/&gt;
  ///      * All token burn transactions for this token SHALL remove the tokens to be
  ///      * burned from the treasury account.
  final proto_basic_types.HederaAccountID? treasury;

  /// *
  ///      * Access control for general modification of this token.
  ///      * &lt;p&gt;
  ///      * This key MUST sign any `token_update` transaction that
  ///      * changes any attribute of the token other than expiration_time.
  ///      * Other attributes of this token MAY be changed by transactions other than
  ///      * `token_update`, and MUST be signed by one of the other purpose-specific
  ///      * keys assigned to the token.&lt;br/&gt;
  ///      * This value can be set during token creation, and SHALL NOT be
  ///      * modified thereafter, unless the update transaction is signed by both
  ///      * the existing `admin_key` and the new `admin_key`.&lt;br/&gt;
  ///      * If the `admin_key` is not set for a token, that token SHALL be immutable.
  final proto_basic_types.HederaKey? adminKey;

  /// *
  ///      * Access control for KYC for this token.
  ///      * &lt;p&gt;
  ///      * Know Your Customer (KYC) status may be granted for an account by a token
  ///      * grant kyc transaction signed by this key.&lt;br/&gt;
  ///      * If this key is not set, then KYC status cannot be granted to an account
  ///      * for this token, and any `TokenGrantKyc` transaction attempting to grant
  ///      * kyc to an account for this token SHALL NOT succeed.&lt;br/&gt;
  ///      * This key MAY be set when the token is created, and MAY be set or modified
  ///      * via a token update transaction signed by the `admin_key`.&lt;br/&gt;
  ///      * If `admin_key` is not set, this value, whether set or unset,
  ///      * SHALL be immutable.
  final proto_basic_types.HederaKey? kycKey;

  /// *
  ///      * Access control to freeze this token.
  ///      * &lt;p&gt;
  ///      * A token may be frozen for an account, preventing any transaction from
  ///      * transferring that token for that specified account, by a token freeze
  ///      * account transaction signed by this key.&lt;br/&gt;
  ///      * If this key is not set, the token cannot be frozen, and any transaction
  ///      * attempting to freeze the token for an account SHALL NOT succeed.&lt;br/&gt;
  ///      * This key MAY be set when the token is created, and MAY be set or modified
  ///      * via a token update transaction signed by the `admin_key`.&lt;br/&gt;
  ///      * If `admin_key` is not set, this value, whether set or unset,
  ///      * SHALL be immutable.
  final proto_basic_types.HederaKey? freezeKey;

  /// *
  ///      * Access control of account wipe for this token.
  ///      * &lt;p&gt;
  ///      * A token may be wiped, removing and burning tokens from a specific
  ///      * account, by a token wipe transaction, which MUST be signed by this key.
  ///      * The `treasury_account` cannot be subjected to a token wipe. A token burn
  ///      * transaction, signed by the `supply_key`, serves to burn tokens held by
  ///      * the `treasury_account` instead.&lt;br/&gt;
  ///      * If this key is not set, the token cannot be wiped, and any transaction
  ///      * attempting to wipe the token from an account SHALL NOT succeed.&lt;br/&gt;
  ///      * This key MAY be set when the token is created, and MAY be set or modified
  ///      * via a token update transaction signed by the `admin_key`.&lt;br/&gt;
  ///      * If `admin_key` is not set, this value, whether set or unset,
  ///      * SHALL be immutable.
  final proto_basic_types.HederaKey? wipeKey;

  /// *
  ///      * Access control of token mint/burn for this token.
  ///      * &lt;p&gt;
  ///      * A token mint transaction MUST be signed by this key, and any token mint
  ///      * transaction not signed by the current `supply_key` for that token
  ///      * SHALL NOT succeed.&lt;br/&gt;
  ///      * A token burn transaction MUST be signed by this key, and any token burn
  ///      * transaction not signed by the current `supply_key` for that token
  ///      * SHALL NOT succeed.&lt;br/&gt;
  ///      * This key MAY be set when the token is created, and MAY be set or modified
  ///      * via a token update transaction signed by the `admin_key`.&lt;br/&gt;
  ///      * If `admin_key` is not set, this value, whether set or unset,
  ///      * SHALL be immutable.
  final proto_basic_types.HederaKey? supplyKey;

  /// *
  ///      * A flag indicating if accounts associated to this token are frozen by
  ///      * default, not frozen, or freeze is not applicable.
  ///      * &lt;p&gt;
  ///      * Accounts frozen by default and newly associated with this token CANNOT
  ///      * transact in the token until unfrozen.&lt;br/&gt;
  ///      * This SHALL NOT prevent a `tokenReject` transaction to return the tokens
  ///      * from an account to the treasury account.
  final proto_basic_types.HederaTokenFreezeStatus? defaultFreezeStatus;

  /// *
  ///      * A flag indicating if accounts associated with this token are granted
  ///      * KYC by default, revoked by default, or KYC is not applicable.
  final proto_basic_types.HederaTokenKycStatus? defaultKycStatus;

  /// *
  ///      * A flag indicating that this token is deleted.
  ///      * &lt;p&gt;
  ///      * A transaction involving a deleted token MUST NOT succeed.
  final bool? deleted;

  /// *
  ///      * An identifier for the account (if any) that the network will attempt
  ///      * to charge for this token's auto-renewal upon expiration.
  ///      * &lt;p&gt;
  ///      * This field is OPTIONAL. If it is not set then renewal fees SHALL be
  ///      * charged to the account identified by `treasury`.
  final proto_basic_types.HederaAccountID? autoRenewAccount;

  /// *
  ///      * A duration by which the network should automatically extend
  ///      * this token's expiration.
  ///      * &lt;p&gt;
  ///      * If the token has a valid auto-renew account, and is not deleted upon
  ///      * expiration, the network SHALL attempt to automatically renew this
  ///      * token.&lt;br/&gt;
  ///      * The default values for the minimum period and maximum period are 30 days
  ///      * and 90 days, respectively.
  final proto_duration.HederaDuration? autoRenewPeriod;

  /// *
  ///      * An expiration time for this token, in seconds since the epoch.
  ///      * &lt;p&gt;
  ///      * For this purpose, `epoch` SHALL be the
  ///      * UNIX epoch with 0 at `1970-01-01T00:00:00.000Z`.
  final proto_timestamp.HederaTimestamp? expiry;

  /// *
  ///      * A short description of this token.
  ///      * &lt;p&gt;
  ///      * This value, if set, MUST NOT exceed `transaction.maxMemoUtf8Bytes`
  ///      * (default 100) bytes when encoded as UTF-8.
  final String? memo;

  /// *
  ///      * A type for this token.
  ///      * &lt;p&gt;
  ///      * A token SHALL be either `FUNGIBLE_COMMON` or `NON_FUNGIBLE_UNIQUE`.&lt;br/&gt;
  ///      * If this value was omitted during token creation, `FUNGIBLE_COMMON`
  ///      * SHALL be used.&lt;br/&gt;
  ///      * The value `FUNGIBLE_COMMON` SHALL represent a fungible/common token.
  ///      * The value `NON_FUNGIBLE_UNIQUE` SHALL represent a
  ///      * non-fungible/unique token.
  final proto_basic_types.HederaTokenType? tokenType;

  /// *
  ///      * A supply type for this token.
  ///      * &lt;p&gt;
  ///      * A token SHALL have either `INFINITE` or `FINITE` supply type.&lt;br/&gt;
  ///      * If this value was omitted during token creation, the value `INFINITE`
  ///      * SHALL be used.
  final proto_basic_types.HederaTokenSupplyType? supplyType;

  /// *
  ///      * A maximum supply of this token.&lt;br/&gt;
  ///      * This is the maximum number of tokens of this type that may be issued.
  ///      * &lt;p&gt;
  ///      * This limit SHALL apply regardless of `token_type`.&lt;br/&gt;
  ///      * If `supply_type` is `INFINITE` then this value MUST be 0.&lt;br/&gt;
  ///      * If `supply_type` is `FINITE`, then this value MUST be greater than 0.
  final BigInt? maxSupply;

  /// *
  ///      * Access control of the `custom_fees` field for this token.
  ///      * &lt;p&gt;
  ///      * The token custom fee schedule may be changed, modifying the fees charged
  ///      * for transferring that token, by a token update transaction, which MUST
  ///      * be signed by this key.&lt;br/&gt;
  ///      * If this key is not set, the token custom fee schedule cannot be changed,
  ///      * and any transaction attempting to change the custom fee schedule for
  ///      * this token SHALL NOT succeed.&lt;br/&gt;
  ///      * This key MAY be set when the token is created, and MAY be set or modified
  ///      * via a token update transaction signed by the `admin_key`.&lt;br/&gt;
  ///      * If `admin_key` is not set, this value, whether set or unset,
  ///      * SHALL be immutable.
  final proto_basic_types.HederaKey? feeScheduleKey;

  /// *
  ///      * A custom fee schedule for this token.
  final List<proto_custom_fees.HederaCustomFee> customFees;

  /// *
  ///      * Access control of pause/unpause for this token.
  ///      * &lt;p&gt;
  ///      * A token may be paused, preventing any transaction from transferring that
  ///      * token, by a token update transaction signed by this key.&lt;br/&gt;
  ///      * If this key is not set, the token cannot be paused, and any transaction
  ///      * attempting to pause the token SHALL NOT succeed.&lt;br/&gt;
  ///      * This key MAY be set when the token is created, and MAY be set or modified
  ///      * via a token update transaction signed by the `admin_key`.&lt;br/&gt;
  ///      * If `admin_key` is not set, this value, whether set or unset,
  ///      * SHALL be immutable.
  final proto_basic_types.HederaKey? pauseKey;

  /// *
  ///      * A flag indicating that this token is paused.&lt;br/&gt;
  ///      * A token may be paused, unpaused, or pause not applicable.
  ///      * &lt;p&gt;
  ///      * A transaction involving a paused token, other than token_unpause,
  ///      * MUST NOT succeed.
  final proto_basic_types.HederaTokenPauseStatus? pauseStatus;

  /// *
  ///      * The ledger ID of the network that generated this response.
  ///      * &lt;p&gt;
  ///      * This value SHALL identify the distributed ledger that responded to
  ///      * this query.
  final List<int>? ledgerId;

  /// *
  ///      * A Token "Metadata".
  ///      * &lt;p&gt;
  ///      * This value, if set, SHALL NOT exceed 100 bytes.
  final List<int>? metadata;

  /// *
  ///      * Access Control of metadata update for this token.
  ///      * &lt;p&gt;
  ///      * A transaction to update the `metadata` field of this token MUST be
  ///      * signed by this key.&lt;br/&gt;
  ///      * If this token is a non-fungible/unique token type, a transaction to
  ///      * update the `metadata` field of any individual serialized unique token
  ///      * of this type MUST be signed by this key.&lt;br/&gt;
  ///      * If this key is not set, the token metadata SHALL NOT be changed after it
  ///      * is created.&lt;br/&gt;
  ///      * If this key is not set, the metadata for any individual serialized token
  ///      * of this type SHALL NOT be changed after it is created.&lt;br/&gt;
  ///      * This key MAY be set when the token is created, and MAY be set or modified
  ///      * via a token update transaction signed by the `admin_key`.&lt;br/&gt;
  ///      * If `admin_key` is not set, this value, whether set or unset,
  ///      * SHALL be immutable.
  final proto_basic_types.HederaKey? metadataKey;

  const HederaTokenInfo({
    this.tokenId,
    this.name,
    this.symbol,
    this.decimals,
    this.totalSupply,
    this.treasury,
    this.adminKey,
    this.kycKey,
    this.freezeKey,
    this.wipeKey,
    this.supplyKey,
    this.defaultFreezeStatus,
    this.defaultKycStatus,
    this.deleted,
    this.autoRenewAccount,
    this.autoRenewPeriod,
    this.expiry,
    this.memo,
    this.tokenType,
    this.supplyType,
    this.maxSupply,
    this.feeScheduleKey,
    this.customFees = const [],
    this.pauseKey,
    this.pauseStatus,
    this.ledgerId,
    this.metadata,
    this.metadataKey,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.string(2),
        ProtoFieldConfig.string(3),
        ProtoFieldConfig.uint32(4),
        ProtoFieldConfig.uint64(5),
        ProtoFieldConfig.message(6),
        ProtoFieldConfig.message(7),
        ProtoFieldConfig.message(8),
        ProtoFieldConfig.message(9),
        ProtoFieldConfig.message(10),
        ProtoFieldConfig.message(11),
        ProtoFieldConfig.enumType(12),
        ProtoFieldConfig.enumType(13),
        ProtoFieldConfig.bool(14),
        ProtoFieldConfig.message(15),
        ProtoFieldConfig.message(16),
        ProtoFieldConfig.message(17),
        ProtoFieldConfig.string(18),
        ProtoFieldConfig.enumType(19),
        ProtoFieldConfig.enumType(20),
        ProtoFieldConfig.int64(21),
        ProtoFieldConfig.message(22),
        ProtoFieldConfig.repeated(
          fieldNumber: 23,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.message(24),
        ProtoFieldConfig.enumType(25),
        ProtoFieldConfig.bytes(26),
        ProtoFieldConfig.bytes(27),
        ProtoFieldConfig.message(28),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    tokenId,
    name,
    symbol,
    decimals,
    totalSupply,
    treasury,
    adminKey,
    kycKey,
    freezeKey,
    wipeKey,
    supplyKey,
    defaultFreezeStatus,
    defaultKycStatus,
    deleted,
    autoRenewAccount,
    autoRenewPeriod,
    expiry,
    memo,
    tokenType,
    supplyType,
    maxSupply,
    feeScheduleKey,
    customFees,
    pauseKey,
    pauseStatus,
    ledgerId,
    metadata,
    metadataKey,
  ];

  HederaTokenInfo copyWith({
    proto_basic_types.HederaTokenID? tokenId,

    String? name,

    String? symbol,

    int? decimals,

    BigInt? totalSupply,

    proto_basic_types.HederaAccountID? treasury,

    proto_basic_types.HederaKey? adminKey,

    proto_basic_types.HederaKey? kycKey,

    proto_basic_types.HederaKey? freezeKey,

    proto_basic_types.HederaKey? wipeKey,

    proto_basic_types.HederaKey? supplyKey,

    proto_basic_types.HederaTokenFreezeStatus? defaultFreezeStatus,

    proto_basic_types.HederaTokenKycStatus? defaultKycStatus,

    bool? deleted,

    proto_basic_types.HederaAccountID? autoRenewAccount,

    proto_duration.HederaDuration? autoRenewPeriod,

    proto_timestamp.HederaTimestamp? expiry,

    String? memo,

    proto_basic_types.HederaTokenType? tokenType,

    proto_basic_types.HederaTokenSupplyType? supplyType,

    BigInt? maxSupply,

    proto_basic_types.HederaKey? feeScheduleKey,

    List<proto_custom_fees.HederaCustomFee>? customFees,

    proto_basic_types.HederaKey? pauseKey,

    proto_basic_types.HederaTokenPauseStatus? pauseStatus,

    List<int>? ledgerId,

    List<int>? metadata,

    proto_basic_types.HederaKey? metadataKey,
  }) {
    return HederaTokenInfo(
      tokenId: tokenId ?? this.tokenId,
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
      decimals: decimals ?? this.decimals,
      totalSupply: totalSupply ?? this.totalSupply,
      treasury: treasury ?? this.treasury,
      adminKey: adminKey ?? this.adminKey,
      kycKey: kycKey ?? this.kycKey,
      freezeKey: freezeKey ?? this.freezeKey,
      wipeKey: wipeKey ?? this.wipeKey,
      supplyKey: supplyKey ?? this.supplyKey,
      defaultFreezeStatus: defaultFreezeStatus ?? this.defaultFreezeStatus,
      defaultKycStatus: defaultKycStatus ?? this.defaultKycStatus,
      deleted: deleted ?? this.deleted,
      autoRenewAccount: autoRenewAccount ?? this.autoRenewAccount,
      autoRenewPeriod: autoRenewPeriod ?? this.autoRenewPeriod,
      expiry: expiry ?? this.expiry,
      memo: memo ?? this.memo,
      tokenType: tokenType ?? this.tokenType,
      supplyType: supplyType ?? this.supplyType,
      maxSupply: maxSupply ?? this.maxSupply,
      feeScheduleKey: feeScheduleKey ?? this.feeScheduleKey,
      customFees: customFees ?? this.customFees,
      pauseKey: pauseKey ?? this.pauseKey,
      pauseStatus: pauseStatus ?? this.pauseStatus,
      ledgerId: ledgerId ?? this.ledgerId,
      metadata: metadata ?? this.metadata,
      metadataKey: metadataKey ?? this.metadataKey,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'tokenId': config.encodeMessage(tokenId),
      'name': name,
      'symbol': symbol,
      'decimals': decimals,
      'totalSupply': config.encodeBigint(totalSupply),
      'treasury': config.encodeMessage(treasury),
      'adminKey': config.encodeMessage(adminKey),
      'kycKey': config.encodeMessage(kycKey),
      'freezeKey': config.encodeMessage(freezeKey),
      'wipeKey': config.encodeMessage(wipeKey),
      'supplyKey': config.encodeMessage(supplyKey),
      'defaultFreezeStatus': config.encodeEnum(defaultFreezeStatus),
      'defaultKycStatus': config.encodeEnum(defaultKycStatus),
      'deleted': deleted,
      'autoRenewAccount': config.encodeMessage(autoRenewAccount),
      'autoRenewPeriod': config.encodeMessage(autoRenewPeriod),
      'expiry': config.encodeMessage(expiry),
      'memo': memo,
      'tokenType': config.encodeEnum(tokenType),
      'supplyType': config.encodeEnum(supplyType),
      'maxSupply': config.encodeBigint(maxSupply),
      'fee_schedule_key': config.encodeMessage(feeScheduleKey),
      'custom_fees': customFees.map((e) => config.encodeMessage(e)).toList(),
      'pause_key': config.encodeMessage(pauseKey),
      'pause_status': config.encodeEnum(pauseStatus),
      'ledger_id': config.encodeBinary(ledgerId),
      'metadata': config.encodeBinary(metadata),
      'metadata_key': config.encodeMessage(metadataKey),
    };
  }

  factory HederaTokenInfo.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaTokenInfo(
      tokenId: json.valueTo<proto_basic_types.HederaTokenID?, Object>(
        key: 'tokenId',
        parse:
            (v) => proto_basic_types.HederaTokenID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      name: json.valueAsString<String?>(
        'name',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      symbol: json.valueAsString<String?>(
        'symbol',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      decimals: json.valueAsInt<int?>(
        'decimals',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      totalSupply: json.valueAsBigInt<BigInt?>(
        'totalSupply',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      treasury: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'treasury',
        parse:
            (v) => proto_basic_types.HederaAccountID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      adminKey: json.valueTo<proto_basic_types.HederaKey?, Object>(
        key: 'adminKey',
        parse:
            (v) => proto_basic_types.HederaKey.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      kycKey: json.valueTo<proto_basic_types.HederaKey?, Object>(
        key: 'kycKey',
        parse:
            (v) => proto_basic_types.HederaKey.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      freezeKey: json.valueTo<proto_basic_types.HederaKey?, Object>(
        key: 'freezeKey',
        parse:
            (v) => proto_basic_types.HederaKey.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      wipeKey: json.valueTo<proto_basic_types.HederaKey?, Object>(
        key: 'wipeKey',
        parse:
            (v) => proto_basic_types.HederaKey.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      supplyKey: json.valueTo<proto_basic_types.HederaKey?, Object>(
        key: 'supplyKey',
        parse:
            (v) => proto_basic_types.HederaKey.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      defaultFreezeStatus: json
          .valueTo<proto_basic_types.HederaTokenFreezeStatus?, Object?>(
            key: 'defaultFreezeStatus',
            parse: (v) => proto_basic_types.HederaTokenFreezeStatus.from(v),
          ),
      defaultKycStatus: json
          .valueTo<proto_basic_types.HederaTokenKycStatus?, Object?>(
            key: 'defaultKycStatus',
            parse: (v) => proto_basic_types.HederaTokenKycStatus.from(v),
          ),
      deleted: json.valueAsBool<bool?>(
        'deleted',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      autoRenewAccount: json
          .valueTo<proto_basic_types.HederaAccountID?, Object>(
            key: 'autoRenewAccount',
            parse:
                (v) => proto_basic_types.HederaAccountID.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      autoRenewPeriod: json.valueTo<proto_duration.HederaDuration?, Object>(
        key: 'autoRenewPeriod',
        parse:
            (v) => proto_duration.HederaDuration.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      expiry: json.valueTo<proto_timestamp.HederaTimestamp?, Object>(
        key: 'expiry',
        parse:
            (v) => proto_timestamp.HederaTimestamp.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      memo: json.valueAsString<String?>(
        'memo',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      tokenType: json.valueTo<proto_basic_types.HederaTokenType?, Object?>(
        key: 'tokenType',
        parse: (v) => proto_basic_types.HederaTokenType.from(v),
      ),
      supplyType: json
          .valueTo<proto_basic_types.HederaTokenSupplyType?, Object?>(
            key: 'supplyType',
            parse: (v) => proto_basic_types.HederaTokenSupplyType.from(v),
          ),
      maxSupply: json.valueAsBigInt<BigInt?>(
        'maxSupply',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      feeScheduleKey: json.valueTo<proto_basic_types.HederaKey?, Object>(
        key: 'fee_schedule_key',
        parse:
            (v) => proto_basic_types.HederaKey.fromJson(
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
      pauseKey: json.valueTo<proto_basic_types.HederaKey?, Object>(
        key: 'pause_key',
        parse:
            (v) => proto_basic_types.HederaKey.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      pauseStatus: json
          .valueTo<proto_basic_types.HederaTokenPauseStatus?, Object?>(
            key: 'pause_status',
            parse: (v) => proto_basic_types.HederaTokenPauseStatus.from(v),
          ),
      ledgerId: config.decodeBinary<List<int>?>(
        json.valueAs('ledger_id', normalizeKeyLookup: config.normalizeKeys),
      ),
      metadata: config.decodeBinary<List<int>?>(
        json.valueAs('metadata', normalizeKeyLookup: config.normalizeKeys),
      ),
      metadataKey: json.valueTo<proto_basic_types.HederaKey?, Object>(
        key: 'metadata_key',
        parse:
            (v) => proto_basic_types.HederaKey.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaTokenInfo.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTokenInfo(
      tokenId: decode.messageTo<proto_basic_types.HederaTokenID?>(
        1,
        (b) => proto_basic_types.HederaTokenID.deserialize(b),
      ),
      name: decode.getString<String?>(2),
      symbol: decode.getString<String?>(3),
      decimals: decode.getInt<int?>(4),
      totalSupply: decode.getBigInt<BigInt?>(5),
      treasury: decode.messageTo<proto_basic_types.HederaAccountID?>(
        6,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
      adminKey: decode.messageTo<proto_basic_types.HederaKey?>(
        7,
        (b) => proto_basic_types.HederaKey.deserialize(b),
      ),
      kycKey: decode.messageTo<proto_basic_types.HederaKey?>(
        8,
        (b) => proto_basic_types.HederaKey.deserialize(b),
      ),
      freezeKey: decode.messageTo<proto_basic_types.HederaKey?>(
        9,
        (b) => proto_basic_types.HederaKey.deserialize(b),
      ),
      wipeKey: decode.messageTo<proto_basic_types.HederaKey?>(
        10,
        (b) => proto_basic_types.HederaKey.deserialize(b),
      ),
      supplyKey: decode.messageTo<proto_basic_types.HederaKey?>(
        11,
        (b) => proto_basic_types.HederaKey.deserialize(b),
      ),
      defaultFreezeStatus: decode
          .getEnum<proto_basic_types.HederaTokenFreezeStatus?>(
            12,
            proto_basic_types.HederaTokenFreezeStatus.values,
          ),
      defaultKycStatus: decode.getEnum<proto_basic_types.HederaTokenKycStatus?>(
        13,
        proto_basic_types.HederaTokenKycStatus.values,
      ),
      deleted: decode.getBool<bool?>(14),
      autoRenewAccount: decode.messageTo<proto_basic_types.HederaAccountID?>(
        15,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
      autoRenewPeriod: decode.messageTo<proto_duration.HederaDuration?>(
        16,
        (b) => proto_duration.HederaDuration.deserialize(b),
      ),
      expiry: decode.messageTo<proto_timestamp.HederaTimestamp?>(
        17,
        (b) => proto_timestamp.HederaTimestamp.deserialize(b),
      ),
      memo: decode.getString<String?>(18),
      tokenType: decode.getEnum<proto_basic_types.HederaTokenType?>(
        19,
        proto_basic_types.HederaTokenType.values,
      ),
      supplyType: decode.getEnum<proto_basic_types.HederaTokenSupplyType?>(
        20,
        proto_basic_types.HederaTokenSupplyType.values,
      ),
      maxSupply: decode.getBigInt<BigInt?>(21),
      feeScheduleKey: decode.messageTo<proto_basic_types.HederaKey?>(
        22,
        (b) => proto_basic_types.HederaKey.deserialize(b),
      ),
      customFees:
          decode
              .getListOfBytes(23)
              .map((b) => proto_custom_fees.HederaCustomFee.deserialize(b))
              .toList(),
      pauseKey: decode.messageTo<proto_basic_types.HederaKey?>(
        24,
        (b) => proto_basic_types.HederaKey.deserialize(b),
      ),
      pauseStatus: decode.getEnum<proto_basic_types.HederaTokenPauseStatus?>(
        25,
        proto_basic_types.HederaTokenPauseStatus.values,
      ),
      ledgerId: decode.getBytes<List<int>?>(26),
      metadata: decode.getBytes<List<int>?>(27),
      metadataKey: decode.messageTo<proto_basic_types.HederaKey?>(
        28,
        (b) => proto_basic_types.HederaKey.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoTokenInfo;
}

/// *
///  * A response message for the `getTokenInfo` query.
class HederaTokenGetInfoResponse extends HederaProtoMessage
    with Equality, IHederaQueryRespone {
  /// *
  ///      * The standard response information for queries.&lt;br/&gt;
  ///      * This includes the values requested in the `QueryHeader`
  ///      * (cost, state proof, both, or neither).
  @override
  final proto_response_header.HederaResponseHeader? header;

  /// *
  ///      * The information requested for the identified token.
  final HederaTokenInfo? tokenInfo;

  const HederaTokenGetInfoResponse({this.header, this.tokenInfo});

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
  List<Object?> get protoValues => [header, tokenInfo];

  HederaTokenGetInfoResponse copyWith({
    proto_response_header.HederaResponseHeader? header,

    HederaTokenInfo? tokenInfo,
  }) {
    return HederaTokenGetInfoResponse(
      header: header ?? this.header,
      tokenInfo: tokenInfo ?? this.tokenInfo,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'header': config.encodeMessage(header),
      'tokenInfo': config.encodeMessage(tokenInfo),
    };
  }

  factory HederaTokenGetInfoResponse.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaTokenGetInfoResponse(
      header: json.valueTo<proto_response_header.HederaResponseHeader?, Object>(
        key: 'header',
        parse:
            (v) => proto_response_header.HederaResponseHeader.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      tokenInfo: json.valueTo<HederaTokenInfo?, Object>(
        key: 'tokenInfo',
        parse:
            (v) =>
                HederaTokenInfo.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaTokenGetInfoResponse.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTokenGetInfoResponse(
      header: decode.messageTo<proto_response_header.HederaResponseHeader?>(
        1,
        (b) => proto_response_header.HederaResponseHeader.deserialize(b),
      ),
      tokenInfo: decode.messageTo<HederaTokenInfo?>(
        2,
        (b) => HederaTokenInfo.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoTokenGetInfoResponse;
}
