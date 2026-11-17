import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/block/stream/src/block_item.dart" as com_hedera_hapi_block_stream_block_item;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/block/stream/src/block.dart" as com_hedera_hapi_block_stream_block;
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart" as proto_basic_types;

/// *
///  * An enumeration indicating why a Publisher ended a stream.
///  *
///  * This enumeration describes the reason a block stream
///  * (sent via `publishBlockStream`) was ended by the Publisher.
enum HederaPublishStreamEndCode implements ProtoEnumVariant {
    /// *
  ///      * An "unset value" flag, this value SHALL NOT be used.&lt;br/&gt;
  ///      * This status indicates the server software failed to set a
  ///      * status, and SHALL be considered a software defect.
  streamEndUnknown(0, 'STREAM_END_UNKNOWN'),
    /// *
  ///      * The Publisher reached a reset point.&lt;br/&gt;
  ///      * No errors occurred and the source Block-Node orderly ended the stream.
  ///      *
  ///      * Publishers SHOULD use this code to end a stream and restart
  ///      * occasionally. Occasionally resetting the stream increases stability and
  ///      * allows for routine network configuration changes.
  streamEndReset(1, 'STREAM_END_RESET'),
    /// *
  ///      * The delay between items was too long.&lt;br/&gt;
  ///      * The destination system did not timely acknowledge a block.
  ///      * &lt;p&gt;
  ///      * The source SHALL start a new stream before the failed block.
  streamEndTimeout(2, 'STREAM_END_TIMEOUT'),
    /// *
  ///      * The Publisher encountered an error.&lt;br/&gt;
  ///      * The Publisher encountered an internal error and must try again later.
  ///      * &lt;p&gt;
  ///      * Publishers that encounter internal logic errors, find themselves
  ///      * "behind" the network, or otherwise detect an unexpected situation MUST
  ///      * send this code and restart the stream before the failed block.
  streamEndError(3, 'STREAM_END_ERROR'),
    /// *
  ///      * The Block-Node is too far behind to catch up directly.&lt;br/&gt;
  ///      * The Block-Node responded to a block header with "BEHIND" and is
  ///      * too far behind the Publisher.
  ///      * &lt;p&gt;
  ///      * The Block-Node MUST recover and "catch up" from another trustworthy
  ///      * Block-Node.&lt;br/&gt;
  ///      * The Publisher MAY stream items to a different Block-Node.&lt;br/&gt;
  ///      * The Publisher MAY resume streaming to this Block-Node later.&lt;br/&gt;
  ///      * The `EndOfStream` message MUST include the earliest and latest blocks
  ///      * currently available from the Publisher.&lt;br/&gt;
  ///      * The Block-Node SHOULD attempt to "catch up" to the _latest_ block
  ///      * available from the Publisher.
  streamEndTooFarBehind(4, 'STREAM_END_TOO_FAR_BEHIND');

  const HederaPublishStreamEndCode(this.value, this.protoName);
  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static HederaPublishStreamEndCode fromValue(int? value) {
    value ??=0;
    return HederaPublishStreamEndCode.values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching HederaPublishStreamEndCode found for the given value. $value", details: {"name": "HederaPublishStreamEndCode", "value": value?.toString()})
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static HederaPublishStreamEndCode from(Object? value) {
    value ??=0;
    return HederaPublishStreamEndCode.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching HederaPublishStreamEndCode found for the given value. $value", details: {"name": "HederaPublishStreamEndCode", "value": value?.toString()})
    );
  }

}


/// *
///  * An enumeration indicating the status of this request.
///  *
///  * This enumeration SHALL describe the reason a block stream
///  * (sent via `publishBlockStream`) ended.
enum HederaPublishStreamResponseCode implements ProtoEnumVariant {
    /// *
  ///      * An "unset value" flag, this value SHALL NOT be used.&lt;br/&gt;
  ///      * This status indicates the server software failed to set a
  ///      * status, and SHALL be considered a software defect.
  streamItemsUnknown(0, 'STREAM_ITEMS_UNKNOWN'),
    /// *
  ///      * The request succeeded.&lt;br/&gt;
  ///      * No errors occurred and the receiving Block-Node orderly ended the stream.
  ///      * &lt;p&gt;
  ///      * The Publisher MAY start a new stream beginning with the next block.
  streamItemsSuccess(1, 'STREAM_ITEMS_SUCCESS'),
    /// *
  ///      * The delay between items was too long.
  ///      * &lt;p&gt;
  ///      * The source MUST start a new stream before the failed block.
  streamItemsTimeout(2, 'STREAM_ITEMS_TIMEOUT'),
    /// *
  ///      * An item was received out-of-order.&lt;br/&gt;
  ///      * This might be two headers without a proof between them, or similar.
  ///      * &lt;p&gt;
  ///      * The source MUST start a new stream before the failed block.
  streamItemsOutOfOrder(3, 'STREAM_ITEMS_OUT_OF_ORDER'),
    /// *
  ///      * A block state proof item could not be validated.&lt;br/&gt;
  ///      * The source MUST start a new stream before the failed block.
  streamItemsBadStateProof(4, 'STREAM_ITEMS_BAD_STATE_PROOF'),
    /// *
  ///      * The Block-Node is "behind" the Publisher.&lt;br/&gt;
  ///      * Ths Publisher has sent a block later than this Block-Node
  ///      * can process. The Publisher may retry by sending blocks immediately
  ///      * following the `block_number` returned, or may connect
  ///      * to another Block-Node.
  ///      * &lt;p&gt;
  ///      * Block-Nodes that are "behind" SHOULD attempt to "catch up" by requesting
  ///      * blocks from another Block-Node or other source of recent historical
  ///      * block stream data.
  streamItemsBehind(5, 'STREAM_ITEMS_BEHIND'),
    /// *
  ///      * The Block-Node had an internal error and cannot continue processing.&lt;br/&gt;
  ///      * The Publisher may retry again later.
  streamItemsInternalError(6, 'STREAM_ITEMS_INTERNAL_ERROR'),
    /// *
  ///      * The Block-Node failed to store the block persistently.
  ///      * &lt;p&gt;
  ///      * The Publisher SHOULD start a new stream to send the block to
  ///      * this Block-Node, or any other reliable Block-Node.
  ///      * The Publisher MUST NOT discard the block until it is successfully
  ///      * persisted and verified (and acknowledged) by at least one Block-Node.
  streamItemsPersistenceFailed(7, 'STREAM_ITEMS_PERSISTENCE_FAILED');

  const HederaPublishStreamResponseCode(this.value, this.protoName);
  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static HederaPublishStreamResponseCode fromValue(int? value) {
    value ??=0;
    return HederaPublishStreamResponseCode.values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching HederaPublishStreamResponseCode found for the given value. $value", details: {"name": "HederaPublishStreamResponseCode", "value": value?.toString()})
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static HederaPublishStreamResponseCode from(Object? value) {
    value ??=0;
    return HederaPublishStreamResponseCode.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching HederaPublishStreamResponseCode found for the given value. $value", details: {"name": "HederaPublishStreamResponseCode", "value": value?.toString()})
    );
  }

}


