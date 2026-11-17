import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart" as proto_basic_types;
import "package:on_chain/hedera/src/proto_messages/google/protobuf/src/wrappers.dart" as google_protobuf_wrappers;
import "package:on_chain/hedera/src/proto_messages/proto/src/duration.dart" as proto_duration;
import "package:on_chain/hedera/src/proto_messages/proto/src/timestamp.dart" as proto_timestamp;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/node/hooks/src/hook_types.dart" as com_hedera_hapi_node_hooks_hook_types;

/// *
///  * # Crypto Update
///  * Modify a single account.
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
///  * Modify the current state of an account.
///  *
///  * ### Requirements
///  * - The `key` for this account MUST sign all account update transactions.
///  * - If the `key` field is set for this transaction, then _both_ the current
///  *   `key` and the new `key` MUST sign this transaction, for security and to
///  *   prevent setting the `key` field to an invalid value.
///  * - If the `auto_renew_account` field is set for this transaction, the account
///  *   identified in that field MUST sign this transaction.
///  * - Fields set to non-default values in this transaction SHALL be updated on
///  *   success. Fields not set to non-default values SHALL NOT be
///  *   updated on success.
///  * - All fields that may be modified in this transaction SHALL have a
///  *   default value of unset (a.k.a. `null`).
///  *
///  * ### Block Stream Effects
///  * None
class HederaCryptoUpdateTransactionBody extends HederaProtoMessage with Equality {
    /// NOTE: Seven deprecated fields should probably be removed and the
  /// field names reserved.
  /// reserved 4,5,6,7,10,11,12
  /// Also, the `receiverSigRequiredField` oneOf should be removed
  /// around `receiverSigRequiredWrapper` and the field renamed
  /// (both actions are "safe" in protobuf) to `receiver_signature_required`.
  /// *
  ///      * An account identifier.&lt;br/&gt;
  ///      * This identifies the account which is to be modified in this transaction.
  ///      * &lt;p&gt;
  ///      * This field is REQUIRED.
  final proto_basic_types.HederaAccountID? accountIDToUpdate;

    /// *
  ///      * An account key.&lt;br/&gt;
  ///      * This may be a "primitive" key (a singly cryptographic key), or a
  ///      * composite key.
  ///      * &lt;p&gt;
  ///      * If set, this key MUST be a valid key.&lt;br/&gt;
  ///      * If set, the previous key and new key MUST both sign this transaction.
  final proto_basic_types.HederaKey? key;

    /// *
  ///      * Removed in favor of the `staked_id` oneOf.&lt;br/&gt;
  ///      * An account identifier for a "proxy" account. This account's HBAR are
  ///      * staked to a node selected by the proxy account.
  final proto_basic_types.HederaAccountID? proxyAccountID;

    /// *
  ///      * Removed prior to the first available history.&lt;br/&gt;
  ///      * A fraction to split staking rewards between this account and the proxy
  ///      * account.
  final int? proxyFraction;

    /// This entire oneOf is deprecated, and the concept is not implemented.
  /// *
  ///          * Removed prior to the first available history, and may be related
  ///          * to an early design dead-end.&lt;br/&gt;
  ///          * The new threshold amount (in tinybars) for which an account record is
  ///          * created for any send/withdraw transaction
  final BigInt? sendRecordThreshold;

    /// *
  ///          * Removed prior to the first available history, and may be related
  ///          * to an early design dead-end.&lt;br/&gt;
  ///          * The new threshold amount (in tinybars) for which an account record is
  ///          * created for any send/withdraw transaction
  final google_protobuf_wrappers.HederaUInt64Value? sendRecordThresholdWrapper;

    /// This entire oneOf is deprecated, and the concept is not implemented.
  /// *
  ///          * Removed prior to the first available history, and may be related
  ///          * to an early design dead-end.&lt;br/&gt;
  ///          * The new threshold amount (in tinybars) for which an account record is
  ///          * created for any receive/deposit transaction.
  final BigInt? receiveRecordThreshold;

    /// *
  ///          * Removed prior to the first available history, and may be related
  ///          * to an early design dead-end.&lt;br/&gt;
  ///          * The new threshold amount (in tinybars) for which an account record is
  ///          * created for any receive/deposit transaction.
  final google_protobuf_wrappers.HederaUInt64Value? receiveRecordThresholdWrapper;

