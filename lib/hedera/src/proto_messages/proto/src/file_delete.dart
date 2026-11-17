import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart" as proto_basic_types;

/// *
///  * # File Delete
///  * A message for a transaction to delete a file.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in
///  * [RFC2119](https://www.ietf.org/rfc/rfc2119) and clarified in
///  * [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.file"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * Mark a file as deleted and remove its content from network state.
///  *
///  * The metadata for a deleted file SHALL be retained at least until the
///  * expiration time for the file is exceeded.&lt;br/&gt;
///  * On completion, the identified file SHALL be marked `deleted`.&lt;br/&gt;
///  * On completion, the identified file SHALL have an empty `contents` array.&lt;br/&gt;
///  * This transaction SHALL be final and irreversible.&lt;br/&gt;
///  *
///  * #### Signature Requirements
///  * At least _one_ key from the `KeyList` in the `keys` field of the
///  * identified file MUST sign this transaction.&lt;br/&gt;
///  * If the keys field for the identified file is an empty `KeyList` (because that
///  * file was previously created or updated to have an empty `KeyList`), then the
///  * file is considered immutable and this message SHALL fail as UNAUTHORIZED.
///  * See the [File Service](#FileService) specification for a detailed
///  * explanation of the signature requirements for all file transactions.
///  *
///  * ### What is a "system" file
///  * A "system" file is any file with a file number less than or equal to the
///  * current configuration value for `ledger.numReservedSystemEntities`,
///  * typically `750`.
///  *
///  * ### Block Stream Effects
///  * None
class HederaFileDeleteTransactionBody extends HederaProtoMessage with Equality {
    /// *
  ///      * A file identifier.&lt;br/&gt;
  ///      * This identifies the file to delete.
  ///      * &lt;p&gt;
  ///      * The identified file MUST NOT be a "system" file.&lt;br/&gt;
  ///      * This field is REQUIRED.
  final proto_basic_types.HederaFileID? fileID;

  const HederaFileDeleteTransactionBody({
    this.fileID,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(2),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        fileID,
      ];


HederaFileDeleteTransactionBody copyWith(
{proto_basic_types.HederaFileID? fileID,

}) {
    return HederaFileDeleteTransactionBody(
fileID: fileID ?? this.fileID,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'fileID': config.encodeMessage(fileID),
    };
  }


  factory HederaFileDeleteTransactionBody.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaFileDeleteTransactionBody(
      fileID: json.valueTo<proto_basic_types.HederaFileID?, Object>(
        key: 'fileID',
        parse: (v) => proto_basic_types.HederaFileID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory HederaFileDeleteTransactionBody.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaFileDeleteTransactionBody(
      fileID: decode.messageTo<proto_basic_types.HederaFileID?>(2, (b) => proto_basic_types.HederaFileID.deserialize(b)),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoFileDeleteTransactionBody;

}


