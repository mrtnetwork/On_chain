import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart" as proto_basic_types;
import "package:on_chain/hedera/src/proto_messages/proto/src/timestamp.dart" as proto_timestamp;
import "package:on_chain/hedera/src/proto_messages/proto/src/consensus_submit_message.dart" as proto_consensus_submit_message;

/// -
///  * ‌
///  * Hedera Mirror Node
///  * ​
///  * Copyright (C) 2019 Hedera Hashgraph, LLC
///  * ​
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
///  * ‍
/// *
///  * Required for the reactor-grpc generator to work correctly
class HederaConsensusTopicQuery extends HederaProtoMessage with Equality {
    /// *
  ///      * A required topic ID to retrieve messages for.
  final proto_basic_types.HederaTopicID? topicID;

    /// *
  ///      * Include messages which reached consensus on or after this time. Defaults to current time if
  ///      * not set.
  final proto_timestamp.HederaTimestamp? consensusStartTime;

    /// *
  ///      * Include messages which reached consensus before this time. If not set it will receive
  ///      * indefinitely.
  final proto_timestamp.HederaTimestamp? consensusEndTime;

    /// *
  ///      * The maximum number of messages to receive before stopping. If not set or set to zero it will
  ///      * return messages indefinitely.
  final BigInt? limit;