    /// *
  ///      * A duration to extend account expiration.&lt;br/&gt;
  ///      * An amount of time, in seconds, to extend the expiration date for this
  ///      * account when _automatically_ renewed.
  ///      * &lt;p&gt;
  ///      * This duration MUST be between the current configured minimum and maximum
  ///      * values defined for the network.&lt;br/&gt;
  ///      * This duration SHALL be applied only when _automatically_ extending the
  ///      * account expiration.
  final proto_duration.HederaDuration? autoRenewPeriod;

    /// *
  ///      * A new account expiration time, in seconds since the epoch.
  ///      * &lt;p&gt;
  ///      * For this purpose, `epoch` SHALL be the UNIX epoch with 0
  ///      * at `1970-01-01T00:00:00.000Z`.&lt;br/&gt;
  ///      * If set, this value MUST be later than the current consensus time.&lt;br/&gt;
  ///      * If set, this value MUST be earlier than the current consensus time
  ///      * extended by the current maximum expiration time configured for the
  ///      * network.
  final proto_timestamp.HederaTimestamp? expirationTime;

    /// *
  ///          * Removed to distinguish between unset and a default value.&lt;br/&gt;
  ///          * Do NOT use this field to set a false value because the server cannot
  ///          * distinguish from the default value. Use receiverSigRequiredWrapper
  ///          * field for this purpose.
  final bool? receiverSigRequired;

    /// *
  ///          * A flag indicating the account holder must authorize all incoming
  ///          * token transfers.
  ///          * &lt;p&gt;
  ///          * If this flag is set then any transaction that would result in adding
  ///          * hbar or other tokens to this account balance MUST be signed by the
  ///          * identifying key of this account (that is, the `key` field).
  final google_protobuf_wrappers.HederaBoolValue? receiverSigRequiredWrapper;

    /// *
  ///      * A short description of this Account.
  ///      * &lt;p&gt;
  ///      * This value, if set, MUST NOT exceed `transaction.maxMemoUtf8Bytes`
  ///      * (default 100) bytes when encoded as UTF-8.
  final google_protobuf_wrappers.HederaStringValue? memo;

    /// *
  ///      * A maximum number of tokens that can be auto-associated
  ///      * with this account.&lt;br/&gt;
  ///      * By default this value is 0 for all accounts except for automatically
  ///      * created accounts (i.e smart contracts) which default to -1.
  ///      * &lt;p&gt;
  ///      * If this value is `0`, then this account MUST manually associate to
  ///      * a token before holding or transacting in that token.&lt;br/&gt;
  ///      * This value MAY also be `-1` to indicate no limit.&lt;br/&gt;
  ///      * If set, this value MUST NOT be less than `-1`.&lt;br/&gt;
  final google_protobuf_wrappers.HederaInt32Value? maxAutomaticTokenAssociations;

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
  ///      * payments for doing so, if this value is set, and `true`.
  final google_protobuf_wrappers.HederaBoolValue? declineReward;

    /// *
  ///      * The ids the hooks to delete from the account.
  final List<BigInt> hookIdsToDelete;

    /// *
  ///      * The hooks to create for the account.
  final List<com_hedera_hapi_node_hooks_hook_types.HederaHookCreationDetails> hookCreationDetails;

    /// *
  ///      * The delegated contract address to set for the account.
  ///      * &lt;p&gt;
  ///      * If this field is unset (empty), no change is made to account's `delegation_address`.
  ///      * If set, the value MUST be 20 bytes long (EVM address).
  ///      * Submitting a value of `0x0000000000000000000000000000000000000000` will clear
  ///      * account's current `delegation_address`.
  ///      *
  ///      * If this field is set on the account, anytime a call is made to the account's address
  ///      * (either an EVM call within HSCS or a child call dispatched by CryptoTransfer)
  ///      * the EVM code of the contract referenced by `delegation_address` will be
  ///      * executed in the context of the account.
  final List<int>? delegationAddress;

