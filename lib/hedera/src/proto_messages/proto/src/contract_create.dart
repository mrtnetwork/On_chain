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
///  * # Smart Contract Create
///  *
///  * Create a new smart contract.
///  *
///  * ## General Comments
///  *  - A smart contract normally enforces rules, so "the code is law".&lt;br/&gt;
///  *    For example, an ERC-20 contract prevents a transfer from being undone
///  *    without a signature by the recipient of the transfer. This characteristic
///  *    is generally true if the contract instance was created without a value
///  *    for the `adminKey` field. For some uses, however, it may be desirable to
///  *    create something like an ERC-20 contract that has a specific group of
///  *    trusted individuals who can act as a "supreme court" with the ability to
///  *    override the normal operation, when a sufficient number of them agree to
///  *    do so. If `adminKey` is set to a valid Key (which MAY be complex), then a
///  *    transaction that can change the state of the smart contract in arbitrary
///  *    ways MAY be signed with enough signatures to activate that Key. Such
///  *    transactions might reverse a transaction, change the code to close an
///  *    unexpected loophole, remove an exploit, or adjust outputs in ways not
///  *    covered by the code itself. The admin key MAY also be used to change the
///  *    autoRenewPeriod, and change the adminKey field itself (for example, to
///  *    remove that key after a suitable testing period). The API currently does
///  *    not implement all relevant capabilities. But it does allow the `adminKey`
///  *    field to be set and queried, and MAY implement further administrative
///  *    capability in future releases.
///  *  - The current API ignores shardID, realmID, and newRealmAdminKey, and
///  *    creates everything in shard 0 and realm 0. Future versions of the system
///  *    MAY support additional shards and realms.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in
///  * [RFC2119](https://www.ietf.org/rfc/rfc2119) and clarified in
///  * [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.contract"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * Create a new smart contract.
///  *
///  * If this transaction succeeds, the `ContractID` for the new smart contract
///  * SHALL be set in the transaction receipt.&lt;br/&gt;
///  * The contract is defined by the initial bytecode (or `initcode`). The
///  * `initcode` SHALL be stored either in a previously created file, or in the
///  * transaction body itself for very small contracts.
///  *
///  * As part of contract creation, the constructor defined for the new smart
///  * contract SHALL run with the parameters provided in the
///  * `constructorParameters` field.&lt;br/&gt;
///  * The gas to "power" that constructor MUST be provided via the `gas` field,
///  * and SHALL be charged to the payer for this transaction.&lt;br/&gt;
///  * If the contract _constructor_ stores information, it is charged gas for that
///  * storage. There is a separate fee in HBAR to maintain that storage until the
///  * expiration, and that fee SHALL be added to this transaction as part of the
///  * _transaction fee_, rather than gas.
///  *
///  * ### Block Stream Effects
///  * A `CreateContractOutput` message SHALL be emitted for each transaction.
class HederaContractCreateTransactionBody extends HederaProtoMessage
    with Equality {
  /// *
  ///          * The source for the smart contract EVM bytecode.
  ///          * &lt;p&gt;
  ///          * The file containing the smart contract initcode.
  ///          * A copy of the contents SHALL be made and held as `bytes`
  ///          * in smart contract state.&lt;br/&gt;
  ///          * The contract bytecode is limited in size only by the
  ///          * network file size limit.
  final proto_basic_types.HederaFileID? fileID;

  /// *
  ///          * The source for the smart contract EVM bytecode.
  ///          * &lt;p&gt;
  ///          * The bytes of the smart contract initcode. A copy of the contents
  ///          * SHALL be made and held as `bytes` in smart contract state.&lt;br/&gt;
  ///          * This value is limited in length by the network transaction size
  ///          * limit. This entire transaction, including all fields and signatures,
  ///          * MUST be less than the network transaction size limit.
  final List<int>? initcode;

  /// *
  ///      * Access control for modification of the smart contract after
  ///      * it is created.
  ///      * &lt;p&gt;
  ///      * If this field is set, that key MUST sign this transaction.&lt;br/&gt;
  ///      * If this field is set, that key MUST sign each future transaction to
  ///      * update or delete the contract.&lt;br/&gt;
  ///      * An updateContract transaction that _only_ extends the topic
  ///      * expirationTime (a "manual renewal" transaction) SHALL NOT require
  ///      * admin key signature.
  ///      * &lt;p&gt;
  ///      * A contract without an admin key SHALL be immutable, except for
  ///      * expiration and renewal.
  final proto_basic_types.HederaKey? adminKey;

  /// *
  ///      * A maximum limit to the amount of gas to use for the constructor call.
  ///      * &lt;p&gt;
  ///      * The network SHALL charge the greater of the following, but SHALL NOT
  ///      * charge more than the value of this field.
  ///      * &lt;ol&gt;
  ///      *   &lt;li&gt;The actual gas consumed by the smart contract
  ///      *       constructor call.&lt;/li&gt;
  ///      *   &lt;li&gt;`80%` of this value.&lt;/li&gt;
  ///      * &lt;/ol&gt;
  ///      * The `80%` factor encourages reasonable estimation, while allowing for
  ///      * some overage to ensure successful execution.
  final BigInt? gas;

  /// *
  ///      * The amount of HBAR to use as an initial balance for the account
  ///      * representing the new smart contract.
  ///      * &lt;p&gt;
  ///      * This value is presented in tinybar
  ///      * (10&lt;sup&gt;&lt;strong&gt;-&lt;/strong&gt;8&lt;/sup&gt; HBAR).&lt;br/&gt;
  ///      * The HBAR provided here will be withdrawn from the payer account that
  ///      * signed this transaction.
  final BigInt? initialBalance;

  /// *
  ///      * Proxy account staking is handled via `staked_id`.
  ///      * &lt;p&gt;
  ///      * Former field to designate a proxy account for HBAR staking.
  ///      * This field MUST NOT be set.
  final proto_basic_types.HederaAccountID? proxyAccountID;

  /// *
  ///      * The initial lifetime, in seconds, for the smart contract, and the number
  ///      * of seconds for which the smart contract will be automatically renewed
  ///      * upon expiration.
  ///      * &lt;p&gt;
  ///      * This value MUST be set.&lt;br/&gt;
  ///      * This value MUST be greater than the configured MIN_AUTORENEW_PERIOD.&lt;br/&gt;
  ///      * This value MUST be less than the configured MAX_AUTORENEW_PERIOD.&lt;br/&gt;
  final proto_duration.HederaDuration? autoRenewPeriod;

  /// *
  ///      * An array of bytes containing the EVM-encoded parameters to pass to
  ///      * the smart contract constructor defined in the smart contract init
  ///      * code provided.
  final List<int>? constructorParameters;

  /// *
  ///      * &lt;blockquote&gt;Review Question&lt;br/&gt;
  ///      * &lt;blockquote&gt;Should this be deprecated?&lt;br/&gt;
  ///      * It's never been used and probably never should be used...&lt;br/&gt;
  ///      * Shard should be determined by the node the transaction is submitted to.
  ///      * &lt;/blockquote&gt;&lt;/blockquote&gt;
  ///      * &lt;p&gt;
  ///      * The shard in which to create the new smart contract.&lt;br/&gt;
  ///      * This value is currently ignored.
  final proto_basic_types.HederaShardID? shardID;

  /// *
  ///      * &lt;blockquote&gt;Review Question&lt;br/&gt;
  ///      * &lt;blockquote&gt;Should this be deprecated?&lt;br/&gt;
  ///      * It's never been used and probably never should be used...&lt;br/&gt;
  ///      * Realm should be determined by node and network parameters.
  ///      * &lt;/blockquote&gt;&lt;/blockquote&gt;
  ///      * &lt;p&gt;
  ///      * The shard/realm in which to create the new smart contract.&lt;br/&gt;
  ///      * This value is currently ignored.
  final proto_basic_types.HederaRealmID? realmID;

  /// *
  ///      * &lt;blockquote&gt;Review Question&lt;br/&gt;
  ///      * &lt;blockquote&gt;Should this be deprecated?&lt;br/&gt;
  ///      * It's never been used and probably never should be used...&lt;br/&gt;
  ///      * If a realm is used, it must already exist; we shouldn't be creating it
  ///      * without a separate transaction.&lt;/blockquote&gt;&lt;/blockquote&gt;
  ///      * &lt;p&gt;
  ///      * This was intended to provide an admin key for any new realm created
  ///      * during the creation of the smart contract.&lt;br/&gt;
  ///      * This value is currently ignored. a new realm SHALL NOT be created,
  ///      * regardless of the value of `realmID`.
  final proto_basic_types.HederaKey? newRealmAdminKey;

  /// *
  ///      * A short memo for this smart contract.
  ///      * &lt;p&gt;
  ///      * This value, if set, MUST NOT exceed `transaction.maxMemoUtf8Bytes`
  ///      * (default 100) bytes when encoded as UTF-8.
  final String? memo;

  /// *
  ///      * The maximum number of tokens that can be auto-associated with this
  ///      * smart contract.
  ///      * &lt;p&gt;
  ///      * If this is less than or equal to `used_auto_associations` (or 0), then
  ///      * this contract MUST manually associate with a token before transacting
  ///      * in that token.&lt;br/&gt;
  ///      * Following HIP-904 This value may also be `-1` to indicate no limit.&lt;br/&gt;
  ///      * This value MUST NOT be less than `-1`.
  final int? maxAutomaticTokenAssociations;

  /// *
  ///      * The id of an account, in the same shard and realm as this smart
  ///      * contract, that has signed this transaction, allowing the network to use
  ///      * its balance, when needed, to automatically extend this contract's
  ///      * expiration time.
  ///      * &lt;p&gt;
  ///      * If this field is set, that key MUST sign this transaction.&lt;br/&gt;
  ///      * If this field is set, then the network SHALL deduct the necessary fees
  ///      * from the designated auto renew account, if that account has sufficient
  ///      * balance. If the auto renew account does not have sufficient balance,
  ///      * then the fees for contract renewal SHALL be deducted from the HBAR
  ///      * balance held by the smart contract.&lt;br/&gt;
  ///      * If this field is not set, then all renewal fees SHALL be deducted from
  ///      * the HBAR balance held by this contract.
  final proto_basic_types.HederaAccountID? autoRenewAccountId;

  /// *
  ///          * An account ID.
  ///          * &lt;p&gt;
  ///          * This smart contract SHALL stake its HBAR via this account as proxy.
  final proto_basic_types.HederaAccountID? stakedAccountId;

  /// *
  ///          * The ID of a network node.
  ///          * &lt;p&gt;
  ///          * This smart contract SHALL stake its HBAR to this node.
  ///          * &lt;p&gt;
  ///          * &lt;blockquote&gt;Note: node IDs do fluctuate as node operators change.
  ///          * Most contracts are immutable, and a contract staking to an invalid
  ///          * node ID SHALL NOT participate in staking. Immutable contracts MAY
  ///          * find it more reliable to use a proxy account for staking
  ///          * (via `staked_account_id`) to enable updating the _effective_ staking
  ///          * node ID when necessary through updating the proxy
  ///          * account.&lt;/blockquote&gt;
  final BigInt? stakedNodeId;

  /// *
  ///      * A flag indicating that this smart contract declines to receive any
  ///      * reward for staking its HBAR balance to help secure the network.
  ///      * &lt;p&gt;
  ///      * If set to true, this smart contract SHALL NOT receive any reward for
  ///      * staking its HBAR balance to help secure the network, regardless of
  ///      * staking configuration, but MAY stake HBAR to support the network
  ///      * without reward.
  final bool? declineReward;

  /// *
  ///      * Details of hooks to add immediately after creating this contract.
  final List<com_hedera_hapi_node_hooks_hook_types.HederaHookCreationDetails>
  hookCreationDetails;

  const HederaContractCreateTransactionBody({
    this.fileID,
    this.initcode,
    this.adminKey,
    this.gas,
    this.initialBalance,
    this.proxyAccountID,
    this.autoRenewPeriod,
    this.constructorParameters,
    this.shardID,
    this.realmID,
    this.newRealmAdminKey,
    this.memo,
    this.maxAutomaticTokenAssociations,
    this.autoRenewAccountId,
    this.stakedAccountId,
    this.stakedNodeId,
    this.declineReward,
    this.hookCreationDetails = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.bytes(16),
        ProtoFieldConfig.message(3),
        ProtoFieldConfig.int64(4),
        ProtoFieldConfig.int64(5),
        ProtoFieldConfig.message(
          6,
          options: [ProtoOptionBool(name: "deprecated", value: true)],
        ),
        ProtoFieldConfig.message(8),
        ProtoFieldConfig.bytes(9),
        ProtoFieldConfig.message(10),
        ProtoFieldConfig.message(11),
        ProtoFieldConfig.message(12),
        ProtoFieldConfig.string(13),
        ProtoFieldConfig.int32(14),
        ProtoFieldConfig.message(15),
        ProtoFieldConfig.message(17),
        ProtoFieldConfig.int64(18),
        ProtoFieldConfig.bool(19),
        ProtoFieldConfig.repeated(
          fieldNumber: 20,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    fileID,
    initcode,
    adminKey,
    gas,
    initialBalance,
    proxyAccountID,
    autoRenewPeriod,
    constructorParameters,
    shardID,
    realmID,
    newRealmAdminKey,
    memo,
    maxAutomaticTokenAssociations,
    autoRenewAccountId,
    stakedAccountId,
    stakedNodeId,
    declineReward,
    hookCreationDetails,
  ];

  HederaContractCreateTransactionBody copyWith({
    proto_basic_types.HederaFileID? fileID,

    List<int>? initcode,

    proto_basic_types.HederaKey? adminKey,

    BigInt? gas,

    BigInt? initialBalance,

    proto_basic_types.HederaAccountID? proxyAccountID,

    proto_duration.HederaDuration? autoRenewPeriod,

    List<int>? constructorParameters,

    proto_basic_types.HederaShardID? shardID,

    proto_basic_types.HederaRealmID? realmID,

    proto_basic_types.HederaKey? newRealmAdminKey,

    String? memo,

    int? maxAutomaticTokenAssociations,

    proto_basic_types.HederaAccountID? autoRenewAccountId,

    proto_basic_types.HederaAccountID? stakedAccountId,

    BigInt? stakedNodeId,

    bool? declineReward,

    List<com_hedera_hapi_node_hooks_hook_types.HederaHookCreationDetails>?
    hookCreationDetails,
  }) {
    return HederaContractCreateTransactionBody(
      fileID: fileID ?? this.fileID,
      initcode: initcode ?? this.initcode,
      adminKey: adminKey ?? this.adminKey,
      gas: gas ?? this.gas,
      initialBalance: initialBalance ?? this.initialBalance,
      proxyAccountID: proxyAccountID ?? this.proxyAccountID,
      autoRenewPeriod: autoRenewPeriod ?? this.autoRenewPeriod,
      constructorParameters:
          constructorParameters ?? this.constructorParameters,
      shardID: shardID ?? this.shardID,
      realmID: realmID ?? this.realmID,
      newRealmAdminKey: newRealmAdminKey ?? this.newRealmAdminKey,
      memo: memo ?? this.memo,
      maxAutomaticTokenAssociations:
          maxAutomaticTokenAssociations ?? this.maxAutomaticTokenAssociations,
      autoRenewAccountId: autoRenewAccountId ?? this.autoRenewAccountId,
      stakedAccountId: stakedAccountId ?? this.stakedAccountId,
      stakedNodeId: stakedNodeId ?? this.stakedNodeId,
      declineReward: declineReward ?? this.declineReward,
      hookCreationDetails: hookCreationDetails ?? this.hookCreationDetails,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'fileID': config.encodeMessage(fileID),
      'initcode': config.encodeBinary(initcode),
      'adminKey': config.encodeMessage(adminKey),
      'gas': config.encodeBigint(gas),
      'initialBalance': config.encodeBigint(initialBalance),
      'proxyAccountID': config.encodeMessage(proxyAccountID),
      'autoRenewPeriod': config.encodeMessage(autoRenewPeriod),
      'constructorParameters': config.encodeBinary(constructorParameters),
      'shardID': config.encodeMessage(shardID),
      'realmID': config.encodeMessage(realmID),
      'newRealmAdminKey': config.encodeMessage(newRealmAdminKey),
      'memo': memo,
      'max_automatic_token_associations': maxAutomaticTokenAssociations,
      'auto_renew_account_id': config.encodeMessage(autoRenewAccountId),
      'staked_account_id': config.encodeMessage(stakedAccountId),
      'staked_node_id': config.encodeBigint(stakedNodeId),
      'decline_reward': declineReward,
      'hook_creation_details':
          hookCreationDetails.map((e) => config.encodeMessage(e)).toList(),
    };
  }

  factory HederaContractCreateTransactionBody.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaContractCreateTransactionBody(
      fileID: json.valueTo<proto_basic_types.HederaFileID?, Object>(
        key: 'fileID',
        parse:
            (v) => proto_basic_types.HederaFileID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      initcode: config.decodeBinary<List<int>?>(
        json.valueAs('initcode', normalizeKeyLookup: config.normalizeKeys),
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
      gas: json.valueAsBigInt<BigInt?>(
        'gas',
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
      autoRenewPeriod: json.valueTo<proto_duration.HederaDuration?, Object>(
        key: 'autoRenewPeriod',
        parse:
            (v) => proto_duration.HederaDuration.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      constructorParameters: config.decodeBinary<List<int>?>(
        json.valueAs(
          'constructorParameters',
          normalizeKeyLookup: config.normalizeKeys,
        ),
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
    );
  }

  factory HederaContractCreateTransactionBody.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaContractCreateTransactionBody(
      fileID: decode.messageTo<proto_basic_types.HederaFileID?>(
        1,
        (b) => proto_basic_types.HederaFileID.deserialize(b),
      ),
      initcode: decode.getBytes<List<int>?>(16),
      adminKey: decode.messageTo<proto_basic_types.HederaKey?>(
        3,
        (b) => proto_basic_types.HederaKey.deserialize(b),
      ),
      gas: decode.getBigInt<BigInt?>(4),
      initialBalance: decode.getBigInt<BigInt?>(5),
      proxyAccountID: decode.messageTo<proto_basic_types.HederaAccountID?>(
        6,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
      autoRenewPeriod: decode.messageTo<proto_duration.HederaDuration?>(
        8,
        (b) => proto_duration.HederaDuration.deserialize(b),
      ),
      constructorParameters: decode.getBytes<List<int>?>(9),
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
      autoRenewAccountId: decode.messageTo<proto_basic_types.HederaAccountID?>(
        15,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
      stakedAccountId: decode.messageTo<proto_basic_types.HederaAccountID?>(
        17,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
      stakedNodeId: decode.getBigInt<BigInt?>(18),
      declineReward: decode.getBool<bool?>(19),
      hookCreationDetails:
          decode
              .getListOfBytes(20)
              .map(
                (b) => com_hedera_hapi_node_hooks_hook_types
                    .HederaHookCreationDetails.deserialize(b),
              )
              .toList(),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoContractCreateTransactionBody;
}
