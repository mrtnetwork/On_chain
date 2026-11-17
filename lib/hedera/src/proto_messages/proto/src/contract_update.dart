import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;
import "package:on_chain/hedera/src/proto_messages/proto/src/timestamp.dart"
    as proto_timestamp;
import "package:on_chain/hedera/src/proto_messages/proto/src/duration.dart"
    as proto_duration;
import "package:on_chain/hedera/src/proto_messages/google/protobuf/src/wrappers.dart"
    as google_protobuf_wrappers;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/node/hooks/src/hook_types.dart"
    as com_hedera_hapi_node_hooks_hook_types;

/// *
///  * # Contract Update
///  * Modify a smart contract. Any change other than updating the expiration time
///  * requires that the contract be modifiable (has a valid `adminKey`) and that
///  * the transaction be signed by the `adminKey`
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
///  * Modify the current state of a smart contract.
///  *
///  * ### Requirements
///  * - The `adminKey` MUST sign all contract update transactions except one
///  *   that only updates the `expirationTime`.
///  * - A transaction that modifies any field other than `expirationTime` for
///  *   a contract without a valid `adminKey` set SHALL fail with response
///  *   code `MODIFYING_IMMUTABLE_CONTRACT`.
///  * - Fields set to non-default values in this transaction SHALL be updated on
///  *   success. Fields not set to non-default values SHALL NOT be
///  *   updated on success.
///  *
///  * ### Block Stream Effects
///  * None
class HederaContractUpdateTransactionBody extends HederaProtoMessage
    with Equality {
  /// *
  ///      * The contact ID that identifies the smart contract to be updated.&lt;br/&gt;
  ///      * This field MUST be set, and MUST NOT be a default ID (`0.0.0`).
  final proto_basic_types.HederaContractID? contractID;

  /// *
  ///      * If set, modify the time at which this contract will expire.&lt;br/&gt;
  ///      * An expired contract requires a rent payment to "renew" the contract.
  ///      * A transaction to update this field is how that rent payment is made.
  ///      * &lt;p&gt;
  ///      * This value MUST NOT be less than the current `expirationTime`
  ///      * of the contract. If this value is earlier than the current
  ///      * value, the transaction SHALL fail with response
  ///      * code `EXPIRATION_REDUCTION_NOT_ALLOWED`.
  final proto_timestamp.HederaTimestamp? expirationTime;

  /// *
  ///      * If set, modify the key that authorizes updates to the contract.
  ///      * &lt;p&gt;
  ///      * If this field is set to a valid Key, this key and the previously set key
  ///      * MUST both sign this transaction.&lt;br/&gt;
  ///      * If this value is an empty `KeyList`, the prior key MUST sign this
  ///      * transaction, and the smart contract SHALL be immutable after this
  ///      * transaction completes, except for expiration and renewal.&lt;br/&gt;
  ///      * If this value is not an empty `KeyList`, but does not contain any
  ///      * cryptographic keys, or is otherwise malformed, this transaction SHALL
  ///      * fail with response code `INVALID_ADMIN_KEY`.
  final proto_basic_types.HederaKey? adminKey;

  /// *
  ///      * Replaced with `staked_id` alternatives.
  ///      * This field is unused and SHALL NOT modify the contract state.&lt;br/&gt;
  ///      * The id of an account to which the contract is proxy staked
  final proto_basic_types.HederaAccountID? proxyAccountID;

  /// *
  ///      * If set, modify the duration added to expiration time by each
  ///      * auto-renewal to this value.
  final proto_duration.HederaDuration? autoRenewPeriod;

  /// *
  ///      * This field is unused and SHALL NOT modify the contract state.&lt;br/&gt;
  ///      * Previously, an ID of a file containing the bytecode of the Solidity
  ///      * transaction that created this contract.
  final proto_basic_types.HederaFileID? fileID;

  /// This should be condensed to just a field instead of a oneof and field 9 reserved.
  /// *
  ///          * This value could not accurately distinguish unset or deliberately
  ///          * empty. memoWrapper should be used instead.&lt;br/&gt;
  final String? memo;

  /// *
  ///          * If set, modify the short memo for this smart contract.
  ///          * &lt;p&gt;
  ///          * This value, if set, MUST NOT exceed `transaction.maxMemoUtf8Bytes`
  ///          * (default 100) bytes when encoded as UTF-8.
  final google_protobuf_wrappers.HederaStringValue? memoWrapper;

  /// *
  ///      * If set, modify the maximum number of tokens that can be auto-associated with the
  ///      * contract.
  ///      * &lt;p&gt;
  ///      * If this is set and less than or equal to `used_auto_associations`, or 0, then this contract
  ///      * MUST manually associate with a token before transacting in that token.&lt;br/&gt;
  ///      * This value MAY also be `-1` to indicate no limit.&lt;br/&gt;
  ///      * This value MUST NOT be less than `-1`.
  final google_protobuf_wrappers.HederaInt32Value?
  maxAutomaticTokenAssociations;

  /// *
  ///      * If set, modify the account, in the same shard and realm as this smart
  ///      * contract, that has agreed to allow the network to use its balance, when
  ///      * needed, to automatically extend this contract's expiration time.
  ///      * &lt;p&gt;
  ///      * If this field is set to a non-default value, that Account MUST sign this
  ///      * transaction.&lt;br/&gt;
  ///      * If this field is set to a default AccountID value (`0.0.0`), any
  ///      * pre-existing `auto_renew_account_id` value SHALL be removed on success.
  final proto_basic_types.HederaAccountID? autoRenewAccountId;

  /// *
  ///          * An account identifier.&lt;br/&gt;
  ///          * A staked account acts as a proxy, and this contract effectively
  ///          * nominates the same node as the identified account.
  ///          * &lt;p&gt;
  ///          * If set, modify this smart contract such that it SHALL stake its HBAR
  ///          * to the same node as the identified account.&lt;br/&gt;
  ///          * If this field is set to a default AccountID value (`0.0.0`), any
  ///          * pre-existing `staked_account_id` value SHALL be removed on success.
  final proto_basic_types.HederaAccountID? stakedAccountId;

  /// *
  ///          * A node identifier.&lt;br/&gt;
  ///          * A staked node identifier indicates the consensus node that this
  ///          * account nominates for staking.
  ///          * &lt;p&gt;
  ///          * If set, modify this smart contract such that it SHALL stake its HBAR
  ///          * to this node.
  ///          * If set to a the value `-1` any pre-existing `staked_node_id` value
  ///          * SHALL be removed on success.
  ///          * &lt;p&gt;
  ///          * &lt;blockquote&gt;Note: node IDs do fluctuate as node operators change.
  ///          * Most contracts are immutable, and a contract staking to an invalid
  ///          * node ID SHALL NOT participate in staking. Immutable contracts may
  ///          * find it more reliable to use a proxy account for staking (via
  ///          * `staked_account_id`) to enable updating the _effective_ staking node
  ///          * ID when necessary through updating the proxy account.&lt;/blockquote&gt;
  final BigInt? stakedNodeId;

  /// *
  ///      * A flag indicating if staking rewards are declined.&lt;br/&gt;
  ///      * If set, modify the flag indicating if this contract declines to accept
  ///      * rewards for staking its HBAR to secure the network.
  ///      * &lt;p&gt;
  ///      * If set to true, this smart contract SHALL NOT receive any reward for
  ///      * staking its HBAR balance to help secure the network, regardless of
  ///      * staking configuration, but MAY stake HBAR to support the network
  ///      * without reward.
  final google_protobuf_wrappers.HederaBoolValue? declineReward;

  /// *
  ///      * The ids the hooks to delete from the contract.
  final List<BigInt> hookIdsToDelete;

  /// *
  ///      * The hooks to create for the contract.
  final List<com_hedera_hapi_node_hooks_hook_types.HederaHookCreationDetails>
  hookCreationDetails;

  const HederaContractUpdateTransactionBody({
    this.contractID,
    this.expirationTime,
    this.adminKey,
    this.proxyAccountID,
    this.autoRenewPeriod,
    this.fileID,
    this.memo,
    this.memoWrapper,
    this.maxAutomaticTokenAssociations,
    this.autoRenewAccountId,
    this.stakedAccountId,
    this.stakedNodeId,
    this.declineReward,
    this.hookIdsToDelete = const [],
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
        ProtoFieldConfig.message(2),
        ProtoFieldConfig.message(3),
        ProtoFieldConfig.message(
          6,
          options: [ProtoOptionBool(name: "deprecated", value: true)],
        ),
        ProtoFieldConfig.message(7),
        ProtoFieldConfig.message(
          8,
          options: [ProtoOptionBool(name: "deprecated", value: true)],
        ),
        ProtoFieldConfig.string(
          9,
          options: [ProtoOptionBool(name: "deprecated", value: true)],
        ),
        ProtoFieldConfig.message(10),
        ProtoFieldConfig.message(11),
        ProtoFieldConfig.message(12),
        ProtoFieldConfig.message(13),
        ProtoFieldConfig.int64(14),
        ProtoFieldConfig.message(15),
        ProtoFieldConfig.repeated(
          fieldNumber: 16,
          elementType: ProtoFieldType.int64,
        ),
        ProtoFieldConfig.repeated(
          fieldNumber: 17,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    contractID,
    expirationTime,
    adminKey,
    proxyAccountID,
    autoRenewPeriod,
    fileID,
    memo,
    memoWrapper,
    maxAutomaticTokenAssociations,
    autoRenewAccountId,
    stakedAccountId,
    stakedNodeId,
    declineReward,
    hookIdsToDelete,
    hookCreationDetails,
  ];

  HederaContractUpdateTransactionBody copyWith({
    proto_basic_types.HederaContractID? contractID,

    proto_timestamp.HederaTimestamp? expirationTime,

    proto_basic_types.HederaKey? adminKey,

    proto_basic_types.HederaAccountID? proxyAccountID,

    proto_duration.HederaDuration? autoRenewPeriod,

    proto_basic_types.HederaFileID? fileID,

    String? memo,

    google_protobuf_wrappers.HederaStringValue? memoWrapper,

    google_protobuf_wrappers.HederaInt32Value? maxAutomaticTokenAssociations,

    proto_basic_types.HederaAccountID? autoRenewAccountId,

    proto_basic_types.HederaAccountID? stakedAccountId,

    BigInt? stakedNodeId,

    google_protobuf_wrappers.HederaBoolValue? declineReward,

    List<BigInt>? hookIdsToDelete,

    List<com_hedera_hapi_node_hooks_hook_types.HederaHookCreationDetails>?
    hookCreationDetails,
  }) {
    return HederaContractUpdateTransactionBody(
      contractID: contractID ?? this.contractID,
      expirationTime: expirationTime ?? this.expirationTime,
      adminKey: adminKey ?? this.adminKey,
      proxyAccountID: proxyAccountID ?? this.proxyAccountID,
      autoRenewPeriod: autoRenewPeriod ?? this.autoRenewPeriod,
      fileID: fileID ?? this.fileID,
      memo: memo ?? this.memo,
      memoWrapper: memoWrapper ?? this.memoWrapper,
      maxAutomaticTokenAssociations:
          maxAutomaticTokenAssociations ?? this.maxAutomaticTokenAssociations,
      autoRenewAccountId: autoRenewAccountId ?? this.autoRenewAccountId,
      stakedAccountId: stakedAccountId ?? this.stakedAccountId,
      stakedNodeId: stakedNodeId ?? this.stakedNodeId,
      declineReward: declineReward ?? this.declineReward,
      hookIdsToDelete: hookIdsToDelete ?? this.hookIdsToDelete,
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
      'contractID': config.encodeMessage(contractID),
      'expirationTime': config.encodeMessage(expirationTime),
      'adminKey': config.encodeMessage(adminKey),
      'proxyAccountID': config.encodeMessage(proxyAccountID),
      'autoRenewPeriod': config.encodeMessage(autoRenewPeriod),
      'fileID': config.encodeMessage(fileID),
      'memo': memo,
      'memoWrapper': config.encodeMessage(memoWrapper),
      'max_automatic_token_associations': config.encodeMessage(
        maxAutomaticTokenAssociations,
      ),
      'auto_renew_account_id': config.encodeMessage(autoRenewAccountId),
      'staked_account_id': config.encodeMessage(stakedAccountId),
      'staked_node_id': config.encodeBigint(stakedNodeId),
      'decline_reward': config.encodeMessage(declineReward),
      'hook_ids_to_delete':
          hookIdsToDelete.map((e) => config.encodeBigint(e)).toList(),
      'hook_creation_details':
          hookCreationDetails.map((e) => config.encodeMessage(e)).toList(),
    };
  }

  factory HederaContractUpdateTransactionBody.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaContractUpdateTransactionBody(
      contractID: json.valueTo<proto_basic_types.HederaContractID?, Object>(
        key: 'contractID',
        parse:
            (v) => proto_basic_types.HederaContractID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
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
      adminKey: json.valueTo<proto_basic_types.HederaKey?, Object>(
        key: 'adminKey',
        parse:
            (v) => proto_basic_types.HederaKey.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
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
      fileID: json.valueTo<proto_basic_types.HederaFileID?, Object>(
        key: 'fileID',
        parse:
            (v) => proto_basic_types.HederaFileID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      memo: json.valueAsString<String?>(
        'memo',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      memoWrapper: json
          .valueTo<google_protobuf_wrappers.HederaStringValue?, Object>(
            key: 'memoWrapper',
            parse:
                (v) => google_protobuf_wrappers.HederaStringValue.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      maxAutomaticTokenAssociations: json
          .valueTo<google_protobuf_wrappers.HederaInt32Value?, Object>(
            key: 'max_automatic_token_associations',
            parse:
                (v) => google_protobuf_wrappers.HederaInt32Value.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
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
      declineReward: json
          .valueTo<google_protobuf_wrappers.HederaBoolValue?, Object>(
            key: 'decline_reward',
            parse:
                (v) => google_protobuf_wrappers.HederaBoolValue.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      hookIdsToDelete:
          (json.valueEnsureAsList<dynamic>(
            'hook_ids_to_delete',
            normalizeKeyLookup: config.normalizeKeys,
            onMissing: () => [],
          )).map((e) => JsonParser.valueAsBigInt<BigInt>(e)).toList(),
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

  factory HederaContractUpdateTransactionBody.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaContractUpdateTransactionBody(
      contractID: decode.messageTo<proto_basic_types.HederaContractID?>(
        1,
        (b) => proto_basic_types.HederaContractID.deserialize(b),
      ),
      expirationTime: decode.messageTo<proto_timestamp.HederaTimestamp?>(
        2,
        (b) => proto_timestamp.HederaTimestamp.deserialize(b),
      ),
      adminKey: decode.messageTo<proto_basic_types.HederaKey?>(
        3,
        (b) => proto_basic_types.HederaKey.deserialize(b),
      ),
      proxyAccountID: decode.messageTo<proto_basic_types.HederaAccountID?>(
        6,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
      autoRenewPeriod: decode.messageTo<proto_duration.HederaDuration?>(
        7,
        (b) => proto_duration.HederaDuration.deserialize(b),
      ),
      fileID: decode.messageTo<proto_basic_types.HederaFileID?>(
        8,
        (b) => proto_basic_types.HederaFileID.deserialize(b),
      ),
      memo: decode.getString<String?>(9),
      memoWrapper: decode
          .messageTo<google_protobuf_wrappers.HederaStringValue?>(
            10,
            (b) => google_protobuf_wrappers.HederaStringValue.deserialize(b),
          ),
      maxAutomaticTokenAssociations: decode
          .messageTo<google_protobuf_wrappers.HederaInt32Value?>(
            11,
            (b) => google_protobuf_wrappers.HederaInt32Value.deserialize(b),
          ),
      autoRenewAccountId: decode.messageTo<proto_basic_types.HederaAccountID?>(
        12,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
      stakedAccountId: decode.messageTo<proto_basic_types.HederaAccountID?>(
        13,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
      stakedNodeId: decode.getBigInt<BigInt?>(14),
      declineReward: decode
          .messageTo<google_protobuf_wrappers.HederaBoolValue?>(
            15,
            (b) => google_protobuf_wrappers.HederaBoolValue.deserialize(b),
          ),
      hookIdsToDelete: decode.getListOrEmpty<BigInt>(16),
      hookCreationDetails:
          decode
              .getListOfBytes(17)
              .map(
                (b) => com_hedera_hapi_node_hooks_hook_types
                    .HederaHookCreationDetails.deserialize(b),
              )
              .toList(),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoContractUpdateTransactionBody;
}
