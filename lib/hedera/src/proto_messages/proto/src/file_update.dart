import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;
import "package:on_chain/hedera/src/proto_messages/proto/src/timestamp.dart"
    as proto_timestamp;
import "package:on_chain/hedera/src/proto_messages/google/protobuf/src/wrappers.dart"
    as google_protobuf_wrappers;

/// *
///  * # File Update
///  * A message to modify the metadata for a file and/or _replace_ the contents.
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
///  * Update the metadata, and/or replace the content, of a file in the
///  * Hedera File Service (HFS).
///  *
///  * Any field which is not set (i.e. is null) in this message, other than
///  * `fileID`, SHALL be ignored.&lt;br/&gt;
///  * If the `keys` list for the identified file is an empty `KeyList`, then
///  * this message MUST NOT set any field except `expirationTime`.
///  *
///  * #### Signature Requirements
///  * Every `Key` in the `keys` list for the identified file MUST sign this
///  * transaction, if any field other than `expirationTime` is to be updated.&lt;br/&gt;
///  * If the `keys` list for the identified file is an empty `KeyList` (because
///  * this file was previously created or updated to have an empty `KeyList`),
///  * then the file is considered immutable and this message MUST NOT set any
///  * field except `expirationTime`.&lt;br/&gt;
///  * See the [File Service](#FileService) specification for a detailed
///  * explanation of the signature requirements for all file transactions.
///  *
///  * ### Block Stream Effects
///  * None
class HederaFileUpdateTransactionBody extends HederaProtoMessage with Equality {
  /// *
  ///      * A file identifier for the file to update.
  ///      * &lt;p&gt;
  ///      * This field is REQUIRED.
  final proto_basic_types.HederaFileID? fileID;

  /// *
  ///      * An expiration timestamp.
  ///      * &lt;p&gt;
  ///      * If set, this value MUST be strictly later than the existing
  ///      * `expirationTime` value, or else it will be ignored.&lt;br/&gt;
  ///      * If set, this value SHALL replace the existing `expirationTime`.&lt;br/&gt;
  ///      * If this field is the only field set, then this transaction SHALL NOT
  ///      * require any signature other than the `payer` for the transaction.&lt;br/&gt;
  ///      * When the network consensus time exceeds the then-current
  ///      * `expirationTime`, the network SHALL expire the file.
  final proto_timestamp.HederaTimestamp? expirationTime;

  /// *
  ///      * The new list of keys that "own" this file.
  ///      * &lt;p&gt;
  ///      * If set, every key in this `KeyList` MUST sign this transaction.&lt;br/&gt;
  ///      * If set, every key in the _previous_ `KeyList` MUST _also_
  ///      * sign this transaction.&lt;br/&gt;
  ///      * If this value is an empty `KeyList`, then the file SHALL be immutable
  ///      * after completion of this transaction.
  final proto_basic_types.HederaKeyList? keys;

  /// *
  ///      * An array of bytes.
  ///      * &lt;p&gt;
  ///      * This value, if set, SHALL _replace_ the existing file content.
  ///      * If this value is set to an empty byte array, the content of the file
  ///      * SHALL be unchanged.
  final List<int>? contents;

  /// *
  ///      * A short description of this file.
  ///      * &lt;p&gt;
  ///      * This value, if set, MUST NOT exceed `transaction.maxMemoUtf8Bytes`
  ///      * (default 100) bytes when encoded as UTF-8.
  final google_protobuf_wrappers.HederaStringValue? memo;

  const HederaFileUpdateTransactionBody({
    this.fileID,
    this.expirationTime,
    this.keys,
    this.contents,
    this.memo,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.message(2),
        ProtoFieldConfig.message(3),
        ProtoFieldConfig.bytes(4),
        ProtoFieldConfig.message(5),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    fileID,
    expirationTime,
    keys,
    contents,
    memo,
  ];

  HederaFileUpdateTransactionBody copyWith({
    proto_basic_types.HederaFileID? fileID,

    proto_timestamp.HederaTimestamp? expirationTime,

    proto_basic_types.HederaKeyList? keys,

    List<int>? contents,

    google_protobuf_wrappers.HederaStringValue? memo,
  }) {
    return HederaFileUpdateTransactionBody(
      fileID: fileID ?? this.fileID,
      expirationTime: expirationTime ?? this.expirationTime,
      keys: keys ?? this.keys,
      contents: contents ?? this.contents,
      memo: memo ?? this.memo,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'fileID': config.encodeMessage(fileID),
      'expirationTime': config.encodeMessage(expirationTime),
      'keys': config.encodeMessage(keys),
      'contents': config.encodeBinary(contents),
      'memo': config.encodeMessage(memo),
    };
  }

  factory HederaFileUpdateTransactionBody.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaFileUpdateTransactionBody(
      fileID: json.valueTo<proto_basic_types.HederaFileID?, Object>(
        key: 'fileID',
        parse:
            (v) => proto_basic_types.HederaFileID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      expirationTime: json.valueTo<proto_timestamp.HederaTimestamp?, Object>(
        key: 'expirationTime',
        parse:
            (v) => proto_timestamp.HederaTimestamp.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      keys: json.valueTo<proto_basic_types.HederaKeyList?, Object>(
        key: 'keys',
        parse:
            (v) => proto_basic_types.HederaKeyList.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      contents: config.decodeBinary<List<int>?>(
        json.valueAs('contents', normalizeKeyLookup: config.normalizeKeys),
      ),
      memo: json.valueTo<google_protobuf_wrappers.HederaStringValue?, Object>(
        key: 'memo',
        parse:
            (v) => google_protobuf_wrappers.HederaStringValue.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaFileUpdateTransactionBody.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaFileUpdateTransactionBody(
      fileID: decode.messageTo<proto_basic_types.HederaFileID?>(
        1,
        (b) => proto_basic_types.HederaFileID.deserialize(b),
      ),
      expirationTime: decode.messageTo<proto_timestamp.HederaTimestamp?>(
        2,
        (b) => proto_timestamp.HederaTimestamp.deserialize(b),
      ),
      keys: decode.messageTo<proto_basic_types.HederaKeyList?>(
        3,
        (b) => proto_basic_types.HederaKeyList.deserialize(b),
      ),
      contents: decode.getBytes<List<int>?>(4),
      memo: decode.messageTo<google_protobuf_wrappers.HederaStringValue?>(
        5,
        (b) => google_protobuf_wrappers.HederaStringValue.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoFileUpdateTransactionBody;
}
