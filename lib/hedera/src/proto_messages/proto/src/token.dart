import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;
import "package:on_chain/hedera/src/proto_messages/proto/src/custom_fees.dart"
    as proto_custom_fees;

/// *
///  * ## Token
///  * Tokens represent both fungible and non-fungible units of exchange.
///  * The `Token` here represents a token within the network state.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in [RFC2119](https://www.ietf.org/rfc/rfc2119)
///  * and clarified in [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.state.token"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * An Hedera Token Service(HTS) token.
///  *
///  * A token SHALL represent a fungible or non-fungible unit of exchange.&lt;br/&gt;
///  * The specified Treasury Account SHALL receive the initial supply of tokens and
///  * SHALL determine distribution of all tokens once minted.
///  *
class HederaToken extends HederaProtoMessage with Equality {
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
  ///      *   &lt;li&gt;Bitcoin milli-satoshis (21 million whole tokens with 11 decimals).&lt;/li&gt;
  ///      *   &lt;li&gt;Theoretical limit is roughly 92.2 billion with 8 decimals, or
  ///      *       92.2 million with 11 decimals.&lt;/li&gt;
  ///      * &lt;/ul&gt;
  ///      * All token amounts in the network are stored as integer amounts, with each
  ///      * unit representing 10&lt;sup&gt;-decimals&lt;/sup&gt; whole tokens.
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
  final proto_basic_types.HederaAccountID? treasuryAccountId;

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
  ///      * A last used serial number for this token.
  ///      * &lt;p&gt;
  ///      * This SHALL apply only to non-fungible tokens.&lt;br/&gt;
  ///      * When a new NFT is minted, the serial number to apply SHALL be calculated
  ///      * from this value.
  final BigInt? lastUsedSerialNumber;

  /// *
  ///      * A flag indicating that this token is deleted.
  ///      * &lt;p&gt;
  ///      * A transaction involving a deleted token MUST NOT succeed.
  final bool? deleted;

  /// *
  ///      * A type for this token.
  ///      * &lt;p&gt;
  ///      * A token SHALL be either `FUNGIBLE_COMMON` or `NON_FUNGIBLE_UNIQUE`.&lt;br/&gt;
  ///      * If this value was omitted during token creation, `FUNGIBLE_COMMON`
  ///      * SHALL be used.
  final proto_basic_types.HederaTokenType? tokenType;

  /// *
  ///      * A supply type for this token.
  ///      * &lt;p&gt;
  ///      * A token SHALL have either `INFINITE` or `FINITE` supply type.&lt;br/&gt;
  ///      * If this value was omitted during token creation, the value `INFINITE`
  ///      * SHALL be used.
  final proto_basic_types.HederaTokenSupplyType? supplyType;

  /// *
  ///      * An identifier for the account (if any) that the network will attempt
  ///      * to charge for this token's auto-renewal upon expiration.
  ///      * &lt;p&gt;
  ///      * This field is OPTIONAL. If it is not set then renewal fees SHALL be
  ///      * charged to the account identified by `treasury_account_id`.
  final proto_basic_types.HederaAccountID? autoRenewAccountId;

  /// *
  ///      * A number of seconds by which the network should automatically extend
  ///      * this token's expiration.
  ///      * &lt;p&gt;
  ///      * If the token has a valid auto-renew account, and is not deleted upon
  ///      * expiration, the network SHALL attempt to automatically renew this
  ///      * token.&lt;br/&gt;
  ///      * If this is not provided in an allowed range on token creation, the
  ///      * transaction SHALL fail with `INVALID_AUTO_RENEWAL_PERIOD`.&lt;br/&gt;
  ///      * The default values for the minimum period and maximum period are 30 days
  ///      * and 90 days, respectively.
  final BigInt? autoRenewSeconds;

  /// *
  ///      * An expiration time for this token, in seconds since the epoch.
  ///      * &lt;p&gt;
  ///      * For this purpose, `epoch` SHALL be the
  ///      * UNIX epoch with 0 at `1970-01-01T00:00:00.000Z`.
  final BigInt? expirationSecond;

  /// *
  ///      * A short description of this token.
  ///      * &lt;p&gt;
  ///      * This value, if set, MUST NOT exceed `transaction.maxMemoUtf8Bytes`
  ///      * (default 100) bytes when encoded as UTF-8.
  final String? memo;

