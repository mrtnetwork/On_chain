import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart" as proto_basic_types;
import "package:on_chain/hedera/src/proto_messages/google/protobuf/src/wrappers.dart" as google_protobuf_wrappers;

/// *
///  * # Token Update NFTs
///  * Given a token identifier and a metadata block, change the metadata for
///  * one or more non-fungible/unique token instances.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in
///  * [RFC2119](https://www.ietf.org/rfc/rfc2119) and clarified in
///  * [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.token"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * Modify the metadata field for an individual non-fungible/unique token (NFT).
///  *
///  * Updating the metadata of an NFT SHALL NOT affect ownership or
///  * the ability to transfer that NFT.&lt;br/&gt;
///  * This transaction SHALL affect only the specific serial numbered tokens
///  * identified.
///  * This transaction SHALL modify individual token metadata.&lt;br/&gt;
///  * This transaction MUST be signed by the token `metadata_key`.&lt;br/&gt;
///  * The token `metadata_key` MUST be a valid `Key`.&lt;br/&gt;
///  * The token `metadata_key` MUST NOT be an empty `KeyList`.
///  *
///  * ### Block Stream Effects
///  * None
class HederaTokenUpdateNftsTransactionBody extends HederaProtoMessage with Equality {
    /// *
  ///      * A token identifier.&lt;br/&gt;
  ///      * This is the token type (i.e. collection) for which to update NFTs.
  ///      * &lt;p&gt;
  ///      * This field is REQUIRED.&lt;br/&gt;
  ///      * The identified token MUST exist, MUST NOT be paused, MUST have the type
  ///      * non-fungible/unique, and MUST have a valid `metadata_key`.
  final proto_basic_types.HederaTokenID? token;

    /// *
  ///      * A list of serial numbers to be updated.
  ///      * &lt;p&gt;
  ///      * This field is REQUIRED.&lt;br/&gt;
  ///      * This list MUST have at least one(1) entry.&lt;br/&gt;
  ///      * This list MUST NOT have more than ten(10) entries.
  final List<BigInt> serialNumbers;

    /// *
  ///      * A new value for the metadata.
  ///      * &lt;p&gt;
  ///      * If this field is not set, the metadata SHALL NOT change.&lt;br/&gt;
  ///      * This value, if set, MUST NOT exceed 100 bytes.
  final google_protobuf_wrappers.HederaBytesValue? metadata;

  const HederaTokenUpdateNftsTransactionBody({
    this.token,
    this.serialNumbers = const [],
    this.metadata,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.repeated(
          fieldNumber: 2,
          elementType: ProtoFieldType.int64,
        ),
        ProtoFieldConfig.message(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        token,
        serialNumbers,
        metadata,
      ];


HederaTokenUpdateNftsTransactionBody copyWith(
{proto_basic_types.HederaTokenID? token,

List<BigInt>? serialNumbers,

google_protobuf_wrappers.HederaBytesValue? metadata,

}) {
    return HederaTokenUpdateNftsTransactionBody(
token: token ?? this.token,
serialNumbers: serialNumbers ?? this.serialNumbers,
metadata: metadata ?? this.metadata,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'token': config.encodeMessage(token),
      'serial_numbers': serialNumbers.map((e) => config.encodeBigint(e)).toList(),
      'metadata': config.encodeMessage(metadata),
    };
  }


  factory HederaTokenUpdateNftsTransactionBody.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaTokenUpdateNftsTransactionBody(
      token: json.valueTo<proto_basic_types.HederaTokenID?, Object>(
        key: 'token',
        parse: (v) => proto_basic_types.HederaTokenID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      serialNumbers: (json.valueEnsureAsList<dynamic>('serial_numbers', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueAsBigInt<BigInt>(e)).toList(),
      metadata: json.valueTo<google_protobuf_wrappers.HederaBytesValue?, Object>(
        key: 'metadata',
        parse: (v) => google_protobuf_wrappers.HederaBytesValue.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory HederaTokenUpdateNftsTransactionBody.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTokenUpdateNftsTransactionBody(
      token: decode.messageTo<proto_basic_types.HederaTokenID?>(1, (b) => proto_basic_types.HederaTokenID.deserialize(b)),
      serialNumbers: decode.getListOrEmpty<BigInt>(2),
      metadata: decode.messageTo<google_protobuf_wrappers.HederaBytesValue?>(3, (b) => google_protobuf_wrappers.HederaBytesValue.deserialize(b)),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoTokenUpdateNftsTransactionBody;

}


