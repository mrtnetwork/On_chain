import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;
import "package:on_chain/hedera/src/proto_messages/proto/src/duration.dart"
    as proto_duration;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/node/hooks/src/hook_types.dart"
    as com_hedera_hapi_node_hooks_hook_types;

/// *
///  * # Crypto Create
///  * Messages to create a new end-user account within the distributed ledger.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in
///  * [RFC2119](https://www.ietf.org/rfc/rfc2119) and clarified in
///  * [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.token"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// * Create a new account.
///  *
///  * If the auto_renew_account field is set, the key of the referenced account
///  * MUST sign this transaction.&lt;br/&gt;
///  * Current limitations REQUIRE that `shardID` and `realmID` both MUST be `0`.
///  * This is expected to change in the future.
///  *
///  * ### Block Stream Effects
///  * The newly created account SHALL be included in State Changes.
class HederaCryptoCreateTransactionBody extends HederaProtoMessage
    with Equality {
  /// Removed prior to oldest available history
  /// *
  ///      * The identifying key for this account.
  ///      * This key represents the account owner, and is required for most actions
  ///      * involving this account that do not modify the account itself. This key
  ///      * may also identify the account for smart contracts.
  ///      * &lt;p&gt;
  ///      * This field is REQUIRED.
  ///      * This `Key` MUST NOT be an empty `KeyList` and MUST contain at least one
  ///      * "primitive" (i.e. cryptographic) key value.
  final proto_basic_types.HederaKey? key;

  /// *
  ///      * An amount, in tinybar, to deposit to the newly created account.
  ///      * &lt;p&gt;
  ///      * The deposited amount SHALL be debited to the "payer" account for this
  ///      * transaction.
  final BigInt? initialBalance;

  /// *
  ///      * Use `staked_id` instead.&lt;br/&gt;
  ///      * An account identifier for a staking proxy.
  final proto_basic_types.HederaAccountID? proxyAccountID;

  /// *
  ///      * Removed prior to the first available history, and may be related to an
  ///      * early design dead-end.&lt;br/&gt;
  ///      * An amount below which record stream records would not be created for
  ///      * a transaction that reduces this account balance.
  final BigInt? sendRecordThreshold;

  /// *
  ///      * Removed prior to the first available history, and may be related to an
  ///      * early design dead-end.&lt;br/&gt;
  ///      * An amount below which record stream records would not be created for
  ///      * a transaction that increases this account balance.
  final BigInt? receiveRecordThreshold;

  /// *
  ///      * A flag indicating the account holder must authorize all incoming
  ///      * token transfers.
  ///      * &lt;p&gt;
  ///      * If this flag is set then any transaction that would result in adding
  ///      * hbar or other tokens to this account balance MUST be signed by the
  ///      * identifying key of this account (that is, the `key` field).&lt;br/&gt;
  ///      * If this flag is set, then the account key (`key` field) MUST sign
  ///      * this create transaction, in addition to the transaction payer.
  final bool? receiverSigRequired;

  /// *
  ///      * The duration between account automatic renewals.&lt;br/&gt;
  ///      * All entities in state may be charged "rent" occasionally (typically
  ///      * every 90 days) to prevent unnecessary growth of the ledger. This value
  ///      * sets the interval between such events for this account.
  ///      * &lt;p&gt;
  ///      * If the account balance (in HBAR) is insufficient to pay the full renewal
  ///      * fee, the entire HBAR balance SHALL be consumed and the expiration for
  ///      * the account SHALL be extended as far as the available balance can
  ///      * support.&lt;br/&gt;
  ///      * If the account HBAR balance is `0` when the account must be renewed, then
  ///      * the account SHALL be deleted, and subsequently removed from state.
  final proto_duration.HederaDuration? autoRenewPeriod;

  /// *
  ///      * The shard in which this account is created
  ///      * &lt;p&gt;
  ///      * Currently, this MUST be `0`.&lt;br/&gt;
  ///      * If the desired shard is `0`, this SHOULD NOT be set.
  final proto_basic_types.HederaShardID? shardID;

  /// *
  ///      * The realm in which this account is created.
  ///      * &lt;p&gt;
  ///      * The shard number for this realm MUST match the value in `shardID`.&lt;br/&gt;
  ///      * Currently, this MUST be `0` for both fields.&lt;br/&gt;
  ///      * If the desired realm is `0`, this SHOULD NOT be set.
  final proto_basic_types.HederaRealmID? realmID;

  /// *
  ///      * This field was never actually used or enabled, and is not expected to
  ///      * ever be used in the future.&lt;br/&gt;
  final proto_basic_types.HederaKey? newRealmAdminKey;

  /// *
  ///      * A short description of this Account.
  ///      * &lt;p&gt;
  ///      * This value, if set, MUST NOT exceed `transaction.maxMemoUtf8Bytes`
  ///      * (default 100) bytes when encoded as UTF-8.
  final String? memo;

  /// *
  ///      * A maximum number of tokens that can be auto-associated
  ///      * with this account.&lt;br/&gt;
  ///      * By default this value is 0 for all accounts except for automatically
  ///      * created accounts (e.g. smart contracts), which default to -1.
  ///      * &lt;p&gt;
  ///      * If this value is `0`, then this account MUST manually associate to
  ///      * a token before holding or transacting in that token.&lt;br/&gt;
  ///      * This value MAY also be `-1` to indicate no limit.&lt;br/&gt;
  ///      * This value MUST NOT be less than `-1`.
  final int? maxAutomaticTokenAssociations;

  /// *
  ///          * ID of the account to which this account is staking its balances.
  ///          * &lt;p&gt;
  ///          * If this account is not currently staking its balances, then this
  ///          * field, if set, MUST be the sentinel value of `0.0.0`.
  final proto_basic_types.HederaAccountID? stakedAccountId;

  /// *
  ///          * ID of the node this account is staked to.
  ///          * &lt;p&gt;
  ///          * If this account is not currently staking its balances, then this
  ///          * field, if set, SHALL be the sentinel value of `-1`.&lt;br/&gt;
  ///          * Wallet software SHOULD surface staking issues to users and provide a
  ///          * simple mechanism to update staking to a new node ID in the event the
  ///          * prior staked node ID ceases to be valid.
  final BigInt? stakedNodeId;

  /// *
  ///      * A boolean indicating that this account has chosen to decline rewards for
  ///      * staking its balances.
  ///      * &lt;p&gt;
  ///      * This account MAY still stake its balances, but SHALL NOT receive reward
  ///      * payments for doing so, if this value is set.
  final bool? declineReward;

  /// *
  ///      * Bytes to be used as the account's alias.
  ///      * &lt;p&gt;
  ///      * This value, if set, MUST be one of the following values&lt;br/&gt;
  ///      * &lt;ul&gt;
  ///      *   &lt;li&gt;The 32-byte serialized form of the ED25519 account key.&lt;/li&gt;
  ///      *   &lt;li&gt;The 33-byte _compressed_ serialized form of the ECDSA(secp256k1)
  ///      *       account key.&lt;/li&gt;
  ///      *   &lt;li&gt;The 20-byte EVM address derived from a keccak-256 hash of the
  ///      *       ECDSA(secp256k1) account key&lt;/li&gt;
  ///      * &lt;/ul&gt;
  ///      * All aliases within the network MUST be unique. If this value matches an
  ///      * existing account alias, this `create` transaction SHALL fail.&lt;br/&gt;
  ///      * If an account exists with a particular alias value, any transaction to
  ///      * transfer value _to_ that alias SHALL deposit the transferred value in
  ///      * the existing account, and SHALL NOT assess an account creation fee.&lt;br/&gt;
  ///      * Once set, an account alias is immutable and MUST NOT be changed.
  final List<int>? alias;

  /// *
  ///      * Details of hooks to add immediately after creating this account.
  final List<com_hedera_hapi_node_hooks_hook_types.HederaHookCreationDetails>
  hookCreationDetails;

  /// *
  ///      * The initial delegated contract address to set for the new account.
  ///      * &lt;p&gt;
  ///      * If set, the value MUST be 20 bytes long (EVM address).
  ///      * A value of `0x0000000000000000000000000000000000000000` will be ignored.
  ///      *
  ///      * If this field is set on the account, anytime a call is made to the account's address
  ///      * (either an EVM call within HSCS or a child call dispatched by CryptoTransfer)
  ///      * the EVM code of the contract referenced by `delegation_address` will be
  ///      * executed in the context of the account.
  final List<int>? delegationAddress;

  const HederaCryptoCreateTransactionBody({
    this.key,
    this.initialBalance,
    this.proxyAccountID,
    this.sendRecordThreshold,
    this.receiveRecordThreshold,
    this.receiverSigRequired,
    this.autoRenewPeriod,
    this.shardID,
    this.realmID,
    this.newRealmAdminKey,
    this.memo,
    this.maxAutomaticTokenAssociations,
    this.stakedAccountId,
    this.stakedNodeId,
    this.declineReward,
    this.alias,
    this.hookCreationDetails = const [],
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
        ProtoFieldConfig.uint64(2),
        ProtoFieldConfig.message(
          3,
          options: [ProtoOptionBool(name: "deprecated", value: true)],
        ),
        ProtoFieldConfig.uint64(
          6,
          options: [ProtoOptionBool(name: "deprecated", value: true)],
        ),
        ProtoFieldConfig.uint64(
          7,
          options: [ProtoOptionBool(name: "deprecated", value: true)],
        ),
        ProtoFieldConfig.bool(8),
        ProtoFieldConfig.message(9),
        ProtoFieldConfig.message(10),
        ProtoFieldConfig.message(11),
        ProtoFieldConfig.message(
          12,
          options: [ProtoOptionBool(name: "deprecated", value: true)],
        ),
        ProtoFieldConfig.string(13),
        ProtoFieldConfig.int32(14),
        ProtoFieldConfig.message(15),
        ProtoFieldConfig.int64(16),
        ProtoFieldConfig.bool(17),
        ProtoFieldConfig.bytes(18),
        ProtoFieldConfig.repeated(
          fieldNumber: 19,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.bytes(20),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    key,
    initialBalance,
    proxyAccountID,
    sendRecordThreshold,
    receiveRecordThreshold,
    receiverSigRequired,
    autoRenewPeriod,
    shardID,
    realmID,
    newRealmAdminKey,
    memo,
    maxAutomaticTokenAssociations,
    stakedAccountId,
    stakedNodeId,
    declineReward,
    alias,
    hookCreationDetails,
    delegationAddress,
  ];

  HederaCryptoCreateTransactionBody copyWith({
    proto_basic_types.HederaKey? key,

    BigInt? initialBalance,

    proto_basic_types.HederaAccountID? proxyAccountID,

    BigInt? sendRecordThreshold,

    BigInt? receiveRecordThreshold,

    bool? receiverSigRequired,

    proto_duration.HederaDuration? autoRenewPeriod,

    proto_basic_types.HederaShardID? shardID,

    proto_basic_types.HederaRealmID? realmID,

    proto_basic_types.HederaKey? newRealmAdminKey,

    String? memo,

    int? maxAutomaticTokenAssociations,

    proto_basic_types.HederaAccountID? stakedAccountId,

    BigInt? stakedNodeId,

    bool? declineReward,

    List<int>? alias,

    List<com_hedera_hapi_node_hooks_hook_types.HederaHookCreationDetails>?
    hookCreationDetails,

    List<int>? delegationAddress,
  }) {
    return HederaCryptoCreateTransactionBody(
      key: key ?? this.key,
      initialBalance: initialBalance ?? this.initialBalance,
      proxyAccountID: proxyAccountID ?? this.proxyAccountID,
      sendRecordThreshold: sendRecordThreshold ?? this.sendRecordThreshold,
      receiveRecordThreshold:
          receiveRecordThreshold ?? this.receiveRecordThreshold,
      receiverSigRequired: receiverSigRequired ?? this.receiverSigRequired,
      autoRenewPeriod: autoRenewPeriod ?? this.autoRenewPeriod,
      shardID: shardID ?? this.shardID,
      realmID: realmID ?? this.realmID,
      newRealmAdminKey: newRealmAdminKey ?? this.newRealmAdminKey,
      memo: memo ?? this.memo,
      maxAutomaticTokenAssociations:
          maxAutomaticTokenAssociations ?? this.maxAutomaticTokenAssociations,
      stakedAccountId: stakedAccountId ?? this.stakedAccountId,
      stakedNodeId: stakedNodeId ?? this.stakedNodeId,
      declineReward: declineReward ?? this.declineReward,
      alias: alias ?? this.alias,
      hookCreationDetails: hookCreationDetails ?? this.hookCreationDetails,
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
      'key': config.encodeMessage(key),
      'initialBalance': config.encodeBigint(initialBalance),
      'proxyAccountID': config.encodeMessage(proxyAccountID),
      'sendRecordThreshold': config.encodeBigint(sendRecordThreshold),
      'receiveRecordThreshold': config.encodeBigint(receiveRecordThreshold),
      'receiverSigRequired': receiverSigRequired,
      'autoRenewPeriod': config.encodeMessage(autoRenewPeriod),
      'shardID': config.encodeMessage(shardID),
      'realmID': config.encodeMessage(realmID),
      'newRealmAdminKey': config.encodeMessage(newRealmAdminKey),
      'memo': memo,
      'max_automatic_token_associations': maxAutomaticTokenAssociations,
      'staked_account_id': config.encodeMessage(stakedAccountId),
      'staked_node_id': config.encodeBigint(stakedNodeId),
      'decline_reward': declineReward,
      'alias': config.encodeBinary(alias),
      'hook_creation_details':
          hookCreationDetails.map((e) => config.encodeMessage(e)).toList(),
      'delegation_address': config.encodeBinary(delegationAddress),
    };
  }

  factory HederaCryptoCreateTransactionBody.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaCryptoCreateTransactionBody(
      key: json.valueTo<proto_basic_types.HederaKey?, Object>(
        key: 'key',
        parse:
            (v) => proto_basic_types.HederaKey.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      initialBalance: json.valueAsBigInt<BigInt?>(
        'initialBalance',
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
      sendRecordThreshold: json.valueAsBigInt<BigInt?>(
        'sendRecordThreshold',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      receiveRecordThreshold: json.valueAsBigInt<BigInt?>(
        'receiveRecordThreshold',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      receiverSigRequired: json.valueAsBool<bool?>(
        'receiverSigRequired',
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
      shardID: json.valueTo<proto_basic_types.HederaShardID?, Object>(
        key: 'shardID',
        parse:
            (v) => proto_basic_types.HederaShardID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      realmID: json.valueTo<proto_basic_types.HederaRealmID?, Object>(
        key: 'realmID',
        parse:
            (v) => proto_basic_types.HederaRealmID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      newRealmAdminKey: json.valueTo<proto_basic_types.HederaKey?, Object>(
        key: 'newRealmAdminKey',
        parse:
            (v) => proto_basic_types.HederaKey.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      memo: json.valueAsString<String?>(
        'memo',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      maxAutomaticTokenAssociations: json.valueAsInt<int?>(
        'max_automatic_token_associations',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      stakedAccountId: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'staked_account_id',
        parse:
            (v) => proto_basic_types.HederaAccountID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      stakedNodeId: json.valueAsBigInt<BigInt?>(
        'staked_node_id',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      declineReward: json.valueAsBool<bool?>(
        'decline_reward',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      alias: config.decodeBinary<List<int>?>(
        json.valueAs('alias', normalizeKeyLookup: config.normalizeKeys),
      ),
      hookCreationDetails:
          (json.valueEnsureAsList<dynamic>(
                'hook_creation_details',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<
                  com_hedera_hapi_node_hooks_hook_types.HederaHookCreationDetails,
                  Object
                >(
                  value: e,
                  parse:
                      (v) => com_hedera_hapi_node_hooks_hook_types
                          .HederaHookCreationDetails.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      delegationAddress: config.decodeBinary<List<int>?>(
        json.valueAs(
          'delegation_address',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
    );
  }

  factory HederaCryptoCreateTransactionBody.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaCryptoCreateTransactionBody(
      key: decode.messageTo<proto_basic_types.HederaKey?>(
        1,
        (b) => proto_basic_types.HederaKey.deserialize(b),
      ),
      initialBalance: decode.getBigInt<BigInt?>(2),
      proxyAccountID: decode.messageTo<proto_basic_types.HederaAccountID?>(
        3,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
      sendRecordThreshold: decode.getBigInt<BigInt?>(6),
      receiveRecordThreshold: decode.getBigInt<BigInt?>(7),
      receiverSigRequired: decode.getBool<bool?>(8),
      autoRenewPeriod: decode.messageTo<proto_duration.HederaDuration?>(
        9,
        (b) => proto_duration.HederaDuration.deserialize(b),
      ),
      shardID: decode.messageTo<proto_basic_types.HederaShardID?>(
        10,
        (b) => proto_basic_types.HederaShardID.deserialize(b),
      ),
      realmID: decode.messageTo<proto_basic_types.HederaRealmID?>(
        11,
        (b) => proto_basic_types.HederaRealmID.deserialize(b),
      ),
      newRealmAdminKey: decode.messageTo<proto_basic_types.HederaKey?>(
        12,
        (b) => proto_basic_types.HederaKey.deserialize(b),
      ),
      memo: decode.getString<String?>(13),
      maxAutomaticTokenAssociations: decode.getInt<int?>(14),
      stakedAccountId: decode.messageTo<proto_basic_types.HederaAccountID?>(
        15,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
      stakedNodeId: decode.getBigInt<BigInt?>(16),
      declineReward: decode.getBool<bool?>(17),
      alias: decode.getBytes<List<int>?>(18),
      hookCreationDetails:
          decode
              .getListOfBytes(19)
              .map(
                (b) => com_hedera_hapi_node_hooks_hook_types
                    .HederaHookCreationDetails.deserialize(b),
              )
              .toList(),
      delegationAddress: decode.getBytes<List<int>?>(20),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoCryptoCreateTransactionBody;
}