/// *
///  * An enumeration indicating the status of this request.
enum HederaSingleBlockResponseCode implements ProtoEnumVariant {
    /// *
  ///      * An "unset value" flag, this value SHALL NOT be used.&lt;br/&gt;
  ///      * This status indicates the server software failed to set a status,
  ///      * and SHALL be considered a software defect.
  readBlockUnknown(0, 'READ_BLOCK_UNKNOWN'),
    /// *
  ///      * The requesting client account lacks sufficient HBAR to pay the
  ///      * service fee for this request.&lt;br/&gt;
  ///      * The client MAY retry the request, but MUST increase the client
  ///      * account balance with this Block-Node before doing so.
  readBlockInsufficientBalance(1, 'READ_BLOCK_INSUFFICIENT_BALANCE'),
    /// *
  ///      * The request succeeded.&lt;br/&gt;
  ///      * The requested block SHALL be returned in the `block` field.
  readBlockSuccess(2, 'READ_BLOCK_SUCCESS'),
    /// *
  ///      * The requested block was not found.&lt;br/&gt;
  ///      * Something failed and a block that should be available was
  ///      * not found.
  ///      * &lt;p&gt;
  ///      * The client MAY retry the request; if this result is repeated the
  ///      * request SHOULD be directed to a different Block-Node.
  readBlockNotFound(3, 'READ_BLOCK_NOT_FOUND'),
    /// *
  ///      * The requested block is not available on this Block-Node.
  ///      * &lt;p&gt;
  ///      * The client SHOULD send a `serverStatus` request to determine the
  ///      * lowest and highest block numbers available at this Block-Node.
  readBlockNotAvailable(4, 'READ_BLOCK_NOT_AVAILABLE'),
    /// *
  ///      * The request for a verified block cannot be fulfilled.&lt;br/&gt;
  ///      * The client requested a verified block from a Block-Node that does not
  ///      * offer verified blocks.
  ///      * &lt;p&gt;
  ///      * The client MAY retry the request with the `allow_unverified` flag set.
  allowUnverifiedRequired(5, 'ALLOW_UNVERIFIED_REQUIRED'),
    /// *
  ///      * The request for a verified block cannot be fulfilled.&lt;br/&gt;
  ///      * The client requested a verified block from a Block-Node but the
  ///      * requested block is not yet verified.
  ///      * &lt;p&gt;
  ///      * The client MAY retry the request after a short delay
  ///      * (typically 2 seconds or more).
  verifiedBlockUnavailable(6, 'VERIFIED_BLOCK_UNAVAILABLE');

  const HederaSingleBlockResponseCode(this.value, this.protoName);
  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static HederaSingleBlockResponseCode fromValue(int? value) {
    value ??=0;
    return HederaSingleBlockResponseCode.values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching HederaSingleBlockResponseCode found for the given value. $value", details: {"name": "HederaSingleBlockResponseCode", "value": value?.toString()})
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static HederaSingleBlockResponseCode from(Object? value) {
    value ??=0;
    return HederaSingleBlockResponseCode.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching HederaSingleBlockResponseCode found for the given value. $value", details: {"name": "HederaSingleBlockResponseCode", "value": value?.toString()})
    );
  }

}


/// *
/// * An enumeration indicating the status of this request.
/// *
/// * This response code SHALL be the last message in the stream of responses.
/// * This code SHALL represent the final status of the full request.
enum HederaSubscribeStreamResponseCode implements ProtoEnumVariant {
    /// *
  ///      * An "unset value" flag, this value SHALL NOT be used.&lt;br/&gt;
  ///      * This status indicates the server software failed to set a status,
  ///      * and SHALL be considered a software defect.
  readStreamUnknown(0, 'READ_STREAM_UNKNOWN'),
    /// *
  ///      * The requesting client account lacks sufficient HBAR to pay the
  ///      * service fee for this request.
  ///      * &lt;p&gt;
  ///      * The client MAY retry the request, but MUST increase the client
  ///      * account balance with this Block-Node before doing so.
  readStreamInsufficientBalance(1, 'READ_STREAM_INSUFFICIENT_BALANCE'),
    /// *
  ///      * The request succeeded.
  ///      * &lt;p&gt;
  ///      * The requested block(s) SHALL precede the status response
  ///      * with this value.
  readStreamSuccess(2, 'READ_STREAM_SUCCESS'),
    /// *
  ///      * The requested start block number is not valid.&lt;br/&gt;
  ///      * The start block number is after the end block number, less
  ///      * than `0`, or otherwise invalid.&lt;br/&gt;
  ///      * The client MAY retry this request, but MUST change the
  ///      * `start_block_number` field to a valid start block.
  readStreamInvalidStartBlockNumber(3, 'READ_STREAM_INVALID_START_BLOCK_NUMBER'),
    /// *
  ///      * The requested end block number is not valid.&lt;br/&gt;
  ///      * The end block number is greater than the highest current block
  ///      * number, less than `0`, or otherwise invalid.&lt;br/&gt;
  ///      * The client MAY retry this request, but MUST change the
  ///      * `end_block_number` field to a valid end block.
  readStreamInvalidEndBlockNumber(4, 'READ_STREAM_INVALID_END_BLOCK_NUMBER'),
    /// *
  ///      * The requested stream is not available.&lt;br/&gt;
  ///      * The client MAY retry again later.
  readStreamNotAvailable(5, 'READ_STREAM_NOT_AVAILABLE');

  const HederaSubscribeStreamResponseCode(this.value, this.protoName);
  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static HederaSubscribeStreamResponseCode fromValue(int? value) {
    value ??=0;
    return HederaSubscribeStreamResponseCode.values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching HederaSubscribeStreamResponseCode found for the given value. $value", details: {"name": "HederaSubscribeStreamResponseCode", "value": value?.toString()})
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static HederaSubscribeStreamResponseCode from(Object? value) {
    value ??=0;
    return HederaSubscribeStreamResponseCode.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching HederaSubscribeStreamResponseCode found for the given value. $value", details: {"name": "HederaSubscribeStreamResponseCode", "value": value?.toString()})
    );
  }

}


/// *
///  * An enumeration indicating the status of a StateSnapshotResponse request.
enum HederaStateSnapshotResponseCode implements ProtoEnumVariant {
    /// *
  ///      * An "unset value" flag, this value SHALL NOT be used.&lt;br/&gt;
  ///      * This status indicates the server software failed to set a status,
  ///      * and SHALL be considered a software defect.
  stateSnapshotUnknown(0, 'STATE_SNAPSHOT_UNKNOWN'),
    /// *
  ///      * The requesting client account lacks sufficient HBAR to pay the
  ///      * service fee for this request.
  ///      * &lt;p&gt;
  ///      * The client MAY retry the request, but MUST increase the client
  ///      * account balance with this Block-Node before doing so.
  stateSnapshotInsufficientBalance(1, 'STATE_SNAPSHOT_INSUFFICIENT_BALANCE'),
    /// *
  ///      * The request succeeded.
  ///      * &lt;p&gt;
  ///      * The full snapshot data MAY be read via the endpoint provided in the
  ///      * `snapshot_reference` field for the duration specified.
  stateSnapshotSuccess(2, 'STATE_SNAPSHOT_SUCCESS');

  const HederaStateSnapshotResponseCode(this.value, this.protoName);
  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static HederaStateSnapshotResponseCode fromValue(int? value) {
    value ??=0;
    return HederaStateSnapshotResponseCode.values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching HederaStateSnapshotResponseCode found for the given value. $value", details: {"name": "HederaStateSnapshotResponseCode", "value": value?.toString()})
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static HederaStateSnapshotResponseCode from(Object? value) {
    value ??=0;
    return HederaStateSnapshotResponseCode.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching HederaStateSnapshotResponseCode found for the given value. $value", details: {"name": "HederaStateSnapshotResponseCode", "value": value?.toString()})
    );
  }

}


/// *
///  * # Block Service
///  * The Service API exposed by the Block Nodes.
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
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.block"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * Publish a stream of block items.
///  *
///  * Each request in the stream MUST contain at least one `BlockItem`.&lt;br/&gt;
///  * Each request MAY contain more than one `BlockItem`.&lt;br/&gt;
///  * A single request MUST NOT contain `BlockItem`s from more than one block.&lt;br/&gt;
///  * Each request MAY contain a variable number of `BlockItem`s.&lt;br/&gt;
///  * Each Block MUST begin with a single `BlockHeader` block item.&lt;br/&gt;
///  * If a `BlockHeader` is present in a request, it MUST be the first `BlockItem`
///  * in the `block_items` list.&lt;br/&gt;
///  * The Block-Node SHALL append each `BlockItem` to an internal structure
///  * to reconstruct full blocks.&lt;br/&gt;
///  * The Block-Node MUST verify the block proof for each block before sending a
///  * response message acknowledging that block.&lt;br/&gt;
///  * Each Block MUST end with a single `BlockProof` block item.&lt;br/&gt;
///  * If a `BlockProof` is present in a request, it MUST be the last `BlockItem`
///  * in the `block_items` list.&lt;br/&gt;
///  * The Block-Node MUST verify each Block using the `BlockProof` to
///  * ensure all data was received and processed correctly.
class HederaPublishStreamRequest extends HederaProtoMessage with Equality {
    /// *
  ///          * A stream item containing one or more `BlockItem`s.
  ///          * &lt;p&gt;
  ///          * The full stream SHALL consist of many `block_items` messages
  ///          * followed by a single `status` message.
  final HederaBlockItemSet? blockItems;

