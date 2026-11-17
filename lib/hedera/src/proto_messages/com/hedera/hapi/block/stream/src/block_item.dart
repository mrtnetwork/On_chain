import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/block/stream/output/src/block_header.dart" as com_hedera_hapi_block_stream_output_block_header;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/block/stream/input/src/event_metadata.dart" as com_hedera_hapi_block_stream_input_event_metadata;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/block/stream/input/src/round_header.dart" as com_hedera_hapi_block_stream_input_round_header;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/platform/event/src/event_transaction.dart" as com_hedera_hapi_platform_event_event_transaction;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/block/stream/output/src/transaction_result.dart" as com_hedera_hapi_block_stream_output_transaction_result;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/block/stream/output/src/transaction_output.dart" as com_hedera_hapi_block_stream_output_transaction_output;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/block/stream/output/src/state_changes.dart" as com_hedera_hapi_block_stream_output_state_changes;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/block/stream/src/block_proof.dart" as com_hedera_hapi_block_stream_block_proof;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/block/stream/src/record_file_item.dart" as com_hedera_hapi_block_stream_record_file_item;

/// *
///  * # Block Item
///  * A single item in the block stream, such as transaction data, event metadata,
///  * or a a system transaction.&lt;br/&gt;
///  * Each block consists of a block header, one or more block items,
///  * and a block state proof. Within the block are a series of events delimited
///  * by start_event block items.
///  *
///  * This structure here MUST support a stream of block items with no enclosing
///  * message.&lt;br/&gt;
///  * Implementations SHOULD behave in a reasonable manner if used in a gRPC
///  * bidirectional streaming RPC similar to
///  * `rpc processBlocks(stream BlockItem) returns (stream Acknowledgement);`.
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
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.block.stream"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * A single item within a block stream.
///  *
///  * Each item in the block stream SHALL be self-contained and independent,
///  * with the following constraints applicable to the _unfiltered_ stream.
///  * - A block SHALL start with a `header`.
///  * - A block SHALL end with a `state_proof`.
///  * - A `block_header` SHALL be followed by an `event_header`.
///  * - An `event_header` SHALL be followed by one or more
///  *   `event_transaction` items.
///  * - An `event_transaction` SHALL be followed by a `transaction_result`.
///  * - A `transaction_result` MAY be followed by a `transaction_output`.
///  * - A `transaction_result` (or a `transaction_output`, if present) MAY be
///  *     followed by one or more `state_changes`.
///  *
///  * This forms the following required sequence for each block, which is then
///  * repeated within the block stream, indefinitely.  Note that there is no
///  * container structure in the stream, the indentation below is only to
///  * highlight repeated subsequences.&lt;br/&gt;
///  * The order of items within each block below is REQUIRED and SHALL NOT change.
///  *
///  * ```text
///  * header
///  *   repeated {
///  *     start_event
///  *     repeated {
///  *       event_transaction
///  *       transaction_result
///  *       (optional) transaction_output
///  *       (optional) repeated state_changes
///  *     }
///  *   }
///  * state_proof
///  * ```
///  * A filtered stream may exclude some items above, depending on filter
///  * criteria. A filtered item is replaced with a merkle path and hash value
///  * to maintain block stream verifiability.
///  *
///  * A BlockItem SHALL be individually and directly processed to create the
///  * item hash.&lt;br/&gt;
///  * Items to be hashed MUST NOT be contained within another item.&lt;br/&gt;
///  * Items which might be filtered out of the stream MUST NOT be
///  * contained in other items.
///  *
///  * ### Forward Compatibility
///  * In order to maximize forward compatibility, and minimize the need to
///  * coordinate deployments of different systems creating and processing
///  * block streams in the future, the following rules SHALL be followed
///  * for field numbering in this message.
///  * - The first 15 field numbers SHALL be assigned to the fields present
///  *   in the first release. Unused fields in this range SHALL remain reserved
///  *   until needed for additional options that do not fit into "input" or
///  *   "output" categories.
///  * - Fields numbered 16 and above MUST be numbered as follows.
///  *    - "input" items MUST use `odd` field numbers.
///  *    - "output" items MUST use `even` field numbers.
///  *
///  * #### Forward Compatibility Example
///  * A future update adding three new items. A "BlockTrailer" item which is
///  * neither input nor output, a new "ConsensusTransom" which is an input,
///  * and a new "BridgeTransform" which is an output.
///  * - The "BlockTrailer" is field 11, which is removed from the `reserved` list.
///  * - The "ConsensusTransom" is an input, so it is field `17` (the first unused
///  *   `odd` field greater than or equal to 16).
///  * - The "BridgeTransform" is an output, so it is field `16` (the first unused
///  *   even field greater than or equal to 16).
///  *
///  * #### Initial Field assignment to "input", "output", and "other" categories.
///  * - Inputs
///  *    - `event_header`
///  *    - `round_header`
///  *    - `event_transaction`
///  * - Outputs
///  *    - `block_header`
///  *    - `transaction_result`
///  *    - `transaction_output`
///  *    - `state_changes`
///  * - Any subtree (depending on what was filtered).
///  *   This item details it's path in the tree.
///  *    - `filtered_item_hash`
///  * - Neither input nor output (and not part of the "proof" merkle tree)
///  *    - `block_proof`
///  *    - `record_file`
class HederaBlockItem extends HederaProtoMessage with Equality {
    /// Reserved for future items that are neither "input" nor "output".
  /// *
  ///          * An header for the block, marking the start of a new block.
  final com_hedera_hapi_block_stream_output_block_header.HederaBlockHeader? blockHeader;

