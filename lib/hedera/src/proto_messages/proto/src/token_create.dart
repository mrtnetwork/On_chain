import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;
import "package:on_chain/hedera/src/proto_messages/proto/src/timestamp.dart"
    as proto_timestamp;
import "package:on_chain/hedera/src/proto_messages/proto/src/duration.dart"
    as proto_duration;
import "package:on_chain/hedera/src/proto_messages/proto/src/custom_fees.dart"
    as proto_custom_fees;

/// *
///  * # Token Create
///  * Create an Hedera Token Service (HTS) token.
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
///  * Create an HTS token.
///  *
///  * #### Keys
///  * Each token has several keys that, separately, control different functions
///  * for that token. It is *_strongly_* recommended that each key assigned to
///  * a token be unique, or disabled by assigning an empty `KeyList`.
///  * Keys and purpose
///  * - `adminKey` is a general access and may authorize a token update
///  *   transaction as well as _update the other keys_. Even the admin key
///  *   cannot authorize _adding_ a key that is not present, however.&lt;br/&gt;
///  *   The admin key may also delete the token entirely.
///  * - `fee_schedule` may authorize updating the token custom fees. If this
///  *   key is not present, the custom fees for the token are fixed and immutable.
///  * - `freeze` may authorize a token freeze or unfreeze transaction.
///  *   If this key is not present, accounts holding this token cannot have
///  *   their tokens frozen or unfrozen.
///  * - `kyc` may authorize a token grant KYC or revoke KYC transaction.
///  *   If this key is not present, accounts holding this token cannot have
///  *   KYC status granted or revoked.
///  * - `metadata` may authorize token update nfts transactions.
///  *   If this key is not present, the token metadata values for that
///  *   non-fungible/unique token _type_ will be immutable.
///  * - `pause` may authorize a token pause or token unpause transaction.
///  *   If this key is not present, the token cannot be paused (preventing any
///  *   account from transacting in that token) or resumed.
///  * - `supply` may authorize a token mint or burn transaction.
///  *   If this key is not present, the token cannot mint additional supply and
///  *   existing tokens cannot be "burned" from the treasury (but _might_ still be
///  *   "burned" from individual accounts, c.f. `wipeKey` and `tokenWipe`).
///  * - `wipe` may authorize a token wipe account transaction.
///  *   If this key is not present, accounts holding this token cannot have
///  *   their balance or NFTs wiped (effectively burned).
///  *
///  * #### Requirements
///  * If `tokenType` is fungible/common, the `initialSupply` MUST be strictly
///  * greater than zero(`0`).&lt;br/&gt;
///  * If `tokenType` is non-fungible/unique, the `initialSupply` MUST
///  * be zero(`0`).&lt;br/&gt;
///  * If `tokenSupplyType` is "infinite", the `maxSupply` MUST be zero(`0`).&lt;br/&gt;
///  * If `tokenSupplyType` is "finite", the `maxSupply` MUST be strictly
///  * greater than zero(`0`).&lt;br/&gt;
///  *
///  * ### Block Stream Effects
///  * If the token is created, the Token Identifier SHALL be in the receipt.&lt;br/&gt;
class HederaTokenCreateTransactionBody extends HederaProtoMessage
    with Equality {
  /// *
  ///      * A name for the token.&lt;br/&gt;
  ///      * This is generally the "full name" displayed in wallet software.
  ///      * &lt;p&gt;
  ///      * This field is REQUIRED.&lt;br/&gt;
  ///      * This value MUST NOT exceed 100 bytes when encoded as UTF-8.&lt;br/&gt;
  ///      * This value MUST NOT contain the Unicode NUL codepoint.
  final String? name;

  /// *
  ///      * A symbol to use for the token.
  ///      * &lt;p&gt;
  ///      * This field is REQUIRED.&lt;br/&gt;
  ///      * This value MUST NOT exceed 100 bytes when encoded as UTF-8.&lt;br/&gt;
  ///      * This value MUST NOT contain the Unicode NUL codepoint.
  final String? symbol;

  /// *
  ///      * A decimal precision of the token's smallest denomination.&lt;br/&gt;
  ///      * Most values are described in terms of this smallest denomination,
  ///      * so the token initial supply, for instance, must be divided by
  ///      * &lt;tt&gt;10&lt;sup&gt;decimals&lt;/sup&gt;&lt;/tt&gt; to get whole tokens.
  ///      * &lt;p&gt;
  ///      * This MUST be zero(`0`) for non-fungible/unique tokens.
  final int? decimals;

  /// *
  ///      * An initial supply, in the smallest denomination for the token.
  ///      * &lt;p&gt;
  ///      * This amount SHALL be transferred to the treasury account as part
  ///      * of this transaction.&lt;br/&gt;
  ///      * This amount MUST be specified in the smallest denomination for the
  ///      * token (i.e. &lt;tt&gt;10&lt;sup&gt;-decimals&lt;/sup&gt;&lt;/tt&gt; whole tokens).&lt;br/&gt;
  ///      * This MUST be zero(`0`) for a non-fungible/unique token.
  final BigInt? initialSupply;

  /// *
  ///      * A treasury account identifier.
  ///      * &lt;p&gt;
  ///      * This field is REQUIRED.&lt;br/&gt;
  ///      * The identified account SHALL be designated the "treasury" for the
  ///      * new token, and all tokens "minted" SHALL be delivered to that account,
  ///      * including the initial supply, if any.&lt;br/&gt;
  ///      * The identified account MUST exist, MUST NOT be expired, and SHOULD
  ///      * have a non-zero HBAR balance.&lt;br/&gt;
  ///      * The identified account SHALL be associated to the new token.
  final proto_basic_types.HederaAccountID? treasury;

  /// *
  ///      * An Hedera key for token administration.
  ///      * &lt;p&gt;
  ///      * This key, if set, SHALL have administrative authority for this token and
  ///      * MAY authorize token update and/or token delete transactions.&lt;br/&gt;
  ///      * If this key is not set, or is an empty `KeyList`, this token SHALL be
  ///      * immutable, except for expiration and renewal.
  final proto_basic_types.HederaKey? adminKey;

  /// *
  ///      * An Hedera key for managing account KYC.
  ///      * &lt;p&gt;
  ///      * This key, if set, SHALL have KYC authority for this token and
  ///      * MAY authorize transactions to grant or revoke KYC for accounts.&lt;br/&gt;
  ///      * If this key is not set, or is an empty `KeyList`, KYC status for this
  ///      * token SHALL NOT be granted or revoked for any account.&lt;br/&gt;
  ///      * If this key is removed after granting KYC, those grants SHALL remain
  ///      * and cannot be revoked.
  final proto_basic_types.HederaKey? kycKey;

  /// *
  ///      * An Hedera key for managing asset "freeze".
  ///      * &lt;p&gt;
  ///      * This key, if set, SHALL have "freeze" authority for this token and
  ///      * MAY authorize transactions to freeze or unfreeze accounts
  ///      * with respect to this token.&lt;br/&gt;
  ///      * If this key is not set, or is an empty `KeyList`, this token
  ///      * SHALL NOT be frozen or unfrozen for any account.&lt;br/&gt;
  ///      * If this key is removed after freezing accounts, those accounts
  ///      * SHALL remain frozen and cannot be unfrozen.
  final proto_basic_types.HederaKey? freezeKey;

  /// *
  ///      * An Hedera key for wiping tokens from accounts.
  ///      * &lt;p&gt;
  ///      * This key, if set, SHALL have "wipe" authority for this token and
  ///      * MAY authorize transactions to "wipe" any amount of this token from
  ///      * any account, effectively burning the tokens "wiped".&lt;br/&gt;
  ///      * If this key is not set, or is an empty `KeyList`, it SHALL NOT be
  ///      * possible to "wipe" this token from an account.
  final proto_basic_types.HederaKey? wipeKey;

  /// *
  ///      * An Hedera key for "minting" and "burning" tokens.
  ///      * &lt;p&gt;
  ///      * This key, if set, MAY authorize transactions to "mint" new tokens to
  ///      * be delivered to the token treasury or "burn" tokens held by the
  ///      * token treasury.&lt;br/&gt;
  ///      * If this key is not set, or is an empty `KeyList`, it SHALL NOT be
  ///      * possible to change the supply of tokens and neither "mint" nor "burn"
  ///      * transactions SHALL be permitted.
  final proto_basic_types.HederaKey? supplyKey;

  /// *
  ///      * An initial Freeze status for accounts associated to this token.
  ///      * &lt;p&gt;
  ///      * If this value is set, an account MUST be the subject of a
  ///      * `tokenUnfreeze` transaction after associating to the token before
  ///      * that account can send or receive this token.&lt;br/&gt;
  ///      * If this value is set, the `freezeKey` SHOULD be set.&lt;br/&gt;
  ///      * If the `freezeKey` is not set, any account associated to this token
  ///      * while this value is set SHALL be permanently frozen.
  ///      * &lt;p&gt;
  ///      * &lt;blockquote&gt;REVIEW NOTE&lt;blockquote&gt;
  ///      * Should we prevent setting this value true for tokens with no freeze
  ///      * key?&lt;br/&gt;
  ///      * Should we set this value to false if a freeze key is removed?
  ///      * &lt;/blockquote&gt;&lt;/blockquote&gt;
  final bool? freezeDefault;

  /// *
  ///      * An expiration timestamp.
  ///      * &lt;p&gt;
  ///      * If the `autoRenewAccount` and `autoRenewPeriod` fields are set, this
  ///      * value SHALL be replaced with the current consensus time extended
  ///      * by the `autoRenewPeriod` duration.&lt;br/&gt;
  ///      * If this value is set and token expiration is enabled in network
  ///      * configuration, this token SHALL expire when consensus time exceeds
  ///      * this value, and MAY be subsequently removed from the network state.&lt;br/&gt;
  ///      * If this value is not set, and the automatic renewal account is also not
  ///      * set, then this value SHALL default to the current consensus time
  ///      * extended by the "default" expiration period from network configuration.
  final proto_timestamp.HederaTimestamp? expiry;

  /// *
  ///      * An identifier for the account to be charged renewal fees at the token's
  ///      * expiry to extend the lifetime of the token.
  ///      * &lt;p&gt;
  ///      * If this value is set, the token lifetime SHALL be extended by the
  ///      * _smallest_ of the following:
  ///      * &lt;ul&gt;
  ///      *   &lt;li&gt;The current `autoRenewPeriod` duration.&lt;/li&gt;
  ///      *   &lt;li&gt;The maximum duration that this account has funds to purchase.&lt;/li&gt;
  ///      *   &lt;li&gt;The configured MAX_AUTORENEW_PERIOD at the time of automatic
  ///      *       renewal.&lt;/li&gt;
  ///      * &lt;/ul&gt;
  ///      * If this account's HBAR balance is `0` when the token must be
  ///      * renewed, then the token SHALL be expired, and MAY be subsequently
  ///      * removed from state.&lt;br/&gt;
  ///      * If this value is set, the referenced account MUST sign this
  ///      * transaction.
  final proto_basic_types.HederaAccountID? autoRenewAccount;

  /// *
  ///      * A duration between token automatic renewals.&lt;br/&gt;
  ///      * All entities in state may be charged "rent" occasionally (typically
  ///      * every 90 days) to prevent unnecessary growth of the ledger. This value
  ///      * sets the interval between such events for this token.
  ///      * &lt;p&gt;
  ///      * This value MUST be set.&lt;br/&gt;
  ///      * This value MUST be greater than the configured
  ///      * MIN_AUTORENEW_PERIOD.&lt;br/&gt;
  ///      * This value MUST be less than the configured MAX_AUTORENEW_PERIOD.
  final proto_duration.HederaDuration? autoRenewPeriod;

  /// *
  ///      * A short description for this token.
  ///      * &lt;p&gt;
  ///      * This value, if set, MUST NOT exceed `transaction.maxMemoUtf8Bytes`
  ///      * (default 100) bytes when encoded as UTF-8.
  final String? memo;

  /// *
  ///      * A type for this token, according to IWA classification.
  ///      * &lt;p&gt;
  ///      * If this value is not set, the token SHALL have the default type of
  ///      * fungible/common.&lt;br/&gt;
  ///      * This field SHALL be immutable.
  final proto_basic_types.HederaTokenType? tokenType;

  /// *
  ///      * A supply type for this token, according to IWA classification.
  ///      * &lt;p&gt;
  ///      * If this value is not set, the token SHALL have the default supply
  ///      * type of "infinite" (which is, as a practical matter,
  ///      * (2&lt;sup&gt;&lt;i&gt;63&lt;/i&gt;&lt;/sup&gt;-1)/10&lt;sup&gt;&lt;i&gt;decimals&lt;/i&gt;&lt;/sup&gt;).&lt;br/&gt;
  ///      * This field SHALL be immutable.
  final proto_basic_types.HederaTokenSupplyType? supplyType;

  /// *
  ///      * A maximum supply for this token.
  ///      * &lt;p&gt;
  ///      * This SHALL be interpreted in terms of the smallest fractional unit for
  ///      * this token.&lt;br/&gt;
  ///      * If `supplyType` is "infinite", this MUST be `0`.&lt;br/&gt;
  ///      * This field SHALL be immutable.
  final BigInt? maxSupply;

  /// *
  ///      * An Hedera key for managing the token custom fee schedule.
  ///      * &lt;p&gt;
  ///      * This key, if set, MAY authorize transactions to modify the
  ///      * `custom_fees` for this token.&lt;br/&gt;
  ///      * If this key is not set, or is an empty `KeyList`, the `custom_fees`
  ///      * for this token SHALL NOT be modified.
  final proto_basic_types.HederaKey? feeScheduleKey;

  /// *
  ///      * A list of custom fees representing a fee schedule.
  ///      * &lt;p&gt;
  ///      * This list MAY be empty, which SHALL mean that there
  ///      * are no custom fees for this token.&lt;br/&gt;
  ///      * If this token is a non-fungible/unique type, the entries
  ///      * in this list MUST NOT declare a `fractional_fee`.&lt;br/&gt;
  ///      * If this token is a fungible/common type, the entries in this
  ///      * list MUST NOT declare a `royalty_fee`.&lt;br/&gt;
  ///      * Any token type MAY include entries that declare a `fixed_fee`.
  final List<proto_custom_fees.HederaCustomFee> customFees;

  /// *
  ///      * An Hedera key for managing token "pause".
  ///      * &lt;p&gt;
  ///      * This key, if set, SHALL have "pause" authority for this token and
  ///      * MAY authorize transactions to pause or unpause this token.&lt;br/&gt;
  ///      * If this key is not set, or is an empty `KeyList`, this token
  ///      * SHALL NOT be paused or unpaused.&lt;br/&gt;
  ///      * If this key is removed while the token is paused, the token cannot
  ///      * be unpaused and SHALL remain paused.
  final proto_basic_types.HederaKey? pauseKey;

  /// *
  ///      * Token "Metadata".
  ///      * &lt;p&gt;
  ///      * The value, if set, MUST NOT exceed 100 bytes.&lt;br/&gt;
  ///      * &lt;dl&gt;&lt;dt&gt;Examples&lt;/dt&gt;
  ///      *   &lt;dd&gt;hcs://1/0.0.4896575&lt;/dd&gt;
  ///      *   &lt;dd&gt;ipfs://bafkreifd7tcjjuwxxf4qkaibkj62pj4mhfuud7plwrc3pfoygt55al6syi&lt;/dd&gt;
  ///      * &lt;/dl&gt;
  final List<int>? metadata;

  /// *
  ///      * An Hedera key for managing the token `metadata`.
  ///      * &lt;p&gt;
  ///      * This key, if set, MAY authorize transactions to modify the
  ///      * `metadata` for this token.&lt;br/&gt;
  ///      * If this key is not set, or is an empty `KeyList`, the `metadata`
  ///      * for this token SHALL NOT be modified.
  final proto_basic_types.HederaKey? metadataKey;

  const HederaTokenCreateTransactionBody({
    this.name,
    this.symbol,
    this.decimals,
    this.initialSupply,
    this.treasury,
    this.adminKey,
    this.kycKey,
    this.freezeKey,
    this.wipeKey,
    this.supplyKey,
    this.freezeDefault,
    this.expiry,
    this.autoRenewAccount,
    this.autoRenewPeriod,
    this.memo,
    this.tokenType,
    this.supplyType,
    this.maxSupply,
    this.feeScheduleKey,
    this.customFees = const [],
    this.pauseKey,
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
        ProtoFieldConfig.string(1),
        ProtoFieldConfig.string(2),
        ProtoFieldConfig.uint32(3),
        ProtoFieldConfig.uint64(4),
        ProtoFieldConfig.message(5),
        ProtoFieldConfig.message(6),
        ProtoFieldConfig.message(7),
        ProtoFieldConfig.message(8),
        ProtoFieldConfig.message(9),
        ProtoFieldConfig.message(10),
        ProtoFieldConfig.bool(11),
        ProtoFieldConfig.message(13),
        ProtoFieldConfig.message(14),
        ProtoFieldConfig.message(15),
        ProtoFieldConfig.string(16),
        ProtoFieldConfig.enumType(17),
        ProtoFieldConfig.enumType(18),
        ProtoFieldConfig.int64(19),
        ProtoFieldConfig.message(20),
        ProtoFieldConfig.repeated(
          fieldNumber: 21,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.message(22),
        ProtoFieldConfig.bytes(23),
        ProtoFieldConfig.message(24),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    name,
    symbol,
    decimals,
    initialSupply,
    treasury,
    adminKey,
    kycKey,
    freezeKey,
    wipeKey,
    supplyKey,
    freezeDefault,
    expiry,
    autoRenewAccount,
    autoRenewPeriod,
    memo,
    tokenType,
    supplyType,
    maxSupply,
    feeScheduleKey,
    customFees,
    pauseKey,
    metadata,
    metadataKey,
  ];

  HederaTokenCreateTransactionBody copyWith({
    String? name,

    String? symbol,

    int? decimals,

    BigInt? initialSupply,

    proto_basic_types.HederaAccountID? treasury,

    proto_basic_types.HederaKey? adminKey,

    proto_basic_types.HederaKey? kycKey,

    proto_basic_types.HederaKey? freezeKey,

    proto_basic_types.HederaKey? wipeKey,

    proto_basic_types.HederaKey? supplyKey,

    bool? freezeDefault,

    proto_timestamp.HederaTimestamp? expiry,

    proto_basic_types.HederaAccountID? autoRenewAccount,

    proto_duration.HederaDuration? autoRenewPeriod,

    String? memo,

    proto_basic_types.HederaTokenType? tokenType,

    proto_basic_types.HederaTokenSupplyType? supplyType,

    BigInt? maxSupply,

    proto_basic_types.HederaKey? feeScheduleKey,

    List<proto_custom_fees.HederaCustomFee>? customFees,

    proto_basic_types.HederaKey? pauseKey,

    List<int>? metadata,

    proto_basic_types.HederaKey? metadataKey,
  }) {
    return HederaTokenCreateTransactionBody(
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
      decimals: decimals ?? this.decimals,
      initialSupply: initialSupply ?? this.initialSupply,
      treasury: treasury ?? this.treasury,
      adminKey: adminKey ?? this.adminKey,
      kycKey: kycKey ?? this.kycKey,
      freezeKey: freezeKey ?? this.freezeKey,
      wipeKey: wipeKey ?? this.wipeKey,
      supplyKey: supplyKey ?? this.supplyKey,
      freezeDefault: freezeDefault ?? this.freezeDefault,
      expiry: expiry ?? this.expiry,
      autoRenewAccount: autoRenewAccount ?? this.autoRenewAccount,
      autoRenewPeriod: autoRenewPeriod ?? this.autoRenewPeriod,
      memo: memo ?? this.memo,
      tokenType: tokenType ?? this.tokenType,
      supplyType: supplyType ?? this.supplyType,
      maxSupply: maxSupply ?? this.maxSupply,
      feeScheduleKey: feeScheduleKey ?? this.feeScheduleKey,
      customFees: customFees ?? this.customFees,
      pauseKey: pauseKey ?? this.pauseKey,
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
      'name': name,
      'symbol': symbol,
      'decimals': decimals,
      'initialSupply': config.encodeBigint(initialSupply),
      'treasury': config.encodeMessage(treasury),
      'adminKey': config.encodeMessage(adminKey),
      'kycKey': config.encodeMessage(kycKey),
      'freezeKey': config.encodeMessage(freezeKey),
      'wipeKey': config.encodeMessage(wipeKey),
      'supplyKey': config.encodeMessage(supplyKey),
      'freezeDefault': freezeDefault,
      'expiry': config.encodeMessage(expiry),
      'autoRenewAccount': config.encodeMessage(autoRenewAccount),
      'autoRenewPeriod': config.encodeMessage(autoRenewPeriod),
      'memo': memo,
      'tokenType': config.encodeEnum(tokenType),
      'supplyType': config.encodeEnum(supplyType),
      'maxSupply': config.encodeBigint(maxSupply),
      'fee_schedule_key': config.encodeMessage(feeScheduleKey),
      'custom_fees': customFees.map((e) => config.encodeMessage(e)).toList(),
      'pause_key': config.encodeMessage(pauseKey),
      'metadata': config.encodeBinary(metadata),
      'metadata_key': config.encodeMessage(metadataKey),
    };
  }

  factory HederaTokenCreateTransactionBody.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaTokenCreateTransactionBody(
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
      initialSupply: json.valueAsBigInt<BigInt?>(
        'initialSupply',
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
      freezeDefault: json.valueAsBool<bool?>(
        'freezeDefault',
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

  factory HederaTokenCreateTransactionBody.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTokenCreateTransactionBody(
      name: decode.getString<String?>(1),
      symbol: decode.getString<String?>(2),
      decimals: decode.getInt<int?>(3),
      initialSupply: decode.getBigInt<BigInt?>(4),
      treasury: decode.messageTo<proto_basic_types.HederaAccountID?>(
        5,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
      adminKey: decode.messageTo<proto_basic_types.HederaKey?>(
        6,
        (b) => proto_basic_types.HederaKey.deserialize(b),
      ),
      kycKey: decode.messageTo<proto_basic_types.HederaKey?>(
        7,
        (b) => proto_basic_types.HederaKey.deserialize(b),
      ),
      freezeKey: decode.messageTo<proto_basic_types.HederaKey?>(
        8,
        (b) => proto_basic_types.HederaKey.deserialize(b),
      ),
      wipeKey: decode.messageTo<proto_basic_types.HederaKey?>(
        9,
        (b) => proto_basic_types.HederaKey.deserialize(b),
      ),
      supplyKey: decode.messageTo<proto_basic_types.HederaKey?>(
        10,
        (b) => proto_basic_types.HederaKey.deserialize(b),
      ),
      freezeDefault: decode.getBool<bool?>(11),
      expiry: decode.messageTo<proto_timestamp.HederaTimestamp?>(
        13,
        (b) => proto_timestamp.HederaTimestamp.deserialize(b),
      ),
      autoRenewAccount: decode.messageTo<proto_basic_types.HederaAccountID?>(
        14,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
      autoRenewPeriod: decode.messageTo<proto_duration.HederaDuration?>(
        15,
        (b) => proto_duration.HederaDuration.deserialize(b),
      ),
      memo: decode.getString<String?>(16),
      tokenType: decode.getEnum<proto_basic_types.HederaTokenType?>(
        17,
        proto_basic_types.HederaTokenType.values,
      ),
      supplyType: decode.getEnum<proto_basic_types.HederaTokenSupplyType?>(
        18,
        proto_basic_types.HederaTokenSupplyType.values,
      ),
      maxSupply: decode.getBigInt<BigInt?>(19),
      feeScheduleKey: decode.messageTo<proto_basic_types.HederaKey?>(
        20,
        (b) => proto_basic_types.HederaKey.deserialize(b),
      ),
      customFees:
          decode
              .getListOfBytes(21)
              .map((b) => proto_custom_fees.HederaCustomFee.deserialize(b))
              .toList(),
      pauseKey: decode.messageTo<proto_basic_types.HederaKey?>(
        22,
        (b) => proto_basic_types.HederaKey.deserialize(b),
      ),
      metadata: decode.getBytes<List<int>?>(23),
      metadataKey: decode.messageTo<proto_basic_types.HederaKey?>(
        24,
        (b) => proto_basic_types.HederaKey.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoTokenCreateTransactionBody;
}
