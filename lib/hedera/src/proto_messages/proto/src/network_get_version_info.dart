import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/query_header.dart"
    as proto_query_header;
import "package:on_chain/hedera/src/proto_messages/proto/src/response_header.dart"
    as proto_response_header;
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;
import "package:on_chain/hedera/src/proto_messages/proto/src/query.dart"
    as proto_query;

/// *
///  * # Get Version
///  * Standard query for services and API message versions.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in
///  * [RFC2119](https://www.ietf.org/rfc/rfc2119) and clarified in
///  * [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.network"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * Query the deployed versions of Hedera Services and the API definitions in
///  * semantic version format
class HederaNetworkGetVersionInfoQuery extends HederaProtoMessage
    with Equality, IHederaQuery<HederaNetworkGetVersionInfoResponse> {
  /// *
  ///      * Standard information sent with every query operation.&lt;br/&gt;
  ///      * This includes the signed payment and what kind of response is requested
  ///      * (cost, state proof, both, or neither).
  @override
  final proto_query_header.HederaQueryHeader? header;

  const HederaNetworkGetVersionInfoQuery({this.header});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.message(1)],
    );
  }

  @override
  List<Object?> get protoValues => [header];

  @override
  HederaNetworkGetVersionInfoQuery copyWith({
    proto_query_header.HederaQueryHeader? header,
  }) {
    return HederaNetworkGetVersionInfoQuery(header: header ?? this.header);
  }

  @override
  proto_query.HederaQuery toQueryRequest({
    proto_query_header.HederaQueryHeader? header,
  }) =>
      proto_query.HederaQuery(networkGetVersionInfo: copyWith(header: header));
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'header': config.encodeMessage(header)};
  }

  factory HederaNetworkGetVersionInfoQuery.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaNetworkGetVersionInfoQuery(
      header: json.valueTo<proto_query_header.HederaQueryHeader?, Object>(
        key: 'header',
        parse:
            (v) => proto_query_header.HederaQueryHeader.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaNetworkGetVersionInfoQuery.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaNetworkGetVersionInfoQuery(
      header: decode.messageTo<proto_query_header.HederaQueryHeader?>(
        1,
        (b) => proto_query_header.HederaQueryHeader.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoNetworkGetVersionInfoQuery;
}

/// *
///  * A response to a `NetworkGetVersionInfoQuery`.
///  *
///  * This SHALL return `SemanticVersion` information for both Hedera API (HAPI)
///  * and Hedera Services.
class HederaNetworkGetVersionInfoResponse extends HederaProtoMessage
    with Equality, IHederaQueryRespone {
  /// *
  ///      * The standard response information for queries.&lt;br/&gt;
  ///      * This includes the values requested in the `QueryHeader`
  ///      * (cost, state proof, both, or neither).
  @override
  final proto_response_header.HederaResponseHeader? header;

  /// *
  ///      * An API version.
  ///      * &lt;p&gt;
  ///      * This SHALL be the current Hedera API (HAPI) protobuf message version
  ///      * accepted by the network.
  final proto_basic_types.HederaSemanticVersion? hapiProtoVersion;

  /// *
  ///      * A Services version.
  ///      * &lt;p&gt;
  ///      * This SHALL be the current version of the Hedera Services software
  ///      * operating the network.
  final proto_basic_types.HederaSemanticVersion? hederaServicesVersion;

  const HederaNetworkGetVersionInfoResponse({
    this.header,
    this.hapiProtoVersion,
    this.hederaServicesVersion,
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
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    header,
    hapiProtoVersion,
    hederaServicesVersion,
  ];

  HederaNetworkGetVersionInfoResponse copyWith({
    proto_response_header.HederaResponseHeader? header,

    proto_basic_types.HederaSemanticVersion? hapiProtoVersion,

    proto_basic_types.HederaSemanticVersion? hederaServicesVersion,
  }) {
    return HederaNetworkGetVersionInfoResponse(
      header: header ?? this.header,
      hapiProtoVersion: hapiProtoVersion ?? this.hapiProtoVersion,
      hederaServicesVersion:
          hederaServicesVersion ?? this.hederaServicesVersion,
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
      'hapiProtoVersion': config.encodeMessage(hapiProtoVersion),
      'hederaServicesVersion': config.encodeMessage(hederaServicesVersion),
    };
  }

  factory HederaNetworkGetVersionInfoResponse.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaNetworkGetVersionInfoResponse(
      header: json.valueTo<proto_response_header.HederaResponseHeader?, Object>(
        key: 'header',
        parse:
            (v) => proto_response_header.HederaResponseHeader.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      hapiProtoVersion: json
          .valueTo<proto_basic_types.HederaSemanticVersion?, Object>(
            key: 'hapiProtoVersion',
            parse:
                (v) => proto_basic_types.HederaSemanticVersion.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      hederaServicesVersion: json
          .valueTo<proto_basic_types.HederaSemanticVersion?, Object>(
            key: 'hederaServicesVersion',
            parse:
                (v) => proto_basic_types.HederaSemanticVersion.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
    );
  }

  factory HederaNetworkGetVersionInfoResponse.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaNetworkGetVersionInfoResponse(
      header: decode.messageTo<proto_response_header.HederaResponseHeader?>(
        1,
        (b) => proto_response_header.HederaResponseHeader.deserialize(b),
      ),
      hapiProtoVersion: decode
          .messageTo<proto_basic_types.HederaSemanticVersion?>(
            2,
            (b) => proto_basic_types.HederaSemanticVersion.deserialize(b),
          ),
      hederaServicesVersion: decode
          .messageTo<proto_basic_types.HederaSemanticVersion?>(
            3,
            (b) => proto_basic_types.HederaSemanticVersion.deserialize(b),
          ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoNetworkGetVersionInfoResponse;
}