    /// *
  ///          * An header emitted at the start of a new network "event".
  ///          * &lt;p&gt;
  ///          * This item SHALL contain the properties relevant to a single
  ///          * gossip event.
  final com_hedera_hapi_block_stream_input_event_metadata.HederaEventHeader? eventHeader;

    /// *
  ///          * An header emitted at the start of a new consensus "round".
  ///          * &lt;p&gt;
  ///          * This item SHALL contain the properties relevant to a single
  ///          * consensus round.
  final com_hedera_hapi_block_stream_input_round_header.HederaRoundHeader? roundHeader;

    /// *
  ///          * A single transaction.
  ///          * &lt;p&gt;
  ///          * This item SHALL contain the serialized bytes of a
  ///          * single transaction.&lt;br/&gt;
  ///          * Each event transaction SHALL be either a `SignedTransaction` or
  ///          * an internal system-generated transaction.&lt;br/&gt;
  ///          * This item MUST NOT contain data for more than one
  ///          * `SignedTransaction` or system-generated transaction.
  final com_hedera_hapi_platform_event_event_transaction.HederaEventTransaction? eventTransaction;

    /// *
  ///          * The result of running a transaction.
  ///          * &lt;p&gt;
  ///          * This item SHALL be present immediately after an
  ///          * `event_transaction` item.&lt;br/&gt;
  ///          * This item MAY be redacted in some circumstances, and SHALL be
  ///          * replaced with a `filtered_item` if removed.
  final com_hedera_hapi_block_stream_output_transaction_result.HederaTransactionResult? transactionResult;

    /// *
  ///          * A transaction output.
  ///          * &lt;p&gt;
  ///          * This item MAY not be present if a transaction does not produce
  ///          * an output.&lt;br/&gt;
  ///          * If a transaction does produce an output that is not reflected
  ///          * in state changes, then this item MUST be present after the
  ///          * `transaction_result` for that transaction.
  final com_hedera_hapi_block_stream_output_transaction_output.HederaTransactionOutput? transactionOutput;

    /// *
  ///          * A set of state changes.
  ///          * &lt;p&gt;
  ///          * All changes to values in network state SHALL be described by
  ///          * stream items of this type.&lt;br/&gt;
  ///          * The source of these state changes SHALL be described by the
  ///          * `reason` enumeration.
  final com_hedera_hapi_block_stream_output_state_changes.HederaStateChanges? stateChanges;

