import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart" as proto_basic_types;
import "package:on_chain/hedera/src/proto_messages/proto/src/duration.dart" as proto_duration;
import "package:on_chain/hedera/src/proto_messages/proto/src/timestamp.dart" as proto_timestamp;
import "package:on_chain/hedera/src/proto_messages/google/protobuf/src/wrappers.dart" as google_protobuf_wrappers;

/// *
///  * # Token Update
///  * Modify the characteristics of an existing token. Most changes require that
///  * the transaction be signed by an `admin_key`, and if that key is not valid
///  * the only change permitted is to extend the token expiration.
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
///  * Update an existing token.
///  *
///  * This transaction SHALL NOT update any field that is not set.&lt;br/&gt;
///  * Most changes MUST be signed by the current `admin_key` of the token. If the
///  * token does not currently have a valid `admin_key`, then this transaction
///  * MUST NOT set any value other than `expiry` or a non-admin key.&lt;br/&gt;
///  * If the `treasury` is set to a new account, the new account MUST sign this
///  * transaction.&lt;br/&gt;
///  * If the `treasury` is set to a new account for a _non-fungible/unique_ token,
///  * The current treasury MAY hold some tokens.
///  *
///  * #### Requirements for Keys
///  * Any of the key values may be changed, even without an admin key, but the
///  * key to be changed MUST have an existing valid key assigned, and both the
///  * current key and the new key MUST sign the transaction.&lt;br/&gt;
///  * A key value MAY be set to an empty `KeyList`. In this case the existing
///  * key MUST sign this transaction, but the new value is not a valid key, and the
///  * update SHALL effectively remove the existing key.
///  *
///  * ### Block Stream Effects
///  * None
class HederaTokenUpdateTransactionBody extends HederaProtoMessage with Equality {
    /// *
  ///      * A token identifier.
  ///      * &lt;p&gt;
  ///      * This SHALL identify the token type to delete.&lt;br/&gt;
  ///      * The identified token MUST exist, and MUST NOT be deleted.&lt;br/&gt;
  ///      * If any field other than `expiry` is set, the identified token MUST
  ///      * have a valid `admin_key`.
  final proto_basic_types.HederaTokenID? token;

    /// *
  ///      * A new symbol to use for the token.
  ///      * &lt;p&gt;
  ///      * This value, if set, MUST NOT exceed 100 bytes when encoded as UTF-8.&lt;br/&gt;
  ///      * This value, if set, MUST NOT contain the Unicode NUL codepoint.
  final String? symbol;

    /// *
  ///      * A new name for the token.&lt;br/&gt;
  ///      * This is generally the "full name" displayed in wallet software.
  ///      * &lt;p&gt;
  ///      * This value, if set, MUST NOT exceed 100 bytes when encoded as UTF-8.&lt;br/&gt;
  ///      * This value, if set, MUST NOT contain the Unicode NUL codepoint.
  final String? name;

    /// *
  ///      * A new treasury account identifier.
  ///      * &lt;p&gt;
  ///      * If set,
  ///      * - The identified account SHALL be designated the "treasury" for the
  ///      *   token, and all tokens "minted" SHALL be delivered to that account
  ///      *   following this transaction.&lt;br/&gt;
  ///      * - The identified account MUST exist, MUST NOT be expired, MUST NOT be
  ///      *   deleted, and SHOULD have a non-zero HBAR balance.&lt;br/&gt;
  ///      * - The identified account SHALL be associated to this token.
  ///      * - The full balance of this token held by the prior treasury account
  ///      *   SHALL be transferred to the new treasury account, if the token type
  ///      *   is fungible/common.
  ///      * - If the token type is non-fungible/unique, the previous treasury
  ///      *   account MUST NOT hold any tokens of this type.
  ///      * - The new treasury account key MUST sign this transaction.
  final proto_basic_types.HederaAccountID? treasury;

