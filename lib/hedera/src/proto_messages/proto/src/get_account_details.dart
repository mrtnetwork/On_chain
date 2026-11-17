import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/query_header.dart"
    as proto_query_header;
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;
import "package:on_chain/hedera/src/proto_messages/proto/src/response_header.dart"
    as proto_response_header;
import "package:on_chain/hedera/src/proto_messages/proto/src/timestamp.dart"
    as proto_timestamp;
import "package:on_chain/hedera/src/proto_messages/proto/src/duration.dart"
    as proto_duration;
import "package:on_chain/hedera/src/proto_messages/proto/src/query.dart"
    as proto_query;

/// *
///  * # Get Account Details
///  * A standard query to inspect the full detail of an account.
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
///  * Request detail information about an account.
///  *
///  * The returned information SHALL include balance and allowances.&lt;br/&gt;
///  * The returned information SHALL NOT include a list of account records.
///  *
///  * #### Important
///  * This query is a _privileged_ query. Only "system" accounts SHALL be
///  * permitted to submit this query.
class HederaGetAccountDetailsQuery extends HederaProtoMessage
    with Equality, IHederaQuery<HederaGetAccountDetailsResponse> {
  /// *
  ///      * Standard information sent with every query operation.&lt;br/&gt;
  ///      * This includes the signed payment and what kind of response is requested
  ///      * (cost, state proof, both, or neither).
  @override
  final proto_query_header.HederaQueryHeader? header;

  /// *
  ///      * An account ID for which information is requested
  ///      * &lt;p&gt;
  ///      * This value SHALL identify the account to be queried.&lt;br/&gt;
  ///      * This value MUST identify a valid account.&lt;br/&gt;
  ///      * This field is REQUIRED.
  final proto_basic_types.HederaAccountID? accountId;

  const HederaGetAccountDetailsQuery({this.header, this.accountId});

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
  List<Object?> get protoValues => [header, accountId];

  @override
  HederaGetAccountDetailsQuery copyWith({
    proto_query_header.HederaQueryHeader? header,

    proto_basic_types.HederaAccountID? accountId,
  }) {
    return HederaGetAccountDetailsQuery(
      header: header ?? this.header,
      accountId: accountId ?? this.accountId,
    );
  }

  @override
  proto_query.HederaQuery toQueryRequest({
    proto_query_header.HederaQueryHeader? header,
  }) => proto_query.HederaQuery(accountDetails: copyWith(header: header));
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'header': config.encodeMessage(header),
      'account_id': config.encodeMessage(accountId),
    };
  }

  factory HederaGetAccountDetailsQuery.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaGetAccountDetailsQuery(
      header: json.valueTo<proto_query_header.HederaQueryHeader?, Object>(
        key: 'header',
        parse:
            (v) => proto_query_header.HederaQueryHeader.fromJson(
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
    );
  }

  factory HederaGetAccountDetailsQuery.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaGetAccountDetailsQuery(
      header: decode.messageTo<proto_query_header.HederaQueryHeader?>(
        1,
        (b) => proto_query_header.HederaQueryHeader.deserialize(b),
      ),
      accountId: decode.messageTo<proto_basic_types.HederaAccountID?>(
        2,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoGetAccountDetailsQuery;
}

/// *
///  * A response to a `GetAccountDetailsQuery`.
///  *
///  * This SHALL contain the account details if requested and successful.
class HederaGetAccountDetailsResponse extends HederaProtoMessage
    with Equality, IHederaQueryRespone {
  /// *
  ///      * The standard response information for queries.&lt;br/&gt;
  ///      * This includes the values requested in the `QueryHeader`
  ///      * (cost, state proof, both, or neither).
  @override
  final proto_response_header.HederaResponseHeader? header;

  /// *
  ///      * Details of the account.
  ///      * &lt;p&gt;
  ///      * A state proof MAY be generated for this field.
  final HederaGetAccountDetailsResponseAccountDetails? accountDetails;

  const HederaGetAccountDetailsResponse({this.header, this.accountDetails});

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
  List<Object?> get protoValues => [header, accountDetails];

  HederaGetAccountDetailsResponse copyWith({
    proto_response_header.HederaResponseHeader? header,

    HederaGetAccountDetailsResponseAccountDetails? accountDetails,
  }) {
    return HederaGetAccountDetailsResponse(
      header: header ?? this.header,
      accountDetails: accountDetails ?? this.accountDetails,
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
      'account_details': config.encodeMessage(accountDetails),
    };
  }

  factory HederaGetAccountDetailsResponse.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaGetAccountDetailsResponse(
      header: json.valueTo<proto_response_header.HederaResponseHeader?, Object>(
        key: 'header',
        parse:
            (v) => proto_response_header.HederaResponseHeader.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      accountDetails: json
          .valueTo<HederaGetAccountDetailsResponseAccountDetails?, Object>(
            key: 'account_details',
            parse:
                (v) => HederaGetAccountDetailsResponseAccountDetails.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
    );
  }

  factory HederaGetAccountDetailsResponse.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaGetAccountDetailsResponse(
      header: decode.messageTo<proto_response_header.HederaResponseHeader?>(
        1,
        (b) => proto_response_header.HederaResponseHeader.deserialize(b),
      ),
      accountDetails: decode
          .messageTo<HederaGetAccountDetailsResponseAccountDetails?>(
            2,
            (b) => HederaGetAccountDetailsResponseAccountDetails.deserialize(b),
          ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoGetAccountDetailsResponse;
}

/// *
///      * Information describing a single Account in the Hedera distributed ledger.
///      *
///      * #### Attributes
///      * Each Account may have a unique three-part identifier, a Key, and one or
///      * more token balances. Accounts also have an alias, which has multiple
///      * forms, and may be set automatically. Several additional items are
///      * associated with the Account to enable full functionality.
///      *
///      * #### Expiration
///      * Accounts, as most items in the network, have an expiration time, recorded
///      * as a `Timestamp`, and must be "renewed" for a small fee at expiration.
///      * This helps to reduce the amount of inactive accounts retained in state.
///      * Another account may be designated to pay any renewal fees and
///      * automatically renew the account for (by default) 30-90 days at a time as
///      * a means to optionally ensure important accounts remain active.
///      *
///      * ### Staking
///      * Accounts may participate in securing the network by "staking" the account
///      * balances to a particular network node, and receive a portion of network
///      * fees as a reward. An account may optionally decline these rewards but
///      * still stake its balances.
///      *
///      * #### Transfer Restrictions
///      * An account may optionally require that inbound transfer transactions be
///      * signed by that account as receiver (in addition to any other signatures
///      * required, including sender).
///      *
class HederaGetAccountDetailsResponseAccountDetails extends HederaProtoMessage
    with Equality {
  /// *
  ///          * The unique ID of this account.
  ///          * &lt;p&gt;
  ///          * An account ID, when assigned to this field, SHALL be of
  ///          * the form `shard.realm.number`.&lt;br/&gt;
  ///          * Transactions MAY reference the account by alias, but the account
  ///          * itself MUST always have a purely numeric identifier. This numeric
  ///          * ID is the value used to reference the account in query responses,
  ///          * transaction receipts, transaction records, and the block stream.
  final proto_basic_types.HederaAccountID? accountId;

  /// *
  ///          * A Solidity ID.&lt;br/&gt;
  ///          * This identifies the contract instance, and the `Account` associated
  ///          * with that contract instance.
  ///          * &lt;p&gt;
  ///          * This SHALL be populated if this account is a smart contract, and
  ///          * SHALL NOT be populated otherwise.&lt;br/&gt;
  ///          * This SHALL be formatted as a string according to Solidity ID
  ///          * standards.
  final String? contractAccountId;

  /// *
  ///          * A boolean indicating that this account is deleted.
  final bool? deleted;

  /// *
  ///          * Replaced by StakingInfo.&lt;br/&gt;
  ///          * ID of the account to which this account is staking its balances. If
  ///          * this account is not currently staking its balances, then this field,
  ///          * if set, SHALL be the sentinel value of `0.0.0`.
  final proto_basic_types.HederaAccountID? proxyAccountId;

  /// *
  ///          * The total amount of tinybar proxy staked to this account.
  final BigInt? proxyReceived;

  /// *
  ///          * The key to be used to sign transactions from this account, if any.
  ///          * &lt;p&gt;
  ///          * This key SHALL NOT be set for hollow accounts until the account
  ///          * is finalized.&lt;br/&gt;
  ///          * This key SHALL be set on all other accounts, except for certain
  ///          * immutable accounts (0.0.800 and 0.0.801) necessary for network
  ///          * function and otherwise secured by the governing council.
  final proto_basic_types.HederaKey? key;

  /// *
  ///          * The HBAR balance of this account, in tinybar (10&lt;sup&gt;-8&lt;/sup&gt; HBAR).
  ///          * &lt;p&gt;
  ///          * This value SHALL always be a whole number.
  final BigInt? balance;

  /// *
  ///          * A boolean indicating that the account requires a receiver signature
  ///          * for inbound token transfer transactions.
  ///          * &lt;p&gt;
  ///          * If this value is `true` then a transaction to transfer tokens to this
  ///          * account SHALL NOT succeed unless this account has signed the
  ///          * transfer transaction.
  final bool? receiverSigRequired;

  /// *
  ///          * The current expiration time for this account.
  ///          * &lt;p&gt;
  ///          * This account SHALL be due standard renewal fees when the network
  ///          * consensus time exceeds this time.&lt;br/&gt;
  ///          * If rent and expiration are enabled for the network, and automatic
  ///          * renewal is enabled for this account, renewal fees SHALL be charged
  ///          * after this time, and, if charged, the expiration time SHALL be
  ///          * extended for another renewal period.&lt;br/&gt;
  ///          * This account MAY be expired and removed from state at any point
  ///          * after this time if not renewed.&lt;br/&gt;
  ///          * An account holder MAY extend this time by submitting an account
  ///          * update transaction to modify expiration time, subject to the current
  ///          * maximum expiration time for the network.
  final proto_timestamp.HederaTimestamp? expirationTime;

  /// *
  ///          * A duration to extend this account's expiration.
  ///          * &lt;p&gt;
  ///          * The network SHALL extend the account's expiration by this
  ///          * duration, if funds are available, upon automatic renewal.&lt;br/&gt;
  ///          * This SHALL NOT apply if the account is already deleted
  ///          * upon expiration.&lt;br/&gt;
  ///          * If this is not provided in an allowed range on account creation, the
  ///          * transaction SHALL fail with INVALID_AUTO_RENEWAL_PERIOD. The default
  ///          * values for the minimum period and maximum period are currently
  ///          * 30 days and 90 days, respectively.
  final proto_duration.HederaDuration? autoRenewPeriod;

  /// *
  ///          * As of `HIP-367`, which enabled unlimited token associations, the
  ///          * potential scale for this value requires that users consult a mirror
  ///          * node for this information. Only the top `maxRelsPerInfoQuery`
  ///          * (default 1000) relationships will be returned by this query.&lt;br/&gt;
  ///          * A list of tokens to which this account is "associated", enabling the
  ///          * transfer of that token type by this account.
  final List<proto_basic_types.HederaTokenRelationship> tokenRelationships;

  /// *
  ///          * A short description of this account.
  ///          * &lt;p&gt;
  ///          * This value, if set, MUST NOT exceed `transaction.maxMemoUtf8Bytes`
  ///          * (default 100) bytes when encoded as UTF-8.
  final String? memo;

  /// *
  ///          * The total number of non-fungible/unique tokens owned by this account.
  final BigInt? ownedNfts;

  /// *
  ///          * The maximum number of tokens that can be auto-associated with the
  ///          * account.
  ///          * &lt;p&gt;
  ///          * If this is less than or equal to `used_auto_associations` (or 0),
  ///          * then this account MUST manually associate with a token before
  ///          * transacting in that token.&lt;br/&gt;
  ///          * Following HIP-904 This value may also be `-1` to indicate no
  ///          * limit.&lt;br/&gt;
  ///          * This value MUST NOT be less than `-1`.
  final int? maxAutomaticTokenAssociations;

  /// *
  ///          * An account EVM alias.&lt;br/&gt;
  ///          * This is a value used in some contexts to reference an account when
  ///          * the tripartite account identifier is not available.
  ///          * &lt;p&gt;
  ///          * This field, when set to a non-default value, is immutable and
  ///          * SHALL NOT be changed.
  final List<int>? alias;

  /// *
  ///          * The ledger ID of the network that generated this response.
  ///          * &lt;p&gt;
  ///          * This value SHALL identify the distributed ledger that responded to
  ///          * this query.
  final List<int>? ledgerId;

  /// *
  ///          * A list of crypto (HBAR) allowances approved by this account.
  ///          * &lt;p&gt;
  ///          * If this is not empty, each allowance SHALL permit a specified
  ///          * "spender" account to spend this account's HBAR balance, up
  ///          * to a designated limit.&lt;br/&gt;
  ///          * This field SHALL permit spending only HBAR balance, not other
  ///          * tokens the account may hold.&lt;br/&gt;
  ///          * Allowances for other tokens SHALL be listed in the
  ///          * `token_allowances` field or the
  ///          * `approve_for_all_nft_allowances` field.
  final List<HederaGrantedCryptoAllowance> grantedCryptoAllowances;

  /// *
  ///          * A list of non-fungible token (NFT) allowances approved by
  ///          * this account.
  ///          * &lt;p&gt;
  ///          * If this is not empty, each allowance SHALL permit a specified
  ///          * "spender" account to transfer _all_ of this account's
  ///          * non-fungible/unique tokens from a particular collection.&lt;br/&gt;
  ///          * Allowances for a specific serial number MUST be directly
  ///          * associated with that specific non-fungible/unique token, rather
  ///          * than the holding account.
  final List<HederaGrantedNftAllowance> grantedNftAllowances;

  /// *
  ///          * A list of fungible token allowances approved by this account.
  ///          * &lt;p&gt;
  ///          * If this is not empty, each allowance SHALL permit a specified
  ///          * "spender" to spend this account's fungible tokens, of the
  ///          * designated type, up to a designated limit.
  final List<HederaGrantedTokenAllowance> grantedTokenAllowances;

  const HederaGetAccountDetailsResponseAccountDetails({
    this.accountId,
    this.contractAccountId,
    this.deleted,
    this.proxyAccountId,
    this.proxyReceived,
    this.key,
    this.balance,
    this.receiverSigRequired,
    this.expirationTime,
    this.autoRenewPeriod,
    this.tokenRelationships = const [],
    this.memo,
    this.ownedNfts,
    this.maxAutomaticTokenAssociations,
    this.alias,
    this.ledgerId,
    this.grantedCryptoAllowances = const [],
    this.grantedNftAllowances = const [],
    this.grantedTokenAllowances = const [],
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
        ProtoFieldConfig.bool(3),
        ProtoFieldConfig.message(
          4,
          options: [ProtoOptionBool(name: "deprecated", value: true)],
        ),
        ProtoFieldConfig.int64(5),
        ProtoFieldConfig.message(6),
        ProtoFieldConfig.uint64(7),
        ProtoFieldConfig.bool(8),
        ProtoFieldConfig.message(9),
        ProtoFieldConfig.message(10),
        ProtoFieldConfig.repeated(
          fieldNumber: 11,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.string(12),
        ProtoFieldConfig.int64(13),
        ProtoFieldConfig.int32(14),
        ProtoFieldConfig.bytes(15),
        ProtoFieldConfig.bytes(16),
        ProtoFieldConfig.repeated(
          fieldNumber: 17,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.repeated(
          fieldNumber: 18,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.repeated(
          fieldNumber: 19,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    accountId,
    contractAccountId,
    deleted,
    proxyAccountId,
    proxyReceived,
    key,
    balance,
    receiverSigRequired,
    expirationTime,
    autoRenewPeriod,
    tokenRelationships,
    memo,
    ownedNfts,
    maxAutomaticTokenAssociations,
    alias,
    ledgerId,
    grantedCryptoAllowances,
    grantedNftAllowances,
    grantedTokenAllowances,
  ];

  HederaGetAccountDetailsResponseAccountDetails copyWith({
    proto_basic_types.HederaAccountID? accountId,

    String? contractAccountId,

    bool? deleted,

    proto_basic_types.HederaAccountID? proxyAccountId,

    BigInt? proxyReceived,

    proto_basic_types.HederaKey? key,

    BigInt? balance,

    bool? receiverSigRequired,

    proto_timestamp.HederaTimestamp? expirationTime,

    proto_duration.HederaDuration? autoRenewPeriod,

    List<proto_basic_types.HederaTokenRelationship>? tokenRelationships,

    String? memo,

    BigInt? ownedNfts,

    int? maxAutomaticTokenAssociations,

    List<int>? alias,

    List<int>? ledgerId,

    List<HederaGrantedCryptoAllowance>? grantedCryptoAllowances,

    List<HederaGrantedNftAllowance>? grantedNftAllowances,

    List<HederaGrantedTokenAllowance>? grantedTokenAllowances,
  }) {
    return HederaGetAccountDetailsResponseAccountDetails(
      accountId: accountId ?? this.accountId,
      contractAccountId: contractAccountId ?? this.contractAccountId,
      deleted: deleted ?? this.deleted,
      proxyAccountId: proxyAccountId ?? this.proxyAccountId,
      proxyReceived: proxyReceived ?? this.proxyReceived,
      key: key ?? this.key,
      balance: balance ?? this.balance,
      receiverSigRequired: receiverSigRequired ?? this.receiverSigRequired,
      expirationTime: expirationTime ?? this.expirationTime,
      autoRenewPeriod: autoRenewPeriod ?? this.autoRenewPeriod,
      tokenRelationships: tokenRelationships ?? this.tokenRelationships,
      memo: memo ?? this.memo,
      ownedNfts: ownedNfts ?? this.ownedNfts,
      maxAutomaticTokenAssociations:
          maxAutomaticTokenAssociations ?? this.maxAutomaticTokenAssociations,
      alias: alias ?? this.alias,
      ledgerId: ledgerId ?? this.ledgerId,
      grantedCryptoAllowances:
          grantedCryptoAllowances ?? this.grantedCryptoAllowances,
      grantedNftAllowances: grantedNftAllowances ?? this.grantedNftAllowances,
      grantedTokenAllowances:
          grantedTokenAllowances ?? this.grantedTokenAllowances,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'account_id': config.encodeMessage(accountId),
      'contract_account_id': contractAccountId,
      'deleted': deleted,
      'proxy_account_id': config.encodeMessage(proxyAccountId),
      'proxy_received': config.encodeBigint(proxyReceived),
      'key': config.encodeMessage(key),
      'balance': config.encodeBigint(balance),
      'receiver_sig_required': receiverSigRequired,
      'expiration_time': config.encodeMessage(expirationTime),
      'auto_renew_period': config.encodeMessage(autoRenewPeriod),
      'token_relationships':
          tokenRelationships.map((e) => config.encodeMessage(e)).toList(),
      'memo': memo,
      'owned_nfts': config.encodeBigint(ownedNfts),
      'max_automatic_token_associations': maxAutomaticTokenAssociations,
      'alias': config.encodeBinary(alias),
      'ledger_id': config.encodeBinary(ledgerId),
      'granted_crypto_allowances':
          grantedCryptoAllowances.map((e) => config.encodeMessage(e)).toList(),
      'granted_nft_allowances':
          grantedNftAllowances.map((e) => config.encodeMessage(e)).toList(),
      'granted_token_allowances':
          grantedTokenAllowances.map((e) => config.encodeMessage(e)).toList(),
    };
  }

  factory HederaGetAccountDetailsResponseAccountDetails.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaGetAccountDetailsResponseAccountDetails(
      accountId: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'account_id',
        parse:
            (v) => proto_basic_types.HederaAccountID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      contractAccountId: json.valueAsString<String?>(
        'contract_account_id',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      deleted: json.valueAsBool<bool?>(
        'deleted',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      proxyAccountId: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'proxy_account_id',
        parse:
            (v) => proto_basic_types.HederaAccountID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      proxyReceived: json.valueAsBigInt<BigInt?>(
        'proxy_received',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      key: json.valueTo<proto_basic_types.HederaKey?, Object>(
        key: 'key',
        parse:
            (v) => proto_basic_types.HederaKey.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      balance: json.valueAsBigInt<BigInt?>(
        'balance',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      receiverSigRequired: json.valueAsBool<bool?>(
        'receiver_sig_required',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      expirationTime: json.valueTo<proto_timestamp.HederaTimestamp?, Object>(
        key: 'expiration_time',
        parse:
            (v) => proto_timestamp.HederaTimestamp.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      autoRenewPeriod: json.valueTo<proto_duration.HederaDuration?, Object>(
        key: 'auto_renew_period',
        parse:
            (v) => proto_duration.HederaDuration.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      tokenRelationships:
          (json.valueEnsureAsList<dynamic>(
                'token_relationships',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<
                  proto_basic_types.HederaTokenRelationship,
                  Object
                >(
                  value: e,
                  parse:
                      (v) => proto_basic_types.HederaTokenRelationship.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      memo: json.valueAsString<String?>(
        'memo',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      ownedNfts: json.valueAsBigInt<BigInt?>(
        'owned_nfts',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      maxAutomaticTokenAssociations: json.valueAsInt<int?>(
        'max_automatic_token_associations',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      alias: config.decodeBinary<List<int>?>(
        json.valueAs('alias', normalizeKeyLookup: config.normalizeKeys),
      ),
      ledgerId: config.decodeBinary<List<int>?>(
        json.valueAs('ledger_id', normalizeKeyLookup: config.normalizeKeys),
      ),
      grantedCryptoAllowances:
          (json.valueEnsureAsList<dynamic>(
                'granted_crypto_allowances',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<HederaGrantedCryptoAllowance, Object>(
                  value: e,
                  parse:
                      (v) => HederaGrantedCryptoAllowance.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      grantedNftAllowances:
          (json.valueEnsureAsList<dynamic>(
                'granted_nft_allowances',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<HederaGrantedNftAllowance, Object>(
                  value: e,
                  parse:
                      (v) => HederaGrantedNftAllowance.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      grantedTokenAllowances:
          (json.valueEnsureAsList<dynamic>(
                'granted_token_allowances',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<HederaGrantedTokenAllowance, Object>(
                  value: e,
                  parse:
                      (v) => HederaGrantedTokenAllowance.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory HederaGetAccountDetailsResponseAccountDetails.deserialize(
    List<int> bytes,
  ) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaGetAccountDetailsResponseAccountDetails(
      accountId: decode.messageTo<proto_basic_types.HederaAccountID?>(
        1,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
      contractAccountId: decode.getString<String?>(2),
      deleted: decode.getBool<bool?>(3),
      proxyAccountId: decode.messageTo<proto_basic_types.HederaAccountID?>(
        4,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
      proxyReceived: decode.getBigInt<BigInt?>(5),
      key: decode.messageTo<proto_basic_types.HederaKey?>(
        6,
        (b) => proto_basic_types.HederaKey.deserialize(b),
      ),
      balance: decode.getBigInt<BigInt?>(7),
      receiverSigRequired: decode.getBool<bool?>(8),
      expirationTime: decode.messageTo<proto_timestamp.HederaTimestamp?>(
        9,
        (b) => proto_timestamp.HederaTimestamp.deserialize(b),
      ),
      autoRenewPeriod: decode.messageTo<proto_duration.HederaDuration?>(
        10,
        (b) => proto_duration.HederaDuration.deserialize(b),
      ),
      tokenRelationships:
          decode
              .getListOfBytes(11)
              .map(
                (b) => proto_basic_types.HederaTokenRelationship.deserialize(b),
              )
              .toList(),
      memo: decode.getString<String?>(12),
      ownedNfts: decode.getBigInt<BigInt?>(13),
      maxAutomaticTokenAssociations: decode.getInt<int?>(14),
      alias: decode.getBytes<List<int>?>(15),
      ledgerId: decode.getBytes<List<int>?>(16),
      grantedCryptoAllowances:
          decode
              .getListOfBytes(17)
              .map((b) => HederaGrantedCryptoAllowance.deserialize(b))
              .toList(),
      grantedNftAllowances:
          decode
              .getListOfBytes(18)
              .map((b) => HederaGrantedNftAllowance.deserialize(b))
              .toList(),
      grantedTokenAllowances:
          decode
              .getListOfBytes(19)
              .map((b) => HederaGrantedTokenAllowance.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoGetAccountDetailsResponseAccountDetails;
}

/// *
///  * Permission granted by one account (the "funding" account) to another
///  * account (the "spender" account) that allows the spender to spend a
///  * specified amount of HBAR owned by the funding account.
///  *
///  * An allowance SHALL NOT transfer any HBAR directly, it only permits
///  * transactions signed only by the spender account to transfer HBAR, up
///  * to the amount specified, from the funding account.
///  *
///  * Once the specified amount is spent, the allowance SHALL be consumed
///  * and a new allowance SHALL be required before that spending account
///  * may spend additional HBAR from the funding account.
class HederaGrantedCryptoAllowance extends HederaProtoMessage with Equality {
  /// *
  ///      * The identifier for the spending account associated with this allowance.
  ///      * &lt;p&gt;
  ///      * This account SHALL be permitted to sign transactions to spend
  ///      * HBAR from the funding/allowing account.&lt;br/&gt;
  ///      * This permission SHALL be limited to no more than the specified `amount`.
  final proto_basic_types.HederaAccountID? spender;

  /// *
  ///      * The maximum amount that the spender account may transfer within
  ///      * the scope of this allowance.
  ///      * &lt;p&gt;
  ///      * This allowance SHALL be consumed if any combination of transfers
  ///      * authorized via this allowance meet this value in total.&lt;br/&gt;
  ///      * This value MUST be specified in tinybar (i.e. 10&lt;sup&gt;-8&lt;/sup&gt; HBAR).
  final BigInt? amount;

  const HederaGrantedCryptoAllowance({this.spender, this.amount});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.message(1), ProtoFieldConfig.int64(2)],
    );
  }

  @override
  List<Object?> get protoValues => [spender, amount];

  HederaGrantedCryptoAllowance copyWith({
    proto_basic_types.HederaAccountID? spender,

    BigInt? amount,
  }) {
    return HederaGrantedCryptoAllowance(
      spender: spender ?? this.spender,
      amount: amount ?? this.amount,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'spender': config.encodeMessage(spender),
      'amount': config.encodeBigint(amount),
    };
  }

  factory HederaGrantedCryptoAllowance.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaGrantedCryptoAllowance(
      spender: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'spender',
        parse:
            (v) => proto_basic_types.HederaAccountID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      amount: json.valueAsBigInt<BigInt?>(
        'amount',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaGrantedCryptoAllowance.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaGrantedCryptoAllowance(
      spender: decode.messageTo<proto_basic_types.HederaAccountID?>(
        1,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
      amount: decode.getBigInt<BigInt?>(2),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoGrantedCryptoAllowance;
}

/// *
///  * Permission granted by one account (the "funding" account) to another
///  * account (the "spender" account) that allows the spender to transfer
///  * all serial numbers of a specific non-fungible/unique token (NFT)
///  * collection owned by the funding account.&lt;br/&gt;
///  * This is a broad permission, as it does not matter how many NFTs of the
///  * specified collection the funding account owns, the spender MAY dispose
///  * of any or all of them with this allowance.&lt;br/&gt;
///  * Each token type (typically a collection of NFTs) SHALL require
///  * a separate allowance.&lt;br/&gt;
///  * Allowances for a specific serial number MUST be directly associated
///  * with that specific non-fungible/unique token, rather than
///  * the holding account.
///  *
///  * An allowance SHALL NOT transfer any tokens directly, it only permits
///  * transactions signed only by the spender account to transfer any
///  * non-fungible/unique tokens of the specified type owned by
///  * the funding account.
class HederaGrantedNftAllowance extends HederaProtoMessage with Equality {
  /// *
  ///      * The identifier for the token associated with this allowance.
  ///      * &lt;p&gt;
  ///      * This token MUST be a non-fungible/unique token.
  final proto_basic_types.HederaTokenID? tokenId;

  /// *
  ///      * The identifier for the spending account associated with this allowance.
  ///      * &lt;p&gt;
  ///      * This account SHALL be permitted to sign transactions to spend
  ///      * tokens of the associated token type from the funding/allowing account.
  final proto_basic_types.HederaAccountID? spender;

  const HederaGrantedNftAllowance({this.tokenId, this.spender});

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
  List<Object?> get protoValues => [tokenId, spender];

  HederaGrantedNftAllowance copyWith({
    proto_basic_types.HederaTokenID? tokenId,

    proto_basic_types.HederaAccountID? spender,
  }) {
    return HederaGrantedNftAllowance(
      tokenId: tokenId ?? this.tokenId,
      spender: spender ?? this.spender,
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
      'spender': config.encodeMessage(spender),
    };
  }

  factory HederaGrantedNftAllowance.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaGrantedNftAllowance(
      tokenId: json.valueTo<proto_basic_types.HederaTokenID?, Object>(
        key: 'token_id',
        parse:
            (v) => proto_basic_types.HederaTokenID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      spender: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'spender',
        parse:
            (v) => proto_basic_types.HederaAccountID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaGrantedNftAllowance.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaGrantedNftAllowance(
      tokenId: decode.messageTo<proto_basic_types.HederaTokenID?>(
        1,
        (b) => proto_basic_types.HederaTokenID.deserialize(b),
      ),
      spender: decode.messageTo<proto_basic_types.HederaAccountID?>(
        2,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoGrantedNftAllowance;
}

/// *
///  * Permission granted by one account (the "funding" account) to another
///  * account (the "spender" account) that allows the spender to spend a
///  * specified amount of a specific non-HBAR fungible token from the
///  * balance owned by the funding account.
///  *
///  * An allowance SHALL NOT transfer any tokens directly, it only permits
///  * transactions signed only by the spender account to transfer tokens
///  * of the specified type, up to the amount specified, from the funding account.
///  *
///  * Once the specified amount is spent, the allowance SHALL be consumed
///  * and a new allowance SHALL be required before that spending account
///  * may spend additional tokens from the funding account.
class HederaGrantedTokenAllowance extends HederaProtoMessage with Equality {
  /// *
  ///      * The identifier for the token associated with this allowance.
  ///      * &lt;p&gt;
  ///      * This token MUST be a fungible/common token.
  final proto_basic_types.HederaTokenID? tokenId;

  /// *
  ///      * The identifier for the spending account associated with this allowance.
  ///      * &lt;p&gt;
  ///      * This account SHALL be permitted to sign transactions to spend tokens
  ///      * of the associated token type from the funding/allowing account.&lt;br/&gt;
  ///      * This permission SHALL be limited to no more than the specified `amount`.
  final proto_basic_types.HederaAccountID? spender;

  /// * The maximum amount that the spender account may transfer within
  ///      * the scope of this allowance.
  ///      * &lt;p&gt;
  ///      * This allowance SHALL be consumed if any combination of transfers
  ///      * authorized via this allowance meet this value in total.&lt;br/&gt;
  ///      * This value MUST be specified in the smallest units of the relevant
  ///      * token (i.e. 10&lt;sup&gt;-decimals&lt;/sup&gt; whole tokens).
  final BigInt? amount;

  const HederaGrantedTokenAllowance({this.tokenId, this.spender, this.amount});

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
  List<Object?> get protoValues => [tokenId, spender, amount];

  HederaGrantedTokenAllowance copyWith({
    proto_basic_types.HederaTokenID? tokenId,

    proto_basic_types.HederaAccountID? spender,

    BigInt? amount,
  }) {
    return HederaGrantedTokenAllowance(
      tokenId: tokenId ?? this.tokenId,
      spender: spender ?? this.spender,
      amount: amount ?? this.amount,
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
      'spender': config.encodeMessage(spender),
      'amount': config.encodeBigint(amount),
    };
  }

  factory HederaGrantedTokenAllowance.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaGrantedTokenAllowance(
      tokenId: json.valueTo<proto_basic_types.HederaTokenID?, Object>(
        key: 'token_id',
        parse:
            (v) => proto_basic_types.HederaTokenID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      spender: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'spender',
        parse:
            (v) => proto_basic_types.HederaAccountID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      amount: json.valueAsBigInt<BigInt?>(
        'amount',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaGrantedTokenAllowance.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaGrantedTokenAllowance(
      tokenId: decode.messageTo<proto_basic_types.HederaTokenID?>(
        1,
        (b) => proto_basic_types.HederaTokenID.deserialize(b),
      ),
      spender: decode.messageTo<proto_basic_types.HederaAccountID?>(
        2,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
      amount: decode.getBigInt<BigInt?>(3),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoGrantedTokenAllowance;
}