  const HederaPublishStreamRequest({
    this.blockItems,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        blockItems,
      ];


HederaPublishStreamRequest copyWith(
{HederaBlockItemSet? blockItems,

}) {
    return HederaPublishStreamRequest(
blockItems: blockItems ?? this.blockItems,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'block_items': config.encodeMessage(blockItems),
    };
  }


  factory HederaPublishStreamRequest.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaPublishStreamRequest(
      blockItems: json.valueTo<HederaBlockItemSet?, Object>(
        key: 'block_items',
        parse: (v) => HederaBlockItemSet.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory HederaPublishStreamRequest.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaPublishStreamRequest(
      blockItems: decode.messageTo<HederaBlockItemSet?>(1, (b) => HederaBlockItemSet.deserialize(b)),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiBlockPublishStreamRequest;

}


/// *
///  * A wrapper around a repeated BlockItem.&lt;br/&gt;
///  * This message is required so that we can include ordered lists of block
///  * items as `oneof` alternatives in streams.
///  *
///  * Each `BlockItemSet` MUST contain at least one `BlockItem`,
///  * and MAY contain up to one full block.&lt;br/&gt;
///  * A single `BlockItemSet` SHALL NOT contain block items from
///  * more than one block.&lt;br/&gt;
///  * If a `BlockHeader` is present in a `BlockItemSet`, that item
///  * MUST be the first item in the list.&lt;br/&gt;
///  * If a `BlockProof` is present in a `BlockItemSet`, that item
///  * MUST be the last item in the list.
class HederaBlockItemSet extends HederaProtoMessage with Equality {
    /// *
  ///      * An ordered list of `BlockItem`s.&lt;br/&gt;
  ///      * This list supports sending block items to subscribers in batches
  ///      * for greater channel efficiency.
  final List<com_hedera_hapi_block_stream_block_item.HederaBlockItem> blockItems;

  const HederaBlockItemSet({
    this.blockItems = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.repeated(
          fieldNumber: 1,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        blockItems,
      ];


HederaBlockItemSet copyWith(
{List<com_hedera_hapi_block_stream_block_item.HederaBlockItem>? blockItems,

}) {
    return HederaBlockItemSet(
blockItems: blockItems ?? this.blockItems,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'block_items': blockItems.map((e) => config.encodeMessage(e)).toList(),
    };
  }


  factory HederaBlockItemSet.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaBlockItemSet(
      blockItems: (json.valueEnsureAsList<dynamic>('block_items', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<com_hedera_hapi_block_stream_block_item.HederaBlockItem, Object>(
          value: e,
          parse: (v) => com_hedera_hapi_block_stream_block_item.HederaBlockItem.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
    );
  }

  factory HederaBlockItemSet.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaBlockItemSet(
      blockItems: decode.getListOfBytes(1).map((b) => com_hedera_hapi_block_stream_block_item.HederaBlockItem.deserialize(b)).toList(),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiBlockBlockItemSet;

}


/// *
///  * A response to writing a block stream.
///  *
///  * This message is sent in response to each Block in a block stream sent
///  * to a Block-Node. The block stream is sent as a stream of messages, and each
///  * message MAY be acknowledged with a message of this type.&lt;br/&gt;
///  * Each `BlockItem` MAY be acknowledged with an `Acknowledgement`
///  * response. Item acknowledgement is an OPTIONAL feature.&lt;br/&gt;
///  * Each completed block SHALL be acknowledged with an `Acknowledgement`
///  * response. Block acknowledgement is a REQUIRED feature.&lt;br/&gt;
///  * A final response SHALL be sent with an `EndOfStream` status result after
///  * the last block stream item is received, or when the Block-Node must end the
///  * stream for any reason.&lt;br/&gt;
///  * At any time, a Block-Node MAY send a `SkipBlock` response to request that
///  * the Publisher skip the current block and resume with the next. When a
///  * Block-Node sends a `SkipBlock`, that Block-Node SHALL subsequently send
///  * an `Acknowledgement` for the same block, or SHALL send a `ResendBlock`
///  * message.
///  * If a failure is detected (which may include a block or block item that
///  * fails validation) an `EndOfStream` response SHALL be sent with a
///  * relevant error status.
class HederaPublishStreamResponse extends HederaProtoMessage with Equality {
    /// *
  ///          * A response sent to acknowledge successful receipt of a block.
  final HederaPublishStreamResponseAcknowledgement? acknowledgement;

    /// *
  ///          * A response sent to request the Publisher end the current stream.
  final HederaPublishStreamResponseEndOfStream? endStream;

    /// *
  ///          * A response sent to request the Publisher skip the current block.
  final HederaPublishStreamResponseSkipBlock? skipBlock;

    /// *
  ///          * A response sent to request the Publisher resend a skipped block.
  final HederaPublishStreamResponseResendBlock? resendBlock;

  const HederaPublishStreamResponse({
    this.acknowledgement,
    this.endStream,
    this.skipBlock,
    this.resendBlock,
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
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        acknowledgement,
        endStream,
        skipBlock,
        resendBlock,
      ];


HederaPublishStreamResponse copyWith(
{HederaPublishStreamResponseAcknowledgement? acknowledgement,

HederaPublishStreamResponseEndOfStream? endStream,

HederaPublishStreamResponseSkipBlock? skipBlock,

HederaPublishStreamResponseResendBlock? resendBlock,

}) {
    return HederaPublishStreamResponse(
acknowledgement: acknowledgement ?? this.acknowledgement,
endStream: endStream ?? this.endStream,
skipBlock: skipBlock ?? this.skipBlock,
resendBlock: resendBlock ?? this.resendBlock,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'acknowledgement': config.encodeMessage(acknowledgement),
      'end_stream': config.encodeMessage(endStream),
      'skip_block': config.encodeMessage(skipBlock),
      'resend_block': config.encodeMessage(resendBlock),
    };
  }


  factory HederaPublishStreamResponse.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaPublishStreamResponse(
      acknowledgement: json.valueTo<HederaPublishStreamResponseAcknowledgement?, Object>(
        key: 'acknowledgement',
        parse: (v) => HederaPublishStreamResponseAcknowledgement.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      endStream: json.valueTo<HederaPublishStreamResponseEndOfStream?, Object>(
        key: 'end_stream',
        parse: (v) => HederaPublishStreamResponseEndOfStream.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      skipBlock: json.valueTo<HederaPublishStreamResponseSkipBlock?, Object>(
        key: 'skip_block',
        parse: (v) => HederaPublishStreamResponseSkipBlock.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      resendBlock: json.valueTo<HederaPublishStreamResponseResendBlock?, Object>(
        key: 'resend_block',
        parse: (v) => HederaPublishStreamResponseResendBlock.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory HederaPublishStreamResponse.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaPublishStreamResponse(
      acknowledgement: decode.messageTo<HederaPublishStreamResponseAcknowledgement?>(1, (b) => HederaPublishStreamResponseAcknowledgement.deserialize(b)),
      endStream: decode.messageTo<HederaPublishStreamResponseEndOfStream?>(2, (b) => HederaPublishStreamResponseEndOfStream.deserialize(b)),
      skipBlock: decode.messageTo<HederaPublishStreamResponseSkipBlock?>(3, (b) => HederaPublishStreamResponseSkipBlock.deserialize(b)),
      resendBlock: decode.messageTo<HederaPublishStreamResponseResendBlock?>(4, (b) => HederaPublishStreamResponseResendBlock.deserialize(b)),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiBlockPublishStreamResponse;

}


/// *
///      * A response to acknowledge receipt and verification of a single item
///      * or full block.
class HederaPublishStreamResponseAcknowledgement extends HederaProtoMessage with Equality {
    /// *
  ///          * A response type to acknowledge a full and complete block.
  ///          * &lt;p&gt;
  ///          * All Block-Nodes SHOULD acknowledge each block.
  final HederaPublishStreamResponseBlockAcknowledgement? blockAck;

  const HederaPublishStreamResponseAcknowledgement({
    this.blockAck,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        blockAck,
      ];


HederaPublishStreamResponseAcknowledgement copyWith(
{HederaPublishStreamResponseBlockAcknowledgement? blockAck,

}) {
    return HederaPublishStreamResponseAcknowledgement(
blockAck: blockAck ?? this.blockAck,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'block_ack': config.encodeMessage(blockAck),
    };
  }


  factory HederaPublishStreamResponseAcknowledgement.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaPublishStreamResponseAcknowledgement(
      blockAck: json.valueTo<HederaPublishStreamResponseBlockAcknowledgement?, Object>(
        key: 'block_ack',
        parse: (v) => HederaPublishStreamResponseBlockAcknowledgement.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory HederaPublishStreamResponseAcknowledgement.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaPublishStreamResponseAcknowledgement(
      blockAck: decode.messageTo<HederaPublishStreamResponseBlockAcknowledgement?>(1, (b) => HederaPublishStreamResponseBlockAcknowledgement.deserialize(b)),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiBlockPublishStreamResponseAcknowledgement;

}


/// *
///      * Acknowledgement of a full block.&lt;br/&gt;
///      * This message is a necessary part of the block streaming protocol.
///      *
///      * This response SHALL be sent after a block state proof item is
///      * received and verified.&lt;br/&gt;
///      * The Block-Node SHALL send exactly one `BlockAcknowledgement` for
///      * each successful block.
class HederaPublishStreamResponseBlockAcknowledgement extends HederaProtoMessage with Equality {
    /// *
  ///          * A block number number of the acknowledged block.
  ///          * &lt;p&gt;
  ///          * A Publisher SHOULD verify that this value matches the block sent.
  final BigInt? blockNumber;

    /// *
  ///          * A hash of the virtual merkle root for the block.
  ///          * &lt;p&gt;
  ///          * This SHALL be the hash calculated by the Block-Node for the
  ///          * root node of the virtual merkle tree that is signed by the source
  ///          * system to validate the block.
  final List<int>? blockRootHash;

    /// *
  ///          * A flag indicating that the received block duplicates an
  ///          * existing block.
  ///          * &lt;p&gt;
  ///          * If a Publisher receives acknowledgement with this flag set
  ///          * true the Publisher MAY end the stream.&lt;br/&gt;
  ///          * The `block_number` returned SHALL be the last block known and
  ///          * verified by the Block-Node.&lt;br/&gt;
  ///          * The Publisher MAY resume publishing immediately after the indicated
  ///          * block.
  final bool? blockAlreadyExists;

  const HederaPublishStreamResponseBlockAcknowledgement({
    this.blockNumber,
    this.blockRootHash,
    this.blockAlreadyExists,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.uint64(1),
        ProtoFieldConfig.bytes(2),
        ProtoFieldConfig.bool(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        blockNumber,
        blockRootHash,
        blockAlreadyExists,
      ];


HederaPublishStreamResponseBlockAcknowledgement copyWith(
{BigInt? blockNumber,

List<int>? blockRootHash,

bool? blockAlreadyExists,

}) {
    return HederaPublishStreamResponseBlockAcknowledgement(
blockNumber: blockNumber ?? this.blockNumber,
blockRootHash: blockRootHash ?? this.blockRootHash,
blockAlreadyExists: blockAlreadyExists ?? this.blockAlreadyExists,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'block_number': config.encodeBigint(blockNumber),
      'block_root_hash': config.encodeBinary(blockRootHash),
      'block_already_exists': blockAlreadyExists,
    };
  }


  factory HederaPublishStreamResponseBlockAcknowledgement.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaPublishStreamResponseBlockAcknowledgement(
      blockNumber: json.valueAsBigInt<BigInt?>('block_number', normalizeKeyLookup: config.normalizeKeys),
      blockRootHash: config.decodeBinary<List<int>?>(json.valueAs('block_root_hash', normalizeKeyLookup: config.normalizeKeys)),
      blockAlreadyExists: json.valueAsBool<bool?>('block_already_exists', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaPublishStreamResponseBlockAcknowledgement.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaPublishStreamResponseBlockAcknowledgement(
      blockNumber: decode.getBigInt<BigInt?>(1),
      blockRootHash: decode.getBytes<List<int>?>(2),
      blockAlreadyExists: decode.getBool<bool?>(3),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiBlockPublishStreamResponseBlockAcknowledgement;

}


/// *
///      * Message indicating the Publisher should skip the current block.
///      *
///      * Block-Nodes SHOULD only skip a block if that block is currently being
///      * received from another source.&lt;br/&gt;
///      * Publishers MUST stop sending the current block and resume with
///      * the block header for the next block, or else end the stream.&lt;br/&gt;
///      * A Publisher that receives this message SHALL subsequently receive an
///      * acknowledgement for the skipped block or SHALL receive a `ResendBlock`
///      * message.&lt;br/&gt;
///      * A Publisher asked to skip a block SHOULD NOT delay any subsequent
///      * block, but should send that block as soon as it is available.&lt;br/&gt;
///      * A Publisher MAY be asked to skip multiple blocks in succession, but
///      * SHOULD interpret that as the presence of another Publisher with a
///      * lower latency connection.&lt;br/&gt;
///      * A Publisher MAY choose to end the stream and send the block to a
///      * different Block-Node, rather than skip sending the block to the
///      * current Block-Node.
class HederaPublishStreamResponseSkipBlock extends HederaProtoMessage with Equality {
    /// *
  ///          * The number of the _unverified_ block to skip.
  ///          * &lt;p&gt;
  ///          * This MUST match the block number of the `BlockHeader` most recently
  ///          * sent by the Publisher.
  final BigInt? blockNumber;

  const HederaPublishStreamResponseSkipBlock({
    this.blockNumber,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.uint64(2),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        blockNumber,
      ];


HederaPublishStreamResponseSkipBlock copyWith(
{BigInt? blockNumber,

}) {
    return HederaPublishStreamResponseSkipBlock(
blockNumber: blockNumber ?? this.blockNumber,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'block_number': config.encodeBigint(blockNumber),
    };
  }


  factory HederaPublishStreamResponseSkipBlock.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaPublishStreamResponseSkipBlock(
      blockNumber: json.valueAsBigInt<BigInt?>('block_number', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaPublishStreamResponseSkipBlock.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaPublishStreamResponseSkipBlock(
      blockNumber: decode.getBigInt<BigInt?>(2),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiBlockPublishStreamResponseSkipBlock;

}


/// *
///      * Message indicating the Publisher must resend from a specified block.
///      * A Publisher might resend the block, if it has that block available,
///      * or it might choose to end the stream if it has already received
///      * acknowledgement from a different trustworthy Block-Node.
///      *
///      * On receiving this message, a Publisher MUST resume sending blocks at
///      * the block number indicated, or else end the stream.&lt;br/&gt;
///      * This message SHALL only be sent following a `SkipBlock` message for a
///      * block that has not been acknowledged.&lt;br/&gt;
///      * A Block-Node SHALL NOT send a `ResendBlock` message for any block that
///      * is already acknowledged.&lt;br/&gt;
///      * A Publisher MAY choose to end the stream rather than resend the
///      * the requested block.
class HederaPublishStreamResponseResendBlock extends HederaProtoMessage with Equality {
    /// *
  ///          * The number of the _unverified_ block to re-send.
  ///          * &lt;p&gt;
  ///          * This SHALL be the block number one greater than the last block
  ///          * this Block-Node has successfully stored and verified.
  final BigInt? blockNumber;

  const HederaPublishStreamResponseResendBlock({
    this.blockNumber,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.uint64(2),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        blockNumber,
      ];


HederaPublishStreamResponseResendBlock copyWith(
{BigInt? blockNumber,

}) {
    return HederaPublishStreamResponseResendBlock(
blockNumber: blockNumber ?? this.blockNumber,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'block_number': config.encodeBigint(blockNumber),
    };
  }


  factory HederaPublishStreamResponseResendBlock.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaPublishStreamResponseResendBlock(
      blockNumber: json.valueAsBigInt<BigInt?>('block_number', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaPublishStreamResponseResendBlock.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaPublishStreamResponseResendBlock(
      blockNumber: decode.getBigInt<BigInt?>(2),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiBlockPublishStreamResponseResendBlock;

}


/// *
///      * A message sent to end a stream.
///      *
///      * This response message SHALL be sent from a Block-Node to a block
///      * stream Publisher when a `publishBlockStream` stream ends.&lt;br/&gt;
///      * This message SHALL be sent exactly once for each `publishBlockStream`
///      * call.&lt;br/&gt;
///      * The Publisher SHALL cease sending block items upon receiving
///      * this response, and MAY determine the ending state of the stream from
///      * the `status` enumeration and the `block_number` returned.&lt;br/&gt;
///      * A Publisher SHOULD verify that the `block_number` value matches the
///      * last block sent, and SHOULD resend one or more blocks if the value
///      * here does not match the expected value.
class HederaPublishStreamResponseEndOfStream extends HederaProtoMessage with Equality {
    /// *
  ///          * A response code.
  ///          * &lt;p&gt;
  ///          * This code indicates the reason the stream ended.&lt;br/&gt;
  ///          * This value MUST be set to a non-default value.
  final HederaPublishStreamResponseCode? status;

    /// *
  ///          * The number of the last completed and _verified_ block.
  ///          * &lt;p&gt;
  ///          * Block-Nodes SHOULD only end a stream after a block state proof to avoid
  ///          * the need to resend items.&lt;br/&gt;
  ///          * If status is a failure code, the Publisher MUST start a new
  ///          * stream at the beginning of the first block _following_ this number
  ///          * (e.g. if this is 91827362983, then the new stream must start with
  ///          * the _header_ for block 91827362984).
  final BigInt? blockNumber;

  const HederaPublishStreamResponseEndOfStream({
    this.status,
    this.blockNumber,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.enumType(1),
        ProtoFieldConfig.uint64(2),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        status,
        blockNumber,
      ];


HederaPublishStreamResponseEndOfStream copyWith(
{HederaPublishStreamResponseCode? status,

BigInt? blockNumber,

}) {
    return HederaPublishStreamResponseEndOfStream(
status: status ?? this.status,
blockNumber: blockNumber ?? this.blockNumber,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'status': config.encodeEnum(status),
      'block_number': config.encodeBigint(blockNumber),
    };
  }


  factory HederaPublishStreamResponseEndOfStream.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaPublishStreamResponseEndOfStream(
      status: json.valueTo<HederaPublishStreamResponseCode?, Object?>(
        key: 'status',
        parse: (v) => HederaPublishStreamResponseCode.from(v),
      ),
      blockNumber: json.valueAsBigInt<BigInt?>('block_number', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaPublishStreamResponseEndOfStream.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaPublishStreamResponseEndOfStream(
      status: decode.getEnum<HederaPublishStreamResponseCode?>(1, HederaPublishStreamResponseCode.values),
      blockNumber: decode.getBigInt<BigInt?>(2),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiBlockPublishStreamResponseEndOfStream;

}


/// *
///  * A request to read a single block.
///  *
///  * A client system SHALL send this message to request a single block,
///  * including the block state proof.&lt;br/&gt;
///  * A client MAY request that the block be sent without verification.
///  * A compliant Block-Node MAY respond to requests that allow unverified
///  * responses by returning the full requested block before verifying
///  * the included block proof.&lt;br/&gt;
///  * A compliant Block-Node MAY support _only_ requests that allow unverified
///  * blocks, but MUST clearly document that limitation, and MUST respond to
///  * a request that does not allow unverified blocks with the
///  * `ALLOW_UNVERIFIED_REQUIRED` response code.
class HederaSingleBlockRequest extends HederaProtoMessage with Equality {
    /// *
  ///      * The block number of a block to retrieve.
  ///      * &lt;p&gt;
  ///      * The requested block MUST exist on the Block-Node.&lt;br/&gt;
  ///      * This value MUST NOT be set if `retrieve_latest` is set `true`.&lt;br/&gt;
  ///      * This value MUST be set to a valid block number if `retrieve_latest` is
  ///      * unset or is set `false`.
  final BigInt? blockNumber;

    /// *
  ///      * A flag to indicate that the requested block may be sent without
  ///      * verifying its `BlockProof`.&lt;br/&gt;
  ///      * This might be set by a client that expects to perform its own
  ///      * verification and wishes lower latency or, potentially, lower cost.
  ///      * &lt;p&gt;
  ///      * If this value is set, then the responding Block-Node MAY respond with a
  ///      * block that has not completed verification of its `BlockProof`.&lt;br/&gt;
  ///      * If this is _not_ set then the Block-Node MUST respond with either a
  ///      * fully verified and validated block, or `VERIFIED_BLOCK_UNAVAILABLE` if
  ///      * the requested block is not yet verified.&lt;br/&gt;
  ///      * The default value is _not set_.
  final bool? allowUnverified;

    /// *
  ///      * A flag to request the latest available block.
  ///      * &lt;p&gt;
  ///      * This value MAY be set `true` to request the last block available.&lt;br/&gt;
  ///      * If this value is set to `true` then `block_number` MUST NOT be set and
  ///      * SHALL be ignored.
  final bool? retrieveLatest;

  const HederaSingleBlockRequest({
    this.blockNumber,
    this.allowUnverified,
    this.retrieveLatest,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.uint64(1),
        ProtoFieldConfig.bool(2),
        ProtoFieldConfig.bool(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        blockNumber,
        allowUnverified,
        retrieveLatest,
      ];


HederaSingleBlockRequest copyWith(
{BigInt? blockNumber,

bool? allowUnverified,

bool? retrieveLatest,

}) {
    return HederaSingleBlockRequest(
blockNumber: blockNumber ?? this.blockNumber,
allowUnverified: allowUnverified ?? this.allowUnverified,
retrieveLatest: retrieveLatest ?? this.retrieveLatest,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'block_number': config.encodeBigint(blockNumber),
      'allow_unverified': allowUnverified,
      'retrieve_latest': retrieveLatest,
    };
  }


  factory HederaSingleBlockRequest.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaSingleBlockRequest(
      blockNumber: json.valueAsBigInt<BigInt?>('block_number', normalizeKeyLookup: config.normalizeKeys),
      allowUnverified: json.valueAsBool<bool?>('allow_unverified', normalizeKeyLookup: config.normalizeKeys),
      retrieveLatest: json.valueAsBool<bool?>('retrieve_latest', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaSingleBlockRequest.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaSingleBlockRequest(
      blockNumber: decode.getBigInt<BigInt?>(1),
      allowUnverified: decode.getBool<bool?>(2),
      retrieveLatest: decode.getBool<bool?>(3),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiBlockSingleBlockRequest;

}


/// *
///  * A response to a `singleBlock` request.
///  *
///  * This message SHALL be sent in response to a request, and SHALL contain at
///  * least a valid `status`.&lt;br/&gt;
///  * If `status` is `READ_BLOCK_SUCCESS`, the response SHALL contain the
///  * requested block in the `block` field.
///  *
///  * &gt; Note
///  * &gt;&gt; A block can become quite large. A client MUST be prepared to receive the
///  * &gt;&gt; full content of the block, perhaps many megabytes of data.
class HederaSingleBlockResponse extends HederaProtoMessage with Equality {
    /// *
  ///      * A response status.
  ///      * &lt;p&gt;
  ///      * The reported status SHALL reflect the success of the request, or
  ///      * a detailed reason the request failed.
  final HederaSingleBlockResponseCode? status;

    /// *
  ///      * The requested block.
  ///      * &lt;p&gt;
  ///      * This container object SHALL hold the entire sequence of block items
  ///      * for the requested block.&lt;br/&gt;
  ///      * The block items in this message SHALL be in the same order
  ///      * as received.&lt;br/&gt;
  ///      * The items in this message SHALL begin with a `BlockHeader` and end with
  ///      * a `BlockStateProof` applicable to this block.
  final com_hedera_hapi_block_stream_block.HederaBlock? block;

  const HederaSingleBlockResponse({
    this.status,
    this.block,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.enumType(1),
        ProtoFieldConfig.message(2),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        status,
        block,
      ];


HederaSingleBlockResponse copyWith(
{HederaSingleBlockResponseCode? status,

com_hedera_hapi_block_stream_block.HederaBlock? block,

}) {
    return HederaSingleBlockResponse(
status: status ?? this.status,
block: block ?? this.block,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'status': config.encodeEnum(status),
      'block': config.encodeMessage(block),
    };
  }


  factory HederaSingleBlockResponse.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaSingleBlockResponse(
      status: json.valueTo<HederaSingleBlockResponseCode?, Object?>(
        key: 'status',
        parse: (v) => HederaSingleBlockResponseCode.from(v),
      ),
      block: json.valueTo<com_hedera_hapi_block_stream_block.HederaBlock?, Object>(
        key: 'block',
        parse: (v) => com_hedera_hapi_block_stream_block.HederaBlock.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory HederaSingleBlockResponse.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaSingleBlockResponse(
      status: decode.getEnum<HederaSingleBlockResponseCode?>(1, HederaSingleBlockResponseCode.values),
      block: decode.messageTo<com_hedera_hapi_block_stream_block.HederaBlock?>(2, (b) => com_hedera_hapi_block_stream_block.HederaBlock.deserialize(b)),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiBlockSingleBlockResponse;

}


/// *
///  * A request to stream block items from Block-Node to a client.
///  *
///  * The Block-Node SHALL respond to this request with a stream of
///  * `SubscribeStreamResponse` messages.&lt;br/&gt;
///  * The Block-Node SHALL stream the full contents of the blocks requested.&lt;br/&gt;
///  * The block items SHALL be streamed in order originally produced within
///  * a block.&lt;br/&gt;
///  * The blocks SHALL be streamed in ascending order by `block_number`.&lt;br/&gt;
///  * The Block-Node SHALL end the stream when the last requested block has
///  * been sent.&lt;br/&gt;
///  * The Block-Node SHALL end the stream with a response code status of SUCCESS
///  * when the stream is complete.&lt;br/&gt;
///  * The client SHOULD call the `serverStatus` rpc prior to constructing this
///  * request to determine the available start and end blocks.
class HederaSubscribeStreamRequest extends HederaProtoMessage with Equality {
    /// *
  ///      * A block number to start the stream.
  ///      * &lt;p&gt;
  ///      * This SHALL be the block number of the first block returned.&lt;br/&gt;
  ///      * This field MUST be less than or equal to the latest available
  ///      * block number.
  final BigInt? startBlockNumber;

    /// *
  ///      * A block number to end the stream.&lt;br/&gt;
  ///      * This is optional, and if not set (0), the stream will be "infinite".
  ///      * &lt;p&gt;
  ///      * This field MAY be zero (`0`) to indicate the stream SHOULD continue
  ///      * indefinitely, streaming new blocks as each becomes available.&lt;br/&gt;
  ///      * If this value is greater than zero (`0`)
  ///      * &lt;ul&gt;
  ///      *   &lt;li&gt;This value SHALL be the number of the last block returned.&lt;/li&gt;
  ///      *   &lt;li&gt;This field MUST NOT be less than `start_block_number`.&lt;/li&gt;
  ///      *   &lt;li&gt;This SHOULD be a block number that is immediately available
  ///      *       from the Block-Node.&lt;/li&gt;
  ///      *   &lt;li&gt;A Block-Node SHALL continue to stream blocks until the last
  ///      *       requested block is transmitted.&lt;/li&gt;
  ///      *   &lt;li&gt;A Block-Node MAY reject a request for a block
  ///      *       that is not yet available.&lt;/li&gt;
  ///      *   &lt;li&gt;A Block-Node MAY accept future block numbers.&lt;/li&gt;
  ///      *   &lt;li&gt;Block-Node implementations MAY charge increased fees for such
  ///      *       "future" streams.&lt;/li&gt;
  ///      * &lt;/ul&gt;
  final BigInt? endBlockNumber;

    /// *
  ///      * A flag to indicate that the requested block(s) may be sent before
  ///      * verifying each block's `BlockProof`.&lt;br/&gt;
  ///      * This might be set by a client that expects to perform its own
  ///      * verification and wishes lower latency or, potentially, lower cost.
  ///      * &lt;p&gt;
  ///      * If this value is set, then the responding Block-Node MAY respond with
  ///      * blocks that have not (yet) completed block proof verification.&lt;br/&gt;
  ///      * If this is _not set_ then the Block-Node MUST respond with only
  ///      * fully verified and validated block(s).&lt;br/&gt;
  ///      * If this is _set_, then a Block-Node MAY stream items from
  ///      * blocks that have not yet been verified or do not yet have
  ///      * a block proof available.&lt;br/&gt;
  ///      * The default value is _not set_.
  final bool? allowUnverified;

  const HederaSubscribeStreamRequest({
    this.startBlockNumber,
    this.endBlockNumber,
    this.allowUnverified,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.uint64(1),
        ProtoFieldConfig.uint64(2),
        ProtoFieldConfig.bool(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        startBlockNumber,
        endBlockNumber,
        allowUnverified,
      ];


HederaSubscribeStreamRequest copyWith(
{BigInt? startBlockNumber,

BigInt? endBlockNumber,

bool? allowUnverified,

}) {
    return HederaSubscribeStreamRequest(
startBlockNumber: startBlockNumber ?? this.startBlockNumber,
endBlockNumber: endBlockNumber ?? this.endBlockNumber,
allowUnverified: allowUnverified ?? this.allowUnverified,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'start_block_number': config.encodeBigint(startBlockNumber),
      'end_block_number': config.encodeBigint(endBlockNumber),
      'allow_unverified': allowUnverified,
    };
  }


  factory HederaSubscribeStreamRequest.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaSubscribeStreamRequest(
      startBlockNumber: json.valueAsBigInt<BigInt?>('start_block_number', normalizeKeyLookup: config.normalizeKeys),
      endBlockNumber: json.valueAsBigInt<BigInt?>('end_block_number', normalizeKeyLookup: config.normalizeKeys),
      allowUnverified: json.valueAsBool<bool?>('allow_unverified', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaSubscribeStreamRequest.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaSubscribeStreamRequest(
      startBlockNumber: decode.getBigInt<BigInt?>(1),
      endBlockNumber: decode.getBigInt<BigInt?>(2),
      allowUnverified: decode.getBool<bool?>(3),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiBlockSubscribeStreamRequest;

}


/// *
///  * One item in a stream of `subscribeBlockStream` responses.
///  *
///  * The Block-Node SHALL respond to a `subscribeBlockStream` request with a
///  * stream of `SubscribeStreamResponse` messages.&lt;br/&gt;
///  * The Block-Node SHALL stream the full contents of the blocks requested.&lt;br/&gt;
///  * The block items SHALL be streamed in order originally produced within
///  * a block.&lt;br/&gt;
///  * The blocks SHALL be streamed in ascending order by `block_number`.&lt;br/&gt;
///  * The Block-Node SHALL end the stream when the last requested block has
///  * been sent.&lt;br/&gt;
///  * The Block-Node SHALL end the stream with a response code status of SUCCESS
///  * when the stream is complete.&lt;br/&gt;
///  * The Block-Node SHALL end the stream with a response code status of
///  * `READ_STREAM_INVALID_START_BLOCK_NUMBER` if the start block number is
///  * greater than the end block number.&lt;br/&gt;
///  * The Block-Node SHALL end the stream with a response code status of
///  * `READ_STREAM_INSUFFICIENT_BALANCE` if insufficient balance remains to
///  * complete the requested stream.
///  * The Block-Node SHALL make every reasonable effort to fulfill as much of the
///  * request as available balance supports, in the event balance is not
///  * sufficient to complete the request.
class HederaSubscribeStreamResponse extends HederaProtoMessage with Equality {
    /// *
  ///          * A final response item describing the terminal status of this stream.
  ///          * &lt;p&gt;
  ///          * The Block-Node SHALL end the stream following this message.
  final HederaSubscribeStreamResponseCode? status;

    /// *
  ///          * A stream response item containing one or more `BlockItem`s.
  ///          * &lt;p&gt;
  ///          * The full stream SHALL consist of many `block_items` messages
  ///          * followed by a single `status` message.
  final HederaBlockItemSet? blockItems;

  const HederaSubscribeStreamResponse({
    this.status,
    this.blockItems,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.enumType(1),
        ProtoFieldConfig.message(2),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        status,
        blockItems,
      ];


HederaSubscribeStreamResponse copyWith(
{HederaSubscribeStreamResponseCode? status,

HederaBlockItemSet? blockItems,

}) {
    return HederaSubscribeStreamResponse(
status: status ?? this.status,
blockItems: blockItems ?? this.blockItems,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'status': config.encodeEnum(status),
      'block_items': config.encodeMessage(blockItems),
    };
  }


  factory HederaSubscribeStreamResponse.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaSubscribeStreamResponse(
      status: json.valueTo<HederaSubscribeStreamResponseCode?, Object?>(
        key: 'status',
        parse: (v) => HederaSubscribeStreamResponseCode.from(v),
      ),
      blockItems: json.valueTo<HederaBlockItemSet?, Object>(
        key: 'block_items',
        parse: (v) => HederaBlockItemSet.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory HederaSubscribeStreamResponse.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaSubscribeStreamResponse(
      status: decode.getEnum<HederaSubscribeStreamResponseCode?>(1, HederaSubscribeStreamResponseCode.values),
      blockItems: decode.messageTo<HederaBlockItemSet?>(2, (b) => HederaBlockItemSet.deserialize(b)),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiBlockSubscribeStreamResponse;

}


/// *
///  * A request to read a state snapshot.
///  *
///  * A state snapshot is a full copy of the network state at the completion of a
///  * particular block.
///  *
///  * This request MUST contain a block number that has already reached this
///  * Block-Node and completed verification, or request the "latest" snapshot.&lt;br/&gt;
///  * This request MAY specify the "latest" snapshot, and the Block-Node SHALL
///  * respond with a reference to a snapshot containing the most recent contents
///  * of the network state known to that Block-Node.
class HederaStateSnapshotRequest extends HederaProtoMessage with Equality {
    /// *
  ///      * A block number.
  ///      * &lt;p&gt;
  ///      * This SHALL be the last block number present in the snapshot
  ///      * returned.&lt;br/&gt;
  ///      * If `retrieve_latest` is set `true` this field SHOULD NOT be set
  ///      * and SHALL be ignored.&lt;br/&gt;
  ///      * A Block-Node MAY reject any request with a non-default
  ///      * value for this field, but MUST clearly document that behavior.
  final BigInt? lastBlockNumber;

    /// *
  ///      * A boolean to request the latest available snapshot.
  ///      * &lt;p&gt;
  ///      * This value MAY be set `true` to request the most recent state snapshot
  ///      * available.&lt;br/&gt;
  ///      * If this value is set to `true` then `last_block_number` SHOULD NOT be
  ///      * set and SHALL be ignored.&lt;br/&gt;
  ///      * A Block-Node MAY reject any request with that does _not_
  ///      * set this field `true`, but MUST clearly document that behavior.
  final bool? retrieveLatest;

  const HederaStateSnapshotRequest({
    this.lastBlockNumber,
    this.retrieveLatest,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.uint64(2),
        ProtoFieldConfig.bool(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        lastBlockNumber,
        retrieveLatest,
      ];


HederaStateSnapshotRequest copyWith(
{BigInt? lastBlockNumber,

bool? retrieveLatest,

}) {
    return HederaStateSnapshotRequest(
lastBlockNumber: lastBlockNumber ?? this.lastBlockNumber,
retrieveLatest: retrieveLatest ?? this.retrieveLatest,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'last_block_number': config.encodeBigint(lastBlockNumber),
      'retrieve_latest': retrieveLatest,
    };
  }


  factory HederaStateSnapshotRequest.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaStateSnapshotRequest(
      lastBlockNumber: json.valueAsBigInt<BigInt?>('last_block_number', normalizeKeyLookup: config.normalizeKeys),
      retrieveLatest: json.valueAsBool<bool?>('retrieve_latest', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaStateSnapshotRequest.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaStateSnapshotRequest(
      lastBlockNumber: decode.getBigInt<BigInt?>(2),
      retrieveLatest: decode.getBool<bool?>(3),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiBlockStateSnapshotRequest;

}


/// *
///  * A response to a request for a state snapshot.
///  *
///  * This message SHALL deliver a _reference_ to the requested snapshot
///  * data if successful.&lt;br/&gt;
///  * This message SHALL deliver a code indicating the reason for failure
///  * if unsuccessful.
class HederaStateSnapshotResponse extends HederaProtoMessage with Equality {
    /// *
  ///      * A status response.
  ///      * &lt;p&gt;
  ///      * This code SHALL indicate a successful call, or the detailed
  ///      * reason for failure.
  final HederaStateSnapshotResponseCode? status;

    /// *
  ///      * A block number.
  ///      * &lt;p&gt;
  ///      * This SHALL be the number of the last block included in this
  ///      * state snapshot.
  final BigInt? lastBlockNumber;

    /// *
  ///      * A reference to where the requested state snapshot may be obtained.
  ///      * &lt;p&gt;
  ///      * &lt;blockquote&gt;REVIEW NOTE&lt;blockquote&gt;
  ///      * This is TEMPORARY.  We have not yet designed how state snapshots may
  ///      * be sent. One idea is to use `Any` and let implementations decide;
  ///      * another is to use a time limited URL (with the same login as the
  ///      * Block-Node server); another is to use a customer-pays cloud
  ///      * storage bucket.
  ///      * &lt;/blockquote&gt;&lt;/blockquote&gt;
  final String? snapshotReference;

  const HederaStateSnapshotResponse({
    this.status,
    this.lastBlockNumber,
    this.snapshotReference,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.enumType(1),
        ProtoFieldConfig.uint64(2),
        ProtoFieldConfig.string(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        status,
        lastBlockNumber,
        snapshotReference,
      ];


HederaStateSnapshotResponse copyWith(
{HederaStateSnapshotResponseCode? status,

BigInt? lastBlockNumber,

String? snapshotReference,

}) {
    return HederaStateSnapshotResponse(
status: status ?? this.status,
lastBlockNumber: lastBlockNumber ?? this.lastBlockNumber,
snapshotReference: snapshotReference ?? this.snapshotReference,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'status': config.encodeEnum(status),
      'last_block_number': config.encodeBigint(lastBlockNumber),
      'snapshot_reference': snapshotReference,
    };
  }


  factory HederaStateSnapshotResponse.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaStateSnapshotResponse(
      status: json.valueTo<HederaStateSnapshotResponseCode?, Object?>(
        key: 'status',
        parse: (v) => HederaStateSnapshotResponseCode.from(v),
      ),
      lastBlockNumber: json.valueAsBigInt<BigInt?>('last_block_number', normalizeKeyLookup: config.normalizeKeys),
      snapshotReference: json.valueAsString<String?>('snapshot_reference', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaStateSnapshotResponse.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaStateSnapshotResponse(
      status: decode.getEnum<HederaStateSnapshotResponseCode?>(1, HederaStateSnapshotResponseCode.values),
      lastBlockNumber: decode.getBigInt<BigInt?>(2),
      snapshotReference: decode.getString<String?>(3),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiBlockStateSnapshotResponse;

}


/// *
///  * A request for the status of a Block-Node.
class HederaServerStatusRequest extends HederaProtoMessage with Equality {
  const HederaServerStatusRequest();

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
      ];


HederaServerStatusRequest copyWith(
) {
    return HederaServerStatusRequest(
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
    };
  }


  factory HederaServerStatusRequest.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaServerStatusRequest(
    );
  }

  factory HederaServerStatusRequest.deserialize(List<int> bytes) {
    return HederaServerStatusRequest(
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiBlockServerStatusRequest;

}


/// *
///  * A response to a server status request.
///  *
///  * This message SHALL provide a client with information needed to successfully
///  * query this Block-Node for a block, stream of blocks, or
///  * state snapshot.&lt;br/&gt;
///  * A request for blocks between `first_available_block` and
///  * `last_available_block`, inclusive, SHOULD succeed. Any request for blocks
///  * outside that range SHOULD fail.
class HederaServerStatusResponse extends HederaProtoMessage with Equality {
    /// *
  ///      * The lowest numbered block available on this Block-Node.
  ///      * &lt;p&gt;
  ///      * Any request for a block with lower number than this value SHALL fail
  ///      * with a status value indicating and invalid start block number.
  final BigInt? firstAvailableBlock;

    /// *
  ///      * The greatest block number available from this Block-Node.
  ///      * &lt;p&gt;
  ///      * Any request for a block with a block number higher than this
  ///      * value MAY fail.
  final BigInt? lastAvailableBlock;

    /// *
  ///      * A flag indicating this Block-Node only offers the latest state snapshot.
  ///      * &lt;p&gt;
  ///      * If this value is `true` the client MUST set `retrieve_latest` `true`
  ///      * in any `StateSnapshotRequest` sent to this Block-Node.
  final bool? onlyLatestState;

    /// *
  ///      * Version information.&lt;br/&gt;
  ///      * Versions for the block network address book, block stream protocol
  ///      * buffer schema, and Block-Node software.
  final HederaBlockNodeVersions? versionInformation;

  const HederaServerStatusResponse({
    this.firstAvailableBlock,
    this.lastAvailableBlock,
    this.onlyLatestState,
    this.versionInformation,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.uint64(1),
        ProtoFieldConfig.uint64(2),
        ProtoFieldConfig.bool(3),
        ProtoFieldConfig.message(4),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        firstAvailableBlock,
        lastAvailableBlock,
        onlyLatestState,
        versionInformation,
      ];


HederaServerStatusResponse copyWith(
{BigInt? firstAvailableBlock,

BigInt? lastAvailableBlock,

bool? onlyLatestState,

HederaBlockNodeVersions? versionInformation,

}) {
    return HederaServerStatusResponse(
firstAvailableBlock: firstAvailableBlock ?? this.firstAvailableBlock,
lastAvailableBlock: lastAvailableBlock ?? this.lastAvailableBlock,
onlyLatestState: onlyLatestState ?? this.onlyLatestState,
versionInformation: versionInformation ?? this.versionInformation,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'first_available_block': config.encodeBigint(firstAvailableBlock),
      'last_available_block': config.encodeBigint(lastAvailableBlock),
      'only_latest_state': onlyLatestState,
      'version_information': config.encodeMessage(versionInformation),
    };
  }


  factory HederaServerStatusResponse.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaServerStatusResponse(
      firstAvailableBlock: json.valueAsBigInt<BigInt?>('first_available_block', normalizeKeyLookup: config.normalizeKeys),
      lastAvailableBlock: json.valueAsBigInt<BigInt?>('last_available_block', normalizeKeyLookup: config.normalizeKeys),
      onlyLatestState: json.valueAsBool<bool?>('only_latest_state', normalizeKeyLookup: config.normalizeKeys),
      versionInformation: json.valueTo<HederaBlockNodeVersions?, Object>(
        key: 'version_information',
        parse: (v) => HederaBlockNodeVersions.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory HederaServerStatusResponse.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaServerStatusResponse(
      firstAvailableBlock: decode.getBigInt<BigInt?>(1),
      lastAvailableBlock: decode.getBigInt<BigInt?>(2),
      onlyLatestState: decode.getBool<bool?>(3),
      versionInformation: decode.messageTo<HederaBlockNodeVersions?>(4, (b) => HederaBlockNodeVersions.deserialize(b)),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiBlockServerStatusResponse;

}


/// *
///  * Version information for a Block-Node.
///  *
///  * The `stream_proto_version` SHOULD be an officially released Block Stream
///  * version.
///  * The `address_book_version` SHALL be determined by networks of Block-Nodes.
///  * The `software_version` SHALL be determined by the implementation of this
///  * specification.
class HederaBlockNodeVersions extends HederaProtoMessage with Equality {
    /// *
  ///      * A version of the Block-Node network address book.&lt;br/&gt;
  ///      * The address book version describes what version of address book
  ///      * this Block-Node holds for discovering and identifying other Block-Nodes.
  ///      * &lt;p&gt;
  ///      * This version SHALL be specific to each "network" of interconnected
  ///      * Block-Nodes.
  final proto_basic_types.HederaSemanticVersion? addressBookVersion;

    /// *
  ///      * A version of the Block Stream specification.&lt;br/&gt;
  ///      * This is the Stream version currently supported by this Block-Node.
  ///      * &lt;p&gt;
  ///      * Implementations SHOULD make reasonable effort to ensure the latest
  ///      * released Block Stream version is supported.&lt;br/&gt;
  ///      * This version MUST be an officially released Block Stream version if
  ///      * the responding Block-Node is not private.
  final proto_basic_types.HederaSemanticVersion? streamProtoVersion;

    /// *
  ///      * A version of the Block-Node software.&lt;br/&gt;
  ///      * This is the software version that this Block-Node is currently
  ///      * running.
  ///      * &lt;p&gt;
  ///      * This value is implementation-defined.
  final proto_basic_types.HederaSemanticVersion? softwareVersion;

  const HederaBlockNodeVersions({
    this.addressBookVersion,
    this.streamProtoVersion,
    this.softwareVersion,
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
        addressBookVersion,
        streamProtoVersion,
        softwareVersion,
      ];


HederaBlockNodeVersions copyWith(
{proto_basic_types.HederaSemanticVersion? addressBookVersion,

proto_basic_types.HederaSemanticVersion? streamProtoVersion,

proto_basic_types.HederaSemanticVersion? softwareVersion,

}) {
    return HederaBlockNodeVersions(
addressBookVersion: addressBookVersion ?? this.addressBookVersion,
streamProtoVersion: streamProtoVersion ?? this.streamProtoVersion,
softwareVersion: softwareVersion ?? this.softwareVersion,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'address_book_version': config.encodeMessage(addressBookVersion),
      'stream_proto_version': config.encodeMessage(streamProtoVersion),
      'software_version': config.encodeMessage(softwareVersion),
    };
  }


  factory HederaBlockNodeVersions.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaBlockNodeVersions(
      addressBookVersion: json.valueTo<proto_basic_types.HederaSemanticVersion?, Object>(
        key: 'address_book_version',
        parse: (v) => proto_basic_types.HederaSemanticVersion.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      streamProtoVersion: json.valueTo<proto_basic_types.HederaSemanticVersion?, Object>(
        key: 'stream_proto_version',
        parse: (v) => proto_basic_types.HederaSemanticVersion.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      softwareVersion: json.valueTo<proto_basic_types.HederaSemanticVersion?, Object>(
        key: 'software_version',
        parse: (v) => proto_basic_types.HederaSemanticVersion.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory HederaBlockNodeVersions.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaBlockNodeVersions(
      addressBookVersion: decode.messageTo<proto_basic_types.HederaSemanticVersion?>(1, (b) => proto_basic_types.HederaSemanticVersion.deserialize(b)),
      streamProtoVersion: decode.messageTo<proto_basic_types.HederaSemanticVersion?>(2, (b) => proto_basic_types.HederaSemanticVersion.deserialize(b)),
      softwareVersion: decode.messageTo<proto_basic_types.HederaSemanticVersion?>(3, (b) => proto_basic_types.HederaSemanticVersion.deserialize(b)),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiBlockBlockNodeVersions;

}


