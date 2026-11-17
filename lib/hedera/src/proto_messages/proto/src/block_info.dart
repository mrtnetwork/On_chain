import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/platform/state/src/platform_state.dart" as com_hedera_hapi_platform_state_platform_state;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/services/auxiliary/blockrecords/src/migration_root_hash_vote.dart" as com_hedera_hapi_services_auxiliary_blockrecords_migration_root_hash_vote;
import "package:on_chain/hedera/src/proto_messages/proto/src/timestamp.dart" as proto_timestamp;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/node/state/blockrecords/src/migration_wrapped_hashes.dart" as com_hedera_hapi_node_state_blockrecords_migration_wrapped_hashes;

/// *
///  * # Block Info
///  * Information about the most recent block; including block hashes, current and
///  * previous start times, etc...
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in [RFC2119](https://www.ietf.org/rfc/rfc2119)
///  * and clarified in [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.state.blockrecords"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * A node vote for wrapped-record migration root-hash agreement.
class HederaNodeMigrationRootHashVote extends HederaProtoMessage with Equality {
    /// *
  ///      * The node submitting this vote.
  final com_hedera_hapi_platform_state_platform_state.HederaNodeId? nodeId;

    /// *
  ///      * The submitted vote body.
  final com_hedera_hapi_services_auxiliary_blockrecords_migration_root_hash_vote.HederaMigrationRootHashVoteTransactionBody? vote;

  const HederaNodeMigrationRootHashVote({
    this.nodeId,
    this.vote,
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
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        nodeId,
        vote,
      ];


HederaNodeMigrationRootHashVote copyWith(
{com_hedera_hapi_platform_state_platform_state.HederaNodeId? nodeId,

com_hedera_hapi_services_auxiliary_blockrecords_migration_root_hash_vote.HederaMigrationRootHashVoteTransactionBody? vote,

}) {
    return HederaNodeMigrationRootHashVote(
nodeId: nodeId ?? this.nodeId,
vote: vote ?? this.vote,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'node_id': config.encodeMessage(nodeId),
      'vote': config.encodeMessage(vote),
    };
  }


  factory HederaNodeMigrationRootHashVote.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaNodeMigrationRootHashVote(
      nodeId: json.valueTo<com_hedera_hapi_platform_state_platform_state.HederaNodeId?, Object>(
        key: 'node_id',
        parse: (v) => com_hedera_hapi_platform_state_platform_state.HederaNodeId.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      vote: json.valueTo<com_hedera_hapi_services_auxiliary_blockrecords_migration_root_hash_vote.HederaMigrationRootHashVoteTransactionBody?, Object>(
        key: 'vote',
        parse: (v) => com_hedera_hapi_services_auxiliary_blockrecords_migration_root_hash_vote.HederaMigrationRootHashVoteTransactionBody.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory HederaNodeMigrationRootHashVote.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaNodeMigrationRootHashVote(
      nodeId: decode.messageTo<com_hedera_hapi_platform_state_platform_state.HederaNodeId?>(1, (b) => com_hedera_hapi_platform_state_platform_state.HederaNodeId.deserialize(b)),
      vote: decode.messageTo<com_hedera_hapi_services_auxiliary_blockrecords_migration_root_hash_vote.HederaMigrationRootHashVoteTransactionBody?>(2, (b) => com_hedera_hapi_services_auxiliary_blockrecords_migration_root_hash_vote.HederaMigrationRootHashVoteTransactionBody.deserialize(b)),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoNodeMigrationRootHashVote;

}


/// *
///  * Information for a transaction block.
///  *
///  * This includes:
///  * - last block number.
///  * - consensus times for:
///  *    - previous block start.
///  *    - current block start.
///  *    - last handled transaction.
///  * - hash data for a rolling window of 256 blocks.
///  * - whether migration records were produced.
class HederaBlockInfo extends HederaProtoMessage with Equality {
    /// *
  ///      * A block number.
  ///      * &lt;p&gt;
  ///      * The block number of the last completed immutable block.
  final BigInt? lastBlockNumber;

    /// *
  ///      * A consensus timestamp.
  ///      * &lt;p&gt;
  ///      * The consensus time of the first transaction for the last completed immutable block.
  final proto_timestamp.HederaTimestamp? firstConsTimeOfLastBlock;

    /// *
  ///      * A list of the last 256 block hashes.&lt;br/&gt;
  ///      * This is the SHA384 48 byte hashes of the previous 256 blocks,
  ///      * collected in a single byte array.
  ///      * &lt;p&gt;
  ///      * The first 48 bytes SHALL be the oldest block in the list.&lt;br/&gt;
  ///      * The last 48 bytes SHALL be the newest block, which is the last fully
  ///      * completed immutable block.&lt;br/&gt;
  ///      * This SHALL contain less than 256 block hashes if there are less than 256
  ///      * preceding blocks; for instance, shortly after network genesis the network
  ///      * will not have processed 256 blocks yet.
  ///      * &lt;p&gt;
  ///      * This MAY change significantly for Block Stream (HIP TBD).
  final List<int>? blockHashes;

    /// *
  ///      * A consensus timestamp.
  ///      * &lt;p&gt;
  ///      * The consensus time of the last transaction that was handled by the node
  ///      * within the current block. Only top-level transactions can trigger stake
  ///      * period side effects, so we track them separately from the last-used
  ///      * time of &lt;i&gt;all&lt;/i&gt; transactions, which include children.&lt;br/&gt;
  final proto_timestamp.HederaTimestamp? consTimeOfLastHandledTxn;

    /// *
  ///      * A flag indicating that migration records have been published.
  ///      * &lt;p&gt;
  ///      * This property SHALL be `false` immediately following a node upgrade&lt;br/&gt;
  ///      * This SHALL be set 'true' as migration records, if any, are published.
  ///      * Migration records are typically published "during" the first transaction
  ///      * handled by the node following startup.
  final bool? migrationRecordsStreamed;

    /// *
  ///      * A consensus timestamp.
  ///      * &lt;p&gt;
  ///      * The consensus time of the first transaction in the current block;
  ///      * necessary for reconnecting nodes to detect when the current block
  ///      * is finished.
  final proto_timestamp.HederaTimestamp? firstConsTimeOfCurrentBlock;

    /// *
  ///      * The consensus time of the last transaction that was handled by the node.
  ///      * &lt;p&gt;
  ///      * This property is how we 'advance the consensus clock'. The node MUST
  ///      * continually set this property to the consensus timestamp for the most
  ///      * recent transaction completed by the node.
  final proto_timestamp.HederaTimestamp? lastUsedConsTime;

    /// *
  ///      * The time stamp at which the last interval process was done.
  ///      * &lt;p&gt;
  ///      * This field SHALL hold the consensus time for the last time
  ///      * at which an interval of time-dependent events were processed.
  final proto_timestamp.HederaTimestamp? lastIntervalProcessTime;

    /// *
  ///      * The root hash of the previous wrapped record block.
  final List<int>? previousWrappedRecordBlockRootHash;

    /// *
  ///      * The intermediate hashes, calculated for all historical wrapped
  ///      * record blocks, needed for subroot 2 in the block merkle
  ///      * tree structure. These hashes SHALL include the minimum required
  ///      * wrapped record block root hashes needed to construct subroot 2's
  ///      * final state at the end of the previous block.
  final List<List<int>> wrappedIntermediatePreviousBlockRootHashes;

    /// *
  ///      * The number of leaves in the intermediate wrapped record block
  ///      * roots subtree.
  final BigInt? wrappedIntermediateBlockRootsLeafCount;

    /// *
  ///      * Whether migration root-hash voting has finalized.
  final bool? votingComplete;

    /// *
  ///      * The block number at or after which voting is no longer pending.
  final BigInt? votingCompletionDeadlineBlockNumber;

    /// *
  ///      * Collected migration root-hash votes from nodes.
  final List<HederaNodeMigrationRootHashVote> migrationRootHashVotes;

    /// *
  ///      * Wrapped hashes captured while voting is pending.
  final List<com_hedera_hapi_node_state_blockrecords_migration_wrapped_hashes.HederaMigrationWrappedHashes> migrationWrappedHashes;

    /// *
  ///      * A flag indicating that the preview `BlockStreamInfo` object has been
  ///      * overwritten with the real wrapped record block hashes data from `BlockInfo`,
  ///      * i.e. as part of the block streams cutover release.
  ///      * &lt;p&gt;
  ///      * This SHALL be set to `true` only after the schema overwrite logic
  ///      * has run, to prevent any block streams cutover logic from repeating.
  final bool? previewStreamOverwritten;

  const HederaBlockInfo({
    this.lastBlockNumber,
    this.firstConsTimeOfLastBlock,
    this.blockHashes,
    this.consTimeOfLastHandledTxn,
    this.migrationRecordsStreamed,
    this.firstConsTimeOfCurrentBlock,
    this.lastUsedConsTime,
    this.lastIntervalProcessTime,
    this.previousWrappedRecordBlockRootHash,
    this.wrappedIntermediatePreviousBlockRootHashes = const [],
    this.wrappedIntermediateBlockRootsLeafCount,
    this.votingComplete,
    this.votingCompletionDeadlineBlockNumber,
    this.migrationRootHashVotes = const [],
    this.migrationWrappedHashes = const [],
    this.previewStreamOverwritten,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.int64(1),
        ProtoFieldConfig.message(2),
        ProtoFieldConfig.bytes(3),
        ProtoFieldConfig.message(4),
        ProtoFieldConfig.bool(5),
        ProtoFieldConfig.message(6),
        ProtoFieldConfig.message(7),
        ProtoFieldConfig.message(8),
        ProtoFieldConfig.bytes(10),
        ProtoFieldConfig.repeated(
          fieldNumber: 11,
          elementType: ProtoFieldType.bytes,
        ),
        ProtoFieldConfig.uint64(12),
        ProtoFieldConfig.bool(13),
        ProtoFieldConfig.uint64(14),
        ProtoFieldConfig.repeated(
          fieldNumber: 15,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.repeated(
          fieldNumber: 16,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.bool(17),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        lastBlockNumber,
        firstConsTimeOfLastBlock,
        blockHashes,
        consTimeOfLastHandledTxn,
        migrationRecordsStreamed,
        firstConsTimeOfCurrentBlock,
        lastUsedConsTime,
        lastIntervalProcessTime,
        previousWrappedRecordBlockRootHash,
        wrappedIntermediatePreviousBlockRootHashes,
        wrappedIntermediateBlockRootsLeafCount,
        votingComplete,
        votingCompletionDeadlineBlockNumber,
        migrationRootHashVotes,
        migrationWrappedHashes,
        previewStreamOverwritten,
      ];


HederaBlockInfo copyWith(
{BigInt? lastBlockNumber,

proto_timestamp.HederaTimestamp? firstConsTimeOfLastBlock,

List<int>? blockHashes,

proto_timestamp.HederaTimestamp? consTimeOfLastHandledTxn,

bool? migrationRecordsStreamed,

proto_timestamp.HederaTimestamp? firstConsTimeOfCurrentBlock,

proto_timestamp.HederaTimestamp? lastUsedConsTime,

proto_timestamp.HederaTimestamp? lastIntervalProcessTime,

List<int>? previousWrappedRecordBlockRootHash,

List<List<int>>? wrappedIntermediatePreviousBlockRootHashes,

BigInt? wrappedIntermediateBlockRootsLeafCount,

bool? votingComplete,

BigInt? votingCompletionDeadlineBlockNumber,

List<HederaNodeMigrationRootHashVote>? migrationRootHashVotes,

List<com_hedera_hapi_node_state_blockrecords_migration_wrapped_hashes.HederaMigrationWrappedHashes>? migrationWrappedHashes,

bool? previewStreamOverwritten,

}) {
    return HederaBlockInfo(
lastBlockNumber: lastBlockNumber ?? this.lastBlockNumber,
firstConsTimeOfLastBlock: firstConsTimeOfLastBlock ?? this.firstConsTimeOfLastBlock,
blockHashes: blockHashes ?? this.blockHashes,
consTimeOfLastHandledTxn: consTimeOfLastHandledTxn ?? this.consTimeOfLastHandledTxn,
migrationRecordsStreamed: migrationRecordsStreamed ?? this.migrationRecordsStreamed,
firstConsTimeOfCurrentBlock: firstConsTimeOfCurrentBlock ?? this.firstConsTimeOfCurrentBlock,
lastUsedConsTime: lastUsedConsTime ?? this.lastUsedConsTime,
lastIntervalProcessTime: lastIntervalProcessTime ?? this.lastIntervalProcessTime,
previousWrappedRecordBlockRootHash: previousWrappedRecordBlockRootHash ?? this.previousWrappedRecordBlockRootHash,
wrappedIntermediatePreviousBlockRootHashes: wrappedIntermediatePreviousBlockRootHashes ?? this.wrappedIntermediatePreviousBlockRootHashes,
wrappedIntermediateBlockRootsLeafCount: wrappedIntermediateBlockRootsLeafCount ?? this.wrappedIntermediateBlockRootsLeafCount,
votingComplete: votingComplete ?? this.votingComplete,
votingCompletionDeadlineBlockNumber: votingCompletionDeadlineBlockNumber ?? this.votingCompletionDeadlineBlockNumber,
migrationRootHashVotes: migrationRootHashVotes ?? this.migrationRootHashVotes,
migrationWrappedHashes: migrationWrappedHashes ?? this.migrationWrappedHashes,
previewStreamOverwritten: previewStreamOverwritten ?? this.previewStreamOverwritten,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'last_block_number': config.encodeBigint(lastBlockNumber),
      'first_cons_time_of_last_block': config.encodeMessage(firstConsTimeOfLastBlock),
      'block_hashes': config.encodeBinary(blockHashes),
      'cons_time_of_last_handled_txn': config.encodeMessage(consTimeOfLastHandledTxn),
      'migration_records_streamed': migrationRecordsStreamed,
      'first_cons_time_of_current_block': config.encodeMessage(firstConsTimeOfCurrentBlock),
      'last_used_cons_time': config.encodeMessage(lastUsedConsTime),
      'last_interval_process_time': config.encodeMessage(lastIntervalProcessTime),
      'previous_wrapped_record_block_root_hash': config.encodeBinary(previousWrappedRecordBlockRootHash),
      'wrapped_intermediate_previous_block_root_hashes': wrappedIntermediatePreviousBlockRootHashes.map((e) => config.encodeBinary(e)).toList(),
      'wrapped_intermediate_block_roots_leaf_count': config.encodeBigint(wrappedIntermediateBlockRootsLeafCount),
      'voting_complete': votingComplete,
      'voting_completion_deadline_block_number': config.encodeBigint(votingCompletionDeadlineBlockNumber),
      'migration_root_hash_votes': migrationRootHashVotes.map((e) => config.encodeMessage(e)).toList(),
      'migration_wrapped_hashes': migrationWrappedHashes.map((e) => config.encodeMessage(e)).toList(),
      'preview_stream_overwritten': previewStreamOverwritten,
    };
  }


  factory HederaBlockInfo.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaBlockInfo(
      lastBlockNumber: json.valueAsBigInt<BigInt?>('last_block_number', normalizeKeyLookup: config.normalizeKeys),
      firstConsTimeOfLastBlock: json.valueTo<proto_timestamp.HederaTimestamp?, Object>(
        key: 'first_cons_time_of_last_block',
        parse: (v) => proto_timestamp.HederaTimestamp.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      blockHashes: config.decodeBinary<List<int>?>(json.valueAs('block_hashes', normalizeKeyLookup: config.normalizeKeys)),
      consTimeOfLastHandledTxn: json.valueTo<proto_timestamp.HederaTimestamp?, Object>(
        key: 'cons_time_of_last_handled_txn',
        parse: (v) => proto_timestamp.HederaTimestamp.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      migrationRecordsStreamed: json.valueAsBool<bool?>('migration_records_streamed', normalizeKeyLookup: config.normalizeKeys),
      firstConsTimeOfCurrentBlock: json.valueTo<proto_timestamp.HederaTimestamp?, Object>(
        key: 'first_cons_time_of_current_block',
        parse: (v) => proto_timestamp.HederaTimestamp.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      lastUsedConsTime: json.valueTo<proto_timestamp.HederaTimestamp?, Object>(
        key: 'last_used_cons_time',
        parse: (v) => proto_timestamp.HederaTimestamp.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      lastIntervalProcessTime: json.valueTo<proto_timestamp.HederaTimestamp?, Object>(
        key: 'last_interval_process_time',
        parse: (v) => proto_timestamp.HederaTimestamp.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      previousWrappedRecordBlockRootHash: config.decodeBinary<List<int>?>(json.valueAs('previous_wrapped_record_block_root_hash', normalizeKeyLookup: config.normalizeKeys)),
      wrappedIntermediatePreviousBlockRootHashes: (json.valueEnsureAsList<dynamic>('wrapped_intermediate_previous_block_root_hashes', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => config.decodeBinary<List<int>>(e)).toList(),
      wrappedIntermediateBlockRootsLeafCount: json.valueAsBigInt<BigInt?>('wrapped_intermediate_block_roots_leaf_count', normalizeKeyLookup: config.normalizeKeys),
      votingComplete: json.valueAsBool<bool?>('voting_complete', normalizeKeyLookup: config.normalizeKeys),
      votingCompletionDeadlineBlockNumber: json.valueAsBigInt<BigInt?>('voting_completion_deadline_block_number', normalizeKeyLookup: config.normalizeKeys),
      migrationRootHashVotes: (json.valueEnsureAsList<dynamic>('migration_root_hash_votes', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<HederaNodeMigrationRootHashVote, Object>(
          value: e,
          parse: (v) => HederaNodeMigrationRootHashVote.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
      migrationWrappedHashes: (json.valueEnsureAsList<dynamic>('migration_wrapped_hashes', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<com_hedera_hapi_node_state_blockrecords_migration_wrapped_hashes.HederaMigrationWrappedHashes, Object>(
          value: e,
          parse: (v) => com_hedera_hapi_node_state_blockrecords_migration_wrapped_hashes.HederaMigrationWrappedHashes.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
      previewStreamOverwritten: json.valueAsBool<bool?>('preview_stream_overwritten', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaBlockInfo.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaBlockInfo(
      lastBlockNumber: decode.getBigInt<BigInt?>(1),
      firstConsTimeOfLastBlock: decode.messageTo<proto_timestamp.HederaTimestamp?>(2, (b) => proto_timestamp.HederaTimestamp.deserialize(b)),
      blockHashes: decode.getBytes<List<int>?>(3),
      consTimeOfLastHandledTxn: decode.messageTo<proto_timestamp.HederaTimestamp?>(4, (b) => proto_timestamp.HederaTimestamp.deserialize(b)),
      migrationRecordsStreamed: decode.getBool<bool?>(5),
      firstConsTimeOfCurrentBlock: decode.messageTo<proto_timestamp.HederaTimestamp?>(6, (b) => proto_timestamp.HederaTimestamp.deserialize(b)),
      lastUsedConsTime: decode.messageTo<proto_timestamp.HederaTimestamp?>(7, (b) => proto_timestamp.HederaTimestamp.deserialize(b)),
      lastIntervalProcessTime: decode.messageTo<proto_timestamp.HederaTimestamp?>(8, (b) => proto_timestamp.HederaTimestamp.deserialize(b)),
      previousWrappedRecordBlockRootHash: decode.getBytes<List<int>?>(10),
      wrappedIntermediatePreviousBlockRootHashes: decode.getListOfBytes(11),
      wrappedIntermediateBlockRootsLeafCount: decode.getBigInt<BigInt?>(12),
      votingComplete: decode.getBool<bool?>(13),
      votingCompletionDeadlineBlockNumber: decode.getBigInt<BigInt?>(14),
      migrationRootHashVotes: decode.getListOfBytes(15).map((b) => HederaNodeMigrationRootHashVote.deserialize(b)).toList(),
      migrationWrappedHashes: decode.getListOfBytes(16).map((b) => com_hedera_hapi_node_state_blockrecords_migration_wrapped_hashes.HederaMigrationWrappedHashes.deserialize(b)).toList(),
      previewStreamOverwritten: decode.getBool<bool?>(17),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoBlockInfo;

}


