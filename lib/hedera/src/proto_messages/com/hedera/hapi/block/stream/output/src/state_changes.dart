import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/timestamp.dart"
    as proto_timestamp;
import "package:on_chain/hedera/src/proto_messages/proto/src/block_info.dart"
    as proto_block_info;
import "package:on_chain/hedera/src/proto_messages/proto/src/congestion_level_starts.dart"
    as proto_congestion_level_starts;
import "package:on_chain/hedera/src/proto_messages/google/protobuf/src/wrappers.dart"
    as google_protobuf_wrappers;
import "package:on_chain/hedera/src/proto_messages/proto/src/exchange_rate.dart"
    as proto_exchange_rate;
import "package:on_chain/hedera/src/proto_messages/proto/src/network_staking_rewards.dart"
    as proto_network_staking_rewards;
import "package:on_chain/hedera/src/proto_messages/proto/src/running_hashes.dart"
    as proto_running_hashes;
import "package:on_chain/hedera/src/proto_messages/proto/src/throttle_usage_snapshots.dart"
    as proto_throttle_usage_snapshots;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/node/state/blockstream/src/block_stream_info.dart"
    as com_hedera_hapi_node_state_blockstream_block_stream_info;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/platform/state/src/platform_state.dart"
    as com_hedera_hapi_platform_state_platform_state;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/node/state/roster/src/roster_state.dart"
    as com_hedera_hapi_node_state_roster_roster_state;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/node/state/hints/src/hints_types.dart"
    as com_hedera_hapi_node_state_hints_hints_types;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/node/state/entity/src/entity_counts.dart"
    as com_hedera_hapi_node_state_entity_entity_counts;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/node/state/history/src/history_types.dart"
    as com_hedera_hapi_node_state_history_history_types;
import "package:on_chain/hedera/src/proto_messages/proto/src/node_rewards.dart"
    as proto_node_rewards;
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;
import "package:on_chain/hedera/src/proto_messages/proto/src/storage_slot.dart"
    as proto_storage_slot;
import "package:on_chain/hedera/src/proto_messages/proto/src/schedule.dart"
    as proto_schedule;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/node/state/tss/src/tss_message_map_key.dart"
    as com_hedera_hapi_node_state_tss_tss_message_map_key;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/node/state/tss/src/tss_vote_map_key.dart"
    as com_hedera_hapi_node_state_tss_tss_vote_map_key;
import "package:on_chain/hedera/src/proto_messages/proto/src/account.dart"
    as proto_account;
import "package:on_chain/hedera/src/proto_messages/proto/src/bytecode.dart"
    as proto_bytecode;
import "package:on_chain/hedera/src/proto_messages/proto/src/file.dart"
    as proto_file;
import "package:on_chain/hedera/src/proto_messages/proto/src/nft.dart"
    as proto_nft;
import "package:on_chain/hedera/src/proto_messages/proto/src/staking_node_info.dart"
    as proto_staking_node_info;
import "package:on_chain/hedera/src/proto_messages/proto/src/token.dart"
    as proto_token;
import "package:on_chain/hedera/src/proto_messages/proto/src/token_relation.dart"
    as proto_token_relation;
import "package:on_chain/hedera/src/proto_messages/proto/src/topic.dart"
    as proto_topic;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/node/state/addressbook/src/node.dart"
    as com_hedera_hapi_node_state_addressbook_node;
import "package:on_chain/hedera/src/proto_messages/proto/src/account_pending_airdrop.dart"
    as proto_account_pending_airdrop;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/node/state/roster/src/roster.dart"
    as com_hedera_hapi_node_state_roster_roster;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/node/state/tss/src/tss_encryption_keys.dart"
    as com_hedera_hapi_node_state_tss_tss_encryption_keys;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/services/auxiliary/tss/src/tss_message.dart"
    as com_hedera_hapi_services_auxiliary_tss_tss_message;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/services/auxiliary/tss/src/tss_vote.dart"
    as com_hedera_hapi_services_auxiliary_tss_tss_vote;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/services/auxiliary/hints/src/crs_publication.dart"
    as com_hedera_hapi_services_auxiliary_hints_crs_publication;
import "package:on_chain/hedera/src/proto_messages/proto/src/recordcache.dart"
    as proto_recordcache;

/// *
///  * An informational enumeration of all known states.
///  * This enumeration is included here So that people know the mapping from
///  * integer to state "name".
///  *
///  * State changes are expressed in terms of changes to named states at the
///  * high level conceptual model of the state type like map key/values or
///  * queue appends. To say which state the change is on we will include an
///  * `integer` number for the state name. This is done for performance and
///  * efficiency as there will be 10s of thousands of state changes in a block.
///  *
///  * We use an integer, and provide this enumeration, for the following reasons.
///  * - If we have a extra 8-10 bytes per state change at 40-50K state changes
///  *   per second then that is an extra 2.5-4 megabits of bandwidth. Compression
///  *   should help a lot but that is not guaranteed.
///  * - When the state name is used as part of complex key in the big state
///  *   merkle map. The smaller the key is, in bytes, the more efficient the
///  *   database is, because more keys can fit in a single disk page.
///  * - When parsing keys, parsing a UTF-8 string to a Java String is a many
///  *   times more expensive than parsing a VARINT to an integer.
///  *
///  * Note: This enumeration is never transmitted directly in the block stream.
///  * This enumeration is provided for clients to _interpret_ the value
///  * of the `StateChange`.`state_id` field.
enum HederaStateIdentifier implements ProtoEnumVariant {
  /// *
  ///      * A state identifier for the Topics state.
  stateIdTopics(0, 'STATE_ID_TOPICS'),

  /// *
  ///      * A state identifier for the next entity Identifier.
  stateIdEntityId(1, 'STATE_ID_ENTITY_ID'),

  /// *
  ///      * A state identifier for the Accounts state.
  stateIdAccounts(2, 'STATE_ID_ACCOUNTS'),

  /// *
  ///      * A state identifier for account aliases.
  stateIdAliases(3, 'STATE_ID_ALIASES'),

  /// *
  ///      * A state identifier for contract storage slots.
  stateIdContractStorage(4, 'STATE_ID_CONTRACT_STORAGE'),

  /// *
  ///      * A state identifier for contract bytecode.
  stateIdContractBytecode(5, 'STATE_ID_CONTRACT_BYTECODE'),

  /// *
  ///      * A state identifier for Hedera File Service (HFS).
  stateIdFiles(6, 'STATE_ID_FILES'),

  /// *
  ///      * A state identifier for Hedera Token Service (HTS).
  stateIdTokens(7, 'STATE_ID_TOKENS'),

  /// *
  ///      * A state identifier for non-fungible/unique tokens.
  stateIdNfts(8, 'STATE_ID_NFTS'),

  /// *
  ///      * A state identifier for token relationships.
  stateIdTokenRelations(9, 'STATE_ID_TOKEN_RELATIONS'),

  /// *
  ///      * A state identifier for network staking information.
  stateIdStakingInfo(10, 'STATE_ID_STAKING_INFO'),

  /// *
  ///      * A state identifier for network staking rewards.
  stateIdNetworkRewards(11, 'STATE_ID_NETWORK_REWARDS'),

  /// *
  ///      * A state identifier for throttle usage.
  stateIdThrottleUsage(12, 'STATE_ID_THROTTLE_USAGE'),

  /// *
  ///      * A state identifier for network congestion start times.
  stateIdCongestionStarts(13, 'STATE_ID_CONGESTION_STARTS'),

  /// *
  ///      * A state identifier for scheduled transactions.
  stateIdSchedulesById(14, 'STATE_ID_SCHEDULES_BY_ID'),

  /// *
  ///      * A state identifier for scheduled transaction expiration.
  stateIdSchedulesByExpiry(15, 'STATE_ID_SCHEDULES_BY_EXPIRY'),

  /// *
  ///      * A state identifier for scheduled transaction deduplication.
  stateIdSchedulesByEquality(16, 'STATE_ID_SCHEDULES_BY_EQUALITY'),

  /// *
  ///      * A state identifier for conversion rate updates.
  stateIdMidnightRates(17, 'STATE_ID_MIDNIGHT_RATES'),

  /// *
  ///      * A state identifier for the network running hash(es).
  stateIdRunningHashes(18, 'STATE_ID_RUNNING_HASHES'),

  /// *
  ///      * A state identifier for network block information.
  stateIdBlockInfo(19, 'STATE_ID_BLOCK_INFO'),

  /// *
  ///      * A state identifier for address book nodes.
  stateIdNodes(20, 'STATE_ID_NODES'),

  /// *
  ///      * A state identifier for the next "upgrade" file.
  stateIdUpgradeFile(21, 'STATE_ID_UPGRADE_FILE'),

  /// *
  ///      * A state identifier for the hash of the next "upgrade" file.
  stateIdUpgradeFileHash(22, 'STATE_ID_UPGRADE_FILE_HASH'),

  /// *
  ///      * A state identifier for the next network freeze time.
  stateIdFreezeTime(23, 'STATE_ID_FREEZE_TIME'),

  /// *
  ///      * A state identifier for the block stream status singleton.
  stateIdBlockStreamInfo(24, 'STATE_ID_BLOCK_STREAM_INFO'),

  /// *
  ///      * A state identifier for pending airdrops.
  stateIdPendingAirdrops(25, 'STATE_ID_PENDING_AIRDROPS'),

  /// *
  ///      * A state identifier for the platform state singleton.
  stateIdPlatformState(26, 'STATE_ID_PLATFORM_STATE'),

  /// *
  ///      * A state identifier for the roster state singleton.
  stateIdRosterState(27, 'STATE_ID_ROSTER_STATE'),

  /// *
  ///      * A state identifier for the rosters key/value map.
  stateIdRosters(28, 'STATE_ID_ROSTERS'),

  /// *
  ///     * A state identifier for counts of transactions scheduled and
  ///     * processed in a second.
  stateIdScheduledCounts(29, 'STATE_ID_SCHEDULED_COUNTS'),

  /// *
  ///      * A state identifier for scheduled transaction deduplication.
  stateIdScheduleIdByEquality(30, 'STATE_ID_SCHEDULE_ID_BY_EQUALITY'),

  /// *
  ///      * A state identifier for TSS messages.
  stateIdTssMessages(31, 'STATE_ID_TSS_MESSAGES'),

  /// *
  ///      * A state identifier for TSS votes.
  stateIdTssVotes(32, 'STATE_ID_TSS_VOTES'),

  /// *
  ///     * A state identifier for the ordering of scheduled transactions.
  stateIdScheduledOrders(33, 'STATE_ID_SCHEDULED_ORDERS'),

  /// *
  ///      * A state identifier for scheduled throttle usage snapshots.
  stateIdScheduledUsages(34, 'STATE_ID_SCHEDULED_USAGES'),

  /// *
  ///      * A state identifier for the TSS encryption keys.
  stateIdTssEncryptionKeys(35, 'STATE_ID_TSS_ENCRYPTION_KEYS'),

  /// *
  ///      * A state identifier for the TSS status.
  stateIdTssStatus(36, 'STATE_ID_TSS_STATUS'),

  /// *
  ///      * A state identifier for hinTS key sets.
  stateIdHintsKeySets(37, 'STATE_ID_HINTS_KEY_SETS'),

  /// *
  ///      * A state identifier for the active hinTS construction.
  stateIdActiveHintsConstruction(38, 'STATE_ID_ACTIVE_HINTS_CONSTRUCTION'),

  /// *
  ///      * A state identifier for the next hinTS construction.
  stateIdNextHintsConstruction(39, 'STATE_ID_NEXT_HINTS_CONSTRUCTION'),

  /// *
  ///      * A state identifier for hinTS preprocessing output votes.
  stateIdPreprocessingVotes(40, 'STATE_ID_PREPROCESSING_VOTES'),

  /// *
  ///      * A state identifier for the entity counts.
  stateIdEntityCounts(41, 'STATE_ID_ENTITY_COUNTS'),

  /// *
  ///      * A state identifier for the ledger id.
  stateIdLedgerId(42, 'STATE_ID_LEDGER_ID'),

  /// *
  ///      * A state identifier for history proof key sets.
  stateIdProofKeySets(43, 'STATE_ID_PROOF_KEY_SETS'),

  /// *
  ///      * A state identifier for the active proof construction.
  stateIdActiveProofConstruction(44, 'STATE_ID_ACTIVE_PROOF_CONSTRUCTION'),

  /// *
  ///      * A state identifier for the next proof construction.
  stateIdNextProofConstruction(45, 'STATE_ID_NEXT_PROOF_CONSTRUCTION'),

  /// *
  ///      * A state identifier for signatures on roster transition histories.
  stateIdHistorySignatures(46, 'STATE_ID_HISTORY_SIGNATURES'),

  /// *
  ///      * A state identifier for votes on history proofs.
  stateIdProofVotes(47, 'STATE_ID_PROOF_VOTES'),

  /// *
  ///      * A state identifier for the CRS state.
  stateIdCrsState(48, 'STATE_ID_CRS_STATE'),

  /// *
  ///      * A state identifier for the CRS publications.
  stateIdCrsPublications(49, 'STATE_ID_CRS_PUBLICATIONS'),

  /// *
  ///      * A state identifier for the node rewards
  stateIdNodeRewards(50, 'STATE_ID_NODE_REWARDS'),