    /// *
  ///      * An Hedera key for token administration.
  ///      * &lt;p&gt;
  ///      * This key, if set, SHALL have administrative authority for this token and
  ///      * MAY authorize token update and/or token delete transactions.&lt;br/&gt;
  ///      * If this key is set to an empty `KeyList`, this token SHALL be
  ///      * immutable thereafter, except for expiration and renewal.&lt;br/&gt;
  ///      * If set, this key MUST be a valid key or an empty `KeyList`.&lt;br/&gt;
  ///      * If set to a valid key, the previous key and new key MUST both
  ///      * sign this transaction.
  final proto_basic_types.HederaKey? adminKey;

    /// *
  ///      * An Hedera key for managing account KYC.
  ///      * &lt;p&gt;
  ///      * This key, if set, SHALL have KYC authority for this token and
  ///      * MAY authorize transactions to grant or revoke KYC for accounts.&lt;br/&gt;
  ///      * If this key is not set, or is an empty `KeyList`, KYC status for this
  ///      * token SHALL NOT be granted or revoked for any account.&lt;br/&gt;
  ///      * If this key is removed after granting KYC, those grants SHALL remain
  ///      * and cannot be revoked.&lt;br/&gt;
  ///      * If set, this key MUST be a valid key or an empty `KeyList`.&lt;br/&gt;
  ///      * If set to a valid key, the previous key and new key MUST both
  ///      * sign this transaction.
  final proto_basic_types.HederaKey? kycKey;

    /// *
  ///      * An Hedera key for managing asset "freeze".
  ///      * &lt;p&gt;
  ///      * This key, if set, SHALL have "freeze" authority for this token and
  ///      * MAY authorize transactions to freeze or unfreeze accounts
  ///      * with respect to this token.&lt;br/&gt;
  ///      * If this key is set to an empty `KeyList`, this token
  ///      * SHALL NOT be frozen or unfrozen for any account.&lt;br/&gt;
  ///      * If this key is removed after freezing accounts, those accounts
  ///      * SHALL remain frozen and cannot be unfrozen.&lt;br/&gt;
  ///      * If set, this key MUST be a valid key or an empty `KeyList`.&lt;br/&gt;
  ///      * If set to a valid key, the previous key and new key MUST both
  ///      * sign this transaction.
  final proto_basic_types.HederaKey? freezeKey;

    /// *
  ///      * An Hedera key for wiping tokens from accounts.
  ///      * &lt;p&gt;
  ///      * This key, if set, SHALL have "wipe" authority for this token and
  ///      * MAY authorize transactions to "wipe" any amount of this token from
  ///      * any account, effectively burning the tokens "wiped".&lt;br/&gt;
  ///      * If this key is set to an empty `KeyList`, it SHALL NOT be
  ///      * possible to "wipe" this token from an account.&lt;br/&gt;
  ///      * If set, this key MUST be a valid key or an empty `KeyList`.&lt;br/&gt;
  ///      * If set to a valid key, the previous key and new key MUST both
  ///      * sign this transaction.
  final proto_basic_types.HederaKey? wipeKey;

    /// *
  ///      * An Hedera key for "minting" and "burning" tokens.
  ///      * &lt;p&gt;
  ///      * This key, if set, MAY authorize transactions to "mint" new tokens to
  ///      * be delivered to the token treasury or "burn" tokens held by the
  ///      * token treasury.&lt;br/&gt;
  ///      * If this key is set to an empty `KeyList`, it SHALL NOT be
  ///      * possible to change the supply of tokens and neither "mint" nor "burn"
  ///      * transactions SHALL be permitted.&lt;br/&gt;
  ///      * If set, this key MUST be a valid key or an empty `KeyList`.&lt;br/&gt;
  ///      * If set to a valid key, the previous key and new key MUST both
  ///      * sign this transaction.
  final proto_basic_types.HederaKey? supplyKey;

    /// *
  ///      * An identifier for the account to be charged renewal fees at the token's
  ///      * expiry to extend the lifetime of the token.
  ///      * &lt;p&gt;
  ///      * If this value is set for the identified token, the token lifetime SHALL
  ///      * be extended by the _smallest_ of the following at expiration:
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
  ///      * &lt;p&gt;
  ///      * &lt;blockquote&gt;Note&lt;blockquote&gt;
  ///      * It is not currently possible to remove an automatic renewal account.
  ///      * Once set, it can only be replaced by a valid account.
  ///      * &lt;/blockquote&gt;&lt;/blockquote&gt;
  final proto_basic_types.HederaAccountID? autoRenewAccount;

