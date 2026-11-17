import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart" as proto_basic_types;

/// *
///  * # Submit Message
///  * Submit a message to a topic via the Hedera Consensus Service (HCS).
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in
///  * [RFC2119](https://www.ietf.org/rfc/rfc2119) and clarified in
///  * [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.consensus"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * Consensus message "chunk" detail.&lt;br/&gt;
///  * This message carries information describing the way in which a message
///  * submitted for consensus is broken into multiple fragments to fit within
///  * network transaction size limits.
///  *
///  * The use of multiple message fragments is RECOMMENDED for any message
///  * greater than 4KiB in total size.
///  *
///  * ### Block Stream Effects
///  * None
class HederaConsensusMessageChunkInfo extends HederaProtoMessage with Equality {
    /// *
  ///      * The TransactionID of the first chunk.
  ///      * &lt;p&gt;
  ///      * This MUST be set for every chunk in a fragmented message.
  final proto_basic_types.HederaTransactionID? initialTransactionID;

    /// *
  ///      * The total number of chunks in the message.
  final int? total;

    /// *
  ///      * The sequence number (from 1 to total) of the current chunk
  ///      * in the message.
  final int? number;

  const HederaConsensusMessageChunkInfo({
    this.initialTransactionID,
    this.total,
    this.number,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.int32(2),
        ProtoFieldConfig.int32(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        initialTransactionID,
        total,
        number,
      ];


HederaConsensusMessageChunkInfo copyWith(
{proto_basic_types.HederaTransactionID? initialTransactionID,

int? total,

int? number,

}) {
    return HederaConsensusMessageChunkInfo(
initialTransactionID: initialTransactionID ?? this.initialTransactionID,
total: total ?? this.total,
number: number ?? this.number,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'initialTransactionID': config.encodeMessage(initialTransactionID),
      'total': total,
      'number': number,
    };
  }


  factory HederaConsensusMessageChunkInfo.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaConsensusMessageChunkInfo(
      initialTransactionID: json.valueTo<proto_basic_types.HederaTransactionID?, Object>(
        key: 'initialTransactionID',
        parse: (v) => proto_basic_types.HederaTransactionID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      total: json.valueAsInt<int?>('total', normalizeKeyLookup: config.normalizeKeys),
      number: json.valueAsInt<int?>('number', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaConsensusMessageChunkInfo.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaConsensusMessageChunkInfo(
      initialTransactionID: decode.messageTo<proto_basic_types.HederaTransactionID?>(1, (b) => proto_basic_types.HederaTransactionID.deserialize(b)),
      total: decode.getInt<int?>(2),
      number: decode.getInt<int?>(3),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoConsensusMessageChunkInfo;

}


/// *
///  * Submit a message for consensus.&lt;br/&gt;
///  * This transaction adds a new entry to the "end" of a topic, and provides
///  * the core function of the consensus service.
///  *
///  * Valid and authorized messages on valid topics SHALL be ordered by the
///  * consensus service, published in the block stream, and available to all
///  * subscribers on this topic via the mirror nodes.&lt;br/&gt;
///  * If this transaction succeeds the resulting `TransactionReceipt` SHALL contain
///  * the latest `topicSequenceNumber` and `topicRunningHash` for the topic.&lt;br/&gt;
///  * If the topic `submitKey` is set, and not an empty `KeyList`, then that key
///  * MUST sign this transaction.
///  *
///  * ### Block Stream Effects
///  * None
class HederaConsensusSubmitMessageTransactionBody extends HederaProtoMessage with Equality {
    /// *
  ///      * Topic to submit message to.
  final proto_basic_types.HederaTopicID? topicID;

    /// *
  ///      * A message to be submitted.
  ///      * &lt;p&gt;
  ///      * This Transaction (including signatures) MUST be less than 6KiB.&lt;br/&gt;
  ///      * Messages SHOULD be less than 4KiB. A "chunked" message MAY be submitted
  ///      * if a message larger than this is required.
  final List<int>? message;

    /// *
  ///      * Information for the current "chunk" in a fragmented message.
  ///      * &lt;p&gt;
  ///      * This value is REQUIRED if the full `message` is submitted in two or
  ///      * more fragments due to transaction size limits.&lt;br/&gt;
  ///      * If the message is submitted in a single transaction, then this
  ///      * field SHOULD NOT be set.
  final HederaConsensusMessageChunkInfo? chunkInfo;

  const HederaConsensusSubmitMessageTransactionBody({
    this.topicID,
    this.message,
    this.chunkInfo,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.bytes(2),
        ProtoFieldConfig.message(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        topicID,
        message,
        chunkInfo,
      ];


HederaConsensusSubmitMessageTransactionBody copyWith(
{proto_basic_types.HederaTopicID? topicID,

List<int>? message,

HederaConsensusMessageChunkInfo? chunkInfo,

}) {
    return HederaConsensusSubmitMessageTransactionBody(
topicID: topicID ?? this.topicID,
message: message ?? this.message,
chunkInfo: chunkInfo ?? this.chunkInfo,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'topicID': config.encodeMessage(topicID),
      'message': config.encodeBinary(message),
      'chunkInfo': config.encodeMessage(chunkInfo),
    };
  }


  factory HederaConsensusSubmitMessageTransactionBody.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaConsensusSubmitMessageTransactionBody(
      topicID: json.valueTo<proto_basic_types.HederaTopicID?, Object>(
        key: 'topicID',
        parse: (v) => proto_basic_types.HederaTopicID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      message: config.decodeBinary<List<int>?>(json.valueAs('message', normalizeKeyLookup: config.normalizeKeys)),
      chunkInfo: json.valueTo<HederaConsensusMessageChunkInfo?, Object>(
        key: 'chunkInfo',
        parse: (v) => HederaConsensusMessageChunkInfo.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory HederaConsensusSubmitMessageTransactionBody.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaConsensusSubmitMessageTransactionBody(
      topicID: decode.messageTo<proto_basic_types.HederaTopicID?>(1, (b) => proto_basic_types.HederaTopicID.deserialize(b)),
      message: decode.getBytes<List<int>?>(2),
      chunkInfo: decode.messageTo<HederaConsensusMessageChunkInfo?>(3, (b) => HederaConsensusMessageChunkInfo.deserialize(b)),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoConsensusSubmitMessageTransactionBody;

}