  /// *
  ///      * A state identifier for the round receipts queue.
  stateIdTransactionReceiptsQueue(126, 'STATE_ID_TRANSACTION_RECEIPTS_QUEUE'),

  /// *
  ///      * A state for the `150` upgrade file data
  stateIdUpgradeData150(10001, 'STATE_ID_UPGRADE_DATA_150'),

  /// *
  ///      * A state for the `151` upgrade file data
  stateIdUpgradeData151(10002, 'STATE_ID_UPGRADE_DATA_151'),

  /// *
  ///      * A state for the `152` upgrade file data
  stateIdUpgradeData152(10003, 'STATE_ID_UPGRADE_DATA_152'),

  /// *
  ///      * A state for the `153` upgrade file data
  stateIdUpgradeData153(10004, 'STATE_ID_UPGRADE_DATA_153'),

  /// *
  ///      * A state for the `154` upgrade file data
  stateIdUpgradeData154(10005, 'STATE_ID_UPGRADE_DATA_154'),

  /// *
  ///      * A state for the `155` upgrade file data
  stateIdUpgradeData155(10006, 'STATE_ID_UPGRADE_DATA_155'),

  /// *
  ///      * A state for the `156` upgrade file data
  stateIdUpgradeData156(10007, 'STATE_ID_UPGRADE_DATA_156'),

  /// *
  ///      * A state for the `157` upgrade file data
  stateIdUpgradeData157(10008, 'STATE_ID_UPGRADE_DATA_157'),

  /// *
  ///      * A state for the `158` upgrade file data
  stateIdUpgradeData158(10009, 'STATE_ID_UPGRADE_DATA_158'),

  /// *
  ///      * A state for the `159` upgrade file data
  stateIdUpgradeData159(10010, 'STATE_ID_UPGRADE_DATA_159');

  const HederaStateIdentifier(this.value, this.protoName);

  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static HederaStateIdentifier fromValue(int? value) {
    value ??= 0;
    return HederaStateIdentifier.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching HederaStateIdentifier found for the given value. $value",
                details: {
                  "name": "HederaStateIdentifier",
                  "value": value?.toString(),
                },
              ),
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static HederaStateIdentifier from(Object? value) {
    value ??= 0;
    return HederaStateIdentifier.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching HederaStateIdentifier found for the given value. $value",
                details: {
                  "name": "HederaStateIdentifier",
                  "value": value?.toString(),
                },
              ),
    );
  }
}

/// *
///  * An enumeration of the types of named states.&lt;br/&gt;
///  * The default, Singleton, is the type of state most frequently
///  * added and removed.
enum HederaNewStateType implements ProtoEnumVariant {
  singleton(0, 'SINGLETON'),
  virtualMap(1, 'VIRTUAL_MAP'),
  queue(2, 'QUEUE');

  const HederaNewStateType(this.value, this.protoName);

  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static HederaNewStateType fromValue(int? value) {
    value ??= 0;
    return HederaNewStateType.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching HederaNewStateType found for the given value. $value",
                details: {
                  "name": "HederaNewStateType",
                  "value": value?.toString(),
                },
              ),
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static HederaNewStateType from(Object? value) {
    value ??= 0;
    return HederaNewStateType.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching HederaNewStateType found for the given value. $value",
                details: {
                  "name": "HederaNewStateType",
                  "value": value?.toString(),
                },
              ),
    );
  }
}

/// *
///  * # State Changes
///  * Serialization of change records which describe the mutation of state
///  * during a block.
///  *
///  * The _ordered_ application of all `StateChanges` in a block to an initial
///  * state that matches network state at the beginning of that block MUST produce
///  * a resultant state that matches the network state at the end of that block.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in
///  * [RFC2119](https://www.ietf.org/rfc/rfc2119) and clarified in
///  * [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// * Copyright (C) 2024 Hedera Hashgraph, LLC
///  *
///  * Licensed under the Apache License, Version 2.0 (the "License");
///  * you may not use this file except in compliance with the License.
///  * You may obtain a copy of the License at
///  *
///  *      http://www.apache.org/licenses/LICENSE-2.0
///  *
///  * Unless required by applicable law or agreed to in writing, software
///  * distributed under the License is distributed on an "AS IS" BASIS,
///  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
///  * See the License for the specific language governing permissions and
///  * limitations under the License.
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.block.stream.output"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * A set of state changes.
///  *
///  * Each set of changes in the network deterministically mutates the
///  * current state to a new state, and all nodes MUST apply the same
///  * changes in the same order.&lt;br/&gt;
///  * Each change set described in the block stream SHALL describe an
///  * ordered set of mutations which mutate the previous valid state to
///  * produce a new valid state.&lt;br/&gt;
///  * The order of state change sets SHALL be determined by the
///  * `consensus_timestamp`, which is a strictly ascending value
///  * determined by network consensus.
///  *
///  * ### Consensus Timestamp
///  * This value enables a consumer of the block stream to order state
///  * changes by a consistent ascending value that is determined by network
///  * consensus. A primary use case would be to enter state changes in a
///  * time-series database.&lt;br/&gt;
///  * This value depends on the cause of the state change.
///  *  1. For transactions, this is the transaction consensus timestamp.
///  *  1. For events without transactions, this is the consensus timestamp of
///  *     the event (round?).
///  *  1. For changes that are not the result of a transaction, but still follow
///  *     a transaction within an event, this is the consensus timestamp of the
///  *     preceding transaction.
class HederaStateChanges extends HederaProtoMessage with Equality {
  /// *
  ///      * The consensus timestamp of this set of changes.
  ///      * &lt;p&gt;
  ///      * This value SHALL be deterministic with the cause of the state change.
  final proto_timestamp.HederaTimestamp? consensusTimestamp;

  /// *
  ///      * An ordered list of individual changes.
  ///      * &lt;p&gt;
  ///      * These changes MUST be applied in the order listed to produce
  ///      * a correct modified state.
  final List<HederaStateChange> stateChanges;