    /// *
  ///      * A duration between token automatic renewals.&lt;br/&gt;
  ///      * All entities in state may be charged "rent" occasionally (typically
  ///      * every 90 days) to prevent unnecessary growth of the ledger. This value
  ///      * sets the interval between such events for this token.
  ///      * &lt;p&gt;
  ///      * If set, this value MUST be greater than the configured
  ///      * `MIN_AUTORENEW_PERIOD`.&lt;br/&gt;
  ///      * If set, this value MUST be less than the configured
  ///      * `MAX_AUTORENEW_PERIOD`.
  final proto_duration.HederaDuration? autoRenewPeriod;

    /// *
  ///      * An expiration timestamp.
  ///      * &lt;p&gt;
  ///      * If this value is set, the automatic renewal account is not set for the
  ///      * identified token, and token expiration is enabled in network
  ///      * configuration, this token SHALL expire when the consensus time exceeds
  ///      * this value, and MAY be subsequently removed from the network state.&lt;br/&gt;
  ///      * If `autoRenewAccount` is set or the `auto_renew_account_id` is set for
  ///      * the identified token, the token SHALL be subject to automatic renewal
  ///      * when the consensus time exceeds this value.
  final proto_timestamp.HederaTimestamp? expiry;

    /// *
  ///      * A short description for this token.
  ///      * &lt;p&gt;
  ///      * This value, if set, MUST NOT exceed `transaction.maxMemoUtf8Bytes`
  ///      * (default 100) bytes when encoded as UTF-8.
  final google_protobuf_wrappers.HederaStringValue? memo;

    /// *
  ///      * An Hedera key for managing the token custom fee schedule.
  ///      * &lt;p&gt;
  ///      * This key, if set, MAY authorize transactions to modify the
  ///      * `custom_fees` for this token.&lt;br/&gt;
  ///      * If this key is set to an empty `KeyList`, the `custom_fees`
  ///      * for this token SHALL NOT be modified.&lt;br/&gt;
  ///      * If set, this key MUST be a valid key or an empty `KeyList`.&lt;br/&gt;
  ///      * If set to a valid key, the previous key and new key MUST both
  ///      * sign this transaction.
  final proto_basic_types.HederaKey? feeScheduleKey;

    /// *
  ///      * An Hedera key for managing token "pause".
  ///      * &lt;p&gt;
  ///      * This key, if set, SHALL have "pause" authority for this token and
  ///      * MAY authorize transactions to pause or unpause this token.&lt;br/&gt;
  ///      * If this key is set to an empty `KeyList`, this token
  ///      * SHALL NOT be paused or unpaused.&lt;br/&gt;
  ///      * If this key is removed while the token is paused, the token cannot
  ///      * be unpaused and SHALL remain paused.&lt;br/&gt;
  ///      * If set, this key MUST be a valid key or an empty `KeyList`.&lt;br/&gt;
  ///      * If set to a valid key, the previous key and new key MUST both
  ///      * sign this transaction.
  final proto_basic_types.HederaKey? pauseKey;

    /// *
  ///      * Token "Metadata".
  ///      * &lt;p&gt;
  ///      * The value, if set, MUST NOT exceed 100 bytes.&lt;br/&gt;
  ///      * &lt;dl&gt;&lt;dt&gt;Examples&lt;/dt&gt;
  ///      *   &lt;dd&gt;hcs://1/0.0.4896575&lt;/dd&gt;
  ///      *   &lt;dd&gt;ipfs://bafkreifd7tcjjuwxxf4qkaibkj62pj4mhfuud7plwrc3pfoygt55al6syi&lt;/dd&gt;
  ///      * &lt;/dl&gt;
  final google_protobuf_wrappers.HederaBytesValue? metadata;

