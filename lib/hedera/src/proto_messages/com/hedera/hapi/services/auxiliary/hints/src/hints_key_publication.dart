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
///  * A transaction body to publish a node's hinTS key for a certain
///  * party id and number of parties. A hinTS key is an extended
///  * public key; that is, a BLS public key combined with "hints"
///  * derived from the matching private key that a signature
///  * aggregator can use to prove well-formedness of an aggregate
///  * public key by an efficiently verifiable SNARK.
class HederaHintsKeyPublicationTransactionBody extends HederaProtoMessage with Equality {
    /// *
  ///    * The party id for which the hinTS key is being published;
  ///    * must be in the range [0, num_parties).
  ///    * &lt;p&gt;
  ///    * This value MUST be set to a non-negative integer.&lt;br/&gt;
  final int? partyId;

    /// *
  ///    * The number of parties in the hinTS scheme.
  final int? numParties;

    /// *
  ///    * The party's hinTS key.
  final List<int>? hintsKey;

  const HederaHintsKeyPublicationTransactionBody({
    this.partyId,
    this.numParties,
    this.hintsKey,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.uint32(1),
        ProtoFieldConfig.uint32(2),
        ProtoFieldConfig.bytes(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        partyId,
        numParties,
        hintsKey,
      ];


HederaHintsKeyPublicationTransactionBody copyWith(
{int? partyId,

int? numParties,

List<int>? hintsKey,

}) {
    return HederaHintsKeyPublicationTransactionBody(
partyId: partyId ?? this.partyId,
numParties: numParties ?? this.numParties,
hintsKey: hintsKey ?? this.hintsKey,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'party_id': partyId,
      'num_parties': numParties,
      'hints_key': config.encodeBinary(hintsKey),
    };
  }


  factory HederaHintsKeyPublicationTransactionBody.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaHintsKeyPublicationTransactionBody(
      partyId: json.valueAsInt<int?>('party_id', normalizeKeyLookup: config.normalizeKeys),
      numParties: json.valueAsInt<int?>('num_parties', normalizeKeyLookup: config.normalizeKeys),
      hintsKey: config.decodeBinary<List<int>?>(json.valueAs('hints_key', normalizeKeyLookup: config.normalizeKeys)),
    );
  }

  factory HederaHintsKeyPublicationTransactionBody.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaHintsKeyPublicationTransactionBody(
      partyId: decode.getInt<int?>(1),
      numParties: decode.getInt<int?>(2),
      hintsKey: decode.getBytes<List<int>?>(3),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiServicesAuxiliaryHintsHintsKeyPublicationTransactionBody;

}