    /// *
  ///          * Verification data for an item filtered from the stream.&lt;br/&gt;
  ///          * This is a hash for a merkle tree node where the contents of that
  ///          * part of the merkle tree have been removed from this stream.
  ///          * &lt;p&gt;
  ///          * Items of this type SHALL NOT be present in the full (unfiltered)
  ///          * block stream.&lt;br/&gt;
  ///          * Items of this type SHALL replace any item removed from a partial
  ///          * (filtered) block stream.&lt;br/&gt;
  ///          * Presence of `filtered_item` entries SHALL NOT prevent verification
  ///          * of a block, but MAY preclude verification or reconstruction of
  ///          * consensus state.&lt;br/&gt;
  final HederaFilteredItemHash? filteredItemHash;

    /// *
  ///          * A signed block proof.&lt;br/&gt;
  ///          * The signed merkle proof for this block. This will validate
  ///          * a "virtual" merkle tree containing the previous block "virtual"
  ///          * root, an "input" subtree, an "output" subtree, and
  ///          * a "state changes" subtree.
  ///          * &lt;p&gt;
  ///          * This item is not part of the block stream hash chain/tree, and
  ///          * MUST follow after the end of a block.
  final com_hedera_hapi_block_stream_block_proof.HederaBlockProof? blockProof;

    /// *
  ///          * A record file and associated data.
  ///          * &lt;p&gt;
  ///          * This MUST contain a single Record file, associated Sidecar files,
  ///          * and data from related Signature files.
  ///          * If this item is present, special treatment is
  ///          * REQUIRED for this block.
  ///          * &lt;ul&gt;
  ///          *   &lt;li&gt;The block SHALL NOT have a `BlockHeader`.&lt;/li&gt;
  ///          *   &lt;li&gt;The block SHALL NOT have a `BlockProof`.&lt;/li&gt;
  ///          *   &lt;li&gt;The block SHALL contain _exactly one_ `RecordFileItem`.&lt;/li&gt;
  ///          *   &lt;li&gt;The block SHALL NOT contain any item other than a
  ///          *       `RecordFileItem`.&lt;/li&gt;
  ///          *   &lt;li&gt;The content of the `RecordFileItem` MUST be validated using
  ///          *       the signature data and content provided within according to
  ///          *       the process used for Record Files prior to the creation
  ///          *       of Block Stream.&lt;/li&gt;
  ///          * &lt;/ul&gt;
  final com_hedera_hapi_block_stream_record_file_item.HederaRecordFileItem? recordFile;

