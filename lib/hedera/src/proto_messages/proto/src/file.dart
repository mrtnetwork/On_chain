import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart" as proto_basic_types;

/// *
///  * # File
///  * A "file" in the distributed ledger is a stream of bytes. These bytes may
///  * contain any data, and are limited in length based on network configuration
///  * (for example, 1048576).
///  *
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in [RFC2119](https://www.ietf.org/rfc/rfc2119)
///  * and clarified in [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.state.file"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * Representation of an Hedera File Service `file`.
///  *
///  * Files offer a place to store additional data, much more than is available in
///  * other entities, for use with smart contracts, non-fungible tokens, etc...
///  * As with all network entities, a file has a unique entity number, which is
///  * given along with the network's shard and realm in the form of a
///  * shard.realm.number id.
class HederaFile extends HederaProtoMessage with Equality {
    /// *
  ///      * This file's ID within the global network state.
  ///      * &lt;p&gt;
  ///      * This value SHALL be unique within the network.
  final proto_basic_types.HederaFileID? fileId;

    /// *
  ///      * The file's expiration time in seconds since the epoch.&lt;br/&gt;
  ///      * This value should be compared against consensus time, which may not
  ///      * exactly match clock time at the moment of expiration.
  ///      * &lt;p&gt;
  ///      * For this purpose, `epoch` SHALL be the UNIX epoch with 0 at `1970-01-01T00:00:00.000Z`.
  final BigInt? expirationSecond;

    /// *
  ///      * A list of keys that MUST sign any transaction to create
  ///      * or update this file.
  ///      * &lt;p&gt;
  ///      * Only _one_ of these keys must sign a transaction to delete the file.&lt;br/&gt;
  ///      * This field MAY be `null` or an empty list.&lt;br/&gt;
  ///      * If this field is null or an empty `KeyList`, then the file SHALL be
  ///      * immutable.&lt;br/&gt;
  ///      * For an immutable file, the only transaction permitted to modify that
  ///      * file SHALL be a `fileUpdate` transaction with _only_ the
  ///      * `expirationTime` set.
  final proto_basic_types.HederaKeyList? keys;

    /// *
  ///      * The contents of the file.
  ///      * &lt;p&gt;
  ///      * This SHALL be limited to the current maximum file size; typically no
  ///      * more than 1 Megabyte (1048576 bytes).
  final List<int>? contents;

    /// *
  ///      * A short description of the file.
  ///      * &lt;p&gt;
  ///      * This value, if set, MUST NOT exceed `transaction.maxMemoUtf8Bytes`
  ///      * (default 100) bytes when encoded as UTF-8.
  final String? memo;

    /// *
  ///      * A flag indicating that this file is deleted.
  ///      * &lt;p&gt;
  ///      * The `contents` of a deleted "regular" file SHALL be an empty
  ///      * (zero length) bytes.
  final bool? deleted;

    /// *
  ///      * The pre-system-delete expiration time of a deleted "system" file, in seconds.
  ///      * &lt;p&gt;
  ///      * This field SHALL contain the original expiration time of a "system" file
  ///      * that is deleted. This SHOULD be used to restore that expiration time if
  ///      * the file is subsequently "un-deleted" before it is purged from the
  ///      * system.&lt;br/&gt;
  ///      * A "regular" file cannot be "un-deleted", so this field SHALL NOT be set
  ///      * for those files.
  final BigInt? preSystemDeleteExpirationSecond;

  const HederaFile({
    this.fileId,
    this.expirationSecond,
    this.keys,
    this.contents,
    this.memo,
    this.deleted,
    this.preSystemDeleteExpirationSecond,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.int64(2),
        ProtoFieldConfig.message(3),
        ProtoFieldConfig.bytes(4),
        ProtoFieldConfig.string(5),
        ProtoFieldConfig.bool(6),
        ProtoFieldConfig.int64(7),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        fileId,
        expirationSecond,
        keys,
        contents,
        memo,
        deleted,
        preSystemDeleteExpirationSecond,
      ];


HederaFile copyWith(
{proto_basic_types.HederaFileID? fileId,

BigInt? expirationSecond,

proto_basic_types.HederaKeyList? keys,

List<int>? contents,

String? memo,

bool? deleted,

BigInt? preSystemDeleteExpirationSecond,

}) {
    return HederaFile(
fileId: fileId ?? this.fileId,
expirationSecond: expirationSecond ?? this.expirationSecond,
keys: keys ?? this.keys,
contents: contents ?? this.contents,
memo: memo ?? this.memo,
deleted: deleted ?? this.deleted,
preSystemDeleteExpirationSecond: preSystemDeleteExpirationSecond ?? this.preSystemDeleteExpirationSecond,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'file_id': config.encodeMessage(fileId),
      'expiration_second': config.encodeBigint(expirationSecond),
      'keys': config.encodeMessage(keys),
      'contents': config.encodeBinary(contents),
      'memo': memo,
      'deleted': deleted,
      'pre_system_delete_expiration_second': config.encodeBigint(preSystemDeleteExpirationSecond),
    };
  }


  factory HederaFile.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaFile(
      fileId: json.valueTo<proto_basic_types.HederaFileID?, Object>(
        key: 'file_id',
        parse: (v) => proto_basic_types.HederaFileID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      expirationSecond: json.valueAsBigInt<BigInt?>('expiration_second', normalizeKeyLookup: config.normalizeKeys),
      keys: json.valueTo<proto_basic_types.HederaKeyList?, Object>(
        key: 'keys',
        parse: (v) => proto_basic_types.HederaKeyList.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      contents: config.decodeBinary<List<int>?>(json.valueAs('contents', normalizeKeyLookup: config.normalizeKeys)),
      memo: json.valueAsString<String?>('memo', normalizeKeyLookup: config.normalizeKeys),
      deleted: json.valueAsBool<bool?>('deleted', normalizeKeyLookup: config.normalizeKeys),
      preSystemDeleteExpirationSecond: json.valueAsBigInt<BigInt?>('pre_system_delete_expiration_second', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaFile.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaFile(
      fileId: decode.messageTo<proto_basic_types.HederaFileID?>(1, (b) => proto_basic_types.HederaFileID.deserialize(b)),
      expirationSecond: decode.getBigInt<BigInt?>(2),
      keys: decode.messageTo<proto_basic_types.HederaKeyList?>(3, (b) => proto_basic_types.HederaKeyList.deserialize(b)),
      contents: decode.getBytes<List<int>?>(4),
      memo: decode.getString<String?>(5),
      deleted: decode.getBool<bool?>(6),
      preSystemDeleteExpirationSecond: decode.getBigInt<BigInt?>(7),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoFile;

}


