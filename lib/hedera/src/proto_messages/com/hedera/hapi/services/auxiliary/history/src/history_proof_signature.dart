import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/node/state/history/src/history_types.dart" as com_hedera_hapi_node_state_history_history_types;

/// *
///  * # Metadata Proof Assembly Signature Transaction
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
///  * A transaction body to publish a node's signature on a computed
///  * history of address book hash and associated metadata. This
///  * signature can contribute to a proof that the history belongs to
///  * to the chain of trust for the ledger id.
class HederaHistoryProofSignatureTransactionBody extends HederaProtoMessage with Equality {
    /// *
  ///    * The id of the proof construction this signature is contributing to.
  final BigInt? constructionId;

    /// *
  ///    * This node's signature on its computed history.
  final com_hedera_hapi_node_state_history_history_types.HederaHistorySignature? signature;

  const HederaHistoryProofSignatureTransactionBody({
    this.constructionId,
    this.signature,
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
        signature,
      ];


HederaHistoryProofSignatureTransactionBody copyWith(
{BigInt? constructionId,

com_hedera_hapi_node_state_history_history_types.HederaHistorySignature? signature,

}) {
    return HederaHistoryProofSignatureTransactionBody(
constructionId: constructionId ?? this.constructionId,
signature: signature ?? this.signature,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'construction_id': config.encodeBigint(constructionId),
      'signature': config.encodeMessage(signature),
    };
  }


  factory HederaHistoryProofSignatureTransactionBody.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaHistoryProofSignatureTransactionBody(
      constructionId: json.valueAsBigInt<BigInt?>('construction_id', normalizeKeyLookup: config.normalizeKeys),
      signature: json.valueTo<com_hedera_hapi_node_state_history_history_types.HederaHistorySignature?, Object>(
        key: 'signature',
        parse: (v) => com_hedera_hapi_node_state_history_history_types.HederaHistorySignature.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory HederaHistoryProofSignatureTransactionBody.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaHistoryProofSignatureTransactionBody(
      constructionId: decode.getBigInt<BigInt?>(1),
      signature: decode.messageTo<com_hedera_hapi_node_state_history_history_types.HederaHistorySignature?>(2, (b) => com_hedera_hapi_node_state_history_history_types.HederaHistorySignature.deserialize(b)),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiServicesAuxiliaryHistoryHistoryProofSignatureTransactionBody;

}