  const HederaConsensusTopicQuery({
    this.topicID,
    this.consensusStartTime,
    this.consensusEndTime,
    this.limit,
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
        ProtoFieldConfig.uint64(4),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        topicID,
        consensusStartTime,
        consensusEndTime,
        limit,
      ];


HederaConsensusTopicQuery copyWith(
{proto_basic_types.HederaTopicID? topicID,

proto_timestamp.HederaTimestamp? consensusStartTime,

proto_timestamp.HederaTimestamp? consensusEndTime,

BigInt? limit,

}) {
    return HederaConsensusTopicQuery(
topicID: topicID ?? this.topicID,
consensusStartTime: consensusStartTime ?? this.consensusStartTime,
consensusEndTime: consensusEndTime ?? this.consensusEndTime,
limit: limit ?? this.limit,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'topicID': config.encodeMessage(topicID),
      'consensusStartTime': config.encodeMessage(consensusStartTime),
      'consensusEndTime': config.encodeMessage(consensusEndTime),
      'limit': config.encodeBigint(limit),
    };
  }


  factory HederaConsensusTopicQuery.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaConsensusTopicQuery(
      topicID: json.valueTo<proto_basic_types.HederaTopicID?, Object>(
        key: 'topicID',
        parse: (v) => proto_basic_types.HederaTopicID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      consensusStartTime: json.valueTo<proto_timestamp.HederaTimestamp?, Object>(
        key: 'consensusStartTime',
        parse: (v) => proto_timestamp.HederaTimestamp.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      consensusEndTime: json.valueTo<proto_timestamp.HederaTimestamp?, Object>(
        key: 'consensusEndTime',
        parse: (v) => proto_timestamp.HederaTimestamp.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      limit: json.valueAsBigInt<BigInt?>('limit', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaConsensusTopicQuery.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaConsensusTopicQuery(
      topicID: decode.messageTo<proto_basic_types.HederaTopicID?>(1, (b) => proto_basic_types.HederaTopicID.deserialize(b)),
      consensusStartTime: decode.messageTo<proto_timestamp.HederaTimestamp?>(2, (b) => proto_timestamp.HederaTimestamp.deserialize(b)),
      consensusEndTime: decode.messageTo<proto_timestamp.HederaTimestamp?>(3, (b) => proto_timestamp.HederaTimestamp.deserialize(b)),
      limit: decode.getBigInt<BigInt?>(4),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaMirrorApiProtoConsensusTopicQuery;

}


class HederaConsensusTopicResponse extends HederaProtoMessage with Equality {
    /// *
  ///      * The time at which the transaction reached consensus
  final proto_timestamp.HederaTimestamp? consensusTimestamp;

    /// *
  ///      * The message body originally in the ConsensusSubmitMessageTransactionBody. Message size will
  ///      * be less than 6KiB.
  final List<int>? message;

    /// *
  ///      * The running hash (SHA384) of every message.
  final List<int>? runningHash;

    /// *
  ///      * Starts at 1 for first submitted message. Incremented on each submitted message.
  final BigInt? sequenceNumber;

    /// *
  ///      * Version of the SHA-384 digest used to update the running hash.
  final BigInt? runningHashVersion;

    /// *
  ///      * Optional information of the current chunk in a fragmented message.
  final proto_consensus_submit_message.HederaConsensusMessageChunkInfo? chunkInfo;

  const HederaConsensusTopicResponse({
    this.consensusTimestamp,
    this.message,
    this.runningHash,
    this.sequenceNumber,
    this.runningHashVersion,
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
        ProtoFieldConfig.bytes(3),
        ProtoFieldConfig.uint64(4),
        ProtoFieldConfig.uint64(5),
        ProtoFieldConfig.message(6),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        consensusTimestamp,
        message,
        runningHash,
        sequenceNumber,
        runningHashVersion,
        chunkInfo,
      ];


HederaConsensusTopicResponse copyWith(
{proto_timestamp.HederaTimestamp? consensusTimestamp,

List<int>? message,

List<int>? runningHash,

BigInt? sequenceNumber,

BigInt? runningHashVersion,

proto_consensus_submit_message.HederaConsensusMessageChunkInfo? chunkInfo,

}) {
    return HederaConsensusTopicResponse(
consensusTimestamp: consensusTimestamp ?? this.consensusTimestamp,
message: message ?? this.message,
runningHash: runningHash ?? this.runningHash,
sequenceNumber: sequenceNumber ?? this.sequenceNumber,
runningHashVersion: runningHashVersion ?? this.runningHashVersion,
chunkInfo: chunkInfo ?? this.chunkInfo,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'consensusTimestamp': config.encodeMessage(consensusTimestamp),
      'message': config.encodeBinary(message),
      'runningHash': config.encodeBinary(runningHash),
      'sequenceNumber': config.encodeBigint(sequenceNumber),
      'runningHashVersion': config.encodeBigint(runningHashVersion),
      'chunkInfo': config.encodeMessage(chunkInfo),
    };
  }


  factory HederaConsensusTopicResponse.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaConsensusTopicResponse(
      consensusTimestamp: json.valueTo<proto_timestamp.HederaTimestamp?, Object>(
        key: 'consensusTimestamp',
        parse: (v) => proto_timestamp.HederaTimestamp.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      message: config.decodeBinary<List<int>?>(json.valueAs('message', normalizeKeyLookup: config.normalizeKeys)),
      runningHash: config.decodeBinary<List<int>?>(json.valueAs('runningHash', normalizeKeyLookup: config.normalizeKeys)),
      sequenceNumber: json.valueAsBigInt<BigInt?>('sequenceNumber', normalizeKeyLookup: config.normalizeKeys),
      runningHashVersion: json.valueAsBigInt<BigInt?>('runningHashVersion', normalizeKeyLookup: config.normalizeKeys),
      chunkInfo: json.valueTo<proto_consensus_submit_message.HederaConsensusMessageChunkInfo?, Object>(
        key: 'chunkInfo',
        parse: (v) => proto_consensus_submit_message.HederaConsensusMessageChunkInfo.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory HederaConsensusTopicResponse.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaConsensusTopicResponse(
      consensusTimestamp: decode.messageTo<proto_timestamp.HederaTimestamp?>(1, (b) => proto_timestamp.HederaTimestamp.deserialize(b)),
      message: decode.getBytes<List<int>?>(2),
      runningHash: decode.getBytes<List<int>?>(3),
      sequenceNumber: decode.getBigInt<BigInt?>(4),
      runningHashVersion: decode.getBigInt<BigInt?>(5),
      chunkInfo: decode.messageTo<proto_consensus_submit_message.HederaConsensusMessageChunkInfo?>(6, (b) => proto_consensus_submit_message.HederaConsensusMessageChunkInfo.deserialize(b)),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaMirrorApiProtoConsensusTopicResponse;

}


class HederaServiceConsensusServiceSubscribeTopic extends HederaProtoMessage with Equality, IHederaServiceMessage<HederaConsensusTopicResponse> {
  final HederaConsensusTopicQuery? subscribeTopic;

  const HederaServiceConsensusServiceSubscribeTopic({
    this.subscribeTopic,
  });

HederaServiceConsensusServiceSubscribeTopic copyWith(
{HederaConsensusTopicQuery? subscribeTopic,

}) {
    return HederaServiceConsensusServiceSubscribeTopic(
subscribeTopic: subscribeTopic ?? this.subscribeTopic,
    );
  }
  @override
  ProtoMessageConfig protoConfig() =>subscribeTopic?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => subscribeTopic?.protoValues??[];
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'subscribeTopic': config.encodeMessage(subscribeTopic),
    };
  }


  factory HederaServiceConsensusServiceSubscribeTopic.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaServiceConsensusServiceSubscribeTopic(
      subscribeTopic: json.valueTo<HederaConsensusTopicQuery?, Object>(
        key: 'subscribeTopic',
        parse: (v) => HederaConsensusTopicQuery.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaMirrorApiProtoServiceConsensusServiceSubscribeTopic;
  @override
  HederaConsensusTopicResponse onServiceResponse(List<int> bytes) {
    return HederaConsensusTopicResponse.deserialize(bytes);
  }

}


