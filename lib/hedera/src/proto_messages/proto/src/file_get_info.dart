import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/query_header.dart"
    as proto_query_header;
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;
import "package:on_chain/hedera/src/proto_messages/proto/src/response_header.dart"
    as proto_response_header;
import "package:on_chain/hedera/src/proto_messages/proto/src/timestamp.dart"
    as proto_timestamp;
import "package:on_chain/hedera/src/proto_messages/proto/src/query.dart"
    as proto_query;

/// *
///  * # File Get Information
///  * Messages for a query to retrieve the metadata for a file in the
///  * Hedera File Service (HFS).
///  *
///  * The query defined here does not include the content of the file.
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
///  * Query to request file metadata from the Hedera File Service (HFS).&lt;br/&gt;
///  * This query requests all of the information _about_ a file, but none of the
///  * _content_ of a file. A client should submit a `fileGetContents` query to
///  * view the content of a file. File content _may_ also be available from a
///  * block node or mirror node, generally at lower cost.
///  *
///  * File metadata SHALL be available for active files and deleted files.&lt;br/&gt;
///  * The size of a deleted file SHALL be `0` and the content SHALL be empty.
class HederaFileGetInfoQuery extends HederaProtoMessage
    with Equality, IHederaQuery<HederaFileGetInfoResponse> {
  /// *
  ///      * Standard information sent with every query operation.&lt;br/&gt;
  ///      * This includes the signed payment and what kind of response is requested
  ///      * (cost, state proof, both, or neither).
  @override
  final proto_query_header.HederaQueryHeader? header;

  /// *
  ///      * A file identifier.
  ///      * &lt;p&gt;
  ///      * This MUST be the identifier of a file that exists in HFS.&lt;br/&gt;
  ///      * This value SHALL identify the file to be queried.
  final proto_basic_types.HederaFileID? fileID;

  const HederaFileGetInfoQuery({this.header, this.fileID});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.message(1), ProtoFieldConfig.message(2)],
    );
  }

  @override
  List<Object?> get protoValues => [header, fileID];

  @override
  HederaFileGetInfoQuery copyWith({
    proto_query_header.HederaQueryHeader? header,

    proto_basic_types.HederaFileID? fileID,
  }) {
    return HederaFileGetInfoQuery(
      header: header ?? this.header,
      fileID: fileID ?? this.fileID,
    );
  }

  @override
  proto_query.HederaQuery toQueryRequest({
    proto_query_header.HederaQueryHeader? header,
  }) => proto_query.HederaQuery(fileGetInfo: copyWith(header: header));
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'header': config.encodeMessage(header),
      'fileID': config.encodeMessage(fileID),
    };
  }

  factory HederaFileGetInfoQuery.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaFileGetInfoQuery(
      header: json.valueTo<proto_query_header.HederaQueryHeader?, Object>(
        key: 'header',
        parse:
            (v) => proto_query_header.HederaQueryHeader.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      fileID: json.valueTo<proto_basic_types.HederaFileID?, Object>(
        key: 'fileID',
        parse:
            (v) => proto_basic_types.HederaFileID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaFileGetInfoQuery.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaFileGetInfoQuery(
      header: decode.messageTo<proto_query_header.HederaQueryHeader?>(
        1,
        (b) => proto_query_header.HederaQueryHeader.deserialize(b),
      ),
      fileID: decode.messageTo<proto_basic_types.HederaFileID?>(
        2,
        (b) => proto_basic_types.HederaFileID.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoFileGetInfoQuery;
}

/// *
///  * A response to a query for the metadata of a file in the HFS.
class HederaFileGetInfoResponse extends HederaProtoMessage
    with Equality, IHederaQueryRespone {
  /// *
  ///      * The standard response information for queries.&lt;br/&gt;
  ///      * This includes the values requested in the `QueryHeader`
  ///      * (cost, state proof, both, or neither).
  @override
  final proto_response_header.HederaResponseHeader? header;

  /// *
  ///      * A combination of fields from the requested file metadata.
  ///      * &lt;p&gt;
  ///      * This SHALL NOT be set if the identified file does not exist
  ///      * or has expired.
  final HederaFileGetInfoResponseFileInfo? fileInfo;

  const HederaFileGetInfoResponse({this.header, this.fileInfo});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.message(1), ProtoFieldConfig.message(2)],
    );
  }

  @override
  List<Object?> get protoValues => [header, fileInfo];

  HederaFileGetInfoResponse copyWith({
    proto_response_header.HederaResponseHeader? header,

    HederaFileGetInfoResponseFileInfo? fileInfo,
  }) {
    return HederaFileGetInfoResponse(
      header: header ?? this.header,
      fileInfo: fileInfo ?? this.fileInfo,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'header': config.encodeMessage(header),
      'fileInfo': config.encodeMessage(fileInfo),
    };
  }

  factory HederaFileGetInfoResponse.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaFileGetInfoResponse(
      header: json.valueTo<proto_response_header.HederaResponseHeader?, Object>(
        key: 'header',
        parse:
            (v) => proto_response_header.HederaResponseHeader.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      fileInfo: json.valueTo<HederaFileGetInfoResponseFileInfo?, Object>(
        key: 'fileInfo',
        parse:
            (v) => HederaFileGetInfoResponseFileInfo.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaFileGetInfoResponse.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaFileGetInfoResponse(
      header: decode.messageTo<proto_response_header.HederaResponseHeader?>(
        1,
        (b) => proto_response_header.HederaResponseHeader.deserialize(b),
      ),
      fileInfo: decode.messageTo<HederaFileGetInfoResponseFileInfo?>(
        2,
        (b) => HederaFileGetInfoResponseFileInfo.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoFileGetInfoResponse;
}

class HederaFileGetInfoResponseFileInfo extends HederaProtoMessage
    with Equality {
  /// *
  ///          * A file identifier.
  ///          * &lt;p&gt;
  ///          * This SHALL be the identifier of a file that exists in HFS.&lt;br/&gt;
  ///          * This value SHALL identify the file that was queried.
  final proto_basic_types.HederaFileID? fileID;

  /// *
  ///          * A size, in bytes, for the file.
  final BigInt? size;

  /// *
  ///          * An expiration timestamp.
  ///          * &lt;p&gt;
  ///          * The file SHALL NOT expire before the network consensus time
  ///          * exceeds this value.&lt;br/&gt;
  ///          * The file SHALL expire after the network consensus time
  ///          * exceeds this value.&lt;br/&gt;
  final proto_timestamp.HederaTimestamp? expirationTime;

  /// *
  ///          * A flag indicating this file is deleted.
  ///          * &lt;p&gt;
  ///          * A deleted file SHALL have a size `0` and empty content.
  final bool? deleted;

  /// *
  ///          * A KeyList listing all keys that "own" the file.
  ///          * &lt;p&gt;
  ///          * All keys in this list MUST sign a transaction to append to the
  ///          * file content, or to modify file metadata.&lt;br/&gt;
  ///          * At least _one_ key in this list MUST sign a transaction to delete
  ///          * this file.&lt;br/&gt;
  ///          * If this is an empty `KeyList`, the file is immutable, cannot be
  ///          * modified or deleted, but MAY expire. A `fileUpdate` transaction MAY
  ///          * extend the expiration time for an immutable file.
  final proto_basic_types.HederaKeyList? keys;

  /// *
  ///          * A short description for this file.
  ///          * &lt;p&gt;
  ///          * This value, if set, MUST NOT exceed `transaction.maxMemoUtf8Bytes`
  ///          * (default 100) bytes when encoded as UTF-8.
  final String? memo;

  /// *
  ///          * A ledger identifier for the responding network.
  ///          * &lt;p&gt;
  ///          * This value SHALL identify the distributed ledger that responded to
  ///          * this query.
  final List<int>? ledgerId;

  const HederaFileGetInfoResponseFileInfo({
    this.fileID,
    this.size,
    this.expirationTime,
    this.deleted,
    this.keys,
    this.memo,
    this.ledgerId,
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
        ProtoFieldConfig.bool(4),
        ProtoFieldConfig.message(5),
        ProtoFieldConfig.string(6),
        ProtoFieldConfig.bytes(7),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    fileID,
    size,
    expirationTime,
    deleted,
    keys,
    memo,
    ledgerId,
  ];

  HederaFileGetInfoResponseFileInfo copyWith({
    proto_basic_types.HederaFileID? fileID,

    BigInt? size,

    proto_timestamp.HederaTimestamp? expirationTime,

    bool? deleted,

    proto_basic_types.HederaKeyList? keys,

    String? memo,

    List<int>? ledgerId,
  }) {
    return HederaFileGetInfoResponseFileInfo(
      fileID: fileID ?? this.fileID,
      size: size ?? this.size,
      expirationTime: expirationTime ?? this.expirationTime,
      deleted: deleted ?? this.deleted,
      keys: keys ?? this.keys,
      memo: memo ?? this.memo,
      ledgerId: ledgerId ?? this.ledgerId,
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
      'size': config.encodeBigint(size),
      'expirationTime': config.encodeMessage(expirationTime),
      'deleted': deleted,
      'keys': config.encodeMessage(keys),
      'memo': memo,
      'ledger_id': config.encodeBinary(ledgerId),
    };
  }

  factory HederaFileGetInfoResponseFileInfo.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaFileGetInfoResponseFileInfo(
      fileID: json.valueTo<proto_basic_types.HederaFileID?, Object>(
        key: 'fileID',
        parse:
            (v) => proto_basic_types.HederaFileID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      size: json.valueAsBigInt<BigInt?>(
        'size',
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
      deleted: json.valueAsBool<bool?>(
        'deleted',
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
      memo: json.valueAsString<String?>(
        'memo',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      ledgerId: config.decodeBinary<List<int>?>(
        json.valueAs('ledger_id', normalizeKeyLookup: config.normalizeKeys),
      ),
    );
  }

  factory HederaFileGetInfoResponseFileInfo.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaFileGetInfoResponseFileInfo(
      fileID: decode.messageTo<proto_basic_types.HederaFileID?>(
        1,
        (b) => proto_basic_types.HederaFileID.deserialize(b),
      ),
      size: decode.getBigInt<BigInt?>(2),
      expirationTime: decode.messageTo<proto_timestamp.HederaTimestamp?>(
        3,
        (b) => proto_timestamp.HederaTimestamp.deserialize(b),
      ),
      deleted: decode.getBool<bool?>(4),
      keys: decode.messageTo<proto_basic_types.HederaKeyList?>(
        5,
        (b) => proto_basic_types.HederaKeyList.deserialize(b),
      ),
      memo: decode.getString<String?>(6),
      ledgerId: decode.getBytes<List<int>?>(7),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoFileGetInfoResponseFileInfo;
}
