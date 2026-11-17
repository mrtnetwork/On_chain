import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/node/state/history/src/history_types.dart"
    as com_hedera_hapi_node_state_history_history_types;

/// *
///  * # Proof Key Publication Transaction
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in
///  * [RFC2119](https://www.ietf.org/rfc/rfc2119) and clarified in
///  * [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.services.auxiliary.history"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * A transaction body to publish a node's history proof key and
///  * WRAPS messages.
class HederaHistoryProofKeyPublicationTransactionBody extends HederaProtoMessage
    with Equality {
  /// *
  ///      * The proof key the submitting node intends to use when
  ///      * contributing WRAPS messages for use in proving history
  ///      * belongs to the chain of trust for the ledger id.
  final List<int>? proofKey;

  /// *
  ///      * A WRAPS message from the submitting node.
  final List<int>? wrapsMessage;

  /// *
  ///    * The id of the proof construction this publication is for.
  final BigInt? constructionId;

  /// *
  ///    * The phase of the proof construction this key is being
  ///    * published for.
  final com_hedera_hapi_node_state_history_history_types.HederaWrapsPhase?
  phase;

  const HederaHistoryProofKeyPublicationTransactionBody({
    this.proofKey,
    this.wrapsMessage,
    this.constructionId,
    this.phase,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.bytes(2),
        ProtoFieldConfig.uint64(3),
        ProtoFieldConfig.enumType(4),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    proofKey,
    wrapsMessage,
    constructionId,
    phase,
  ];

  HederaHistoryProofKeyPublicationTransactionBody copyWith({
    List<int>? proofKey,

    List<int>? wrapsMessage,

    BigInt? constructionId,

    com_hedera_hapi_node_state_history_history_types.HederaWrapsPhase? phase,
  }) {
    return HederaHistoryProofKeyPublicationTransactionBody(
      proofKey: proofKey ?? this.proofKey,
      wrapsMessage: wrapsMessage ?? this.wrapsMessage,
      constructionId: constructionId ?? this.constructionId,
      phase: phase ?? this.phase,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'proof_key': config.encodeBinary(proofKey),
      'wraps_message': config.encodeBinary(wrapsMessage),
      'construction_id': config.encodeBigint(constructionId),
      'phase': config.encodeEnum(phase),
    };
  }

  factory HederaHistoryProofKeyPublicationTransactionBody.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaHistoryProofKeyPublicationTransactionBody(
      proofKey: config.decodeBinary<List<int>?>(
        json.valueAs('proof_key', normalizeKeyLookup: config.normalizeKeys),
      ),
      wrapsMessage: config.decodeBinary<List<int>?>(
        json.valueAs('wraps_message', normalizeKeyLookup: config.normalizeKeys),
      ),
      constructionId: json.valueAsBigInt<BigInt?>(
        'construction_id',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      phase: json.valueTo<
        com_hedera_hapi_node_state_history_history_types.HederaWrapsPhase?,
        Object?
      >(
        key: 'phase',
        parse:
            (v) => com_hedera_hapi_node_state_history_history_types
                .HederaWrapsPhase.from(v),
      ),
    );
  }

  factory HederaHistoryProofKeyPublicationTransactionBody.deserialize(
    List<int> bytes,
  ) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaHistoryProofKeyPublicationTransactionBody(
      proofKey: decode.getBytes<List<int>?>(1),
      wrapsMessage: decode.getBytes<List<int>?>(2),
      constructionId: decode.getBigInt<BigInt?>(3),
      phase: decode.getEnum<
        com_hedera_hapi_node_state_history_history_types.HederaWrapsPhase?
      >(
        4,
        com_hedera_hapi_node_state_history_history_types
            .HederaWrapsPhase
            .values,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl
          .comHederaHapiServicesAuxiliaryHistoryHistoryProofKeyPublicationTransactionBody;
}
