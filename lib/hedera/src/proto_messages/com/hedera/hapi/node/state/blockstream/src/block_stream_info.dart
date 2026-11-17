import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/timestamp.dart"
    as proto_timestamp;
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;

/// *
///  * # Block Stream Info
///  * Information stored in consensus state at the beginning of each block to
///  * record the status of the immediately prior block.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in
///  * [RFC2119](https://www.ietf.org/rfc/rfc2119) and clarified in
///  * [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.state.blockstream"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * A message stored in state to maintain block stream parameters.&lt;br/&gt;
///  * Nodes use this information for three purposes.
///  * 1. To maintain hash chain continuity at restart and reconnect boundaries.
///  * 2. To store historical hashes for implementation of the EVM `BLOCKHASH`
///  *    and `PREVRANDAO` opcodes.
///  * 3. To track the amount of consensus time that has passed between blocks.
///  *
///  * This value MUST be updated for every block.&lt;br/&gt;
///  * This value MUST be transmitted in the "state changes" section of
///  * _each_ block, but MUST be updated at the beginning of the _next_ block.&lt;br/&gt;
///  * This value SHALL contain the block hash up to, and including, the
///  * immediately prior completed block.&lt;br/&gt;
///  * The state change to update this singleton MUST be the last
///  * block item in this block.
class HederaBlockStreamInfo extends HederaProtoMessage with Equality {
  /// *
  ///      * A block number.&lt;br/&gt;
  ///      * This is the current block number.
  final BigInt? blockNumber;

  /// *
  ///      * A consensus time for the current block.&lt;br/&gt;
  ///      * This is the consensus time of the first round in the current block,
  ///      * which equates to the first contained transaction's consensus time.
  ///      * It is used to determine if this block was the first across an
  ///      * important boundary in consensus time, such as UTC midnight.
  ///      * This may also be used to purge entities expiring between the last
  ///      * block time and this time.
  final proto_timestamp.HederaTimestamp? blockTime;

  /// *
  ///      * A concatenation of hash values.&lt;br/&gt;
  ///      * This combines several trailing output block item hashes and
  ///      * is used as a seed value for a pseudo-random number generator.&lt;br/&gt;
  ///      * This is also required to implement the EVM `PREVRANDAO` opcode.&lt;br/&gt;
  ///      * This MUST contain at least 256 bits of entropy.
  final List<int>? trailingOutputHashes;

  /// *
  ///      * A concatenation of hash values.&lt;br/&gt;
  ///      * This field combines up to 256 trailing block hashes.
  ///      * &lt;p&gt;
  ///      * If this message is for block number N, then the earliest available
  ///      * hash SHALL be for block number N-256.&lt;br/&gt;
  ///      * The latest available hash SHALL be for block N-1.&lt;br/&gt;
  ///      * This is REQUIRED to implement the EVM `BLOCKHASH` opcode.
  ///      * &lt;p&gt;
  ///      * ### Field Length
  ///      * Each hash value SHALL be the trailing 265 bits of a SHA2-384 hash.&lt;br/&gt;
  ///      * The length of this field SHALL be an integer multiple of 32 bytes.&lt;br/&gt;
  ///      * This field SHALL be at least 32 bytes.&lt;br/&gt;
  ///      * The maximum length of this field SHALL be 8192 bytes.
  final List<int>? trailingBlockHashes;

  /// *
  ///      * A SHA2-384 hash value.&lt;br/&gt;
  ///      * This is the final hash of the "input" subtree for this block.
  final List<int>? inputTreeRootHash;

  /// *
  ///      * A SHA2-384 hash value.&lt;br/&gt;
  ///      * This is the hash of consensus state at the _start_ of this block.
  final List<int>? startOfBlockStateHash;

  /// *
  ///      * A count of "state change" block items in this block.
  ///      * &lt;p&gt;
  ///      * This SHALL count the number of state change block items that _precede_
  ///      * the state change that updates this singleton.
  final BigInt? numPrecedingStateChangesItems;

  /// *
  ///      * A concatenation of SHA2-384 hash values.&lt;br/&gt;
  ///      * This is the "rightmost" values of the "output" subtree.
  ///      * &lt;p&gt;
  ///      * The subtree containing these hashes SHALL be constructed from all "output"
  ///      * `BlockItem`s in this block that _precede_ the update to this singleton.
  final List<List<int>> rightmostPrecedingStateChangesTreeHashes;

  /// *
  ///      * A block-end consensus time stamp.
  ///      * &lt;p&gt;
  ///      * This field SHALL hold the last-used consensus time for
  ///      * the current block.
  final proto_timestamp.HederaTimestamp? blockEndTime;

