import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart" as proto_basic_types;

/// *
///  * # Delete Topic
///  * Delete an existing topic from the Hedera Consensus Service (HCS).
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
///  * Delete a topic.
///  *
///  * Once deleted, subsequent transactions or queries for that topic SHALL NOT
///  * succeed.&lt;br/&gt;
///  * If adminKey is set on the topic, this transaction MUST be signed by that
///  * key.&lt;br/&gt;
///  * If adminKey is not set on the topic, this transaction SHALL fail with a
///  * response code of `UNAUTHORIZED`. A topic without an adminKey cannot be
///  * deleted (but MAY expire).
///  *
///  * ### Block Stream Effects
///  * None
class HederaConsensusDeleteTopicTransactionBody extends HederaProtoMessage with Equality {
    /// *
  ///      * Topic to be deleted.
  final proto_basic_types.HederaTopicID? topicID;

  const HederaConsensusDeleteTopicTransactionBody({
    this.topicID,
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
        topicID,
      ];


HederaConsensusDeleteTopicTransactionBody copyWith(
{proto_basic_types.HederaTopicID? topicID,

}) {
    return HederaConsensusDeleteTopicTransactionBody(
topicID: topicID ?? this.topicID,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'topicID': config.encodeMessage(topicID),
    };
  }


  factory HederaConsensusDeleteTopicTransactionBody.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaConsensusDeleteTopicTransactionBody(
      topicID: json.valueTo<proto_basic_types.HederaTopicID?, Object>(
        key: 'topicID',
        parse: (v) => proto_basic_types.HederaTopicID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory HederaConsensusDeleteTopicTransactionBody.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaConsensusDeleteTopicTransactionBody(
      topicID: decode.messageTo<proto_basic_types.HederaTopicID?>(1, (b) => proto_basic_types.HederaTopicID.deserialize(b)),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoConsensusDeleteTopicTransactionBody;

}