    /// *
  ///      * An Hedera key for managing the token `metadata`.
  ///      * &lt;p&gt;
  ///      * This key, if set, MAY authorize transactions to modify the
  ///      * `metadata` for this token.&lt;br/&gt;
  ///      * If this key is set to an empty `KeyList`, the `metadata`
  ///      * for this token SHALL NOT be modified.&lt;br/&gt;
  ///      * If set, this key MUST be a valid key or an empty `KeyList`.&lt;br/&gt;
  ///      * If set to a valid key, the previous key and new key MUST both
  ///      * sign this transaction.
  final proto_basic_types.HederaKey? metadataKey;

    /// *
  ///      * Set a key validation mode.&lt;br/&gt;
  ///      * Any key may be updated by a transaction signed by the token `admin_key`.
  ///      * Each role key may _also_ sign a transaction to update that key.
  ///      * If a role key signs an update to change that role key both old
  ///      * and new key must sign the transaction, _unless_ this field is set
  ///      * to `NO_VALIDATION`, in which case the _new_ key is not required to
  ///      * sign the transaction (the existing key is still required).&lt;br/&gt;
  ///      * The primary intent for this field is to allow a role key (e.g. a
  ///      * `pause_key`) holder to "remove" that key from the token by signing
  ///      * a transaction to set that role key to an empty `KeyList`.
  ///      * &lt;p&gt;
  ///      * If set to `FULL_VALIDATION`, either the `admin_key` or _both_ current
  ///      * and new key MUST sign this transaction to update a "key" field for the
  ///      * identified token.&lt;br/&gt;
  ///      * If set to `NO_VALIDATION`, either the `admin_key` or the current
  ///      * key MUST sign this transaction to update a "key" field for the
  ///      * identified token.&lt;br/&gt;
  ///      * This field SHALL be treated as `FULL_VALIDATION` if not set.
  final proto_basic_types.HederaTokenKeyValidation? keyVerificationMode;