  /// *
  ///      * Whether the post-upgrade work has been done.
  ///      * &lt;p&gt;
  ///      * This MUST be false if and only if the network just restarted
  ///      * after an upgrade and has not yet done the post-upgrade work.
  final bool? postUpgradeWorkDone;

  /// *
  ///      * A version describing the version of application software.
  ///      * &lt;p&gt;
  ///      * This SHALL be the software version that created this block.
  final proto_basic_types.HederaSemanticVersion? creationSoftwareVersion;

  /// *
  ///      * The time stamp at which the last interval process was done.
  ///      * &lt;p&gt;
  ///      * This field SHALL hold the consensus time for the last time
  ///      * at which an interval of time-dependent events were processed.
  final proto_timestamp.HederaTimestamp? lastIntervalProcessTime;

  /// *
  ///      * The time stamp at which the last user transaction was handled.
  ///      * &lt;p&gt;
  ///      * This field SHALL hold the consensus time for the last time
  ///      * at which a user transaction was handled.
  final proto_timestamp.HederaTimestamp? lastHandleTime;

  /// *
  ///      * A SHA2-384 hash value.&lt;br/&gt;
  ///      * This is the final hash of the "consensus headers" subtree for this block.
  final List<int>? consensusHeaderRootHash;

  /// *
  ///      * A SHA2-384 hash value.&lt;br/&gt;
  ///        * This is the final hash of the "output" subtree for this block.
  final List<int>? outputItemRootHash;

  /// *
  ///      * A SHA2-384 hash value.&lt;br/&gt;
  ///      * This is the final hash of the "trace data" subtree for this block.
  final List<int>? traceDataRootHash;

  /// *
  ///      * The intermediate hashes needed for subroot 2 in the block merkle
  ///      * tree structure. These hashes SHALL include the minimum required
  ///      * block root hashes needed to construct subroot 2's final state at
  ///      * the end of the previous block.
  final List<List<int>> intermediatePreviousBlockRootHashes;

  /// *
  ///      * The number of leaves in the intermediate block roots subtree.
  final BigInt? intermediateBlockRootsLeafCount;

