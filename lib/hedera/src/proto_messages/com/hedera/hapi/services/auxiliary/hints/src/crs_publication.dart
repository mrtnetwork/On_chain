import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';

/// *
///  * # hinTS Key Publication Transaction
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
///  * A transaction body to publish a node's Common Reference String (CRS) to the network. This is used
///  * when node wants to update to reach the final CRS for network to use the hinTS protocol
class HederaCrsPublicationTransactionBody extends HederaProtoMessage with Equality {
    /// *
  ///      * The party's generated random CRS.
  final List<int>? newCrs;

    /// *
  ///      * The party's proof of the CRS update.
  final List<int>? proof;

  const HederaCrsPublicationTransactionBody({
    this.newCrs,
    this.proof,
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
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        newCrs,
        proof,
      ];


HederaCrsPublicationTransactionBody copyWith(
{List<int>? newCrs,

List<int>? proof,

}) {
    return HederaCrsPublicationTransactionBody(
newCrs: newCrs ?? this.newCrs,
proof: proof ?? this.proof,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'new_crs': config.encodeBinary(newCrs),
      'proof': config.encodeBinary(proof),
    };
  }


  factory HederaCrsPublicationTransactionBody.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaCrsPublicationTransactionBody(
      newCrs: config.decodeBinary<List<int>?>(json.valueAs('new_crs', normalizeKeyLookup: config.normalizeKeys)),
      proof: config.decodeBinary<List<int>?>(json.valueAs('proof', normalizeKeyLookup: config.normalizeKeys)),
    );
  }

  factory HederaCrsPublicationTransactionBody.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaCrsPublicationTransactionBody(
      newCrs: decode.getBytes<List<int>?>(1),
      proof: decode.getBytes<List<int>?>(2),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiServicesAuxiliaryHintsCrsPublicationTransactionBody;

}


