import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/node/state/hints/src/hints_types.dart" as com_hedera_hapi_node_state_hints_hints_types;

/// *
///  * # hinTS Aggregation Vote Transaction
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in
///  * [RFC2119](https://www.ietf.org/rfc/rfc2119) and clarified in
///  * [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.services.auxiliary.hints"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * A transaction body to publish a node's vote for the results of
///  * aggregating the hinTS keys for a specified construction id. The
///  * node can either give their explicit aggregation results, or
///  * delegate their vote to another node's results.
class HederaHintsPreprocessingVoteTransactionBody extends HederaProtoMessage with Equality {
    /// *
  ///    * The id of the hinTS construction this vote is for. Because
  ///    * the network only ever performs one construction a time, this
  ///    * is somewhat redundant, but included to detect any strange
  ///    * edge cases where a node is so far behind it votes on the wrong
  ///    * construction.
  final BigInt? constructionId;

    /// *
  ///    * The vote the node is casting for the aggregation of the hints
  ///    * in the given construction (which should be ongoing).
  final com_hedera_hapi_node_state_hints_hints_types.HederaPreprocessingVote? vote;

  const HederaHintsPreprocessingVoteTransactionBody({
    this.constructionId,
    this.vote,
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
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        constructionId,
        vote,
      ];


HederaHintsPreprocessingVoteTransactionBody copyWith(
{BigInt? constructionId,

com_hedera_hapi_node_state_hints_hints_types.HederaPreprocessingVote? vote,

}) {
    return HederaHintsPreprocessingVoteTransactionBody(
constructionId: constructionId ?? this.constructionId,
vote: vote ?? this.vote,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'construction_id': config.encodeBigint(constructionId),
      'vote': config.encodeMessage(vote),
    };
  }


  factory HederaHintsPreprocessingVoteTransactionBody.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaHintsPreprocessingVoteTransactionBody(
      constructionId: json.valueAsBigInt<BigInt?>('construction_id', normalizeKeyLookup: config.normalizeKeys),
      vote: json.valueTo<com_hedera_hapi_node_state_hints_hints_types.HederaPreprocessingVote?, Object>(
        key: 'vote',
        parse: (v) => com_hedera_hapi_node_state_hints_hints_types.HederaPreprocessingVote.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory HederaHintsPreprocessingVoteTransactionBody.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaHintsPreprocessingVoteTransactionBody(
      constructionId: decode.getBigInt<BigInt?>(1),
      vote: decode.messageTo<com_hedera_hapi_node_state_hints_hints_types.HederaPreprocessingVote?>(2, (b) => com_hedera_hapi_node_state_hints_hints_types.HederaPreprocessingVote.deserialize(b)),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiServicesAuxiliaryHintsHintsPreprocessingVoteTransactionBody;

}


