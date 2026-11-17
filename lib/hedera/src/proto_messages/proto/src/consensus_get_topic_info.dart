import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/query_header.dart"
    as proto_query_header;
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;
import "package:on_chain/hedera/src/proto_messages/proto/src/response_header.dart"
    as proto_response_header;
import "package:on_chain/hedera/src/proto_messages/proto/src/consensus_topic_info.dart"
    as proto_consensus_topic_info;
import "package:on_chain/hedera/src/proto_messages/proto/src/query.dart"
    as proto_query;

/// *
///  * # Get Topic
///  * Query a topic in the Hedera Consensus Service (HCS).
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
///  * Retrieve the latest state of a topic.
///  *
///  * This method is unrestricted and allowed on any topic by any payer
///  * account.&lt;br/&gt;
///  * A query for a deleted topic MAY succeed if the topic is within the
///  * "autorenew grace period".&lt;br/&gt;
///  * A query for a topic removed from state SHALL NOT succeed.
class HederaConsensusGetTopicInfoQuery extends HederaProtoMessage
    with Equality, IHederaQuery<HederaConsensusGetTopicInfoResponse> {
  /// *
  ///      * Standard information sent with every query operation.&lt;br/&gt;
  ///      * This includes the signed payment and what kind of response is requested
  ///      * (cost, state proof, both, or neither).
  @override
  final proto_query_header.HederaQueryHeader? header;

  /// *
  ///      * A topic ID.
  ///      * &lt;p&gt;
  ///      * The network SHALL return information for this topic, if successful.
  final proto_basic_types.HederaTopicID? topicID;

  const HederaConsensusGetTopicInfoQuery({this.header, this.topicID});

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
  List<Object?> get protoValues => [header, topicID];
  @override
  HederaConsensusGetTopicInfoQuery copyWith({
    proto_query_header.HederaQueryHeader? header,

    proto_basic_types.HederaTopicID? topicID,
  }) {
    return HederaConsensusGetTopicInfoQuery(
      header: header ?? this.header,
      topicID: topicID ?? this.topicID,
    );
  }

  @override
  proto_query.HederaQuery toQueryRequest({
    proto_query_header.HederaQueryHeader? header,
  }) =>
      proto_query.HederaQuery(consensusGetTopicInfo: copyWith(header: header));
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'header': config.encodeMessage(header),
      'topicID': config.encodeMessage(topicID),
    };
  }

  factory HederaConsensusGetTopicInfoQuery.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaConsensusGetTopicInfoQuery(
      header: json.valueTo<proto_query_header.HederaQueryHeader?, Object>(
        key: 'header',
        parse:
            (v) => proto_query_header.HederaQueryHeader.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      topicID: json.valueTo<proto_basic_types.HederaTopicID?, Object>(
        key: 'topicID',
        parse:
            (v) => proto_basic_types.HederaTopicID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaConsensusGetTopicInfoQuery.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaConsensusGetTopicInfoQuery(
      header: decode.messageTo<proto_query_header.HederaQueryHeader?>(
        1,
        (b) => proto_query_header.HederaQueryHeader.deserialize(b),
      ),
      topicID: decode.messageTo<proto_basic_types.HederaTopicID?>(
        2,
        (b) => proto_basic_types.HederaTopicID.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoConsensusGetTopicInfoQuery;
}

/// *
///  * Query response to describe the current state of a topic in the Hedera
///  * Consensus Service(HCS).
class HederaConsensusGetTopicInfoResponse extends HederaProtoMessage
    with Equality, IHederaQueryRespone {
  /// *
  ///      * The standard response information for queries.&lt;br/&gt;
  ///      * This includes the values requested in the `QueryHeader`
  ///      * (cost, state proof, both, or neither).
  @override
  final proto_response_header.HederaResponseHeader? header;

  /// *
  ///      * The ID of the topic requested in the query.
  final proto_basic_types.HederaTopicID? topicID;

  /// *
  ///      * Information describing the current state of the topic.
  final proto_consensus_topic_info.HederaConsensusTopicInfo? topicInfo;

  const HederaConsensusGetTopicInfoResponse({
    this.header,
    this.topicID,
    this.topicInfo,
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
        ProtoFieldConfig.message(5),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [header, topicID, topicInfo];

  HederaConsensusGetTopicInfoResponse copyWith({
    proto_response_header.HederaResponseHeader? header,

    proto_basic_types.HederaTopicID? topicID,

    proto_consensus_topic_info.HederaConsensusTopicInfo? topicInfo,
  }) {
    return HederaConsensusGetTopicInfoResponse(
      header: header ?? this.header,
      topicID: topicID ?? this.topicID,
      topicInfo: topicInfo ?? this.topicInfo,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'header': config.encodeMessage(header),
      'topicID': config.encodeMessage(topicID),
      'topicInfo': config.encodeMessage(topicInfo),
    };
  }

  factory HederaConsensusGetTopicInfoResponse.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaConsensusGetTopicInfoResponse(
      header: json.valueTo<proto_response_header.HederaResponseHeader?, Object>(
        key: 'header',
        parse:
            (v) => proto_response_header.HederaResponseHeader.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      topicID: json.valueTo<proto_basic_types.HederaTopicID?, Object>(
        key: 'topicID',
        parse:
            (v) => proto_basic_types.HederaTopicID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      topicInfo: json.valueTo<
        proto_consensus_topic_info.HederaConsensusTopicInfo?,
        Object
      >(
        key: 'topicInfo',
        parse:
            (v) => proto_consensus_topic_info.HederaConsensusTopicInfo.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaConsensusGetTopicInfoResponse.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaConsensusGetTopicInfoResponse(
      header: decode.messageTo<proto_response_header.HederaResponseHeader?>(
        1,
        (b) => proto_response_header.HederaResponseHeader.deserialize(b),
      ),
      topicID: decode.messageTo<proto_basic_types.HederaTopicID?>(
        2,
        (b) => proto_basic_types.HederaTopicID.deserialize(b),
      ),
      topicInfo: decode
          .messageTo<proto_consensus_topic_info.HederaConsensusTopicInfo?>(
            5,
            (b) => proto_consensus_topic_info
                .HederaConsensusTopicInfo.deserialize(b),
          ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoConsensusGetTopicInfoResponse;
}