  const HederaStateChanges({
    this.consensusTimestamp,
    this.stateChanges = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.repeated(
          fieldNumber: 2,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [consensusTimestamp, stateChanges];

  HederaStateChanges copyWith({
    proto_timestamp.HederaTimestamp? consensusTimestamp,

    List<HederaStateChange>? stateChanges,
  }) {
    return HederaStateChanges(
      consensusTimestamp: consensusTimestamp ?? this.consensusTimestamp,
      stateChanges: stateChanges ?? this.stateChanges,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'consensus_timestamp': config.encodeMessage(consensusTimestamp),
      'state_changes':
          stateChanges.map((e) => config.encodeMessage(e)).toList(),
    };
  }

  factory HederaStateChanges.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaStateChanges(
      consensusTimestamp: json
          .valueTo<proto_timestamp.HederaTimestamp?, Object>(
            key: 'consensus_timestamp',
            parse:
                (v) => proto_timestamp.HederaTimestamp.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      stateChanges:
          (json.valueEnsureAsList<dynamic>(
                'state_changes',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<HederaStateChange, Object>(
                  value: e,
                  parse:
                      (v) => HederaStateChange.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory HederaStateChanges.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaStateChanges(
      consensusTimestamp: decode.messageTo<proto_timestamp.HederaTimestamp?>(
        1,
        (b) => proto_timestamp.HederaTimestamp.deserialize(b),
      ),
      stateChanges:
          decode
              .getListOfBytes(2)
              .map((b) => HederaStateChange.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiBlockStreamOutputStateChanges;
}

/// *
///  * A change to any item in the merkle tree.
///  *
///  * A State change SHALL represent one mutation of the network state merkle
///  * tree. The state changes published in the block stream MAY be combined
///  * into an ordered set of state mutations that transform the tree from any
///  * initial state to a destination state.&lt;br/&gt;
///  * When the full set of state change items from the block stream for a round
///  * is applied to the network state at the start of that round the result
///  * SHALL match the network state at the end of the round.
///  *       Need to reference that document, stored in platform docs?, here.
class HederaStateChange extends HederaProtoMessage with Equality {
  /// *
  ///      * A state identifier.&lt;br/&gt;
  ///      * The reason we use an integer field here, and not an enum field is to
  ///      * better support forward compatibility. There will be many cases when a
  ///      * block node or other client (such as a dApp) with HAPI version N wants
  ///      * to process blocks from HAPI version N+1, for example. If we use a
  ///      * protobuf enum then when that is mapped Java or Rust it would not be
  ///      * parsed as an enum value because those languages do not support unknown
  ///      * enum values. ProtoC has a workaround for this but it is complex and
  ///      * requires non-deterministic parsing. Our solution to create an integer
  ///      * field and provide an enumeration for mapping that integer is intended
  ///      * as an acceptable compromise solution.
  ///      * &lt;p&gt;
  ///      * This number SHALL identify the merkle subtree "state" to be modified and
  ///      * often corresponds to a `VirtualMap` identifier.
  ///      * This number SHALL be a valid value for the `StateIdentifier` enum.
  final int? stateId;

  /// *
  ///          * Addition of a new state.&lt;br/&gt;
  ///          * This may be a singleton, virtual map, or queue state.
  final HederaNewStateChange? stateAdd;

  /// *
  ///          * Removal of an existing state.&lt;br/&gt;
  ///          * The entire singleton, virtual map, or queue state is removed,
  ///          * and not just the contents.
  final HederaRemovedStateChange? stateRemove;

  /// *
  ///          * An add or update to a `Singleton` state.
  final HederaSingletonUpdateChange? singletonUpdate;

  /// *
  ///          * An add or update to a single item in a `VirtualMap`.
  final HederaMapUpdateChange? mapUpdate;

  /// *
  ///          * A removal of a single item from a `VirtualMap`.
  final HederaMapDeleteChange? mapDelete;

  /// *
  ///          * Addition of an item to a `Queue` state.
  final HederaQueuePushChange? queuePush;

  /// *
  ///          * Removal of an item from a `Queue` state.
  final HederaQueuePopChange? queuePop;

  const HederaStateChange({
    this.stateId,
    this.stateAdd,
    this.stateRemove,
    this.singletonUpdate,
    this.mapUpdate,
    this.mapDelete,
    this.queuePush,
    this.queuePop,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.uint32(1),
        ProtoFieldConfig.message(2),
        ProtoFieldConfig.message(3),
        ProtoFieldConfig.message(4),
        ProtoFieldConfig.message(5),
        ProtoFieldConfig.message(6),
        ProtoFieldConfig.message(7),
        ProtoFieldConfig.message(8),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    stateId,
    stateAdd,
    stateRemove,
    singletonUpdate,
    mapUpdate,
    mapDelete,
    queuePush,
    queuePop,
  ];

  HederaStateChange copyWith({
    int? stateId,

    HederaNewStateChange? stateAdd,

    HederaRemovedStateChange? stateRemove,

    HederaSingletonUpdateChange? singletonUpdate,

    HederaMapUpdateChange? mapUpdate,

    HederaMapDeleteChange? mapDelete,

    HederaQueuePushChange? queuePush,

    HederaQueuePopChange? queuePop,
  }) {
    return HederaStateChange(
      stateId: stateId ?? this.stateId,
      stateAdd: stateAdd ?? this.stateAdd,
      stateRemove: stateRemove ?? this.stateRemove,
      singletonUpdate: singletonUpdate ?? this.singletonUpdate,
      mapUpdate: mapUpdate ?? this.mapUpdate,
      mapDelete: mapDelete ?? this.mapDelete,
      queuePush: queuePush ?? this.queuePush,
      queuePop: queuePop ?? this.queuePop,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'state_id': stateId,
      'state_add': config.encodeMessage(stateAdd),
      'state_remove': config.encodeMessage(stateRemove),
      'singleton_update': config.encodeMessage(singletonUpdate),
      'map_update': config.encodeMessage(mapUpdate),
      'map_delete': config.encodeMessage(mapDelete),
      'queue_push': config.encodeMessage(queuePush),
      'queue_pop': config.encodeMessage(queuePop),
    };
  }

  factory HederaStateChange.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaStateChange(
      stateId: json.valueAsInt<int?>(
        'state_id',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      stateAdd: json.valueTo<HederaNewStateChange?, Object>(
        key: 'state_add',
        parse:
            (v) => HederaNewStateChange.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      stateRemove: json.valueTo<HederaRemovedStateChange?, Object>(
        key: 'state_remove',
        parse:
            (v) => HederaRemovedStateChange.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      singletonUpdate: json.valueTo<HederaSingletonUpdateChange?, Object>(
        key: 'singleton_update',
        parse:
            (v) => HederaSingletonUpdateChange.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      mapUpdate: json.valueTo<HederaMapUpdateChange?, Object>(
        key: 'map_update',
        parse:
            (v) => HederaMapUpdateChange.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      mapDelete: json.valueTo<HederaMapDeleteChange?, Object>(
        key: 'map_delete',
        parse:
            (v) => HederaMapDeleteChange.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      queuePush: json.valueTo<HederaQueuePushChange?, Object>(
        key: 'queue_push',
        parse:
            (v) => HederaQueuePushChange.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      queuePop: json.valueTo<HederaQueuePopChange?, Object>(
        key: 'queue_pop',
        parse:
            (v) => HederaQueuePopChange.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaStateChange.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaStateChange(
      stateId: decode.getInt<int?>(1),
      stateAdd: decode.messageTo<HederaNewStateChange?>(
        2,
        (b) => HederaNewStateChange.deserialize(b),
      ),
      stateRemove: decode.messageTo<HederaRemovedStateChange?>(
        3,
        (b) => HederaRemovedStateChange.deserialize(b),
      ),
      singletonUpdate: decode.messageTo<HederaSingletonUpdateChange?>(
        4,
        (b) => HederaSingletonUpdateChange.deserialize(b),
      ),
      mapUpdate: decode.messageTo<HederaMapUpdateChange?>(
        5,
        (b) => HederaMapUpdateChange.deserialize(b),
      ),
      mapDelete: decode.messageTo<HederaMapDeleteChange?>(
        6,
        (b) => HederaMapDeleteChange.deserialize(b),
      ),
      queuePush: decode.messageTo<HederaQueuePushChange?>(
        7,
        (b) => HederaQueuePushChange.deserialize(b),
      ),
      queuePop: decode.messageTo<HederaQueuePopChange?>(
        8,
        (b) => HederaQueuePopChange.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiBlockStreamOutputStateChange;
}

/// *
///  * An addition of a new named state.
///  *
///  * Adding a new named state SHALL only require the name and type.&lt;br/&gt;
///  * The content of the new state SHALL be filled in via subsequent
///  * state change items specific to the type of state
///  * (e.g. SingletonUpdateChange or MapUpdateChange).
class HederaNewStateChange extends HederaProtoMessage with Equality {
  /// *
  ///      * The type (e.g. Singleton, Virtual Map, Queue) of state to add.
  final HederaNewStateType? stateType;

  const HederaNewStateChange({this.stateType});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.enumType(1)],
    );
  }

  @override
  List<Object?> get protoValues => [stateType];

  HederaNewStateChange copyWith({HederaNewStateType? stateType}) {
    return HederaNewStateChange(stateType: stateType ?? this.stateType);
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'state_type': config.encodeEnum(stateType)};
  }

  factory HederaNewStateChange.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaNewStateChange(
      stateType: json.valueTo<HederaNewStateType?, Object?>(
        key: 'state_type',
        parse: (v) => HederaNewStateType.from(v),
      ),
    );
  }

  factory HederaNewStateChange.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaNewStateChange(
      stateType: decode.getEnum<HederaNewStateType?>(
        1,
        HederaNewStateType.values,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiBlockStreamOutputNewStateChange;
}

/// *
///  * A removal of a named state.
///  *
///  * Removing a named state does not, currently, require additional
///  * information beyond the state name common to all state changes.&lt;br/&gt;
///  * A named state, other than a singleton, SHOULD be empty before it is removed.
class HederaRemovedStateChange extends HederaProtoMessage with Equality {
  const HederaRemovedStateChange();

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [],
    );
  }

  @override
  List<Object?> get protoValues => [];

  HederaRemovedStateChange copyWith() {
    return HederaRemovedStateChange();
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {};
  }

  factory HederaRemovedStateChange.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaRemovedStateChange();
  }

  factory HederaRemovedStateChange.deserialize(List<int> bytes) {
    return HederaRemovedStateChange();
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl
          .comHederaHapiBlockStreamOutputRemovedStateChange;
}

/// *
///  * An update to a `Singleton` state.
class HederaSingletonUpdateChange extends HederaProtoMessage with Equality {
  /// *
  ///          * A change to the block info singleton.
  ///          * &lt;p&gt;
  ///          * The `BlockInfo` SHALL be updated at the end of every block and
  ///          * SHALL store, among other fields, the last 256 block hash values.
  ///          * &lt;blockquote&gt;REVIEW NOTE&lt;blockquote&gt;
  ///          * The full BlockInfo will be in the state proof, and may not be
  ///          * necessary here.&lt;/blockquote&gt;&lt;/blockquote&gt;
  final proto_block_info.HederaBlockInfo? blockInfoValue;

  /// *
  ///          * A change to the congestion level starts singleton.
  ///          * &lt;p&gt;
  ///          * This change SHALL be present if congestion level pricing for
  ///          * general fees or gas fees started during the current block.
  final proto_congestion_level_starts.HederaCongestionLevelStarts?
  congestionLevelStartsValue;

  /// *
  ///          * A change to the Entity Identifier singleton.
  ///          * &lt;p&gt;
  ///          * The Entity Identifier singleton SHALL track the highest entity
  ///          * identifier used for the current shard and realm and SHALL be used
  ///          * to issue new entity numbers.
  final google_protobuf_wrappers.HederaUInt64Value? entityNumberValue;

  /// *
  ///          * A change to the exchange rates singleton.
  ///          * &lt;p&gt;
  ///          * This change SHALL be present if the &lt;tt&gt;HBAR&amp;lt;=&amp;gt;USD&lt;/tt&gt; exchange
  ///          * rate, as stored in the "midnight rates" singleton changed
  ///          * during the current block.
  final proto_exchange_rate.HederaExchangeRateSet? exchangeRateSetValue;

  /// *
  ///          * A change to the network staking rewards singleton.
  ///          * &lt;p&gt;
  ///          * Network staking rewards SHALL be updated for every non-empty block.
  final proto_network_staking_rewards.HederaNetworkStakingRewards?
  networkStakingRewardsValue;

  /// *
  ///          * A change to a raw byte array singleton.
  ///          * &lt;p&gt;
  ///          * This change SHALL present a change made to a raw byte array
  ///          * singleton.&lt;br/&gt;
  ///          * The "upgrade file hash" state is an example of a raw byte
  ///          * array singleton.
  final google_protobuf_wrappers.HederaBytesValue? bytesValue;

  /// *
  ///          * A change to a raw string singleton.
  ///          * &lt;p&gt;
  ///          * &lt;dl&gt;&lt;dt&gt;Note&lt;/dt&gt;&lt;dd&gt;There are no current examples of a raw string
  ///          * singleton state.&lt;/dd&gt;&lt;/dl&gt;
  final google_protobuf_wrappers.HederaStringValue? stringValue;

  /// *
  ///          * A change to the running hashes singleton.
  ///          * &lt;p&gt;
  ///          * Running hashes SHALL be updated for each transaction.
  ///          * &lt;p&gt;
  ///          * &lt;blockquote&gt;REVIEW NOTE&lt;blockquote&gt;
  ///          * Running hashes is a record stream item. Can it be elided from
  ///          * the block stream? It's not written to the record stream, as far
  ///          * as I can tell. If we do write this it's adding over 144 bytes
  ///          * for every transaction. It's also not clear how we'll calculate
  ///          * this, as it's a hash of the records currently, so it would have
  ///          * to be a hash of the block items, including this one...
  ///          * &lt;/blockquote&gt;&lt;/blockquote&gt;
  final proto_running_hashes.HederaRunningHashes? runningHashesValue;

  /// *
  ///          * A change to the throttle usage snapshots singleton.
  ///          * &lt;p&gt;
  ///          * Throttle usage snapshots SHALL be updated for _every transaction_
  ///          * to reflect the amount used for each tps throttle and
  ///          * for the gas throttle.
  final proto_throttle_usage_snapshots.HederaThrottleUsageSnapshots?
  throttleUsageSnapshotsValue;

  /// *
  ///          * A change to a raw `Timestamp` singleton.&lt;br/&gt;
  ///          * An example of a raw `Timestamp` singleton is the
  ///          * "network freeze time" singleton state, which, if set, stores
  ///          * the time for the next scheduled freeze.
  final proto_timestamp.HederaTimestamp? timestampValue;

  /// *
  ///          * A change to the block stream status singleton.
  ///          * &lt;p&gt;
  ///          * This MUST be updated at the beginning of a block, with the
  ///          * information for the immediately prior block.
  final com_hedera_hapi_node_state_blockstream_block_stream_info.HederaBlockStreamInfo?
  blockStreamInfoValue;

  /// *
  ///          * A change to the platform state singleton.
  final com_hedera_hapi_platform_state_platform_state.HederaPlatformState?
  platformStateValue;

  /// *
  ///          * A change to the roster state singleton.
  final com_hedera_hapi_node_state_roster_roster_state.HederaRosterState?
  rosterStateValue;

  /// *
  ///          * A change to a hinTS construction singleton.
  final com_hedera_hapi_node_state_hints_hints_types.HederaHintsConstruction?
  hintsConstructionValue;

  /// *
  ///          * A change to the Entity counts singleton.
  final com_hedera_hapi_node_state_entity_entity_counts.HederaEntityCounts?
  entityCountsValue;

  /// *
  ///          * A change to a hinTS construction singleton.
  final com_hedera_hapi_node_state_history_history_types.HederaHistoryProofConstruction?
  historyProofConstructionValue;

  /// *
  ///          * A change to the CRS State singleton.
  final com_hedera_hapi_node_state_hints_hints_types.HederaCRSState?
  crsStateValue;

  /// *
  ///          * A change to the node rewards singleton.
  ///          * &lt;p&gt;
  ///          * Node rewards SHALL be updated for every non-empty block.
  final proto_node_rewards.HederaNodeRewards? nodeRewardsValue;

  const HederaSingletonUpdateChange({
    this.blockInfoValue,
    this.congestionLevelStartsValue,
    this.entityNumberValue,
    this.exchangeRateSetValue,
    this.networkStakingRewardsValue,
    this.bytesValue,
    this.stringValue,
    this.runningHashesValue,
    this.throttleUsageSnapshotsValue,
    this.timestampValue,
    this.blockStreamInfoValue,
    this.platformStateValue,
    this.rosterStateValue,
    this.hintsConstructionValue,
    this.entityCountsValue,
    this.historyProofConstructionValue,
    this.crsStateValue,
    this.nodeRewardsValue,
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
        ProtoFieldConfig.message(18),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    blockInfoValue,
    congestionLevelStartsValue,
    entityNumberValue,
    exchangeRateSetValue,
    networkStakingRewardsValue,
    bytesValue,
    stringValue,
    runningHashesValue,
    throttleUsageSnapshotsValue,
    timestampValue,
    blockStreamInfoValue,
    platformStateValue,
    rosterStateValue,
    hintsConstructionValue,
    entityCountsValue,
    historyProofConstructionValue,
    crsStateValue,
    nodeRewardsValue,
  ];

  HederaSingletonUpdateChange copyWith({
    proto_block_info.HederaBlockInfo? blockInfoValue,

    proto_congestion_level_starts.HederaCongestionLevelStarts?
    congestionLevelStartsValue,

    google_protobuf_wrappers.HederaUInt64Value? entityNumberValue,

    proto_exchange_rate.HederaExchangeRateSet? exchangeRateSetValue,

    proto_network_staking_rewards.HederaNetworkStakingRewards?
    networkStakingRewardsValue,

    google_protobuf_wrappers.HederaBytesValue? bytesValue,

    google_protobuf_wrappers.HederaStringValue? stringValue,

    proto_running_hashes.HederaRunningHashes? runningHashesValue,

    proto_throttle_usage_snapshots.HederaThrottleUsageSnapshots?
    throttleUsageSnapshotsValue,

    proto_timestamp.HederaTimestamp? timestampValue,

    com_hedera_hapi_node_state_blockstream_block_stream_info.HederaBlockStreamInfo?
    blockStreamInfoValue,

    com_hedera_hapi_platform_state_platform_state.HederaPlatformState?
    platformStateValue,

    com_hedera_hapi_node_state_roster_roster_state.HederaRosterState?
    rosterStateValue,

    com_hedera_hapi_node_state_hints_hints_types.HederaHintsConstruction?
    hintsConstructionValue,

    com_hedera_hapi_node_state_entity_entity_counts.HederaEntityCounts?
    entityCountsValue,

    com_hedera_hapi_node_state_history_history_types.HederaHistoryProofConstruction?
    historyProofConstructionValue,

    com_hedera_hapi_node_state_hints_hints_types.HederaCRSState? crsStateValue,

    proto_node_rewards.HederaNodeRewards? nodeRewardsValue,
  }) {
    return HederaSingletonUpdateChange(
      blockInfoValue: blockInfoValue ?? this.blockInfoValue,
      congestionLevelStartsValue:
          congestionLevelStartsValue ?? this.congestionLevelStartsValue,
      entityNumberValue: entityNumberValue ?? this.entityNumberValue,
      exchangeRateSetValue: exchangeRateSetValue ?? this.exchangeRateSetValue,
      networkStakingRewardsValue:
          networkStakingRewardsValue ?? this.networkStakingRewardsValue,
      bytesValue: bytesValue ?? this.bytesValue,
      stringValue: stringValue ?? this.stringValue,
      runningHashesValue: runningHashesValue ?? this.runningHashesValue,
      throttleUsageSnapshotsValue:
          throttleUsageSnapshotsValue ?? this.throttleUsageSnapshotsValue,
      timestampValue: timestampValue ?? this.timestampValue,
      blockStreamInfoValue: blockStreamInfoValue ?? this.blockStreamInfoValue,
      platformStateValue: platformStateValue ?? this.platformStateValue,
      rosterStateValue: rosterStateValue ?? this.rosterStateValue,
      hintsConstructionValue:
          hintsConstructionValue ?? this.hintsConstructionValue,
      entityCountsValue: entityCountsValue ?? this.entityCountsValue,
      historyProofConstructionValue:
          historyProofConstructionValue ?? this.historyProofConstructionValue,
      crsStateValue: crsStateValue ?? this.crsStateValue,
      nodeRewardsValue: nodeRewardsValue ?? this.nodeRewardsValue,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'block_info_value': config.encodeMessage(blockInfoValue),
      'congestion_level_starts_value': config.encodeMessage(
        congestionLevelStartsValue,
      ),
      'entity_number_value': config.encodeMessage(entityNumberValue),
      'exchange_rate_set_value': config.encodeMessage(exchangeRateSetValue),
      'network_staking_rewards_value': config.encodeMessage(
        networkStakingRewardsValue,
      ),
      'bytes_value': config.encodeMessage(bytesValue),
      'string_value': config.encodeMessage(stringValue),
      'running_hashes_value': config.encodeMessage(runningHashesValue),
      'throttle_usage_snapshots_value': config.encodeMessage(
        throttleUsageSnapshotsValue,
      ),
      'timestamp_value': config.encodeMessage(timestampValue),
      'block_stream_info_value': config.encodeMessage(blockStreamInfoValue),
      'platform_state_value': config.encodeMessage(platformStateValue),
      'roster_state_value': config.encodeMessage(rosterStateValue),
      'hints_construction_value': config.encodeMessage(hintsConstructionValue),
      'entity_counts_value': config.encodeMessage(entityCountsValue),
      'history_proof_construction_value': config.encodeMessage(
        historyProofConstructionValue,
      ),
      'crs_state_value': config.encodeMessage(crsStateValue),
      'node_rewards_value': config.encodeMessage(nodeRewardsValue),
    };
  }

  factory HederaSingletonUpdateChange.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaSingletonUpdateChange(
      blockInfoValue: json.valueTo<proto_block_info.HederaBlockInfo?, Object>(
        key: 'block_info_value',
        parse:
            (v) => proto_block_info.HederaBlockInfo.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      congestionLevelStartsValue: json.valueTo<
        proto_congestion_level_starts.HederaCongestionLevelStarts?,
        Object
      >(
        key: 'congestion_level_starts_value',
        parse:
            (v) => proto_congestion_level_starts
                .HederaCongestionLevelStarts.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      entityNumberValue: json
          .valueTo<google_protobuf_wrappers.HederaUInt64Value?, Object>(
            key: 'entity_number_value',
            parse:
                (v) => google_protobuf_wrappers.HederaUInt64Value.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      exchangeRateSetValue: json
          .valueTo<proto_exchange_rate.HederaExchangeRateSet?, Object>(
            key: 'exchange_rate_set_value',
            parse:
                (v) => proto_exchange_rate.HederaExchangeRateSet.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      networkStakingRewardsValue: json.valueTo<
        proto_network_staking_rewards.HederaNetworkStakingRewards?,
        Object
      >(
        key: 'network_staking_rewards_value',
        parse:
            (v) => proto_network_staking_rewards
                .HederaNetworkStakingRewards.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      bytesValue: json
          .valueTo<google_protobuf_wrappers.HederaBytesValue?, Object>(
            key: 'bytes_value',
            parse:
                (v) => google_protobuf_wrappers.HederaBytesValue.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      stringValue: json
          .valueTo<google_protobuf_wrappers.HederaStringValue?, Object>(
            key: 'string_value',
            parse:
                (v) => google_protobuf_wrappers.HederaStringValue.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      runningHashesValue: json
          .valueTo<proto_running_hashes.HederaRunningHashes?, Object>(
            key: 'running_hashes_value',
            parse:
                (v) => proto_running_hashes.HederaRunningHashes.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      throttleUsageSnapshotsValue: json.valueTo<
        proto_throttle_usage_snapshots.HederaThrottleUsageSnapshots?,
        Object
      >(
        key: 'throttle_usage_snapshots_value',
        parse:
            (v) => proto_throttle_usage_snapshots
                .HederaThrottleUsageSnapshots.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      timestampValue: json.valueTo<proto_timestamp.HederaTimestamp?, Object>(
        key: 'timestamp_value',
        parse:
            (v) => proto_timestamp.HederaTimestamp.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      blockStreamInfoValue: json.valueTo<
        com_hedera_hapi_node_state_blockstream_block_stream_info.HederaBlockStreamInfo?,
        Object
      >(
        key: 'block_stream_info_value',
        parse:
            (v) => com_hedera_hapi_node_state_blockstream_block_stream_info
                .HederaBlockStreamInfo.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      platformStateValue: json.valueTo<
        com_hedera_hapi_platform_state_platform_state.HederaPlatformState?,
        Object
      >(
        key: 'platform_state_value',
        parse:
            (v) => com_hedera_hapi_platform_state_platform_state
                .HederaPlatformState.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      rosterStateValue: json.valueTo<
        com_hedera_hapi_node_state_roster_roster_state.HederaRosterState?,
        Object
      >(
        key: 'roster_state_value',
        parse:
            (v) => com_hedera_hapi_node_state_roster_roster_state
                .HederaRosterState.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      hintsConstructionValue: json.valueTo<
        com_hedera_hapi_node_state_hints_hints_types.HederaHintsConstruction?,
        Object
      >(
        key: 'hints_construction_value',
        parse:
            (v) => com_hedera_hapi_node_state_hints_hints_types
                .HederaHintsConstruction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      entityCountsValue: json.valueTo<
        com_hedera_hapi_node_state_entity_entity_counts.HederaEntityCounts?,
        Object
      >(
        key: 'entity_counts_value',
        parse:
            (v) => com_hedera_hapi_node_state_entity_entity_counts
                .HederaEntityCounts.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      historyProofConstructionValue: json.valueTo<
        com_hedera_hapi_node_state_history_history_types.HederaHistoryProofConstruction?,
        Object
      >(
        key: 'history_proof_construction_value',
        parse:
            (v) => com_hedera_hapi_node_state_history_history_types
                .HederaHistoryProofConstruction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      crsStateValue: json.valueTo<
        com_hedera_hapi_node_state_hints_hints_types.HederaCRSState?,
        Object
      >(
        key: 'crs_state_value',
        parse:
            (v) => com_hedera_hapi_node_state_hints_hints_types
                .HederaCRSState.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      nodeRewardsValue: json
          .valueTo<proto_node_rewards.HederaNodeRewards?, Object>(
            key: 'node_rewards_value',
            parse:
                (v) => proto_node_rewards.HederaNodeRewards.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
    );
  }

  factory HederaSingletonUpdateChange.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaSingletonUpdateChange(
      blockInfoValue: decode.messageTo<proto_block_info.HederaBlockInfo?>(
        1,
        (b) => proto_block_info.HederaBlockInfo.deserialize(b),
      ),
      congestionLevelStartsValue: decode.messageTo<
        proto_congestion_level_starts.HederaCongestionLevelStarts?
      >(
        2,
        (b) => proto_congestion_level_starts
            .HederaCongestionLevelStarts.deserialize(b),
      ),
      entityNumberValue: decode
          .messageTo<google_protobuf_wrappers.HederaUInt64Value?>(
            3,
            (b) => google_protobuf_wrappers.HederaUInt64Value.deserialize(b),
          ),
      exchangeRateSetValue: decode
          .messageTo<proto_exchange_rate.HederaExchangeRateSet?>(
            4,
            (b) => proto_exchange_rate.HederaExchangeRateSet.deserialize(b),
          ),
      networkStakingRewardsValue: decode.messageTo<
        proto_network_staking_rewards.HederaNetworkStakingRewards?
      >(
        5,
        (b) => proto_network_staking_rewards
            .HederaNetworkStakingRewards.deserialize(b),
      ),
      bytesValue: decode.messageTo<google_protobuf_wrappers.HederaBytesValue?>(
        6,
        (b) => google_protobuf_wrappers.HederaBytesValue.deserialize(b),
      ),
      stringValue: decode
          .messageTo<google_protobuf_wrappers.HederaStringValue?>(
            7,
            (b) => google_protobuf_wrappers.HederaStringValue.deserialize(b),
          ),
      runningHashesValue: decode
          .messageTo<proto_running_hashes.HederaRunningHashes?>(
            8,
            (b) => proto_running_hashes.HederaRunningHashes.deserialize(b),
          ),
      throttleUsageSnapshotsValue: decode.messageTo<
        proto_throttle_usage_snapshots.HederaThrottleUsageSnapshots?
      >(
        9,
        (b) => proto_throttle_usage_snapshots
            .HederaThrottleUsageSnapshots.deserialize(b),
      ),
      timestampValue: decode.messageTo<proto_timestamp.HederaTimestamp?>(
        10,
        (b) => proto_timestamp.HederaTimestamp.deserialize(b),
      ),
      blockStreamInfoValue: decode.messageTo<
        com_hedera_hapi_node_state_blockstream_block_stream_info.HederaBlockStreamInfo?
      >(
        11,
        (b) => com_hedera_hapi_node_state_blockstream_block_stream_info
            .HederaBlockStreamInfo.deserialize(b),
      ),
      platformStateValue: decode.messageTo<
        com_hedera_hapi_platform_state_platform_state.HederaPlatformState?
      >(
        12,
        (b) => com_hedera_hapi_platform_state_platform_state
            .HederaPlatformState.deserialize(b),
      ),
      rosterStateValue: decode.messageTo<
        com_hedera_hapi_node_state_roster_roster_state.HederaRosterState?
      >(
        13,
        (b) => com_hedera_hapi_node_state_roster_roster_state
            .HederaRosterState.deserialize(b),
      ),
      hintsConstructionValue: decode.messageTo<
        com_hedera_hapi_node_state_hints_hints_types.HederaHintsConstruction?
      >(
        14,
        (b) => com_hedera_hapi_node_state_hints_hints_types
            .HederaHintsConstruction.deserialize(b),
      ),
      entityCountsValue: decode.messageTo<
        com_hedera_hapi_node_state_entity_entity_counts.HederaEntityCounts?
      >(
        15,
        (b) => com_hedera_hapi_node_state_entity_entity_counts
            .HederaEntityCounts.deserialize(b),
      ),
      historyProofConstructionValue: decode.messageTo<
        com_hedera_hapi_node_state_history_history_types.HederaHistoryProofConstruction?
      >(
        16,
        (b) => com_hedera_hapi_node_state_history_history_types
            .HederaHistoryProofConstruction.deserialize(b),
      ),
      crsStateValue: decode.messageTo<
        com_hedera_hapi_node_state_hints_hints_types.HederaCRSState?
      >(
        17,
        (b) => com_hedera_hapi_node_state_hints_hints_types
            .HederaCRSState.deserialize(b),
      ),
      nodeRewardsValue: decode.messageTo<proto_node_rewards.HederaNodeRewards?>(
        18,
        (b) => proto_node_rewards.HederaNodeRewards.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl
          .comHederaHapiBlockStreamOutputSingletonUpdateChange;
}

/// *
///  * An update to a single item in a `VirtualMap`.&lt;br/&gt;
///  * Each update consists of a "key" and a "value".
///  * Keys are often identifiers or scalar values.
///  * Values are generally full messages or byte arrays.
///  *
///  * The key presented here is not mutable, we do not update map keys.&lt;br/&gt;
///  * The value associated to the key provided is updated, or the value is
///  * added and associated with that key.&lt;br/&gt;
///  * A change of key would be expressed as removal of the prior key and
///  * an addition for the new key.
class HederaMapUpdateChange extends HederaProtoMessage with Equality {
  /// *
  ///      * A key in a virtual map.
  ///      * &lt;p&gt;
  ///      * This key MUST be mapped to the value added or updated.&lt;br/&gt;
  ///      * This field is REQUIRED.
  final HederaMapChangeKey? key;

  /// *
  ///      * A value in a virtual map.
  ///      * &lt;p&gt;
  ///      * This value MUST correctly represent the state of the map entry
  ///      * _after_ the asserted update.&lt;br/&gt;
  ///      * This value MAY be reduced to only transmit fields that differ
  ///      * from the prior state.&lt;br/&gt;
  ///      * This field is REQUIRED.
  final HederaMapChangeValue? value;

  const HederaMapUpdateChange({this.key, this.value});

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
  List<Object?> get protoValues => [key, value];

  HederaMapUpdateChange copyWith({
    HederaMapChangeKey? key,

    HederaMapChangeValue? value,
  }) {
    return HederaMapUpdateChange(
      key: key ?? this.key,
      value: value ?? this.value,
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
      'value': config.encodeMessage(value),
    };
  }

  factory HederaMapUpdateChange.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaMapUpdateChange(
      key: json.valueTo<HederaMapChangeKey?, Object>(
        key: 'key',
        parse:
            (v) => HederaMapChangeKey.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      value: json.valueTo<HederaMapChangeValue?, Object>(
        key: 'value',
        parse:
            (v) => HederaMapChangeValue.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaMapUpdateChange.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaMapUpdateChange(
      key: decode.messageTo<HederaMapChangeKey?>(
        1,
        (b) => HederaMapChangeKey.deserialize(b),
      ),
      value: decode.messageTo<HederaMapChangeValue?>(
        2,
        (b) => HederaMapChangeValue.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiBlockStreamOutputMapUpdateChange;
}

/// *
///  * A removal of a single item from a `VirtualMap`.
class HederaMapDeleteChange extends HederaProtoMessage with Equality {
  /// *
  ///      * A key in a virtual map.
  ///      * &lt;p&gt;
  ///      * This key SHALL be removed.&lt;br/&gt;
  ///      * The mapped value SHALL also be removed.&lt;br/&gt;
  ///      * This field is REQUIRED.
  final HederaMapChangeKey? key;

  const HederaMapDeleteChange({this.key});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.message(1)],
    );
  }

  @override
  List<Object?> get protoValues => [key];

  HederaMapDeleteChange copyWith({HederaMapChangeKey? key}) {
    return HederaMapDeleteChange(key: key ?? this.key);
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'key': config.encodeMessage(key)};
  }

  factory HederaMapDeleteChange.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaMapDeleteChange(
      key: json.valueTo<HederaMapChangeKey?, Object>(
        key: 'key',
        parse:
            (v) => HederaMapChangeKey.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaMapDeleteChange.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaMapDeleteChange(
      key: decode.messageTo<HederaMapChangeKey?>(
        1,
        (b) => HederaMapChangeKey.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiBlockStreamOutputMapDeleteChange;
}

/// *
///  * A key identifying a specific entry in a key-value "virtual map".
class HederaMapChangeKey extends HederaProtoMessage with Equality {
  /// *
  ///          * A key for a change affecting a map keyed by an Account identifier.
  final proto_basic_types.HederaAccountID? accountIdKey;

  /// *
  ///          * A change to the token relationships virtual map.&lt;br/&gt;
  ///          * This map is keyed by the pair of account identifier and
  ///          * token identifier.
  final proto_basic_types.HederaTokenAssociation? tokenRelationshipKey;

  /// *
  ///          * A change to a map keyed by an EntityNumber (which is a whole number).
  ///          * &lt;p&gt;
  ///          * This SHOULD NOT be used. Virtual maps SHOULD be keyed to
  ///          * full identifiers that include shard and realm information.
  final google_protobuf_wrappers.HederaUInt64Value? entityNumberKey;

  /// *
  ///          * A change to a virtual map keyed by File identifier.
  final proto_basic_types.HederaFileID? fileIdKey;

  /// *
  ///          * A change to a virtual map keyed by NFT identifier.
  final proto_basic_types.HederaNftID? nftIdKey;

  /// *
  ///          * A change to a virtual map keyed by a byte array.
  final google_protobuf_wrappers.HederaBytesValue? protoBytesKey;

  /// *
  ///          * A change to a virtual map keyed by an int64 value.
  final google_protobuf_wrappers.HederaInt64Value? protoLongKey;

  /// *
  ///          * A change to a virtual map keyed by a string value.
  final google_protobuf_wrappers.HederaStringValue? protoStringKey;

  /// *
  ///          * A change to a virtual map keyed by a Schedule identifier.
  final proto_basic_types.HederaScheduleID? scheduleIdKey;

  /// *
  ///          * A change to the EVM storage "slot" virtual map.
  final proto_storage_slot.HederaSlotKey? slotKeyKey;

  /// *
  ///          * A change to a virtual map keyed by a Token identifier.
  final proto_basic_types.HederaTokenID? tokenIdKey;

  /// *
  ///          * A change to a virtual map keyed by a Topic identifier.
  final proto_basic_types.HederaTopicID? topicIdKey;

  /// *
  ///          * A change to a virtual map keyed by contract id identifier.
  final proto_basic_types.HederaContractID? contractIdKey;

  /// *
  ///          * A change to a virtual map keyed by pending airdrop id identifier.
  final proto_basic_types.HederaPendingAirdropId? pendingAirdropIdKey;

  /// *
  ///          * An exact date and time,  with a resolution of one second
  final proto_timestamp.HederaTimestampSeconds? timestampSecondsKey;

  /// *
  ///          * An ordering key mapped to a particular schedule.&lt;br/&gt;
  ///          * This identifies the order in which long term scheduled transactions
  ///          * that are requested to execute in the same consensus second will
  ///          * be executed. The value will be the `ScheduleID` for the schedule
  ///          * to be executed at a particular consensus second and order within
  ///          * that second.
  final proto_schedule.HederaScheduledOrder? scheduledOrderKey;

  /// *
  ///          * A TSS Message Map Key key.
  final com_hedera_hapi_node_state_tss_tss_message_map_key.HederaTssMessageMapKey?
  tssMessageMapKey;

  /// *
  ///          * A TSS Message Map Key key.
  final com_hedera_hapi_node_state_tss_tss_vote_map_key.HederaTssVoteMapKey?
  tssVoteMapKey;

  /// *
  ///          * A hinTS party id key.
  final com_hedera_hapi_node_state_hints_hints_types.HederaHintsPartyId?
  hintsPartyIdKey;

  /// *
  ///          * A hinTS preprocessing vote id key.
  final com_hedera_hapi_node_state_hints_hints_types.HederaPreprocessingVoteId?
  preprocessingVoteIdKey;

  /// *
  ///          * An unscoped node id key.
  final com_hedera_hapi_platform_state_platform_state.HederaNodeId? nodeIdKey;

  /// *
  ///          * A construction-scoped node id key.
  final com_hedera_hapi_node_state_history_history_types.HederaConstructionNodeId?
  constructionNodeIdKey;

  const HederaMapChangeKey({
    this.accountIdKey,
    this.tokenRelationshipKey,
    this.entityNumberKey,
    this.fileIdKey,
    this.nftIdKey,
    this.protoBytesKey,
    this.protoLongKey,
    this.protoStringKey,
    this.scheduleIdKey,
    this.slotKeyKey,
    this.tokenIdKey,
    this.topicIdKey,
    this.contractIdKey,
    this.pendingAirdropIdKey,
    this.timestampSecondsKey,
    this.scheduledOrderKey,
    this.tssMessageMapKey,
    this.tssVoteMapKey,
    this.hintsPartyIdKey,
    this.preprocessingVoteIdKey,
    this.nodeIdKey,
    this.constructionNodeIdKey,
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
        ProtoFieldConfig.message(18),
        ProtoFieldConfig.message(19),
        ProtoFieldConfig.message(20),
        ProtoFieldConfig.message(21),
        ProtoFieldConfig.message(22),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    accountIdKey,
    tokenRelationshipKey,
    entityNumberKey,
    fileIdKey,
    nftIdKey,
    protoBytesKey,
    protoLongKey,
    protoStringKey,
    scheduleIdKey,
    slotKeyKey,
    tokenIdKey,
    topicIdKey,
    contractIdKey,
    pendingAirdropIdKey,
    timestampSecondsKey,
    scheduledOrderKey,
    tssMessageMapKey,
    tssVoteMapKey,
    hintsPartyIdKey,
    preprocessingVoteIdKey,
    nodeIdKey,
    constructionNodeIdKey,
  ];

  HederaMapChangeKey copyWith({
    proto_basic_types.HederaAccountID? accountIdKey,

    proto_basic_types.HederaTokenAssociation? tokenRelationshipKey,

    google_protobuf_wrappers.HederaUInt64Value? entityNumberKey,

    proto_basic_types.HederaFileID? fileIdKey,

    proto_basic_types.HederaNftID? nftIdKey,

    google_protobuf_wrappers.HederaBytesValue? protoBytesKey,

    google_protobuf_wrappers.HederaInt64Value? protoLongKey,

    google_protobuf_wrappers.HederaStringValue? protoStringKey,

    proto_basic_types.HederaScheduleID? scheduleIdKey,

    proto_storage_slot.HederaSlotKey? slotKeyKey,

    proto_basic_types.HederaTokenID? tokenIdKey,

    proto_basic_types.HederaTopicID? topicIdKey,

    proto_basic_types.HederaContractID? contractIdKey,

    proto_basic_types.HederaPendingAirdropId? pendingAirdropIdKey,

    proto_timestamp.HederaTimestampSeconds? timestampSecondsKey,

    proto_schedule.HederaScheduledOrder? scheduledOrderKey,

    com_hedera_hapi_node_state_tss_tss_message_map_key.HederaTssMessageMapKey?
    tssMessageMapKey,

    com_hedera_hapi_node_state_tss_tss_vote_map_key.HederaTssVoteMapKey?
    tssVoteMapKey,

    com_hedera_hapi_node_state_hints_hints_types.HederaHintsPartyId?
    hintsPartyIdKey,

    com_hedera_hapi_node_state_hints_hints_types.HederaPreprocessingVoteId?
    preprocessingVoteIdKey,

    com_hedera_hapi_platform_state_platform_state.HederaNodeId? nodeIdKey,

    com_hedera_hapi_node_state_history_history_types.HederaConstructionNodeId?
    constructionNodeIdKey,
  }) {
    return HederaMapChangeKey(
      accountIdKey: accountIdKey ?? this.accountIdKey,
      tokenRelationshipKey: tokenRelationshipKey ?? this.tokenRelationshipKey,
      entityNumberKey: entityNumberKey ?? this.entityNumberKey,
      fileIdKey: fileIdKey ?? this.fileIdKey,
      nftIdKey: nftIdKey ?? this.nftIdKey,
      protoBytesKey: protoBytesKey ?? this.protoBytesKey,
      protoLongKey: protoLongKey ?? this.protoLongKey,
      protoStringKey: protoStringKey ?? this.protoStringKey,
      scheduleIdKey: scheduleIdKey ?? this.scheduleIdKey,
      slotKeyKey: slotKeyKey ?? this.slotKeyKey,
      tokenIdKey: tokenIdKey ?? this.tokenIdKey,
      topicIdKey: topicIdKey ?? this.topicIdKey,
      contractIdKey: contractIdKey ?? this.contractIdKey,
      pendingAirdropIdKey: pendingAirdropIdKey ?? this.pendingAirdropIdKey,
      timestampSecondsKey: timestampSecondsKey ?? this.timestampSecondsKey,
      scheduledOrderKey: scheduledOrderKey ?? this.scheduledOrderKey,
      tssMessageMapKey: tssMessageMapKey ?? this.tssMessageMapKey,
      tssVoteMapKey: tssVoteMapKey ?? this.tssVoteMapKey,
      hintsPartyIdKey: hintsPartyIdKey ?? this.hintsPartyIdKey,
      preprocessingVoteIdKey:
          preprocessingVoteIdKey ?? this.preprocessingVoteIdKey,
      nodeIdKey: nodeIdKey ?? this.nodeIdKey,
      constructionNodeIdKey:
          constructionNodeIdKey ?? this.constructionNodeIdKey,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'account_id_key': config.encodeMessage(accountIdKey),
      'token_relationship_key': config.encodeMessage(tokenRelationshipKey),
      'entity_number_key': config.encodeMessage(entityNumberKey),
      'file_id_key': config.encodeMessage(fileIdKey),
      'nft_id_key': config.encodeMessage(nftIdKey),
      'proto_bytes_key': config.encodeMessage(protoBytesKey),
      'proto_long_key': config.encodeMessage(protoLongKey),
      'proto_string_key': config.encodeMessage(protoStringKey),
      'schedule_id_key': config.encodeMessage(scheduleIdKey),
      'slot_key_key': config.encodeMessage(slotKeyKey),
      'token_id_key': config.encodeMessage(tokenIdKey),
      'topic_id_key': config.encodeMessage(topicIdKey),
      'contract_id_key': config.encodeMessage(contractIdKey),
      'pending_airdrop_id_key': config.encodeMessage(pendingAirdropIdKey),
      'timestamp_seconds_key': config.encodeMessage(timestampSecondsKey),
      'scheduled_order_key': config.encodeMessage(scheduledOrderKey),
      'tss_message_map_key': config.encodeMessage(tssMessageMapKey),
      'tss_vote_map_key': config.encodeMessage(tssVoteMapKey),
      'hints_party_id_key': config.encodeMessage(hintsPartyIdKey),
      'preprocessing_vote_id_key': config.encodeMessage(preprocessingVoteIdKey),
      'node_id_key': config.encodeMessage(nodeIdKey),
      'construction_node_id_key': config.encodeMessage(constructionNodeIdKey),
    };
  }

  factory HederaMapChangeKey.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaMapChangeKey(
      accountIdKey: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'account_id_key',
        parse:
            (v) => proto_basic_types.HederaAccountID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      tokenRelationshipKey: json
          .valueTo<proto_basic_types.HederaTokenAssociation?, Object>(
            key: 'token_relationship_key',
            parse:
                (v) => proto_basic_types.HederaTokenAssociation.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      entityNumberKey: json
          .valueTo<google_protobuf_wrappers.HederaUInt64Value?, Object>(
            key: 'entity_number_key',
            parse:
                (v) => google_protobuf_wrappers.HederaUInt64Value.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      fileIdKey: json.valueTo<proto_basic_types.HederaFileID?, Object>(
        key: 'file_id_key',
        parse:
            (v) => proto_basic_types.HederaFileID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      nftIdKey: json.valueTo<proto_basic_types.HederaNftID?, Object>(
        key: 'nft_id_key',
        parse:
            (v) => proto_basic_types.HederaNftID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      protoBytesKey: json
          .valueTo<google_protobuf_wrappers.HederaBytesValue?, Object>(
            key: 'proto_bytes_key',
            parse:
                (v) => google_protobuf_wrappers.HederaBytesValue.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      protoLongKey: json
          .valueTo<google_protobuf_wrappers.HederaInt64Value?, Object>(
            key: 'proto_long_key',
            parse:
                (v) => google_protobuf_wrappers.HederaInt64Value.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      protoStringKey: json
          .valueTo<google_protobuf_wrappers.HederaStringValue?, Object>(
            key: 'proto_string_key',
            parse:
                (v) => google_protobuf_wrappers.HederaStringValue.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      scheduleIdKey: json.valueTo<proto_basic_types.HederaScheduleID?, Object>(
        key: 'schedule_id_key',
        parse:
            (v) => proto_basic_types.HederaScheduleID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      slotKeyKey: json.valueTo<proto_storage_slot.HederaSlotKey?, Object>(
        key: 'slot_key_key',
        parse:
            (v) => proto_storage_slot.HederaSlotKey.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      tokenIdKey: json.valueTo<proto_basic_types.HederaTokenID?, Object>(
        key: 'token_id_key',
        parse:
            (v) => proto_basic_types.HederaTokenID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      topicIdKey: json.valueTo<proto_basic_types.HederaTopicID?, Object>(
        key: 'topic_id_key',
        parse:
            (v) => proto_basic_types.HederaTopicID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      contractIdKey: json.valueTo<proto_basic_types.HederaContractID?, Object>(
        key: 'contract_id_key',
        parse:
            (v) => proto_basic_types.HederaContractID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      pendingAirdropIdKey: json
          .valueTo<proto_basic_types.HederaPendingAirdropId?, Object>(
            key: 'pending_airdrop_id_key',
            parse:
                (v) => proto_basic_types.HederaPendingAirdropId.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      timestampSecondsKey: json
          .valueTo<proto_timestamp.HederaTimestampSeconds?, Object>(
            key: 'timestamp_seconds_key',
            parse:
                (v) => proto_timestamp.HederaTimestampSeconds.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      scheduledOrderKey: json
          .valueTo<proto_schedule.HederaScheduledOrder?, Object>(
            key: 'scheduled_order_key',
            parse:
                (v) => proto_schedule.HederaScheduledOrder.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      tssMessageMapKey: json.valueTo<
        com_hedera_hapi_node_state_tss_tss_message_map_key.HederaTssMessageMapKey?,
        Object
      >(
        key: 'tss_message_map_key',
        parse:
            (v) => com_hedera_hapi_node_state_tss_tss_message_map_key
                .HederaTssMessageMapKey.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      tssVoteMapKey: json.valueTo<
        com_hedera_hapi_node_state_tss_tss_vote_map_key.HederaTssVoteMapKey?,
        Object
      >(
        key: 'tss_vote_map_key',
        parse:
            (v) => com_hedera_hapi_node_state_tss_tss_vote_map_key
                .HederaTssVoteMapKey.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      hintsPartyIdKey: json.valueTo<
        com_hedera_hapi_node_state_hints_hints_types.HederaHintsPartyId?,
        Object
      >(
        key: 'hints_party_id_key',
        parse:
            (v) => com_hedera_hapi_node_state_hints_hints_types
                .HederaHintsPartyId.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      preprocessingVoteIdKey: json.valueTo<
        com_hedera_hapi_node_state_hints_hints_types.HederaPreprocessingVoteId?,
        Object
      >(
        key: 'preprocessing_vote_id_key',
        parse:
            (v) => com_hedera_hapi_node_state_hints_hints_types
                .HederaPreprocessingVoteId.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      nodeIdKey: json.valueTo<
        com_hedera_hapi_platform_state_platform_state.HederaNodeId?,
        Object
      >(
        key: 'node_id_key',
        parse:
            (v) => com_hedera_hapi_platform_state_platform_state
                .HederaNodeId.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      constructionNodeIdKey: json.valueTo<
        com_hedera_hapi_node_state_history_history_types.HederaConstructionNodeId?,
        Object
      >(
        key: 'construction_node_id_key',
        parse:
            (v) => com_hedera_hapi_node_state_history_history_types
                .HederaConstructionNodeId.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaMapChangeKey.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaMapChangeKey(
      accountIdKey: decode.messageTo<proto_basic_types.HederaAccountID?>(
        1,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
      tokenRelationshipKey: decode
          .messageTo<proto_basic_types.HederaTokenAssociation?>(
            2,
            (b) => proto_basic_types.HederaTokenAssociation.deserialize(b),
          ),
      entityNumberKey: decode
          .messageTo<google_protobuf_wrappers.HederaUInt64Value?>(
            3,
            (b) => google_protobuf_wrappers.HederaUInt64Value.deserialize(b),
          ),
      fileIdKey: decode.messageTo<proto_basic_types.HederaFileID?>(
        4,
        (b) => proto_basic_types.HederaFileID.deserialize(b),
      ),
      nftIdKey: decode.messageTo<proto_basic_types.HederaNftID?>(
        5,
        (b) => proto_basic_types.HederaNftID.deserialize(b),
      ),
      protoBytesKey: decode
          .messageTo<google_protobuf_wrappers.HederaBytesValue?>(
            6,
            (b) => google_protobuf_wrappers.HederaBytesValue.deserialize(b),
          ),
      protoLongKey: decode
          .messageTo<google_protobuf_wrappers.HederaInt64Value?>(
            7,
            (b) => google_protobuf_wrappers.HederaInt64Value.deserialize(b),
          ),
      protoStringKey: decode
          .messageTo<google_protobuf_wrappers.HederaStringValue?>(
            8,
            (b) => google_protobuf_wrappers.HederaStringValue.deserialize(b),
          ),
      scheduleIdKey: decode.messageTo<proto_basic_types.HederaScheduleID?>(
        9,
        (b) => proto_basic_types.HederaScheduleID.deserialize(b),
      ),
      slotKeyKey: decode.messageTo<proto_storage_slot.HederaSlotKey?>(
        10,
        (b) => proto_storage_slot.HederaSlotKey.deserialize(b),
      ),
      tokenIdKey: decode.messageTo<proto_basic_types.HederaTokenID?>(
        11,
        (b) => proto_basic_types.HederaTokenID.deserialize(b),
      ),
      topicIdKey: decode.messageTo<proto_basic_types.HederaTopicID?>(
        12,
        (b) => proto_basic_types.HederaTopicID.deserialize(b),
      ),
      contractIdKey: decode.messageTo<proto_basic_types.HederaContractID?>(
        13,
        (b) => proto_basic_types.HederaContractID.deserialize(b),
      ),
      pendingAirdropIdKey: decode
          .messageTo<proto_basic_types.HederaPendingAirdropId?>(
            14,
            (b) => proto_basic_types.HederaPendingAirdropId.deserialize(b),
          ),
      timestampSecondsKey: decode
          .messageTo<proto_timestamp.HederaTimestampSeconds?>(
            15,
            (b) => proto_timestamp.HederaTimestampSeconds.deserialize(b),
          ),
      scheduledOrderKey: decode.messageTo<proto_schedule.HederaScheduledOrder?>(
        16,
        (b) => proto_schedule.HederaScheduledOrder.deserialize(b),
      ),
      tssMessageMapKey: decode.messageTo<
        com_hedera_hapi_node_state_tss_tss_message_map_key.HederaTssMessageMapKey?
      >(
        17,
        (b) => com_hedera_hapi_node_state_tss_tss_message_map_key
            .HederaTssMessageMapKey.deserialize(b),
      ),
      tssVoteMapKey: decode.messageTo<
        com_hedera_hapi_node_state_tss_tss_vote_map_key.HederaTssVoteMapKey?
      >(
        18,
        (b) => com_hedera_hapi_node_state_tss_tss_vote_map_key
            .HederaTssVoteMapKey.deserialize(b),
      ),
      hintsPartyIdKey: decode.messageTo<
        com_hedera_hapi_node_state_hints_hints_types.HederaHintsPartyId?
      >(
        19,
        (b) => com_hedera_hapi_node_state_hints_hints_types
            .HederaHintsPartyId.deserialize(b),
      ),
      preprocessingVoteIdKey: decode.messageTo<
        com_hedera_hapi_node_state_hints_hints_types.HederaPreprocessingVoteId?
      >(
        20,
        (b) => com_hedera_hapi_node_state_hints_hints_types
            .HederaPreprocessingVoteId.deserialize(b),
      ),
      nodeIdKey: decode.messageTo<
        com_hedera_hapi_platform_state_platform_state.HederaNodeId?
      >(
        21,
        (b) => com_hedera_hapi_platform_state_platform_state
            .HederaNodeId.deserialize(b),
      ),
      constructionNodeIdKey: decode.messageTo<
        com_hedera_hapi_node_state_history_history_types.HederaConstructionNodeId?
      >(
        22,
        (b) => com_hedera_hapi_node_state_history_history_types
            .HederaConstructionNodeId.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiBlockStreamOutputMapChangeKey;
}

/// *
///  * A value updated in, or added to, a virtual map.
///  *
class HederaMapChangeValue extends HederaProtoMessage with Equality {
  /// *
  ///          * An account value.
  final proto_account.HederaAccount? accountValue;

  /// *
  ///          * An account identifier.&lt;br/&gt;
  ///          * In some cases a map is used to connect a value or identifier
  ///          * to another identifier.
  final proto_basic_types.HederaAccountID? accountIdValue;

  /// *
  ///          * Compiled EVM bytecode.
  final proto_bytecode.HederaBytecode? bytecodeValue;

  /// *
  ///          * An Hedera "file" value.
  ///          * &lt;p&gt;
  ///          * &lt;blockquote&gt;REVIEW NOTE&lt;blockquote&gt;
  ///          * A file can become quite large (up to 1048576 bytes).&lt;br/&gt;
  ///          * Do we want to structure file changes separately?&lt;br/&gt;
  ///          * Perhaps a file metadata update and a separate byte array for
  ///          * just the bytes appended (or initial bytes on create). We only
  ///          * allow create/append/delete, so the separate byte array would work
  ///          * and keep the size below 6K per state change.
  ///          * &lt;/blockquote&gt;&lt;/blockquote&gt;
  final proto_file.HederaFile? fileValue;

  /// *
  ///          * A non-fungible/unique token value.
  final proto_nft.HederaNft? nftValue;

  /// *
  ///          * A string value.
  final google_protobuf_wrappers.HederaStringValue? protoStringValue;

  /// *
  ///          * A scheduled transaction value.
  final proto_schedule.HederaSchedule? scheduleValue;

  /// *
  ///          * A list of scheduled transactions.&lt;br/&gt;
  ///          * An example for this value is the map of consensus second to
  ///          * scheduled transactions that expire at that consensus time.
  final proto_schedule.HederaScheduleList? scheduleListValue;

  /// *
  ///          * An EVM storage slot value.
  final proto_storage_slot.HederaSlotValue? slotValueValue;

  /// *
  ///          * An updated set of staking information for all nodes in
  ///          * the address book.
  final proto_staking_node_info.HederaStakingNodeInfo? stakingNodeInfoValue;

  /// *
  ///          * An HTS token value.
  final proto_token.HederaToken? tokenValue;

  /// *
  ///          * A token relationship value.&lt;br/&gt;
  ///          * These values track which accounts are willing to transact
  ///          * in specific HTS tokens.
  final proto_token_relation.HederaTokenRelation? tokenRelationValue;

  /// *
  ///          * An HCS topic value.
  final proto_topic.HederaTopic? topicValue;

  /// *
  ///          * An network node value.
  final com_hedera_hapi_node_state_addressbook_node.HederaNode? nodeValue;

  /// *
  ///          * A pending airdrop value.
  final proto_account_pending_airdrop.HederaAccountPendingAirdrop?
  accountPendingAirdropValue;

  /// *
  ///          * A roster value.
  final com_hedera_hapi_node_state_roster_roster.HederaRoster? rosterValue;

  /// *
  ///          * The value of a map summarizing the counts of scheduled and processed transactions
  ///          * within a particular consensus second.
  final proto_schedule.HederaScheduledCounts? scheduledCountsValue;

  /// *
  ///          * A scheduled id value.
  final proto_basic_types.HederaScheduleID? scheduleIdValue;

  /// *
  ///          * A change to the scheduled throttle usage snapshots.
  final proto_throttle_usage_snapshots.HederaThrottleUsageSnapshots?
  throttleUsageSnapshotsValue;

  /// *
  ///          * The value of a map that stores tss encryption keys for each node.
  final com_hedera_hapi_node_state_tss_tss_encryption_keys.HederaTssEncryptionKeys?
  tssEncryptionKeysValue;

  /// *
  ///          * The value of a map that stores tss messages submitted for each share of nodes.
  final com_hedera_hapi_services_auxiliary_tss_tss_message.HederaTssMessageTransactionBody?
  tssMessageValue;

  /// *
  ///          * The value of a map that stores tss votes submitted by each node to recover the ledger id.
  final com_hedera_hapi_services_auxiliary_tss_tss_vote.HederaTssVoteTransactionBody?
  tssVoteValue;

  /// *
  ///          * A hinTS key set.
  final com_hedera_hapi_node_state_hints_hints_types.HederaHintsKeySet?
  hintsKeySetValue;

  /// *
  ///          * A hinTS preprocessing vote.
  final com_hedera_hapi_node_state_hints_hints_types.HederaPreprocessingVote?
  preprocessingVoteValue;

  /// *
  ///          * A CRS publication submission.
  final com_hedera_hapi_services_auxiliary_hints_crs_publication.HederaCrsPublicationTransactionBody?
  crsPublicationValue;

  /// *
  ///          * A history signature.
  final com_hedera_hapi_node_state_history_history_types.HederaRecordedHistorySignature?
  historySignatureValue;

  /// *
  ///          * A history proof vote.
  final com_hedera_hapi_node_state_history_history_types.HederaHistoryProofVote?
  historyProofVoteValue;

  /// *
  ///          * A proof key set.
  final com_hedera_hapi_node_state_history_history_types.HederaProofKeySet?
  proofKeySetValue;

  const HederaMapChangeValue({
    this.accountValue,
    this.accountIdValue,
    this.bytecodeValue,
    this.fileValue,
    this.nftValue,
    this.protoStringValue,
    this.scheduleValue,
    this.scheduleListValue,
    this.slotValueValue,
    this.stakingNodeInfoValue,
    this.tokenValue,
    this.tokenRelationValue,
    this.topicValue,
    this.nodeValue,
    this.accountPendingAirdropValue,
    this.rosterValue,
    this.scheduledCountsValue,
    this.scheduleIdValue,
    this.throttleUsageSnapshotsValue,
    this.tssEncryptionKeysValue,
    this.tssMessageValue,
    this.tssVoteValue,
    this.hintsKeySetValue,
    this.preprocessingVoteValue,
    this.crsPublicationValue,
    this.historySignatureValue,
    this.historyProofVoteValue,
    this.proofKeySetValue,
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
        ProtoFieldConfig.message(18),
        ProtoFieldConfig.message(19),
        ProtoFieldConfig.message(20),
        ProtoFieldConfig.message(21),
        ProtoFieldConfig.message(22),
        ProtoFieldConfig.message(23),
        ProtoFieldConfig.message(24),
        ProtoFieldConfig.message(25),
        ProtoFieldConfig.message(26),
        ProtoFieldConfig.message(27),
        ProtoFieldConfig.message(28),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    accountValue,
    accountIdValue,
    bytecodeValue,
    fileValue,
    nftValue,
    protoStringValue,
    scheduleValue,
    scheduleListValue,
    slotValueValue,
    stakingNodeInfoValue,
    tokenValue,
    tokenRelationValue,
    topicValue,
    nodeValue,
    accountPendingAirdropValue,
    rosterValue,
    scheduledCountsValue,
    scheduleIdValue,
    throttleUsageSnapshotsValue,
    tssEncryptionKeysValue,
    tssMessageValue,
    tssVoteValue,
    hintsKeySetValue,
    preprocessingVoteValue,
    crsPublicationValue,
    historySignatureValue,
    historyProofVoteValue,
    proofKeySetValue,
  ];

  HederaMapChangeValue copyWith({
    proto_account.HederaAccount? accountValue,

    proto_basic_types.HederaAccountID? accountIdValue,

    proto_bytecode.HederaBytecode? bytecodeValue,

    proto_file.HederaFile? fileValue,

    proto_nft.HederaNft? nftValue,

    google_protobuf_wrappers.HederaStringValue? protoStringValue,

    proto_schedule.HederaSchedule? scheduleValue,

    proto_schedule.HederaScheduleList? scheduleListValue,

    proto_storage_slot.HederaSlotValue? slotValueValue,

    proto_staking_node_info.HederaStakingNodeInfo? stakingNodeInfoValue,

    proto_token.HederaToken? tokenValue,

    proto_token_relation.HederaTokenRelation? tokenRelationValue,

    proto_topic.HederaTopic? topicValue,

    com_hedera_hapi_node_state_addressbook_node.HederaNode? nodeValue,

    proto_account_pending_airdrop.HederaAccountPendingAirdrop?
    accountPendingAirdropValue,

    com_hedera_hapi_node_state_roster_roster.HederaRoster? rosterValue,

    proto_schedule.HederaScheduledCounts? scheduledCountsValue,

    proto_basic_types.HederaScheduleID? scheduleIdValue,

    proto_throttle_usage_snapshots.HederaThrottleUsageSnapshots?
    throttleUsageSnapshotsValue,

    com_hedera_hapi_node_state_tss_tss_encryption_keys.HederaTssEncryptionKeys?
    tssEncryptionKeysValue,

    com_hedera_hapi_services_auxiliary_tss_tss_message.HederaTssMessageTransactionBody?
    tssMessageValue,

    com_hedera_hapi_services_auxiliary_tss_tss_vote.HederaTssVoteTransactionBody?
    tssVoteValue,

    com_hedera_hapi_node_state_hints_hints_types.HederaHintsKeySet?
    hintsKeySetValue,

    com_hedera_hapi_node_state_hints_hints_types.HederaPreprocessingVote?
    preprocessingVoteValue,

    com_hedera_hapi_services_auxiliary_hints_crs_publication.HederaCrsPublicationTransactionBody?
    crsPublicationValue,

    com_hedera_hapi_node_state_history_history_types.HederaRecordedHistorySignature?
    historySignatureValue,

    com_hedera_hapi_node_state_history_history_types.HederaHistoryProofVote?
    historyProofVoteValue,

    com_hedera_hapi_node_state_history_history_types.HederaProofKeySet?
    proofKeySetValue,
  }) {
    return HederaMapChangeValue(
      accountValue: accountValue ?? this.accountValue,
      accountIdValue: accountIdValue ?? this.accountIdValue,
      bytecodeValue: bytecodeValue ?? this.bytecodeValue,
      fileValue: fileValue ?? this.fileValue,
      nftValue: nftValue ?? this.nftValue,
      protoStringValue: protoStringValue ?? this.protoStringValue,
      scheduleValue: scheduleValue ?? this.scheduleValue,
      scheduleListValue: scheduleListValue ?? this.scheduleListValue,
      slotValueValue: slotValueValue ?? this.slotValueValue,
      stakingNodeInfoValue: stakingNodeInfoValue ?? this.stakingNodeInfoValue,
      tokenValue: tokenValue ?? this.tokenValue,
      tokenRelationValue: tokenRelationValue ?? this.tokenRelationValue,
      topicValue: topicValue ?? this.topicValue,
      nodeValue: nodeValue ?? this.nodeValue,
      accountPendingAirdropValue:
          accountPendingAirdropValue ?? this.accountPendingAirdropValue,
      rosterValue: rosterValue ?? this.rosterValue,
      scheduledCountsValue: scheduledCountsValue ?? this.scheduledCountsValue,
      scheduleIdValue: scheduleIdValue ?? this.scheduleIdValue,
      throttleUsageSnapshotsValue:
          throttleUsageSnapshotsValue ?? this.throttleUsageSnapshotsValue,
      tssEncryptionKeysValue:
          tssEncryptionKeysValue ?? this.tssEncryptionKeysValue,
      tssMessageValue: tssMessageValue ?? this.tssMessageValue,
      tssVoteValue: tssVoteValue ?? this.tssVoteValue,
      hintsKeySetValue: hintsKeySetValue ?? this.hintsKeySetValue,
      preprocessingVoteValue:
          preprocessingVoteValue ?? this.preprocessingVoteValue,
      crsPublicationValue: crsPublicationValue ?? this.crsPublicationValue,
      historySignatureValue:
          historySignatureValue ?? this.historySignatureValue,
      historyProofVoteValue:
          historyProofVoteValue ?? this.historyProofVoteValue,
      proofKeySetValue: proofKeySetValue ?? this.proofKeySetValue,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'account_value': config.encodeMessage(accountValue),
      'account_id_value': config.encodeMessage(accountIdValue),
      'bytecode_value': config.encodeMessage(bytecodeValue),
      'file_value': config.encodeMessage(fileValue),
      'nft_value': config.encodeMessage(nftValue),
      'proto_string_value': config.encodeMessage(protoStringValue),
      'schedule_value': config.encodeMessage(scheduleValue),
      'schedule_list_value': config.encodeMessage(scheduleListValue),
      'slot_value_value': config.encodeMessage(slotValueValue),
      'staking_node_info_value': config.encodeMessage(stakingNodeInfoValue),
      'token_value': config.encodeMessage(tokenValue),
      'token_relation_value': config.encodeMessage(tokenRelationValue),
      'topic_value': config.encodeMessage(topicValue),
      'node_value': config.encodeMessage(nodeValue),
      'account_pending_airdrop_value': config.encodeMessage(
        accountPendingAirdropValue,
      ),
      'roster_value': config.encodeMessage(rosterValue),
      'scheduled_counts_value': config.encodeMessage(scheduledCountsValue),
      'schedule_id_value': config.encodeMessage(scheduleIdValue),
      'throttle_usage_snapshots_value': config.encodeMessage(
        throttleUsageSnapshotsValue,
      ),
      'tss_encryption_keys_value': config.encodeMessage(tssEncryptionKeysValue),
      'tss_message_value': config.encodeMessage(tssMessageValue),
      'tss_vote_value': config.encodeMessage(tssVoteValue),
      'hints_key_set_value': config.encodeMessage(hintsKeySetValue),
      'preprocessing_vote_value': config.encodeMessage(preprocessingVoteValue),
      'crs_publication_value': config.encodeMessage(crsPublicationValue),
      'history_signature_value': config.encodeMessage(historySignatureValue),
      'history_proof_vote_value': config.encodeMessage(historyProofVoteValue),
      'proof_key_set_value': config.encodeMessage(proofKeySetValue),
    };
  }

  factory HederaMapChangeValue.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaMapChangeValue(
      accountValue: json.valueTo<proto_account.HederaAccount?, Object>(
        key: 'account_value',
        parse:
            (v) => proto_account.HederaAccount.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      accountIdValue: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'account_id_value',
        parse:
            (v) => proto_basic_types.HederaAccountID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      bytecodeValue: json.valueTo<proto_bytecode.HederaBytecode?, Object>(
        key: 'bytecode_value',
        parse:
            (v) => proto_bytecode.HederaBytecode.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      fileValue: json.valueTo<proto_file.HederaFile?, Object>(
        key: 'file_value',
        parse:
            (v) => proto_file.HederaFile.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      nftValue: json.valueTo<proto_nft.HederaNft?, Object>(
        key: 'nft_value',
        parse:
            (v) => proto_nft.HederaNft.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      protoStringValue: json
          .valueTo<google_protobuf_wrappers.HederaStringValue?, Object>(
            key: 'proto_string_value',
            parse:
                (v) => google_protobuf_wrappers.HederaStringValue.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      scheduleValue: json.valueTo<proto_schedule.HederaSchedule?, Object>(
        key: 'schedule_value',
        parse:
            (v) => proto_schedule.HederaSchedule.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      scheduleListValue: json
          .valueTo<proto_schedule.HederaScheduleList?, Object>(
            key: 'schedule_list_value',
            parse:
                (v) => proto_schedule.HederaScheduleList.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      slotValueValue: json.valueTo<proto_storage_slot.HederaSlotValue?, Object>(
        key: 'slot_value_value',
        parse:
            (v) => proto_storage_slot.HederaSlotValue.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      stakingNodeInfoValue: json
          .valueTo<proto_staking_node_info.HederaStakingNodeInfo?, Object>(
            key: 'staking_node_info_value',
            parse:
                (v) => proto_staking_node_info.HederaStakingNodeInfo.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      tokenValue: json.valueTo<proto_token.HederaToken?, Object>(
        key: 'token_value',
        parse:
            (v) => proto_token.HederaToken.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      tokenRelationValue: json
          .valueTo<proto_token_relation.HederaTokenRelation?, Object>(
            key: 'token_relation_value',
            parse:
                (v) => proto_token_relation.HederaTokenRelation.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      topicValue: json.valueTo<proto_topic.HederaTopic?, Object>(
        key: 'topic_value',
        parse:
            (v) => proto_topic.HederaTopic.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      nodeValue: json.valueTo<
        com_hedera_hapi_node_state_addressbook_node.HederaNode?,
        Object
      >(
        key: 'node_value',
        parse:
            (v) => com_hedera_hapi_node_state_addressbook_node
                .HederaNode.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      accountPendingAirdropValue: json.valueTo<
        proto_account_pending_airdrop.HederaAccountPendingAirdrop?,
        Object
      >(
        key: 'account_pending_airdrop_value',
        parse:
            (v) => proto_account_pending_airdrop
                .HederaAccountPendingAirdrop.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      rosterValue: json.valueTo<
        com_hedera_hapi_node_state_roster_roster.HederaRoster?,
        Object
      >(
        key: 'roster_value',
        parse:
            (v) => com_hedera_hapi_node_state_roster_roster
                .HederaRoster.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      scheduledCountsValue: json
          .valueTo<proto_schedule.HederaScheduledCounts?, Object>(
            key: 'scheduled_counts_value',
            parse:
                (v) => proto_schedule.HederaScheduledCounts.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      scheduleIdValue: json
          .valueTo<proto_basic_types.HederaScheduleID?, Object>(
            key: 'schedule_id_value',
            parse:
                (v) => proto_basic_types.HederaScheduleID.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      throttleUsageSnapshotsValue: json.valueTo<
        proto_throttle_usage_snapshots.HederaThrottleUsageSnapshots?,
        Object
      >(
        key: 'throttle_usage_snapshots_value',
        parse:
            (v) => proto_throttle_usage_snapshots
                .HederaThrottleUsageSnapshots.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      tssEncryptionKeysValue: json.valueTo<
        com_hedera_hapi_node_state_tss_tss_encryption_keys.HederaTssEncryptionKeys?,
        Object
      >(
        key: 'tss_encryption_keys_value',
        parse:
            (v) => com_hedera_hapi_node_state_tss_tss_encryption_keys
                .HederaTssEncryptionKeys.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      tssMessageValue: json.valueTo<
        com_hedera_hapi_services_auxiliary_tss_tss_message.HederaTssMessageTransactionBody?,
        Object
      >(
        key: 'tss_message_value',
        parse:
            (v) => com_hedera_hapi_services_auxiliary_tss_tss_message
                .HederaTssMessageTransactionBody.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      tssVoteValue: json.valueTo<
        com_hedera_hapi_services_auxiliary_tss_tss_vote.HederaTssVoteTransactionBody?,
        Object
      >(
        key: 'tss_vote_value',
        parse:
            (v) => com_hedera_hapi_services_auxiliary_tss_tss_vote
                .HederaTssVoteTransactionBody.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      hintsKeySetValue: json.valueTo<
        com_hedera_hapi_node_state_hints_hints_types.HederaHintsKeySet?,
        Object
      >(
        key: 'hints_key_set_value',
        parse:
            (v) => com_hedera_hapi_node_state_hints_hints_types
                .HederaHintsKeySet.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      preprocessingVoteValue: json.valueTo<
        com_hedera_hapi_node_state_hints_hints_types.HederaPreprocessingVote?,
        Object
      >(
        key: 'preprocessing_vote_value',
        parse:
            (v) => com_hedera_hapi_node_state_hints_hints_types
                .HederaPreprocessingVote.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      crsPublicationValue: json.valueTo<
        com_hedera_hapi_services_auxiliary_hints_crs_publication.HederaCrsPublicationTransactionBody?,
        Object
      >(
        key: 'crs_publication_value',
        parse:
            (v) => com_hedera_hapi_services_auxiliary_hints_crs_publication
                .HederaCrsPublicationTransactionBody.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      historySignatureValue: json.valueTo<
        com_hedera_hapi_node_state_history_history_types.HederaRecordedHistorySignature?,
        Object
      >(
        key: 'history_signature_value',
        parse:
            (v) => com_hedera_hapi_node_state_history_history_types
                .HederaRecordedHistorySignature.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      historyProofVoteValue: json.valueTo<
        com_hedera_hapi_node_state_history_history_types.HederaHistoryProofVote?,
        Object
      >(
        key: 'history_proof_vote_value',
        parse:
            (v) => com_hedera_hapi_node_state_history_history_types
                .HederaHistoryProofVote.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      proofKeySetValue: json.valueTo<
        com_hedera_hapi_node_state_history_history_types.HederaProofKeySet?,
        Object
      >(
        key: 'proof_key_set_value',
        parse:
            (v) => com_hedera_hapi_node_state_history_history_types
                .HederaProofKeySet.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaMapChangeValue.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaMapChangeValue(
      accountValue: decode.messageTo<proto_account.HederaAccount?>(
        1,
        (b) => proto_account.HederaAccount.deserialize(b),
      ),
      accountIdValue: decode.messageTo<proto_basic_types.HederaAccountID?>(
        2,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
      bytecodeValue: decode.messageTo<proto_bytecode.HederaBytecode?>(
        3,
        (b) => proto_bytecode.HederaBytecode.deserialize(b),
      ),
      fileValue: decode.messageTo<proto_file.HederaFile?>(
        4,
        (b) => proto_file.HederaFile.deserialize(b),
      ),
      nftValue: decode.messageTo<proto_nft.HederaNft?>(
        5,
        (b) => proto_nft.HederaNft.deserialize(b),
      ),
      protoStringValue: decode
          .messageTo<google_protobuf_wrappers.HederaStringValue?>(
            6,
            (b) => google_protobuf_wrappers.HederaStringValue.deserialize(b),
          ),
      scheduleValue: decode.messageTo<proto_schedule.HederaSchedule?>(
        7,
        (b) => proto_schedule.HederaSchedule.deserialize(b),
      ),
      scheduleListValue: decode.messageTo<proto_schedule.HederaScheduleList?>(
        8,
        (b) => proto_schedule.HederaScheduleList.deserialize(b),
      ),
      slotValueValue: decode.messageTo<proto_storage_slot.HederaSlotValue?>(
        9,
        (b) => proto_storage_slot.HederaSlotValue.deserialize(b),
      ),
      stakingNodeInfoValue: decode
          .messageTo<proto_staking_node_info.HederaStakingNodeInfo?>(
            10,
            (b) => proto_staking_node_info.HederaStakingNodeInfo.deserialize(b),
          ),
      tokenValue: decode.messageTo<proto_token.HederaToken?>(
        11,
        (b) => proto_token.HederaToken.deserialize(b),
      ),
      tokenRelationValue: decode
          .messageTo<proto_token_relation.HederaTokenRelation?>(
            12,
            (b) => proto_token_relation.HederaTokenRelation.deserialize(b),
          ),
      topicValue: decode.messageTo<proto_topic.HederaTopic?>(
        13,
        (b) => proto_topic.HederaTopic.deserialize(b),
      ),
      nodeValue: decode
          .messageTo<com_hedera_hapi_node_state_addressbook_node.HederaNode?>(
            14,
            (b) => com_hedera_hapi_node_state_addressbook_node
                .HederaNode.deserialize(b),
          ),
      accountPendingAirdropValue: decode.messageTo<
        proto_account_pending_airdrop.HederaAccountPendingAirdrop?
      >(
        15,
        (b) => proto_account_pending_airdrop
            .HederaAccountPendingAirdrop.deserialize(b),
      ),
      rosterValue: decode
          .messageTo<com_hedera_hapi_node_state_roster_roster.HederaRoster?>(
            16,
            (b) => com_hedera_hapi_node_state_roster_roster
                .HederaRoster.deserialize(b),
          ),
      scheduledCountsValue: decode
          .messageTo<proto_schedule.HederaScheduledCounts?>(
            17,
            (b) => proto_schedule.HederaScheduledCounts.deserialize(b),
          ),
      scheduleIdValue: decode.messageTo<proto_basic_types.HederaScheduleID?>(
        18,
        (b) => proto_basic_types.HederaScheduleID.deserialize(b),
      ),
      throttleUsageSnapshotsValue: decode.messageTo<
        proto_throttle_usage_snapshots.HederaThrottleUsageSnapshots?
      >(
        19,
        (b) => proto_throttle_usage_snapshots
            .HederaThrottleUsageSnapshots.deserialize(b),
      ),
      tssEncryptionKeysValue: decode.messageTo<
        com_hedera_hapi_node_state_tss_tss_encryption_keys.HederaTssEncryptionKeys?
      >(
        20,
        (b) => com_hedera_hapi_node_state_tss_tss_encryption_keys
            .HederaTssEncryptionKeys.deserialize(b),
      ),
      tssMessageValue: decode.messageTo<
        com_hedera_hapi_services_auxiliary_tss_tss_message.HederaTssMessageTransactionBody?
      >(
        21,
        (b) => com_hedera_hapi_services_auxiliary_tss_tss_message
            .HederaTssMessageTransactionBody.deserialize(b),
      ),
      tssVoteValue: decode.messageTo<
        com_hedera_hapi_services_auxiliary_tss_tss_vote.HederaTssVoteTransactionBody?
      >(
        22,
        (b) => com_hedera_hapi_services_auxiliary_tss_tss_vote
            .HederaTssVoteTransactionBody.deserialize(b),
      ),
      hintsKeySetValue: decode.messageTo<
        com_hedera_hapi_node_state_hints_hints_types.HederaHintsKeySet?
      >(
        23,
        (b) => com_hedera_hapi_node_state_hints_hints_types
            .HederaHintsKeySet.deserialize(b),
      ),
      preprocessingVoteValue: decode.messageTo<
        com_hedera_hapi_node_state_hints_hints_types.HederaPreprocessingVote?
      >(
        24,
        (b) => com_hedera_hapi_node_state_hints_hints_types
            .HederaPreprocessingVote.deserialize(b),
      ),
      crsPublicationValue: decode.messageTo<
        com_hedera_hapi_services_auxiliary_hints_crs_publication.HederaCrsPublicationTransactionBody?
      >(
        25,
        (b) => com_hedera_hapi_services_auxiliary_hints_crs_publication
            .HederaCrsPublicationTransactionBody.deserialize(b),
      ),
      historySignatureValue: decode.messageTo<
        com_hedera_hapi_node_state_history_history_types.HederaRecordedHistorySignature?
      >(
        26,
        (b) => com_hedera_hapi_node_state_history_history_types
            .HederaRecordedHistorySignature.deserialize(b),
      ),
      historyProofVoteValue: decode.messageTo<
        com_hedera_hapi_node_state_history_history_types.HederaHistoryProofVote?
      >(
        27,
        (b) => com_hedera_hapi_node_state_history_history_types
            .HederaHistoryProofVote.deserialize(b),
      ),
      proofKeySetValue: decode.messageTo<
        com_hedera_hapi_node_state_history_history_types.HederaProofKeySet?
      >(
        28,
        (b) => com_hedera_hapi_node_state_history_history_types
            .HederaProofKeySet.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiBlockStreamOutputMapChangeValue;
}

/// *
///  * Addition of an item to a `Queue` state.&lt;br/&gt;
///  *
///  * The new item SHALL be added after the current "last" element in the
///  * queue.&lt;br/&gt;
///  * The new item MUST be the same type of value as all other items in the queue.
class HederaQueuePushChange extends HederaProtoMessage with Equality {
  /// *
  ///          * A byte array added to the queue state.
  final google_protobuf_wrappers.HederaBytesValue? protoBytesElement;

  /// *
  ///          * A string added to the queue state.
  final google_protobuf_wrappers.HederaStringValue? protoStringElement;

  /// *
  ///          * All transaction receipts for a round added to queue state.
  final proto_recordcache.HederaTransactionReceiptEntries?
  transactionReceiptEntriesElement;

  const HederaQueuePushChange({
    this.protoBytesElement,
    this.protoStringElement,
    this.transactionReceiptEntriesElement,
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
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    protoBytesElement,
    protoStringElement,
    transactionReceiptEntriesElement,
  ];

  HederaQueuePushChange copyWith({
    google_protobuf_wrappers.HederaBytesValue? protoBytesElement,

    google_protobuf_wrappers.HederaStringValue? protoStringElement,

    proto_recordcache.HederaTransactionReceiptEntries?
    transactionReceiptEntriesElement,
  }) {
    return HederaQueuePushChange(
      protoBytesElement: protoBytesElement ?? this.protoBytesElement,
      protoStringElement: protoStringElement ?? this.protoStringElement,
      transactionReceiptEntriesElement:
          transactionReceiptEntriesElement ??
          this.transactionReceiptEntriesElement,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'proto_bytes_element': config.encodeMessage(protoBytesElement),
      'proto_string_element': config.encodeMessage(protoStringElement),
      'transaction_receipt_entries_element': config.encodeMessage(
        transactionReceiptEntriesElement,
      ),
    };
  }

  factory HederaQueuePushChange.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaQueuePushChange(
      protoBytesElement: json
          .valueTo<google_protobuf_wrappers.HederaBytesValue?, Object>(
            key: 'proto_bytes_element',
            parse:
                (v) => google_protobuf_wrappers.HederaBytesValue.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      protoStringElement: json
          .valueTo<google_protobuf_wrappers.HederaStringValue?, Object>(
            key: 'proto_string_element',
            parse:
                (v) => google_protobuf_wrappers.HederaStringValue.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      transactionReceiptEntriesElement: json
          .valueTo<proto_recordcache.HederaTransactionReceiptEntries?, Object>(
            key: 'transaction_receipt_entries_element',
            parse:
                (v) =>
                    proto_recordcache.HederaTransactionReceiptEntries.fromJson(
                      JsonParser.valueAs(v),
                      config: config,
                    ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
    );
  }

  factory HederaQueuePushChange.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaQueuePushChange(
      protoBytesElement: decode
          .messageTo<google_protobuf_wrappers.HederaBytesValue?>(
            1,
            (b) => google_protobuf_wrappers.HederaBytesValue.deserialize(b),
          ),
      protoStringElement: decode
          .messageTo<google_protobuf_wrappers.HederaStringValue?>(
            2,
            (b) => google_protobuf_wrappers.HederaStringValue.deserialize(b),
          ),
      transactionReceiptEntriesElement: decode.messageTo<
        proto_recordcache.HederaTransactionReceiptEntries?
      >(
        3,
        (b) => proto_recordcache.HederaTransactionReceiptEntries.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiBlockStreamOutputQueuePushChange;
}

/// *
///  * Removal of an item from a `Queue` state.&lt;br/&gt;
///  *
///  * The item removed SHALL be the current "front" (or "head") of the queue.&lt;br/&gt;
///  * Removing from a queue "head" does not, currently, require additional
///  * information beyond the state name common to all state changes.
class HederaQueuePopChange extends HederaProtoMessage with Equality {
  const HederaQueuePopChange();

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [],
    );
  }

  @override
  List<Object?> get protoValues => [];

  HederaQueuePopChange copyWith() {
    return HederaQueuePopChange();
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {};
  }

  factory HederaQueuePopChange.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaQueuePopChange();
  }

  factory HederaQueuePopChange.deserialize(List<int> bytes) {
    return HederaQueuePopChange();
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiBlockStreamOutputQueuePopChange;
}
