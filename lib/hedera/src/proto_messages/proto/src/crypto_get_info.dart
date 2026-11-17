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
import "package:on_chain/hedera/src/proto_messages/proto/src/crypto_add_live_hash.dart"
    as proto_crypto_add_live_hash;
import "package:on_chain/hedera/src/proto_messages/proto/src/query.dart"
    as proto_query;

/// *
///  * # Get Account Information
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
///  * A query to read information for an account.
///  *
///  * The returned information SHALL include balance.&lt;br/&gt;
///  * The returned information SHALL NOT include allowances.&lt;br/&gt;
///  * The returned information SHALL NOT include token relationships.&lt;br/&gt;
///  * The returned information SHALL NOT include account records.
class HederaCryptoGetInfoQuery extends HederaProtoMessage
    with Equality, IHederaQuery<HederaCryptoGetInfoResponse> {
  /// *
  ///      * Standard information sent with every query operation.&lt;br/&gt;
  ///      * This includes the signed payment and what kind of response is requested
  ///      * (cost, state proof, both, or neither).
  @override
  final proto_query_header.HederaQueryHeader? header;

  /// *
  ///      * The account ID for which information is requested
  final proto_basic_types.HederaAccountID? accountID;

  const HederaCryptoGetInfoQuery({this.header, this.accountID});

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
  List<Object?> get protoValues => [header, accountID];

  @override
  HederaCryptoGetInfoQuery copyWith({
    proto_query_header.HederaQueryHeader? header,

    proto_basic_types.HederaAccountID? accountID,
  }) {
    return HederaCryptoGetInfoQuery(
      header: header ?? this.header,
      accountID: accountID ?? this.accountID,
    );
  }

  @override
  proto_query.HederaQuery toQueryRequest({
    proto_query_header.HederaQueryHeader? header,
  }) => proto_query.HederaQuery(cryptoGetInfo: copyWith(header: header));
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'header': config.encodeMessage(header),
      'accountID': config.encodeMessage(accountID),
    };
  }

  factory HederaCryptoGetInfoQuery.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaCryptoGetInfoQuery(
      header: json.valueTo<proto_query_header.HederaQueryHeader?, Object>(
        key: 'header',
        parse:
            (v) => proto_query_header.HederaQueryHeader.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      accountID: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'accountID',
        parse:
            (v) => proto_basic_types.HederaAccountID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaCryptoGetInfoQuery.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaCryptoGetInfoQuery(
      header: decode.messageTo<proto_query_header.HederaQueryHeader?>(
        1,
        (b) => proto_query_header.HederaQueryHeader.deserialize(b),
      ),
      accountID: decode.messageTo<proto_basic_types.HederaAccountID?>(
        2,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoCryptoGetInfoQuery;
}

/// *
///  * Response when the client sends the node CryptoGetInfoQuery
class HederaCryptoGetInfoResponse extends HederaProtoMessage
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
  final HederaCryptoGetInfoResponseAccountInfo? accountInfo;

  const HederaCryptoGetInfoResponse({this.header, this.accountInfo});

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
  List<Object?> get protoValues => [header, accountInfo];

  HederaCryptoGetInfoResponse copyWith({
    proto_response_header.HederaResponseHeader? header,

    HederaCryptoGetInfoResponseAccountInfo? accountInfo,
  }) {
    return HederaCryptoGetInfoResponse(
      header: header ?? this.header,
      accountInfo: accountInfo ?? this.accountInfo,
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
      'accountInfo': config.encodeMessage(accountInfo),
    };
  }

  factory HederaCryptoGetInfoResponse.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaCryptoGetInfoResponse(
      header: json.valueTo<proto_response_header.HederaResponseHeader?, Object>(
        key: 'header',
        parse:
            (v) => proto_response_header.HederaResponseHeader.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      accountInfo: json
          .valueTo<HederaCryptoGetInfoResponseAccountInfo?, Object>(
            key: 'accountInfo',
            parse:
                (v) => HederaCryptoGetInfoResponseAccountInfo.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
    );
  }

  factory HederaCryptoGetInfoResponse.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaCryptoGetInfoResponse(
      header: decode.messageTo<proto_response_header.HederaResponseHeader?>(
        1,
        (b) => proto_response_header.HederaResponseHeader.deserialize(b),
      ),
      accountInfo: decode.messageTo<HederaCryptoGetInfoResponseAccountInfo?>(
        2,
        (b) => HederaCryptoGetInfoResponseAccountInfo.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoCryptoGetInfoResponse;
}

/// *
///      * Information describing A single Account in the Hedera distributed ledger.
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
class HederaCryptoGetInfoResponseAccountInfo extends HederaProtoMessage
    with Equality {
  /// Removed prior to oldest available history
  /// *
  ///          * a unique identifier for this account.
  ///          * &lt;p&gt;
  ///          * An account identifier, when assigned to this field, SHALL be of
  ///          * the form `shard.realm.number`.
  final proto_basic_types.HederaAccountID? accountID;

  /// *
  ///          * A Solidity ID.
  ///          * &lt;p&gt;
  ///          * This SHALL be populated if this account is a smart contract, and
  ///          * SHALL NOT be populated otherwise.&lt;br/&gt;
  ///          * This SHALL be formatted as a string according to Solidity ID
  ///          * standards.
  final String? contractAccountID;

  /// *
  ///          * A boolean indicating that this account is deleted.
  ///          * &lt;p&gt;
  ///          * Any transaction involving a deleted account SHALL fail.
  final bool? deleted;

  /// *
  ///          * Replaced by StakingInfo.&lt;br/&gt;
  ///          * ID of the account to which this account is staking its balances. If
  ///          * this account is not currently staking its balances, then this field,
  ///          * if set, SHALL be the sentinel value of `0.0.0`.
  final proto_basic_types.HederaAccountID? proxyAccountID;

  /// *
  ///          * Replaced by StakingInfo.&lt;br/&gt;
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
  ///          * Obsolete and unused.&lt;br/&gt;
  ///          * The threshold amount, in tinybars, at which a record was created for
  ///          * any transaction that decreased the balance of this account.
  final BigInt? generateSendRecordThreshold;

  /// *
  ///          * Obsolete and unused.&lt;br/&gt;
  ///          * The threshold amount, in tinybars, at which a record was created for
  ///          * any transaction that increased the balance of this account.
  final BigInt? generateReceiveRecordThreshold;

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
  ///          * All of the livehashes attached to the account (each of which is a
  ///          * hash along with the keys that authorized it and can delete it)
  final List<proto_crypto_add_live_hash.HederaLiveHash> liveHashes;

  /// *
  ///          * As of `HIP-367`, which enabled unlimited token associations, the
  ///          * potential scale for this value requires that users consult a mirror
  ///          * node for this information.
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
  ///          * An account alias.&lt;br/&gt;
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
  ///          * The ethereum transaction nonce associated with this account.
  final BigInt? ethereumNonce;

  /// *
  ///          * Staking information for this account.
  final proto_basic_types.HederaStakingInfo? stakingInfo;

  /// *
  ///          * The delegated contract address set for this account.
  ///          * &lt;p&gt;
  ///          * If this field is set on the account, anytime a call is made to the account's address
  ///          * (either an EVM call within HSCS or a child call dispatched by CryptoTransfer)
  ///          * the EVM code of the contract referenced by `delegation_address` will be
  ///          * executed in the context of the account.
  final List<int>? delegationAddress;

  const HederaCryptoGetInfoResponseAccountInfo({
    this.accountID,
    this.contractAccountID,
    this.deleted,
    this.proxyAccountID,
    this.proxyReceived,
    this.key,
    this.balance,
    this.generateSendRecordThreshold,
    this.generateReceiveRecordThreshold,
    this.receiverSigRequired,
    this.expirationTime,
    this.autoRenewPeriod,
    this.liveHashes = const [],
    this.tokenRelationships = const [],
    this.memo,
    this.ownedNfts,
    this.maxAutomaticTokenAssociations,
    this.alias,
    this.ledgerId,
    this.ethereumNonce,
    this.stakingInfo,
    this.delegationAddress,
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
        ProtoFieldConfig.int64(
          6,
          options: [ProtoOptionBool(name: "deprecated", value: true)],
        ),
        ProtoFieldConfig.message(7),
        ProtoFieldConfig.uint64(8),
        ProtoFieldConfig.uint64(
          9,
          options: [ProtoOptionBool(name: "deprecated", value: true)],
        ),
        ProtoFieldConfig.uint64(
          10,
          options: [ProtoOptionBool(name: "deprecated", value: true)],
        ),
        ProtoFieldConfig.bool(11),
        ProtoFieldConfig.message(12),
        ProtoFieldConfig.message(13),
        ProtoFieldConfig.repeated(
          fieldNumber: 14,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.repeated(
          fieldNumber: 15,
          elementType: ProtoFieldType.message,
          options: [ProtoOptionBool(name: "deprecated", value: true)],
        ),
        ProtoFieldConfig.string(16),
        ProtoFieldConfig.int64(17),
        ProtoFieldConfig.int32(18),
        ProtoFieldConfig.bytes(19),
        ProtoFieldConfig.bytes(20),
        ProtoFieldConfig.int64(21),
        ProtoFieldConfig.message(22),
        ProtoFieldConfig.bytes(23),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    accountID,
    contractAccountID,
    deleted,
    proxyAccountID,
    proxyReceived,
    key,
    balance,
    generateSendRecordThreshold,
    generateReceiveRecordThreshold,
    receiverSigRequired,
    expirationTime,
    autoRenewPeriod,
    liveHashes,
    tokenRelationships,
    memo,
    ownedNfts,
    maxAutomaticTokenAssociations,
    alias,
    ledgerId,
    ethereumNonce,
    stakingInfo,
    delegationAddress,
  ];

  HederaCryptoGetInfoResponseAccountInfo copyWith({
    proto_basic_types.HederaAccountID? accountID,

    String? contractAccountID,

    bool? deleted,

    proto_basic_types.HederaAccountID? proxyAccountID,

    BigInt? proxyReceived,

    proto_basic_types.HederaKey? key,

    BigInt? balance,

    BigInt? generateSendRecordThreshold,

    BigInt? generateReceiveRecordThreshold,

    bool? receiverSigRequired,

    proto_timestamp.HederaTimestamp? expirationTime,

    proto_duration.HederaDuration? autoRenewPeriod,

    List<proto_crypto_add_live_hash.HederaLiveHash>? liveHashes,

    List<proto_basic_types.HederaTokenRelationship>? tokenRelationships,

    String? memo,

    BigInt? ownedNfts,

    int? maxAutomaticTokenAssociations,

    List<int>? alias,

    List<int>? ledgerId,

    BigInt? ethereumNonce,

    proto_basic_types.HederaStakingInfo? stakingInfo,

    List<int>? delegationAddress,
  }) {
    return HederaCryptoGetInfoResponseAccountInfo(
      accountID: accountID ?? this.accountID,
      contractAccountID: contractAccountID ?? this.contractAccountID,
      deleted: deleted ?? this.deleted,
      proxyAccountID: proxyAccountID ?? this.proxyAccountID,
      proxyReceived: proxyReceived ?? this.proxyReceived,
      key: key ?? this.key,
      balance: balance ?? this.balance,
      generateSendRecordThreshold:
          generateSendRecordThreshold ?? this.generateSendRecordThreshold,
      generateReceiveRecordThreshold:
          generateReceiveRecordThreshold ?? this.generateReceiveRecordThreshold,
      receiverSigRequired: receiverSigRequired ?? this.receiverSigRequired,
      expirationTime: expirationTime ?? this.expirationTime,
      autoRenewPeriod: autoRenewPeriod ?? this.autoRenewPeriod,
      liveHashes: liveHashes ?? this.liveHashes,
      tokenRelationships: tokenRelationships ?? this.tokenRelationships,
      memo: memo ?? this.memo,
      ownedNfts: ownedNfts ?? this.ownedNfts,
      maxAutomaticTokenAssociations:
          maxAutomaticTokenAssociations ?? this.maxAutomaticTokenAssociations,
      alias: alias ?? this.alias,
      ledgerId: ledgerId ?? this.ledgerId,
      ethereumNonce: ethereumNonce ?? this.ethereumNonce,
      stakingInfo: stakingInfo ?? this.stakingInfo,
      delegationAddress: delegationAddress ?? this.delegationAddress,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'accountID': config.encodeMessage(accountID),
      'contractAccountID': contractAccountID,
      'deleted': deleted,
      'proxyAccountID': config.encodeMessage(proxyAccountID),
      'proxyReceived': config.encodeBigint(proxyReceived),
      'key': config.encodeMessage(key),
      'balance': config.encodeBigint(balance),
      'generateSendRecordThreshold': config.encodeBigint(
        generateSendRecordThreshold,
      ),
      'generateReceiveRecordThreshold': config.encodeBigint(
        generateReceiveRecordThreshold,
      ),
      'receiverSigRequired': receiverSigRequired,
      'expirationTime': config.encodeMessage(expirationTime),
      'autoRenewPeriod': config.encodeMessage(autoRenewPeriod),
      'liveHashes': liveHashes.map((e) => config.encodeMessage(e)).toList(),
      'tokenRelationships':
          tokenRelationships.map((e) => config.encodeMessage(e)).toList(),
      'memo': memo,
      'ownedNfts': config.encodeBigint(ownedNfts),
      'max_automatic_token_associations': maxAutomaticTokenAssociations,
      'alias': config.encodeBinary(alias),
      'ledger_id': config.encodeBinary(ledgerId),
      'ethereum_nonce': config.encodeBigint(ethereumNonce),
      'staking_info': config.encodeMessage(stakingInfo),
      'delegation_address': config.encodeBinary(delegationAddress),
    };
  }

  factory HederaCryptoGetInfoResponseAccountInfo.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaCryptoGetInfoResponseAccountInfo(
      accountID: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'accountID',
        parse:
            (v) => proto_basic_types.HederaAccountID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      contractAccountID: json.valueAsString<String?>(
        'contractAccountID',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      deleted: json.valueAsBool<bool?>(
        'deleted',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      proxyAccountID: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'proxyAccountID',
        parse:
            (v) => proto_basic_types.HederaAccountID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      proxyReceived: json.valueAsBigInt<BigInt?>(
        'proxyReceived',
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
      generateSendRecordThreshold: json.valueAsBigInt<BigInt?>(
        'generateSendRecordThreshold',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      generateReceiveRecordThreshold: json.valueAsBigInt<BigInt?>(
        'generateReceiveRecordThreshold',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      receiverSigRequired: json.valueAsBool<bool?>(
        'receiverSigRequired',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      expirationTime: json.valueTo<proto_timestamp.HederaTimestamp?, Object>(
        key: 'expirationTime',
        parse:
            (v) => proto_timestamp.HederaTimestamp.fromJson(
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
      liveHashes:
          (json.valueEnsureAsList<dynamic>(
                'liveHashes',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<
                  proto_crypto_add_live_hash.HederaLiveHash,
                  Object
                >(
                  value: e,
                  parse:
                      (v) => proto_crypto_add_live_hash.HederaLiveHash.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      tokenRelationships:
          (json.valueEnsureAsList<dynamic>(
                'tokenRelationships',
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
        'ownedNfts',
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
      ethereumNonce: json.valueAsBigInt<BigInt?>(
        'ethereum_nonce',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      stakingInfo: json.valueTo<proto_basic_types.HederaStakingInfo?, Object>(
        key: 'staking_info',
        parse:
            (v) => proto_basic_types.HederaStakingInfo.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      delegationAddress: config.decodeBinary<List<int>?>(
        json.valueAs(
          'delegation_address',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
    );
  }

  factory HederaCryptoGetInfoResponseAccountInfo.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaCryptoGetInfoResponseAccountInfo(
      accountID: decode.messageTo<proto_basic_types.HederaAccountID?>(
        1,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
      contractAccountID: decode.getString<String?>(2),
      deleted: decode.getBool<bool?>(3),
      proxyAccountID: decode.messageTo<proto_basic_types.HederaAccountID?>(
        4,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
      proxyReceived: decode.getBigInt<BigInt?>(6),
      key: decode.messageTo<proto_basic_types.HederaKey?>(
        7,
        (b) => proto_basic_types.HederaKey.deserialize(b),
      ),
      balance: decode.getBigInt<BigInt?>(8),
      generateSendRecordThreshold: decode.getBigInt<BigInt?>(9),
      generateReceiveRecordThreshold: decode.getBigInt<BigInt?>(10),
      receiverSigRequired: decode.getBool<bool?>(11),
      expirationTime: decode.messageTo<proto_timestamp.HederaTimestamp?>(
        12,
        (b) => proto_timestamp.HederaTimestamp.deserialize(b),
      ),
      autoRenewPeriod: decode.messageTo<proto_duration.HederaDuration?>(
        13,
        (b) => proto_duration.HederaDuration.deserialize(b),
      ),
      liveHashes:
          decode
              .getListOfBytes(14)
              .map(
                (b) => proto_crypto_add_live_hash.HederaLiveHash.deserialize(b),
              )
              .toList(),
      tokenRelationships:
          decode
              .getListOfBytes(15)
              .map(
                (b) => proto_basic_types.HederaTokenRelationship.deserialize(b),
              )
              .toList(),
      memo: decode.getString<String?>(16),
      ownedNfts: decode.getBigInt<BigInt?>(17),
      maxAutomaticTokenAssociations: decode.getInt<int?>(18),
      alias: decode.getBytes<List<int>?>(19),
      ledgerId: decode.getBytes<List<int>?>(20),
      ethereumNonce: decode.getBigInt<BigInt?>(21),
      stakingInfo: decode.messageTo<proto_basic_types.HederaStakingInfo?>(
        22,
        (b) => proto_basic_types.HederaStakingInfo.deserialize(b),
      ),
      delegationAddress: decode.getBytes<List<int>?>(23),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoCryptoGetInfoResponseAccountInfo;
}
