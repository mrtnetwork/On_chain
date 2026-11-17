import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/query_header.dart"
    as proto_query_header;
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;
import "package:on_chain/hedera/src/proto_messages/proto/src/response_header.dart"
    as proto_response_header;
import "package:on_chain/hedera/src/proto_messages/proto/src/token_get_nft_info.dart"
    as proto_token_get_nft_info;
import "package:on_chain/hedera/src/proto_messages/proto/src/query.dart"
    as proto_query;

/// *
///  * # Token Get NFT Infos
///  * Deprecated and permanently disabled
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
///  * Deleted and unsupported.
///  *
///  * This query is not implemented and any query of this type submitted
///  * SHALL return a `NOT_SUPPORTED` response code.
class HederaTokenGetNftInfosQuery extends HederaProtoMessage
    with Equality, IHederaQuery<HederaTokenGetNftInfosResponse> {
  /// *
  ///      * Standard information sent with every query operation.&lt;br/&gt;
  ///      * This includes the signed payment and what kind of response is requested
  ///      * (cost, state proof, both, or neither).
  @override
  final proto_query_header.HederaQueryHeader? header;

  /// *
  ///      * A token identifier.
  ///      * &lt;p&gt;
  ///      * This SHALL identify the token to query.&lt;br/&gt;
  ///      * The identified token MUST exist, MUST NOT be deleted, and MUST be
  ///      * a non-fungible/unique type.
  final proto_basic_types.HederaTokenID? tokenID;

  /// *
  ///      * Specifies the start index (inclusive) of the range of NFTs to query for.
  ///      * Value must be in the range [0; mintedNFTs-1]
  final BigInt? start;

  /// *
  ///      * Specifies the end index (exclusive) of the range of NFTs to query for.
  ///      * Value must be in the range (start; mintedNFTs]
  final BigInt? end;

  const HederaTokenGetNftInfosQuery({
    this.header,
    this.tokenID,
    this.start,
    this.end,
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
        ProtoFieldConfig.int64(3),
        ProtoFieldConfig.int64(4),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [header, tokenID, start, end];

  @override
  HederaTokenGetNftInfosQuery copyWith({
    proto_query_header.HederaQueryHeader? header,

    proto_basic_types.HederaTokenID? tokenID,

    BigInt? start,

    BigInt? end,
  }) {
    return HederaTokenGetNftInfosQuery(
      header: header ?? this.header,
      tokenID: tokenID ?? this.tokenID,
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }

  @override
  proto_query.HederaQuery toQueryRequest({
    proto_query_header.HederaQueryHeader? header,
  }) => proto_query.HederaQuery(tokenGetNftInfos: copyWith(header: header));
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'header': config.encodeMessage(header),
      'tokenID': config.encodeMessage(tokenID),
      'start': config.encodeBigint(start),
      'end': config.encodeBigint(end),
    };
  }

  factory HederaTokenGetNftInfosQuery.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaTokenGetNftInfosQuery(
      header: json.valueTo<proto_query_header.HederaQueryHeader?, Object>(
        key: 'header',
        parse:
            (v) => proto_query_header.HederaQueryHeader.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      tokenID: json.valueTo<proto_basic_types.HederaTokenID?, Object>(
        key: 'tokenID',
        parse:
            (v) => proto_basic_types.HederaTokenID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      start: json.valueAsBigInt<BigInt?>(
        'start',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      end: json.valueAsBigInt<BigInt?>(
        'end',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaTokenGetNftInfosQuery.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTokenGetNftInfosQuery(
      header: decode.messageTo<proto_query_header.HederaQueryHeader?>(
        1,
        (b) => proto_query_header.HederaQueryHeader.deserialize(b),
      ),
      tokenID: decode.messageTo<proto_basic_types.HederaTokenID?>(
        2,
        (b) => proto_basic_types.HederaTokenID.deserialize(b),
      ),
      start: decode.getBigInt<BigInt?>(3),
      end: decode.getBigInt<BigInt?>(4),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoTokenGetNftInfosQuery;
}

/// *
///  * Deleted and unsupported.
class HederaTokenGetNftInfosResponse extends HederaProtoMessage
    with Equality, IHederaQueryRespone {
  /// *
  ///      * The standard response information for queries.&lt;br/&gt;
  ///      * This includes the values requested in the `QueryHeader`
  ///      * (cost, state proof, both, or neither).
  @override
  final proto_response_header.HederaResponseHeader? header;

  /// *
  ///      * A token identifier.
  ///      * &lt;p&gt;
  ///      * This SHALL identify the token type to query.&lt;br/&gt;
  ///      * The identified token MUST exist, and MUST NOT be deleted.
  ///      * The identified token MUST be a non-fungible/unique type.
  final proto_basic_types.HederaTokenID? tokenID;

  /// *
  ///      * A list of messages, each of which describes one NFT.
  final List<proto_token_get_nft_info.HederaTokenNftInfo> nfts;

  const HederaTokenGetNftInfosResponse({
    this.header,
    this.tokenID,
    this.nfts = const [],
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
        ProtoFieldConfig.repeated(
          fieldNumber: 3,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [header, tokenID, nfts];

  HederaTokenGetNftInfosResponse copyWith({
    proto_response_header.HederaResponseHeader? header,

    proto_basic_types.HederaTokenID? tokenID,

    List<proto_token_get_nft_info.HederaTokenNftInfo>? nfts,
  }) {
    return HederaTokenGetNftInfosResponse(
      header: header ?? this.header,
      tokenID: tokenID ?? this.tokenID,
      nfts: nfts ?? this.nfts,
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
      'tokenID': config.encodeMessage(tokenID),
      'nfts': nfts.map((e) => config.encodeMessage(e)).toList(),
    };
  }

  factory HederaTokenGetNftInfosResponse.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaTokenGetNftInfosResponse(
      header: json.valueTo<proto_response_header.HederaResponseHeader?, Object>(
        key: 'header',
        parse:
            (v) => proto_response_header.HederaResponseHeader.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      tokenID: json.valueTo<proto_basic_types.HederaTokenID?, Object>(
        key: 'tokenID',
        parse:
            (v) => proto_basic_types.HederaTokenID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      nfts:
          (json.valueEnsureAsList<dynamic>(
                'nfts',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<
                  proto_token_get_nft_info.HederaTokenNftInfo,
                  Object
                >(
                  value: e,
                  parse:
                      (v) =>
                          proto_token_get_nft_info.HederaTokenNftInfo.fromJson(
                            JsonParser.valueAs(v),
                            config: config,
                          ),
                ),
              )
              .toList(),
    );
  }

  factory HederaTokenGetNftInfosResponse.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTokenGetNftInfosResponse(
      header: decode.messageTo<proto_response_header.HederaResponseHeader?>(
        1,
        (b) => proto_response_header.HederaResponseHeader.deserialize(b),
      ),
      tokenID: decode.messageTo<proto_basic_types.HederaTokenID?>(
        2,
        (b) => proto_basic_types.HederaTokenID.deserialize(b),
      ),
      nfts:
          decode
              .getListOfBytes(3)
              .map(
                (b) =>
                    proto_token_get_nft_info.HederaTokenNftInfo.deserialize(b),
              )
              .toList(),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoTokenGetNftInfosResponse;
}
