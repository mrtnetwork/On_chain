import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/node/state/history/src/history_types.dart"
    as com_hedera_hapi_node_state_history_history_types;

/// *
///  * # Metadata Proof Vote Transaction
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in
///  * [RFC2119](https://www.ietf.org/rfc/rfc2119) and clarified in
///  * [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.services.auxiliary.history"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * A transaction body to publish a node's vote for a
///  * proof of history associated to a construction id.
class HederaHistoryProofVoteTransactionBody extends HederaProtoMessage
    with Equality {
  /// *
  ///    * The id of the proof construction this vote is for.
  final BigInt? constructionId;

  /// *
  ///    * The submitting node's vote on the history proof.
  final com_hedera_hapi_node_state_history_history_types.HederaHistoryProofVote?
  vote;

  const HederaHistoryProofVoteTransactionBody({this.constructionId, this.vote});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.uint64(1), ProtoFieldConfig.message(2)],
    );
  }

  @override
  List<Object?> get protoValues => [constructionId, vote];

  HederaHistoryProofVoteTransactionBody copyWith({
    BigInt? constructionId,

    com_hedera_hapi_node_state_history_history_types.HederaHistoryProofVote?
    vote,
  }) {
    return HederaHistoryProofVoteTransactionBody(
      constructionId: constructionId ?? this.constructionId,
      vote: vote ?? this.vote,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'construction_id': config.encodeBigint(constructionId),
      'vote': config.encodeMessage(vote),
    };
  }

  factory HederaHistoryProofVoteTransactionBody.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaHistoryProofVoteTransactionBody(
      constructionId: json.valueAsBigInt<BigInt?>(
        'construction_id',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      vote: json.valueTo<
        com_hedera_hapi_node_state_history_history_types.HederaHistoryProofVote?,
        Object
      >(
        key: 'vote',
        parse:
            (v) => com_hedera_hapi_node_state_history_history_types
                .HederaHistoryProofVote.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaHistoryProofVoteTransactionBody.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaHistoryProofVoteTransactionBody(
      constructionId: decode.getBigInt<BigInt?>(1),
      vote: decode.messageTo<
        com_hedera_hapi_node_state_history_history_types.HederaHistoryProofVote?
      >(
        2,
        (b) => com_hedera_hapi_node_state_history_history_types
            .HederaHistoryProofVote.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl
          .comHederaHapiServicesAuxiliaryHistoryHistoryProofVoteTransactionBody;
}
