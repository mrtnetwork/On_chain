import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';

/// *
///  * # hinTS Partial Signature Transaction
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
///  * A transaction body to publish a node's hinTS partial signature on
///  * a particular message for a certain construction id.
class HederaHintsPartialSignatureTransactionBody extends HederaProtoMessage with Equality {
    /// *
  ///    * The id of the hinTS construction this partial signature applies to.
  ///    * (The size of the target roster for this construction implies what
  ///    * hinTS party id the submitting node has in the construction; and
  ///    * hence also what weight the node's signature has.)
  final BigInt? constructionId;

    /// *
  ///    * The message being signed.
  final List<int>? message;

    /// *
  ///    * The node's partial signature on the message.
  final List<int>? partialSignature;

  const HederaHintsPartialSignatureTransactionBody({
    this.constructionId,
    this.message,
    this.partialSignature,
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
        ProtoFieldConfig.bytes(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        constructionId,
        message,
        partialSignature,
      ];


HederaHintsPartialSignatureTransactionBody copyWith(
{BigInt? constructionId,

List<int>? message,

List<int>? partialSignature,

}) {
    return HederaHintsPartialSignatureTransactionBody(
constructionId: constructionId ?? this.constructionId,
message: message ?? this.message,
partialSignature: partialSignature ?? this.partialSignature,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'construction_id': config.encodeBigint(constructionId),
      'message': config.encodeBinary(message),
      'partial_signature': config.encodeBinary(partialSignature),
    };
  }


  factory HederaHintsPartialSignatureTransactionBody.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaHintsPartialSignatureTransactionBody(
      constructionId: json.valueAsBigInt<BigInt?>('construction_id', normalizeKeyLookup: config.normalizeKeys),
      message: config.decodeBinary<List<int>?>(json.valueAs('message', normalizeKeyLookup: config.normalizeKeys)),
      partialSignature: config.decodeBinary<List<int>?>(json.valueAs('partial_signature', normalizeKeyLookup: config.normalizeKeys)),
    );
  }

  factory HederaHintsPartialSignatureTransactionBody.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaHintsPartialSignatureTransactionBody(
      constructionId: decode.getBigInt<BigInt?>(1),
      message: decode.getBytes<List<int>?>(2),
      partialSignature: decode.getBytes<List<int>?>(3),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiServicesAuxiliaryHintsHintsPartialSignatureTransactionBody;

}