  const HederaCryptoUpdateTransactionBody({
    this.accountIDToUpdate,
    this.key,
    this.proxyAccountID,
    this.proxyFraction,
    this.sendRecordThreshold,
    this.sendRecordThresholdWrapper,
    this.receiveRecordThreshold,
    this.receiveRecordThresholdWrapper,
    this.autoRenewPeriod,
    this.expirationTime,
    this.receiverSigRequired,
    this.receiverSigRequiredWrapper,
    this.memo,
    this.maxAutomaticTokenAssociations,
    this.stakedAccountId,
    this.stakedNodeId,
    this.declineReward,
    this.hookIdsToDelete = const [],
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
        ProtoFieldConfig.message(2),
        ProtoFieldConfig.message(3),
        ProtoFieldConfig.message(4, options: [ProtoOptionBool(name: "deprecated", value: true)]),
        ProtoFieldConfig.int32(5, options: [ProtoOptionBool(name: "deprecated", value: true)]),
        ProtoFieldConfig.uint64(6, options: [ProtoOptionBool(name: "deprecated", value: true)]),
        ProtoFieldConfig.message(11, options: [ProtoOptionBool(name: "deprecated", value: true)]),
        ProtoFieldConfig.uint64(7, options: [ProtoOptionBool(name: "deprecated", value: true)]),
        ProtoFieldConfig.message(12, options: [ProtoOptionBool(name: "deprecated", value: true)]),
        ProtoFieldConfig.message(8),
        ProtoFieldConfig.message(9),
        ProtoFieldConfig.bool(10, options: [ProtoOptionBool(name: "deprecated", value: true)]),
        ProtoFieldConfig.message(13),
        ProtoFieldConfig.message(14),
        ProtoFieldConfig.message(15),
        ProtoFieldConfig.message(16),
        ProtoFieldConfig.int64(17),
        ProtoFieldConfig.message(18),
        ProtoFieldConfig.repeated(
          fieldNumber: 19,
          elementType: ProtoFieldType.int64,
        ),
        ProtoFieldConfig.repeated(
          fieldNumber: 20,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.bytes(21),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        accountIDToUpdate,
        key,
        proxyAccountID,
        proxyFraction,
        sendRecordThreshold,
        sendRecordThresholdWrapper,
        receiveRecordThreshold,
        receiveRecordThresholdWrapper,
        autoRenewPeriod,
        expirationTime,
        receiverSigRequired,
        receiverSigRequiredWrapper,
        memo,
        maxAutomaticTokenAssociations,
        stakedAccountId,
        stakedNodeId,
        declineReward,
        hookIdsToDelete,
        hookCreationDetails,
        delegationAddress,
      ];


HederaCryptoUpdateTransactionBody copyWith(
{proto_basic_types.HederaAccountID? accountIDToUpdate,

proto_basic_types.HederaKey? key,

proto_basic_types.HederaAccountID? proxyAccountID,

int? proxyFraction,

BigInt? sendRecordThreshold,

google_protobuf_wrappers.HederaUInt64Value? sendRecordThresholdWrapper,

BigInt? receiveRecordThreshold,

google_protobuf_wrappers.HederaUInt64Value? receiveRecordThresholdWrapper,

proto_duration.HederaDuration? autoRenewPeriod,

proto_timestamp.HederaTimestamp? expirationTime,

bool? receiverSigRequired,

google_protobuf_wrappers.HederaBoolValue? receiverSigRequiredWrapper,

google_protobuf_wrappers.HederaStringValue? memo,

google_protobuf_wrappers.HederaInt32Value? maxAutomaticTokenAssociations,

proto_basic_types.HederaAccountID? stakedAccountId,

BigInt? stakedNodeId,

google_protobuf_wrappers.HederaBoolValue? declineReward,

List<BigInt>? hookIdsToDelete,

List<com_hedera_hapi_node_hooks_hook_types.HederaHookCreationDetails>? hookCreationDetails,

List<int>? delegationAddress,

}) {
    return HederaCryptoUpdateTransactionBody(
accountIDToUpdate: accountIDToUpdate ?? this.accountIDToUpdate,
key: key ?? this.key,
proxyAccountID: proxyAccountID ?? this.proxyAccountID,
proxyFraction: proxyFraction ?? this.proxyFraction,
sendRecordThreshold: sendRecordThreshold ?? this.sendRecordThreshold,
sendRecordThresholdWrapper: sendRecordThresholdWrapper ?? this.sendRecordThresholdWrapper,
receiveRecordThreshold: receiveRecordThreshold ?? this.receiveRecordThreshold,
receiveRecordThresholdWrapper: receiveRecordThresholdWrapper ?? this.receiveRecordThresholdWrapper,
autoRenewPeriod: autoRenewPeriod ?? this.autoRenewPeriod,
expirationTime: expirationTime ?? this.expirationTime,
receiverSigRequired: receiverSigRequired ?? this.receiverSigRequired,
receiverSigRequiredWrapper: receiverSigRequiredWrapper ?? this.receiverSigRequiredWrapper,
memo: memo ?? this.memo,
maxAutomaticTokenAssociations: maxAutomaticTokenAssociations ?? this.maxAutomaticTokenAssociations,
stakedAccountId: stakedAccountId ?? this.stakedAccountId,
stakedNodeId: stakedNodeId ?? this.stakedNodeId,
declineReward: declineReward ?? this.declineReward,
hookIdsToDelete: hookIdsToDelete ?? this.hookIdsToDelete,
hookCreationDetails: hookCreationDetails ?? this.hookCreationDetails,
delegationAddress: delegationAddress ?? this.delegationAddress,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'accountIDToUpdate': config.encodeMessage(accountIDToUpdate),
      'key': config.encodeMessage(key),
      'proxyAccountID': config.encodeMessage(proxyAccountID),
      'proxyFraction': proxyFraction,
      'sendRecordThreshold': config.encodeBigint(sendRecordThreshold),
      'sendRecordThresholdWrapper': config.encodeMessage(sendRecordThresholdWrapper),
      'receiveRecordThreshold': config.encodeBigint(receiveRecordThreshold),
      'receiveRecordThresholdWrapper': config.encodeMessage(receiveRecordThresholdWrapper),
      'autoRenewPeriod': config.encodeMessage(autoRenewPeriod),
      'expirationTime': config.encodeMessage(expirationTime),
      'receiverSigRequired': receiverSigRequired,
      'receiverSigRequiredWrapper': config.encodeMessage(receiverSigRequiredWrapper),
      'memo': config.encodeMessage(memo),
      'max_automatic_token_associations': config.encodeMessage(maxAutomaticTokenAssociations),
      'staked_account_id': config.encodeMessage(stakedAccountId),
      'staked_node_id': config.encodeBigint(stakedNodeId),
      'decline_reward': config.encodeMessage(declineReward),
      'hook_ids_to_delete': hookIdsToDelete.map((e) => config.encodeBigint(e)).toList(),
      'hook_creation_details': hookCreationDetails.map((e) => config.encodeMessage(e)).toList(),
      'delegation_address': config.encodeBinary(delegationAddress),
    };
  }


  factory HederaCryptoUpdateTransactionBody.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaCryptoUpdateTransactionBody(
      accountIDToUpdate: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'accountIDToUpdate',
        parse: (v) => proto_basic_types.HederaAccountID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      key: json.valueTo<proto_basic_types.HederaKey?, Object>(
        key: 'key',
        parse: (v) => proto_basic_types.HederaKey.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      proxyAccountID: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'proxyAccountID',
        parse: (v) => proto_basic_types.HederaAccountID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      proxyFraction: json.valueAsInt<int?>('proxyFraction', normalizeKeyLookup: config.normalizeKeys),
      sendRecordThreshold: json.valueAsBigInt<BigInt?>('sendRecordThreshold', normalizeKeyLookup: config.normalizeKeys),
      sendRecordThresholdWrapper: json.valueTo<google_protobuf_wrappers.HederaUInt64Value?, Object>(
        key: 'sendRecordThresholdWrapper',
        parse: (v) => google_protobuf_wrappers.HederaUInt64Value.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      receiveRecordThreshold: json.valueAsBigInt<BigInt?>('receiveRecordThreshold', normalizeKeyLookup: config.normalizeKeys),
      receiveRecordThresholdWrapper: json.valueTo<google_protobuf_wrappers.HederaUInt64Value?, Object>(
        key: 'receiveRecordThresholdWrapper',
        parse: (v) => google_protobuf_wrappers.HederaUInt64Value.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      autoRenewPeriod: json.valueTo<proto_duration.HederaDuration?, Object>(
        key: 'autoRenewPeriod',
        parse: (v) => proto_duration.HederaDuration.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      expirationTime: json.valueTo<proto_timestamp.HederaTimestamp?, Object>(
        key: 'expirationTime',
        parse: (v) => proto_timestamp.HederaTimestamp.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      receiverSigRequired: json.valueAsBool<bool?>('receiverSigRequired', normalizeKeyLookup: config.normalizeKeys),
      receiverSigRequiredWrapper: json.valueTo<google_protobuf_wrappers.HederaBoolValue?, Object>(
        key: 'receiverSigRequiredWrapper',
        parse: (v) => google_protobuf_wrappers.HederaBoolValue.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      memo: json.valueTo<google_protobuf_wrappers.HederaStringValue?, Object>(
        key: 'memo',
        parse: (v) => google_protobuf_wrappers.HederaStringValue.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      maxAutomaticTokenAssociations: json.valueTo<google_protobuf_wrappers.HederaInt32Value?, Object>(
        key: 'max_automatic_token_associations',
        parse: (v) => google_protobuf_wrappers.HederaInt32Value.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      stakedAccountId: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'staked_account_id',
        parse: (v) => proto_basic_types.HederaAccountID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      stakedNodeId: json.valueAsBigInt<BigInt?>('staked_node_id', normalizeKeyLookup: config.normalizeKeys),
      declineReward: json.valueTo<google_protobuf_wrappers.HederaBoolValue?, Object>(
        key: 'decline_reward',
        parse: (v) => google_protobuf_wrappers.HederaBoolValue.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      hookIdsToDelete: (json.valueEnsureAsList<dynamic>('hook_ids_to_delete', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueAsBigInt<BigInt>(e)).toList(),
      hookCreationDetails: (json.valueEnsureAsList<dynamic>('hook_creation_details', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<com_hedera_hapi_node_hooks_hook_types.HederaHookCreationDetails, Object>(
          value: e,
          parse: (v) => com_hedera_hapi_node_hooks_hook_types.HederaHookCreationDetails.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
      delegationAddress: config.decodeBinary<List<int>?>(json.valueAs('delegation_address', normalizeKeyLookup: config.normalizeKeys)),
    );
  }

  factory HederaCryptoUpdateTransactionBody.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaCryptoUpdateTransactionBody(
      accountIDToUpdate: decode.messageTo<proto_basic_types.HederaAccountID?>(2, (b) => proto_basic_types.HederaAccountID.deserialize(b)),
      key: decode.messageTo<proto_basic_types.HederaKey?>(3, (b) => proto_basic_types.HederaKey.deserialize(b)),
      proxyAccountID: decode.messageTo<proto_basic_types.HederaAccountID?>(4, (b) => proto_basic_types.HederaAccountID.deserialize(b)),
      proxyFraction: decode.getInt<int?>(5),
      sendRecordThreshold: decode.getBigInt<BigInt?>(6),
      sendRecordThresholdWrapper: decode.messageTo<google_protobuf_wrappers.HederaUInt64Value?>(11, (b) => google_protobuf_wrappers.HederaUInt64Value.deserialize(b)),
      receiveRecordThreshold: decode.getBigInt<BigInt?>(7),
      receiveRecordThresholdWrapper: decode.messageTo<google_protobuf_wrappers.HederaUInt64Value?>(12, (b) => google_protobuf_wrappers.HederaUInt64Value.deserialize(b)),
      autoRenewPeriod: decode.messageTo<proto_duration.HederaDuration?>(8, (b) => proto_duration.HederaDuration.deserialize(b)),
      expirationTime: decode.messageTo<proto_timestamp.HederaTimestamp?>(9, (b) => proto_timestamp.HederaTimestamp.deserialize(b)),
      receiverSigRequired: decode.getBool<bool?>(10),
      receiverSigRequiredWrapper: decode.messageTo<google_protobuf_wrappers.HederaBoolValue?>(13, (b) => google_protobuf_wrappers.HederaBoolValue.deserialize(b)),
      memo: decode.messageTo<google_protobuf_wrappers.HederaStringValue?>(14, (b) => google_protobuf_wrappers.HederaStringValue.deserialize(b)),
      maxAutomaticTokenAssociations: decode.messageTo<google_protobuf_wrappers.HederaInt32Value?>(15, (b) => google_protobuf_wrappers.HederaInt32Value.deserialize(b)),
      stakedAccountId: decode.messageTo<proto_basic_types.HederaAccountID?>(16, (b) => proto_basic_types.HederaAccountID.deserialize(b)),
      stakedNodeId: decode.getBigInt<BigInt?>(17),
      declineReward: decode.messageTo<google_protobuf_wrappers.HederaBoolValue?>(18, (b) => google_protobuf_wrappers.HederaBoolValue.deserialize(b)),
      hookIdsToDelete: decode.getListOrEmpty<BigInt>(19),
      hookCreationDetails: decode.getListOfBytes(20).map((b) => com_hedera_hapi_node_hooks_hook_types.HederaHookCreationDetails.deserialize(b)).toList(),
      delegationAddress: decode.getBytes<List<int>?>(21),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoCryptoUpdateTransactionBody;

}