  const HederaTokenUpdateTransactionBody({
    this.token,
    this.symbol,
    this.name,
    this.treasury,
    this.adminKey,
    this.kycKey,
    this.freezeKey,
    this.wipeKey,
    this.supplyKey,
    this.autoRenewAccount,
    this.autoRenewPeriod,
    this.expiry,
    this.memo,
    this.feeScheduleKey,
    this.pauseKey,
    this.metadata,
    this.metadataKey,
    this.keyVerificationMode,
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
        ProtoFieldConfig.message(4),
        ProtoFieldConfig.message(5),
        ProtoFieldConfig.message(6),
        ProtoFieldConfig.message(7),
        ProtoFieldConfig.message(8),
        ProtoFieldConfig.message(9),
        ProtoFieldConfig.message(10),
        ProtoFieldConfig.message(11),
        ProtoFieldConfig.message(12),
        ProtoFieldConfig.message(13),
        ProtoFieldConfig.message(14),
        ProtoFieldConfig.message(15),
        ProtoFieldConfig.message(16),
        ProtoFieldConfig.message(17),
        ProtoFieldConfig.enumType(18),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        token,
        symbol,
        name,
        treasury,
        adminKey,
        kycKey,
        freezeKey,
        wipeKey,
        supplyKey,
        autoRenewAccount,
        autoRenewPeriod,
        expiry,
        memo,
        feeScheduleKey,
        pauseKey,
        metadata,
        metadataKey,
        keyVerificationMode,
      ];


HederaTokenUpdateTransactionBody copyWith(
{proto_basic_types.HederaTokenID? token,

String? symbol,

String? name,

proto_basic_types.HederaAccountID? treasury,

proto_basic_types.HederaKey? adminKey,

proto_basic_types.HederaKey? kycKey,

proto_basic_types.HederaKey? freezeKey,

proto_basic_types.HederaKey? wipeKey,

proto_basic_types.HederaKey? supplyKey,

proto_basic_types.HederaAccountID? autoRenewAccount,

proto_duration.HederaDuration? autoRenewPeriod,

proto_timestamp.HederaTimestamp? expiry,

google_protobuf_wrappers.HederaStringValue? memo,

proto_basic_types.HederaKey? feeScheduleKey,

proto_basic_types.HederaKey? pauseKey,

google_protobuf_wrappers.HederaBytesValue? metadata,

proto_basic_types.HederaKey? metadataKey,

proto_basic_types.HederaTokenKeyValidation? keyVerificationMode,

}) {
    return HederaTokenUpdateTransactionBody(
token: token ?? this.token,
symbol: symbol ?? this.symbol,
name: name ?? this.name,
treasury: treasury ?? this.treasury,
adminKey: adminKey ?? this.adminKey,
kycKey: kycKey ?? this.kycKey,
freezeKey: freezeKey ?? this.freezeKey,
wipeKey: wipeKey ?? this.wipeKey,
supplyKey: supplyKey ?? this.supplyKey,
autoRenewAccount: autoRenewAccount ?? this.autoRenewAccount,
autoRenewPeriod: autoRenewPeriod ?? this.autoRenewPeriod,
expiry: expiry ?? this.expiry,
memo: memo ?? this.memo,
feeScheduleKey: feeScheduleKey ?? this.feeScheduleKey,
pauseKey: pauseKey ?? this.pauseKey,
metadata: metadata ?? this.metadata,
metadataKey: metadataKey ?? this.metadataKey,
keyVerificationMode: keyVerificationMode ?? this.keyVerificationMode,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'token': config.encodeMessage(token),
      'symbol': symbol,
      'name': name,
      'treasury': config.encodeMessage(treasury),
      'adminKey': config.encodeMessage(adminKey),
      'kycKey': config.encodeMessage(kycKey),
      'freezeKey': config.encodeMessage(freezeKey),
      'wipeKey': config.encodeMessage(wipeKey),
      'supplyKey': config.encodeMessage(supplyKey),
      'autoRenewAccount': config.encodeMessage(autoRenewAccount),
      'autoRenewPeriod': config.encodeMessage(autoRenewPeriod),
      'expiry': config.encodeMessage(expiry),
      'memo': config.encodeMessage(memo),
      'fee_schedule_key': config.encodeMessage(feeScheduleKey),
      'pause_key': config.encodeMessage(pauseKey),
      'metadata': config.encodeMessage(metadata),
      'metadata_key': config.encodeMessage(metadataKey),
      'key_verification_mode': config.encodeEnum(keyVerificationMode),
    };
  }


  factory HederaTokenUpdateTransactionBody.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaTokenUpdateTransactionBody(
      token: json.valueTo<proto_basic_types.HederaTokenID?, Object>(
        key: 'token',
        parse: (v) => proto_basic_types.HederaTokenID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      symbol: json.valueAsString<String?>('symbol', normalizeKeyLookup: config.normalizeKeys),
      name: json.valueAsString<String?>('name', normalizeKeyLookup: config.normalizeKeys),
      treasury: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'treasury',
        parse: (v) => proto_basic_types.HederaAccountID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      adminKey: json.valueTo<proto_basic_types.HederaKey?, Object>(
        key: 'adminKey',
        parse: (v) => proto_basic_types.HederaKey.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      kycKey: json.valueTo<proto_basic_types.HederaKey?, Object>(
        key: 'kycKey',
        parse: (v) => proto_basic_types.HederaKey.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      freezeKey: json.valueTo<proto_basic_types.HederaKey?, Object>(
        key: 'freezeKey',
        parse: (v) => proto_basic_types.HederaKey.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      wipeKey: json.valueTo<proto_basic_types.HederaKey?, Object>(
        key: 'wipeKey',
        parse: (v) => proto_basic_types.HederaKey.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      supplyKey: json.valueTo<proto_basic_types.HederaKey?, Object>(
        key: 'supplyKey',
        parse: (v) => proto_basic_types.HederaKey.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      autoRenewAccount: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'autoRenewAccount',
        parse: (v) => proto_basic_types.HederaAccountID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      autoRenewPeriod: json.valueTo<proto_duration.HederaDuration?, Object>(
        key: 'autoRenewPeriod',
        parse: (v) => proto_duration.HederaDuration.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      expiry: json.valueTo<proto_timestamp.HederaTimestamp?, Object>(
        key: 'expiry',
        parse: (v) => proto_timestamp.HederaTimestamp.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      memo: json.valueTo<google_protobuf_wrappers.HederaStringValue?, Object>(
        key: 'memo',
        parse: (v) => google_protobuf_wrappers.HederaStringValue.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      feeScheduleKey: json.valueTo<proto_basic_types.HederaKey?, Object>(
        key: 'fee_schedule_key',
        parse: (v) => proto_basic_types.HederaKey.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      pauseKey: json.valueTo<proto_basic_types.HederaKey?, Object>(
        key: 'pause_key',
        parse: (v) => proto_basic_types.HederaKey.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      metadata: json.valueTo<google_protobuf_wrappers.HederaBytesValue?, Object>(
        key: 'metadata',
        parse: (v) => google_protobuf_wrappers.HederaBytesValue.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      metadataKey: json.valueTo<proto_basic_types.HederaKey?, Object>(
        key: 'metadata_key',
        parse: (v) => proto_basic_types.HederaKey.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      keyVerificationMode: json.valueTo<proto_basic_types.HederaTokenKeyValidation?, Object?>(
        key: 'key_verification_mode',
        parse: (v) => proto_basic_types.HederaTokenKeyValidation.from(v),
      ),
    );
  }

  factory HederaTokenUpdateTransactionBody.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTokenUpdateTransactionBody(
      token: decode.messageTo<proto_basic_types.HederaTokenID?>(1, (b) => proto_basic_types.HederaTokenID.deserialize(b)),
      symbol: decode.getString<String?>(2),
      name: decode.getString<String?>(3),
      treasury: decode.messageTo<proto_basic_types.HederaAccountID?>(4, (b) => proto_basic_types.HederaAccountID.deserialize(b)),
      adminKey: decode.messageTo<proto_basic_types.HederaKey?>(5, (b) => proto_basic_types.HederaKey.deserialize(b)),
      kycKey: decode.messageTo<proto_basic_types.HederaKey?>(6, (b) => proto_basic_types.HederaKey.deserialize(b)),
      freezeKey: decode.messageTo<proto_basic_types.HederaKey?>(7, (b) => proto_basic_types.HederaKey.deserialize(b)),
      wipeKey: decode.messageTo<proto_basic_types.HederaKey?>(8, (b) => proto_basic_types.HederaKey.deserialize(b)),
      supplyKey: decode.messageTo<proto_basic_types.HederaKey?>(9, (b) => proto_basic_types.HederaKey.deserialize(b)),
      autoRenewAccount: decode.messageTo<proto_basic_types.HederaAccountID?>(10, (b) => proto_basic_types.HederaAccountID.deserialize(b)),
      autoRenewPeriod: decode.messageTo<proto_duration.HederaDuration?>(11, (b) => proto_duration.HederaDuration.deserialize(b)),
      expiry: decode.messageTo<proto_timestamp.HederaTimestamp?>(12, (b) => proto_timestamp.HederaTimestamp.deserialize(b)),
      memo: decode.messageTo<google_protobuf_wrappers.HederaStringValue?>(13, (b) => google_protobuf_wrappers.HederaStringValue.deserialize(b)),
      feeScheduleKey: decode.messageTo<proto_basic_types.HederaKey?>(14, (b) => proto_basic_types.HederaKey.deserialize(b)),
      pauseKey: decode.messageTo<proto_basic_types.HederaKey?>(15, (b) => proto_basic_types.HederaKey.deserialize(b)),
      metadata: decode.messageTo<google_protobuf_wrappers.HederaBytesValue?>(16, (b) => google_protobuf_wrappers.HederaBytesValue.deserialize(b)),
      metadataKey: decode.messageTo<proto_basic_types.HederaKey?>(17, (b) => proto_basic_types.HederaKey.deserialize(b)),
      keyVerificationMode: decode.getEnum<proto_basic_types.HederaTokenKeyValidation?>(18, proto_basic_types.HederaTokenKeyValidation.values),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoTokenUpdateTransactionBody;

}