  /// *
  ///      * A maximum supply of this token.&lt;br/&gt;
  ///      * This is the maximum number of tokens of this type that may be issued.
  ///      * &lt;p&gt;
  ///      * This limit SHALL apply regardless of `token_type`.&lt;br/&gt;
  ///      * If `supply_type` is `INFINITE` then this value MUST be 0.&lt;br/&gt;
  ///      * If `supply_type` is `FINITE`, then this value MUST be greater than 0.
  final BigInt? maxSupply;

  /// *
  ///      * A flag indicating that this token is paused.
  ///      * &lt;p&gt;
  ///      * A transaction involving a paused token, other than token_unpause,
  ///      * MUST NOT succeed.
  final bool? paused;

  /// *
  ///      * A flag indicating that accounts associated to this token are frozen by
  ///      * default.
  ///      * &lt;p&gt;
  ///      * Accounts newly associated with this token CANNOT transact in the token
  ///      * until unfrozen.&lt;br/&gt;
  ///      * This SHALL NOT prevent a `tokenReject` transaction to return the tokens
  ///      * from an account to the treasury account.
  final bool? accountsFrozenByDefault;

  /// *
  ///       * A flag indicating that accounts associated with this token are granted
  ///       * KYC by default.
  final bool? accountsKycGrantedByDefault;

  /// *
  ///      * A custom fee schedule for this token.
  final List<proto_custom_fees.HederaCustomFee> customFees;

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

