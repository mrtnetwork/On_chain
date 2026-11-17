import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/query_header.dart"
    as proto_query_header;
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;
import "package:on_chain/hedera/src/proto_messages/proto/src/response_header.dart"
    as proto_response_header;
import "package:on_chain/hedera/src/proto_messages/proto/src/query.dart"
    as proto_query;

/// *
///  * # File Get Contents
///  * Messages for a query to retrieve the content of a file in the
///  * Hedera File Service (HFS).
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
///  * A query request to the Hedera File Service (HFS) for file content.&lt;br/&gt;
///  * This query requests the content of a file, but none of the information
///  * _about_ a file. A client should submit a `fileGetInfo` query to view
///  * information about a file.&lt;br/&gt;
///  * File content may also be available from a block node or mirror node,
///  * generally at lower cost.
class HederaFileGetContentsQuery extends HederaProtoMessage
    with Equality, IHederaQuery<HederaFileGetContentsResponse> {
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

  const HederaFileGetContentsQuery({this.header, this.fileID});

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
  HederaFileGetContentsQuery copyWith({
    proto_query_header.HederaQueryHeader? header,

    proto_basic_types.HederaFileID? fileID,
  }) {
    return HederaFileGetContentsQuery(
      header: header ?? this.header,
      fileID: fileID ?? this.fileID,
    );
  }

  @override
  proto_query.HederaQuery toQueryRequest({
    proto_query_header.HederaQueryHeader? header,
  }) => proto_query.HederaQuery(fileGetContents: copyWith(header: header));
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

  factory HederaFileGetContentsQuery.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaFileGetContentsQuery(
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

  factory HederaFileGetContentsQuery.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaFileGetContentsQuery(
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
      DefaultHederaProtoTypeUrl.protoFileGetContentsQuery;
}

/// *
///  * A response to a query for the content of a file in the
///  * Hedera File Service (HFS).
///  *
///  * This message SHALL contain the full content of the requested file, but
///  * SHALL NOT contain any metadata.
class HederaFileGetContentsResponse extends HederaProtoMessage
    with Equality, IHederaQueryRespone {
  /// *
  ///      * The standard response information for queries.&lt;br/&gt;
  ///      * This includes the values requested in the `QueryHeader`
  ///      * (cost, state proof, both, or neither).
  @override
  final proto_response_header.HederaResponseHeader? header;

  /// *
  ///      * A combination of File identifier and content bytes.
  ///      * &lt;p&gt;
  ///      * This SHALL NOT be set if the file does not exist.&lt;br/&gt;
  ///      * The network MAY generate a state proof for this field.
  final HederaFileGetContentsResponseFileContents? fileContents;

  const HederaFileGetContentsResponse({this.header, this.fileContents});

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
  List<Object?> get protoValues => [header, fileContents];

  HederaFileGetContentsResponse copyWith({
    proto_response_header.HederaResponseHeader? header,

    HederaFileGetContentsResponseFileContents? fileContents,
  }) {
    return HederaFileGetContentsResponse(
      header: header ?? this.header,
      fileContents: fileContents ?? this.fileContents,
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
      'fileContents': config.encodeMessage(fileContents),
    };
  }

  factory HederaFileGetContentsResponse.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaFileGetContentsResponse(
      header: json.valueTo<proto_response_header.HederaResponseHeader?, Object>(
        key: 'header',
        parse:
            (v) => proto_response_header.HederaResponseHeader.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      fileContents: json
          .valueTo<HederaFileGetContentsResponseFileContents?, Object>(
            key: 'fileContents',
            parse:
                (v) => HederaFileGetContentsResponseFileContents.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
    );
  }

  factory HederaFileGetContentsResponse.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaFileGetContentsResponse(
      header: decode.messageTo<proto_response_header.HederaResponseHeader?>(
        1,
        (b) => proto_response_header.HederaResponseHeader.deserialize(b),
      ),
      fileContents: decode
          .messageTo<HederaFileGetContentsResponseFileContents?>(
            2,
            (b) => HederaFileGetContentsResponseFileContents.deserialize(b),
          ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoFileGetContentsResponse;
}

class HederaFileGetContentsResponseFileContents extends HederaProtoMessage
    with Equality {
  /// *
  ///          * A file identifier.
  ///          * &lt;p&gt;
  ///          * This SHALL be the identifier of a file that exists in HFS.&lt;br/&gt;
  ///          * This value SHALL identify the file that was queried.
  final proto_basic_types.HederaFileID? fileID;

  /// *
  ///          * A byte array of file content.
  ///          * &lt;p&gt;
  ///          * This SHALL contain the full content of the requested file.&lt;br/&gt;
  ///          * This SHALL be empty if, and only if, the file content is empty.
  final List<int>? contents;

  const HederaFileGetContentsResponseFileContents({this.fileID, this.contents});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.message(1), ProtoFieldConfig.bytes(2)],
    );
  }

  @override
  List<Object?> get protoValues => [fileID, contents];

  HederaFileGetContentsResponseFileContents copyWith({
    proto_basic_types.HederaFileID? fileID,

    List<int>? contents,
  }) {
    return HederaFileGetContentsResponseFileContents(
      fileID: fileID ?? this.fileID,
      contents: contents ?? this.contents,
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
      'contents': config.encodeBinary(contents),
    };
  }

  factory HederaFileGetContentsResponseFileContents.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaFileGetContentsResponseFileContents(
      fileID: json.valueTo<proto_basic_types.HederaFileID?, Object>(
        key: 'fileID',
        parse:
            (v) => proto_basic_types.HederaFileID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      contents: config.decodeBinary<List<int>?>(
        json.valueAs('contents', normalizeKeyLookup: config.normalizeKeys),
      ),
    );
  }

  factory HederaFileGetContentsResponseFileContents.deserialize(
    List<int> bytes,
  ) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaFileGetContentsResponseFileContents(
      fileID: decode.messageTo<proto_basic_types.HederaFileID?>(
        1,
        (b) => proto_basic_types.HederaFileID.deserialize(b),
      ),
      contents: decode.getBytes<List<int>?>(2),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoFileGetContentsResponseFileContents;
}
