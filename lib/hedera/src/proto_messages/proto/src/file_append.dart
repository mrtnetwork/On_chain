import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart" as proto_basic_types;

/// *
///  * # File Append
///  * A transaction body message to append data to a "file" in state.
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
///  * A transaction body for an `appendContent` transaction.&lt;br/&gt;
///  * This transaction body provides a mechanism to append content to a "file" in
///  * network state. Hedera transactions are limited in size, but there are many
///  * uses for in-state byte arrays (e.g. smart contract bytecode) which require
///  * more than may fit within a single transaction. The `appendFile` transaction
///  * exists to support these requirements. The typical pattern is to create a
///  * file, append more data until the full content is stored, verify the file is
///  * correct, then update the file entry with any final metadata changes (e.g.
///  * adding threshold keys and removing the initial upload key).
///  *
///  * Each append transaction MUST remain within the total transaction size limit
///  * for the network (typically 6144 bytes).&lt;br/&gt;
///  * The total size of a file MUST remain within the maximum file size limit for
///  * the network (typically 1048576 bytes).
///  *
///  * #### Signature Requirements
///  * Append transactions MUST have signatures from _all_ keys in the `KeyList`
///  * assigned to the `keys` field of the file.&lt;br/&gt;
///  * See the [File Service](#FileService) specification for a detailed
///  * explanation of the signature requirements for all file transactions.
///  *
///  * ### Block Stream Effects
///  * None
class HederaFileAppendTransactionBody extends HederaProtoMessage with Equality {
    /// *
  ///      * A file identifier.&lt;br/&gt;
  ///      * This identifies the file to which the `contents` will be appended.
  ///      * &lt;p&gt;
  ///      * This field is REQUIRED.&lt;br/&gt;
  ///      * The identified file MUST exist.&lt;br/&gt;
  ///      * The identified file MUST NOT be larger than the current maximum file
  ///      * size limit.&lt;br/&gt;
  ///      * The identified file MUST NOT be deleted.&lt;br/&gt;
  ///      * The identified file MUST NOT be immutable.
  final proto_basic_types.HederaFileID? fileID;

    /// *
  ///      * An array of bytes to append.&lt;br/&gt;
  ///      * &lt;p&gt;
  ///      * This content SHALL be appended to the identified file if this
  ///      * transaction succeeds.&lt;br/&gt;
  ///      * This field is REQUIRED.&lt;br/&gt;
  ///      * This field MUST NOT be empty.
  final List<int>? contents;

  const HederaFileAppendTransactionBody({
    this.fileID,
    this.contents,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(2),
        ProtoFieldConfig.bytes(4),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        fileID,
        contents,
      ];


HederaFileAppendTransactionBody copyWith(
{proto_basic_types.HederaFileID? fileID,

List<int>? contents,

}) {
    return HederaFileAppendTransactionBody(
fileID: fileID ?? this.fileID,
contents: contents ?? this.contents,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'fileID': config.encodeMessage(fileID),
      'contents': config.encodeBinary(contents),
    };
  }


  factory HederaFileAppendTransactionBody.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaFileAppendTransactionBody(
      fileID: json.valueTo<proto_basic_types.HederaFileID?, Object>(
        key: 'fileID',
        parse: (v) => proto_basic_types.HederaFileID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      contents: config.decodeBinary<List<int>?>(json.valueAs('contents', normalizeKeyLookup: config.normalizeKeys)),
    );
  }

  factory HederaFileAppendTransactionBody.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaFileAppendTransactionBody(
      fileID: decode.messageTo<proto_basic_types.HederaFileID?>(2, (b) => proto_basic_types.HederaFileID.deserialize(b)),
      contents: decode.getBytes<List<int>?>(4),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoFileAppendTransactionBody;

}