  const HederaToken({
    this.tokenId,
    this.name,
    this.symbol,
    this.decimals,
    this.totalSupply,
    this.treasuryAccountId,
    this.adminKey,
    this.kycKey,
    this.freezeKey,
    this.wipeKey,
    this.supplyKey,
    this.feeScheduleKey,
    this.pauseKey,
    this.lastUsedSerialNumber,
    this.deleted,
    this.tokenType,
    this.supplyType,
    this.autoRenewAccountId,
    this.autoRenewSeconds,
    this.expirationSecond,
    this.memo,
    this.maxSupply,
    this.paused,
    this.accountsFrozenByDefault,
    this.accountsKycGrantedByDefault,
    this.customFees = const [],
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
        ProtoFieldConfig.int32(4),
        ProtoFieldConfig.int64(5),
        ProtoFieldConfig.message(6),
        ProtoFieldConfig.message(7),
        ProtoFieldConfig.message(8),
        ProtoFieldConfig.message(9),
        ProtoFieldConfig.message(10),
        ProtoFieldConfig.message(11),
        ProtoFieldConfig.message(12),
        ProtoFieldConfig.message(13),
        ProtoFieldConfig.int64(14),
        ProtoFieldConfig.bool(15),
        ProtoFieldConfig.enumType(16),
        ProtoFieldConfig.enumType(17),
        ProtoFieldConfig.message(18),
        ProtoFieldConfig.int64(19),
        ProtoFieldConfig.int64(20),
        ProtoFieldConfig.string(21),
        ProtoFieldConfig.int64(22),
        ProtoFieldConfig.bool(23),
        ProtoFieldConfig.bool(24),
        ProtoFieldConfig.bool(25),
        ProtoFieldConfig.repeated(
          fieldNumber: 26,
          elementType: ProtoFieldType.message,
        ),
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
    treasuryAccountId,
    adminKey,
    kycKey,
    freezeKey,
    wipeKey,
    supplyKey,
    feeScheduleKey,
    pauseKey,
    lastUsedSerialNumber,
    deleted,
    tokenType,
    supplyType,
    autoRenewAccountId,
    autoRenewSeconds,
    expirationSecond,
    memo,
    maxSupply,
    paused,
    accountsFrozenByDefault,
    accountsKycGrantedByDefault,
    customFees,
    metadata,
    metadataKey,
  ];

  HederaToken copyWith({
    proto_basic_types.HederaTokenID? tokenId,

    String? name,

    String? symbol,

    int? decimals,

    BigInt? totalSupply,

    proto_basic_types.HederaAccountID? treasuryAccountId,

    proto_basic_types.HederaKey? adminKey,

    proto_basic_types.HederaKey? kycKey,

    proto_basic_types.HederaKey? freezeKey,

    proto_basic_types.HederaKey? wipeKey,

    proto_basic_types.HederaKey? supplyKey,

    proto_basic_types.HederaKey? feeScheduleKey,

    proto_basic_types.HederaKey? pauseKey,

    BigInt? lastUsedSerialNumber,

    bool? deleted,

    proto_basic_types.HederaTokenType? tokenType,

    proto_basic_types.HederaTokenSupplyType? supplyType,

    proto_basic_types.HederaAccountID? autoRenewAccountId,

    BigInt? autoRenewSeconds,

    BigInt? expirationSecond,

    String? memo,

    BigInt? maxSupply,

    bool? paused,

    bool? accountsFrozenByDefault,

    bool? accountsKycGrantedByDefault,

    List<proto_custom_fees.HederaCustomFee>? customFees,

    List<int>? metadata,

    proto_basic_types.HederaKey? metadataKey,
  }) {
    return HederaToken(
      tokenId: tokenId ?? this.tokenId,
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
      decimals: decimals ?? this.decimals,
      totalSupply: totalSupply ?? this.totalSupply,
      treasuryAccountId: treasuryAccountId ?? this.treasuryAccountId,
      adminKey: adminKey ?? this.adminKey,
      kycKey: kycKey ?? this.kycKey,
      freezeKey: freezeKey ?? this.freezeKey,
      wipeKey: wipeKey ?? this.wipeKey,
      supplyKey: supplyKey ?? this.supplyKey,
      feeScheduleKey: feeScheduleKey ?? this.feeScheduleKey,
      pauseKey: pauseKey ?? this.pauseKey,
      lastUsedSerialNumber: lastUsedSerialNumber ?? this.lastUsedSerialNumber,
      deleted: deleted ?? this.deleted,
      tokenType: tokenType ?? this.tokenType,
      supplyType: supplyType ?? this.supplyType,
      autoRenewAccountId: autoRenewAccountId ?? this.autoRenewAccountId,
      autoRenewSeconds: autoRenewSeconds ?? this.autoRenewSeconds,
      expirationSecond: expirationSecond ?? this.expirationSecond,
      memo: memo ?? this.memo,
      maxSupply: maxSupply ?? this.maxSupply,
      paused: paused ?? this.paused,
      accountsFrozenByDefault:
          accountsFrozenByDefault ?? this.accountsFrozenByDefault,
      accountsKycGrantedByDefault:
          accountsKycGrantedByDefault ?? this.accountsKycGrantedByDefault,
      customFees: customFees ?? this.customFees,
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
      'token_id': config.encodeMessage(tokenId),
      'name': name,
      'symbol': symbol,
      'decimals': decimals,
      'total_supply': config.encodeBigint(totalSupply),
      'treasury_account_id': config.encodeMessage(treasuryAccountId),
      'admin_key': config.encodeMessage(adminKey),
      'kyc_key': config.encodeMessage(kycKey),
      'freeze_key': config.encodeMessage(freezeKey),
      'wipe_key': config.encodeMessage(wipeKey),
      'supply_key': config.encodeMessage(supplyKey),
      'fee_schedule_key': config.encodeMessage(feeScheduleKey),
      'pause_key': config.encodeMessage(pauseKey),
      'last_used_serial_number': config.encodeBigint(lastUsedSerialNumber),
      'deleted': deleted,
      'token_type': config.encodeEnum(tokenType),
      'supply_type': config.encodeEnum(supplyType),
      'auto_renew_account_id': config.encodeMessage(autoRenewAccountId),
      'auto_renew_seconds': config.encodeBigint(autoRenewSeconds),
      'expiration_second': config.encodeBigint(expirationSecond),
      'memo': memo,
      'max_supply': config.encodeBigint(maxSupply),
      'paused': paused,
      'accounts_frozen_by_default': accountsFrozenByDefault,
      'accounts_kyc_granted_by_default': accountsKycGrantedByDefault,
      'custom_fees': customFees.map((e) => config.encodeMessage(e)).toList(),
      'metadata': config.encodeBinary(metadata),
      'metadata_key': config.encodeMessage(metadataKey),
    };
  }

  factory HederaToken.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaToken(
      tokenId: json.valueTo<proto_basic_types.HederaTokenID?, Object>(
        key: 'token_id',
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
        'total_supply',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      treasuryAccountId: json
          .valueTo<proto_basic_types.HederaAccountID?, Object>(
            key: 'treasury_account_id',
            parse:
                (v) => proto_basic_types.HederaAccountID.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      adminKey: json.valueTo<proto_basic_types.HederaKey?, Object>(
        key: 'admin_key',
        parse:
            (v) => proto_basic_types.HederaKey.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      kycKey: json.valueTo<proto_basic_types.HederaKey?, Object>(
        key: 'kyc_key',
        parse:
            (v) => proto_basic_types.HederaKey.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      freezeKey: json.valueTo<proto_basic_types.HederaKey?, Object>(
        key: 'freeze_key',
        parse:
            (v) => proto_basic_types.HederaKey.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      wipeKey: json.valueTo<proto_basic_types.HederaKey?, Object>(
        key: 'wipe_key',
        parse:
            (v) => proto_basic_types.HederaKey.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      supplyKey: json.valueTo<proto_basic_types.HederaKey?, Object>(
        key: 'supply_key',
        parse:
            (v) => proto_basic_types.HederaKey.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
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
      pauseKey: json.valueTo<proto_basic_types.HederaKey?, Object>(
        key: 'pause_key',
        parse:
            (v) => proto_basic_types.HederaKey.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      lastUsedSerialNumber: json.valueAsBigInt<BigInt?>(
        'last_used_serial_number',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      deleted: json.valueAsBool<bool?>(
        'deleted',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      tokenType: json.valueTo<proto_basic_types.HederaTokenType?, Object?>(
        key: 'token_type',
        parse: (v) => proto_basic_types.HederaTokenType.from(v),
      ),
      supplyType: json
          .valueTo<proto_basic_types.HederaTokenSupplyType?, Object?>(
            key: 'supply_type',
            parse: (v) => proto_basic_types.HederaTokenSupplyType.from(v),
          ),
      autoRenewAccountId: json
          .valueTo<proto_basic_types.HederaAccountID?, Object>(
            key: 'auto_renew_account_id',
            parse:
                (v) => proto_basic_types.HederaAccountID.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      autoRenewSeconds: json.valueAsBigInt<BigInt?>(
        'auto_renew_seconds',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      expirationSecond: json.valueAsBigInt<BigInt?>(
        'expiration_second',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      memo: json.valueAsString<String?>(
        'memo',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      maxSupply: json.valueAsBigInt<BigInt?>(
        'max_supply',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      paused: json.valueAsBool<bool?>(
        'paused',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      accountsFrozenByDefault: json.valueAsBool<bool?>(
        'accounts_frozen_by_default',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      accountsKycGrantedByDefault: json.valueAsBool<bool?>(
        'accounts_kyc_granted_by_default',
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

  factory HederaToken.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaToken(
      tokenId: decode.messageTo<proto_basic_types.HederaTokenID?>(
        1,
        (b) => proto_basic_types.HederaTokenID.deserialize(b),
      ),
      name: decode.getString<String?>(2),
      symbol: decode.getString<String?>(3),
      decimals: decode.getInt<int?>(4),
      totalSupply: decode.getBigInt<BigInt?>(5),
      treasuryAccountId: decode.messageTo<proto_basic_types.HederaAccountID?>(
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
      feeScheduleKey: decode.messageTo<proto_basic_types.HederaKey?>(
        12,
        (b) => proto_basic_types.HederaKey.deserialize(b),
      ),
      pauseKey: decode.messageTo<proto_basic_types.HederaKey?>(
        13,
        (b) => proto_basic_types.HederaKey.deserialize(b),
      ),
      lastUsedSerialNumber: decode.getBigInt<BigInt?>(14),
      deleted: decode.getBool<bool?>(15),
      tokenType: decode.getEnum<proto_basic_types.HederaTokenType?>(
        16,
        proto_basic_types.HederaTokenType.values,
      ),
      supplyType: decode.getEnum<proto_basic_types.HederaTokenSupplyType?>(
        17,
        proto_basic_types.HederaTokenSupplyType.values,
      ),
      autoRenewAccountId: decode.messageTo<proto_basic_types.HederaAccountID?>(
        18,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
      autoRenewSeconds: decode.getBigInt<BigInt?>(19),
      expirationSecond: decode.getBigInt<BigInt?>(20),
      memo: decode.getString<String?>(21),
      maxSupply: decode.getBigInt<BigInt?>(22),
      paused: decode.getBool<bool?>(23),
      accountsFrozenByDefault: decode.getBool<bool?>(24),
      accountsKycGrantedByDefault: decode.getBool<bool?>(25),
      customFees:
          decode
              .getListOfBytes(26)
              .map((b) => proto_custom_fees.HederaCustomFee.deserialize(b))
              .toList(),
      metadata: decode.getBytes<List<int>?>(27),
      metadataKey: decode.messageTo<proto_basic_types.HederaKey?>(
        28,
        (b) => proto_basic_types.HederaKey.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoToken;
}