  const HederaBlockItem({
    this.blockHeader,
    this.eventHeader,
    this.roundHeader,
    this.eventTransaction,
    this.transactionResult,
    this.transactionOutput,
    this.stateChanges,
    this.filteredItemHash,
    this.blockProof,
    this.recordFile,
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
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        blockHeader,
        eventHeader,
        roundHeader,
        eventTransaction,
        transactionResult,
        transactionOutput,
        stateChanges,
        filteredItemHash,
        blockProof,
        recordFile,
      ];


HederaBlockItem copyWith(
{com_hedera_hapi_block_stream_output_block_header.HederaBlockHeader? blockHeader,

com_hedera_hapi_block_stream_input_event_metadata.HederaEventHeader? eventHeader,

com_hedera_hapi_block_stream_input_round_header.HederaRoundHeader? roundHeader,

com_hedera_hapi_platform_event_event_transaction.HederaEventTransaction? eventTransaction,

com_hedera_hapi_block_stream_output_transaction_result.HederaTransactionResult? transactionResult,

com_hedera_hapi_block_stream_output_transaction_output.HederaTransactionOutput? transactionOutput,

com_hedera_hapi_block_stream_output_state_changes.HederaStateChanges? stateChanges,

HederaFilteredItemHash? filteredItemHash,

com_hedera_hapi_block_stream_block_proof.HederaBlockProof? blockProof,

com_hedera_hapi_block_stream_record_file_item.HederaRecordFileItem? recordFile,

}) {
    return HederaBlockItem(
blockHeader: blockHeader ?? this.blockHeader,
eventHeader: eventHeader ?? this.eventHeader,
roundHeader: roundHeader ?? this.roundHeader,
eventTransaction: eventTransaction ?? this.eventTransaction,
transactionResult: transactionResult ?? this.transactionResult,
transactionOutput: transactionOutput ?? this.transactionOutput,
stateChanges: stateChanges ?? this.stateChanges,
filteredItemHash: filteredItemHash ?? this.filteredItemHash,
blockProof: blockProof ?? this.blockProof,
recordFile: recordFile ?? this.recordFile,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'block_header': config.encodeMessage(blockHeader),
      'event_header': config.encodeMessage(eventHeader),
      'round_header': config.encodeMessage(roundHeader),
      'event_transaction': config.encodeMessage(eventTransaction),
      'transaction_result': config.encodeMessage(transactionResult),
      'transaction_output': config.encodeMessage(transactionOutput),
      'state_changes': config.encodeMessage(stateChanges),
      'filtered_item_hash': config.encodeMessage(filteredItemHash),
      'block_proof': config.encodeMessage(blockProof),
      'record_file': config.encodeMessage(recordFile),
    };
  }


  factory HederaBlockItem.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaBlockItem(
      blockHeader: json.valueTo<com_hedera_hapi_block_stream_output_block_header.HederaBlockHeader?, Object>(
        key: 'block_header',
        parse: (v) => com_hedera_hapi_block_stream_output_block_header.HederaBlockHeader.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      eventHeader: json.valueTo<com_hedera_hapi_block_stream_input_event_metadata.HederaEventHeader?, Object>(
        key: 'event_header',
        parse: (v) => com_hedera_hapi_block_stream_input_event_metadata.HederaEventHeader.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      roundHeader: json.valueTo<com_hedera_hapi_block_stream_input_round_header.HederaRoundHeader?, Object>(
        key: 'round_header',
        parse: (v) => com_hedera_hapi_block_stream_input_round_header.HederaRoundHeader.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      eventTransaction: json.valueTo<com_hedera_hapi_platform_event_event_transaction.HederaEventTransaction?, Object>(
        key: 'event_transaction',
        parse: (v) => com_hedera_hapi_platform_event_event_transaction.HederaEventTransaction.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      transactionResult: json.valueTo<com_hedera_hapi_block_stream_output_transaction_result.HederaTransactionResult?, Object>(
        key: 'transaction_result',
        parse: (v) => com_hedera_hapi_block_stream_output_transaction_result.HederaTransactionResult.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      transactionOutput: json.valueTo<com_hedera_hapi_block_stream_output_transaction_output.HederaTransactionOutput?, Object>(
        key: 'transaction_output',
        parse: (v) => com_hedera_hapi_block_stream_output_transaction_output.HederaTransactionOutput.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      stateChanges: json.valueTo<com_hedera_hapi_block_stream_output_state_changes.HederaStateChanges?, Object>(
        key: 'state_changes',
        parse: (v) => com_hedera_hapi_block_stream_output_state_changes.HederaStateChanges.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      filteredItemHash: json.valueTo<HederaFilteredItemHash?, Object>(
        key: 'filtered_item_hash',
        parse: (v) => HederaFilteredItemHash.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      blockProof: json.valueTo<com_hedera_hapi_block_stream_block_proof.HederaBlockProof?, Object>(
        key: 'block_proof',
        parse: (v) => com_hedera_hapi_block_stream_block_proof.HederaBlockProof.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      recordFile: json.valueTo<com_hedera_hapi_block_stream_record_file_item.HederaRecordFileItem?, Object>(
        key: 'record_file',
        parse: (v) => com_hedera_hapi_block_stream_record_file_item.HederaRecordFileItem.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory HederaBlockItem.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaBlockItem(
      blockHeader: decode.messageTo<com_hedera_hapi_block_stream_output_block_header.HederaBlockHeader?>(1, (b) => com_hedera_hapi_block_stream_output_block_header.HederaBlockHeader.deserialize(b)),
      eventHeader: decode.messageTo<com_hedera_hapi_block_stream_input_event_metadata.HederaEventHeader?>(2, (b) => com_hedera_hapi_block_stream_input_event_metadata.HederaEventHeader.deserialize(b)),
      roundHeader: decode.messageTo<com_hedera_hapi_block_stream_input_round_header.HederaRoundHeader?>(3, (b) => com_hedera_hapi_block_stream_input_round_header.HederaRoundHeader.deserialize(b)),
      eventTransaction: decode.messageTo<com_hedera_hapi_platform_event_event_transaction.HederaEventTransaction?>(4, (b) => com_hedera_hapi_platform_event_event_transaction.HederaEventTransaction.deserialize(b)),
      transactionResult: decode.messageTo<com_hedera_hapi_block_stream_output_transaction_result.HederaTransactionResult?>(5, (b) => com_hedera_hapi_block_stream_output_transaction_result.HederaTransactionResult.deserialize(b)),
      transactionOutput: decode.messageTo<com_hedera_hapi_block_stream_output_transaction_output.HederaTransactionOutput?>(6, (b) => com_hedera_hapi_block_stream_output_transaction_output.HederaTransactionOutput.deserialize(b)),
      stateChanges: decode.messageTo<com_hedera_hapi_block_stream_output_state_changes.HederaStateChanges?>(7, (b) => com_hedera_hapi_block_stream_output_state_changes.HederaStateChanges.deserialize(b)),
      filteredItemHash: decode.messageTo<HederaFilteredItemHash?>(8, (b) => HederaFilteredItemHash.deserialize(b)),
      blockProof: decode.messageTo<com_hedera_hapi_block_stream_block_proof.HederaBlockProof?>(9, (b) => com_hedera_hapi_block_stream_block_proof.HederaBlockProof.deserialize(b)),
      recordFile: decode.messageTo<com_hedera_hapi_block_stream_record_file_item.HederaRecordFileItem?>(10, (b) => com_hedera_hapi_block_stream_record_file_item.HederaRecordFileItem.deserialize(b)),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiBlockStreamBlockItem;

}


/// *
///  * Verification data for an item filtered from the stream.
///  *
///  * Items of this type SHALL NOT be present in the full (unfiltered) block
///  * stream.&lt;br/&gt;
///  * Items of this type SHALL replace any item removed from a partial (filtered)
///  * block stream.&lt;br/&gt;
///  * Presence of `filtered_item` entries SHALL NOT prevent verification
///  * of a block, but MAY preclude verification or reconstruction
///  * of consensus state.&lt;br/&gt;
class HederaFilteredItemHash extends HederaProtoMessage with Equality {
    /// *
  ///      * A hash of an item filtered from the stream.
  ///      * &lt;p&gt;
  ///      * The hash algorithm used MUST match the hash algorithm specified in
  ///      * the block header for the containing block.&lt;br/&gt;
  ///      * This field is REQUIRED.
  final List<int>? itemHash;

    /// *
  ///      * A record of the merkle path to the item that was filtered
  ///      * from the stream.&lt;br/&gt;
  ///      * This path begins at the root of the block proof merkle tree.
  ///      * &lt;p&gt;
  ///      * This REQUIRED field SHALL describe the full path in the virtual
  ///      * merkle tree constructed for the block proof that contained the
  ///      * item filtered from the stream.
  final BigInt? filteredPath;

  const HederaFilteredItemHash({
    this.itemHash,
    this.filteredPath,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.uint64(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        itemHash,
        filteredPath,
      ];


HederaFilteredItemHash copyWith(
{List<int>? itemHash,

BigInt? filteredPath,

}) {
    return HederaFilteredItemHash(
itemHash: itemHash ?? this.itemHash,
filteredPath: filteredPath ?? this.filteredPath,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'item_hash': config.encodeBinary(itemHash),
      'filtered_path': config.encodeBigint(filteredPath),
    };
  }


  factory HederaFilteredItemHash.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaFilteredItemHash(
      itemHash: config.decodeBinary<List<int>?>(json.valueAs('item_hash', normalizeKeyLookup: config.normalizeKeys)),
      filteredPath: json.valueAsBigInt<BigInt?>('filtered_path', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaFilteredItemHash.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaFilteredItemHash(
      itemHash: decode.getBytes<List<int>?>(1),
      filteredPath: decode.getBigInt<BigInt?>(3),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiBlockStreamFilteredItemHash;

}