  const HederaBlockStreamInfo({
    this.blockNumber,
    this.blockTime,
    this.trailingOutputHashes,
    this.trailingBlockHashes,
    this.inputTreeRootHash,
    this.startOfBlockStateHash,
    this.numPrecedingStateChangesItems,
    this.rightmostPrecedingStateChangesTreeHashes = const [],
    this.blockEndTime,
    this.postUpgradeWorkDone,
    this.creationSoftwareVersion,
    this.lastIntervalProcessTime,
    this.lastHandleTime,
    this.consensusHeaderRootHash,
    this.outputItemRootHash,
    this.traceDataRootHash,
    this.intermediatePreviousBlockRootHashes = const [],
    this.intermediateBlockRootsLeafCount,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.uint64(1),
        ProtoFieldConfig.message(2),
        ProtoFieldConfig.bytes(3),
        ProtoFieldConfig.bytes(4),
        ProtoFieldConfig.bytes(5),
        ProtoFieldConfig.bytes(6),
        ProtoFieldConfig.uint64(7),
        ProtoFieldConfig.repeated(
          fieldNumber: 8,
          elementType: ProtoFieldType.bytes,
        ),
        ProtoFieldConfig.message(9),
        ProtoFieldConfig.bool(10),
        ProtoFieldConfig.message(11),
        ProtoFieldConfig.message(12),
        ProtoFieldConfig.message(13),
        ProtoFieldConfig.bytes(14),
        ProtoFieldConfig.bytes(15),
        ProtoFieldConfig.bytes(16),
        ProtoFieldConfig.repeated(
          fieldNumber: 17,
          elementType: ProtoFieldType.bytes,
        ),
        ProtoFieldConfig.uint64(18),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    blockNumber,
    blockTime,
    trailingOutputHashes,
    trailingBlockHashes,
    inputTreeRootHash,
    startOfBlockStateHash,
    numPrecedingStateChangesItems,
    rightmostPrecedingStateChangesTreeHashes,
    blockEndTime,
    postUpgradeWorkDone,
    creationSoftwareVersion,
    lastIntervalProcessTime,
    lastHandleTime,
    consensusHeaderRootHash,
    outputItemRootHash,
    traceDataRootHash,
    intermediatePreviousBlockRootHashes,
    intermediateBlockRootsLeafCount,
  ];

  HederaBlockStreamInfo copyWith({
    BigInt? blockNumber,

    proto_timestamp.HederaTimestamp? blockTime,

    List<int>? trailingOutputHashes,

    List<int>? trailingBlockHashes,

    List<int>? inputTreeRootHash,

    List<int>? startOfBlockStateHash,

    BigInt? numPrecedingStateChangesItems,

    List<List<int>>? rightmostPrecedingStateChangesTreeHashes,

    proto_timestamp.HederaTimestamp? blockEndTime,

    bool? postUpgradeWorkDone,

    proto_basic_types.HederaSemanticVersion? creationSoftwareVersion,

    proto_timestamp.HederaTimestamp? lastIntervalProcessTime,

    proto_timestamp.HederaTimestamp? lastHandleTime,

    List<int>? consensusHeaderRootHash,

    List<int>? outputItemRootHash,

    List<int>? traceDataRootHash,

    List<List<int>>? intermediatePreviousBlockRootHashes,

    BigInt? intermediateBlockRootsLeafCount,
  }) {
    return HederaBlockStreamInfo(
      blockNumber: blockNumber ?? this.blockNumber,
      blockTime: blockTime ?? this.blockTime,
      trailingOutputHashes: trailingOutputHashes ?? this.trailingOutputHashes,
      trailingBlockHashes: trailingBlockHashes ?? this.trailingBlockHashes,
      inputTreeRootHash: inputTreeRootHash ?? this.inputTreeRootHash,
      startOfBlockStateHash:
          startOfBlockStateHash ?? this.startOfBlockStateHash,
      numPrecedingStateChangesItems:
          numPrecedingStateChangesItems ?? this.numPrecedingStateChangesItems,
      rightmostPrecedingStateChangesTreeHashes:
          rightmostPrecedingStateChangesTreeHashes ??
          this.rightmostPrecedingStateChangesTreeHashes,
      blockEndTime: blockEndTime ?? this.blockEndTime,
      postUpgradeWorkDone: postUpgradeWorkDone ?? this.postUpgradeWorkDone,
      creationSoftwareVersion:
          creationSoftwareVersion ?? this.creationSoftwareVersion,
      lastIntervalProcessTime:
          lastIntervalProcessTime ?? this.lastIntervalProcessTime,
      lastHandleTime: lastHandleTime ?? this.lastHandleTime,
      consensusHeaderRootHash:
          consensusHeaderRootHash ?? this.consensusHeaderRootHash,
      outputItemRootHash: outputItemRootHash ?? this.outputItemRootHash,
      traceDataRootHash: traceDataRootHash ?? this.traceDataRootHash,
      intermediatePreviousBlockRootHashes:
          intermediatePreviousBlockRootHashes ??
          this.intermediatePreviousBlockRootHashes,
      intermediateBlockRootsLeafCount:
          intermediateBlockRootsLeafCount ??
          this.intermediateBlockRootsLeafCount,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'block_number': config.encodeBigint(blockNumber),
      'block_time': config.encodeMessage(blockTime),
      'trailing_output_hashes': config.encodeBinary(trailingOutputHashes),
      'trailing_block_hashes': config.encodeBinary(trailingBlockHashes),
      'input_tree_root_hash': config.encodeBinary(inputTreeRootHash),
      'start_of_block_state_hash': config.encodeBinary(startOfBlockStateHash),
      'num_preceding_state_changes_items': config.encodeBigint(
        numPrecedingStateChangesItems,
      ),
      'rightmost_preceding_state_changes_tree_hashes':
          rightmostPrecedingStateChangesTreeHashes
              .map((e) => config.encodeBinary(e))
              .toList(),
      'block_end_time': config.encodeMessage(blockEndTime),
      'post_upgrade_work_done': postUpgradeWorkDone,
      'creation_software_version': config.encodeMessage(
        creationSoftwareVersion,
      ),
      'last_interval_process_time': config.encodeMessage(
        lastIntervalProcessTime,
      ),
      'last_handle_time': config.encodeMessage(lastHandleTime),
      'consensus_header_root_hash': config.encodeBinary(
        consensusHeaderRootHash,
      ),
      'output_item_root_hash': config.encodeBinary(outputItemRootHash),
      'trace_data_root_hash': config.encodeBinary(traceDataRootHash),
      'intermediate_previous_block_root_hashes':
          intermediatePreviousBlockRootHashes
              .map((e) => config.encodeBinary(e))
              .toList(),
      'intermediate_block_roots_leaf_count': config.encodeBigint(
        intermediateBlockRootsLeafCount,
      ),
    };
  }

  factory HederaBlockStreamInfo.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaBlockStreamInfo(
      blockNumber: json.valueAsBigInt<BigInt?>(
        'block_number',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      blockTime: json.valueTo<proto_timestamp.HederaTimestamp?, Object>(
        key: 'block_time',
        parse:
            (v) => proto_timestamp.HederaTimestamp.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      trailingOutputHashes: config.decodeBinary<List<int>?>(
        json.valueAs(
          'trailing_output_hashes',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      trailingBlockHashes: config.decodeBinary<List<int>?>(
        json.valueAs(
          'trailing_block_hashes',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      inputTreeRootHash: config.decodeBinary<List<int>?>(
        json.valueAs(
          'input_tree_root_hash',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      startOfBlockStateHash: config.decodeBinary<List<int>?>(
        json.valueAs(
          'start_of_block_state_hash',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      numPrecedingStateChangesItems: json.valueAsBigInt<BigInt?>(
        'num_preceding_state_changes_items',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      rightmostPrecedingStateChangesTreeHashes:
          (json.valueEnsureAsList<dynamic>(
            'rightmost_preceding_state_changes_tree_hashes',
            normalizeKeyLookup: config.normalizeKeys,
            onMissing: () => [],
          )).map((e) => config.decodeBinary<List<int>>(e)).toList(),
      blockEndTime: json.valueTo<proto_timestamp.HederaTimestamp?, Object>(
        key: 'block_end_time',
        parse:
            (v) => proto_timestamp.HederaTimestamp.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      postUpgradeWorkDone: json.valueAsBool<bool?>(
        'post_upgrade_work_done',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      creationSoftwareVersion: json
          .valueTo<proto_basic_types.HederaSemanticVersion?, Object>(
            key: 'creation_software_version',
            parse:
                (v) => proto_basic_types.HederaSemanticVersion.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      lastIntervalProcessTime: json
          .valueTo<proto_timestamp.HederaTimestamp?, Object>(
            key: 'last_interval_process_time',
            parse:
                (v) => proto_timestamp.HederaTimestamp.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      lastHandleTime: json.valueTo<proto_timestamp.HederaTimestamp?, Object>(
        key: 'last_handle_time',
        parse:
            (v) => proto_timestamp.HederaTimestamp.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      consensusHeaderRootHash: config.decodeBinary<List<int>?>(
        json.valueAs(
          'consensus_header_root_hash',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      outputItemRootHash: config.decodeBinary<List<int>?>(
        json.valueAs(
          'output_item_root_hash',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      traceDataRootHash: config.decodeBinary<List<int>?>(
        json.valueAs(
          'trace_data_root_hash',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      intermediatePreviousBlockRootHashes:
          (json.valueEnsureAsList<dynamic>(
            'intermediate_previous_block_root_hashes',
            normalizeKeyLookup: config.normalizeKeys,
            onMissing: () => [],
          )).map((e) => config.decodeBinary<List<int>>(e)).toList(),
      intermediateBlockRootsLeafCount: json.valueAsBigInt<BigInt?>(
        'intermediate_block_roots_leaf_count',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaBlockStreamInfo.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaBlockStreamInfo(
      blockNumber: decode.getBigInt<BigInt?>(1),
      blockTime: decode.messageTo<proto_timestamp.HederaTimestamp?>(
        2,
        (b) => proto_timestamp.HederaTimestamp.deserialize(b),
      ),
      trailingOutputHashes: decode.getBytes<List<int>?>(3),
      trailingBlockHashes: decode.getBytes<List<int>?>(4),
      inputTreeRootHash: decode.getBytes<List<int>?>(5),
      startOfBlockStateHash: decode.getBytes<List<int>?>(6),
      numPrecedingStateChangesItems: decode.getBigInt<BigInt?>(7),
      rightmostPrecedingStateChangesTreeHashes: decode.getListOfBytes(8),
      blockEndTime: decode.messageTo<proto_timestamp.HederaTimestamp?>(
        9,
        (b) => proto_timestamp.HederaTimestamp.deserialize(b),
      ),
      postUpgradeWorkDone: decode.getBool<bool?>(10),
      creationSoftwareVersion: decode
          .messageTo<proto_basic_types.HederaSemanticVersion?>(
            11,
            (b) => proto_basic_types.HederaSemanticVersion.deserialize(b),
          ),
      lastIntervalProcessTime: decode
          .messageTo<proto_timestamp.HederaTimestamp?>(
            12,
            (b) => proto_timestamp.HederaTimestamp.deserialize(b),
          ),
      lastHandleTime: decode.messageTo<proto_timestamp.HederaTimestamp?>(
        13,
        (b) => proto_timestamp.HederaTimestamp.deserialize(b),
      ),
      consensusHeaderRootHash: decode.getBytes<List<int>?>(14),
      outputItemRootHash: decode.getBytes<List<int>?>(15),
      traceDataRootHash: decode.getBytes<List<int>?>(16),
      intermediatePreviousBlockRootHashes: decode.getListOfBytes(17),
      intermediateBlockRootsLeafCount: decode.getBigInt<BigInt?>(18),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl
          .comHederaHapiNodeStateBlockstreamBlockStreamInfo;
}
