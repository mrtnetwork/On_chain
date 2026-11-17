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
///  * # Get Account NFT Infos
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
class HederaTokenGetAccountNftInfosQuery extends HederaProtoMessage
    with Equality, IHederaQuery<HederaTokenGetAccountNftInfosResponse> {
  /// *
  ///      * Standard information sent with every query operation.&lt;br/&gt;
  ///      * This includes the signed payment and what kind of response is requested
  ///      * (cost, state proof, both, or neither).
  @override
  final proto_query_header.HederaQueryHeader? header;

  /// *
  ///      * The Account for which information is requested
  final proto_basic_types.HederaAccountID? accountID;

  /// *
  ///      * Specifies the start index (inclusive) of the range of NFTs to query for.
  ///      * Value must be in the range [0; ownedNFTs-1]
  final BigInt? start;

  /// *
  ///      * Specifies the end index (exclusive) of the range of NFTs to query for.
  ///      * Value must be in the range (start; ownedNFTs]
  final BigInt? end;

  const HederaTokenGetAccountNftInfosQuery({
    this.header,
    this.accountID,
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
  List<Object?> get protoValues => [header, accountID, start, end];

  @override
  HederaTokenGetAccountNftInfosQuery copyWith({
    proto_query_header.HederaQueryHeader? header,

    proto_basic_types.HederaAccountID? accountID,

    BigInt? start,

    BigInt? end,
  }) {
    return HederaTokenGetAccountNftInfosQuery(
      header: header ?? this.header,
      accountID: accountID ?? this.accountID,
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }

  @override
  proto_query.HederaQuery toQueryRequest({
    proto_query_header.HederaQueryHeader? header,
  }) => proto_query.HederaQuery(
    tokenGetAccountNftInfos: copyWith(header: header),
  );
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'header': config.encodeMessage(header),
      'accountID': config.encodeMessage(accountID),
      'start': config.encodeBigint(start),
      'end': config.encodeBigint(end),
    };
  }

  factory HederaTokenGetAccountNftInfosQuery.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaTokenGetAccountNftInfosQuery(
      header: json.valueTo<proto_query_header.HederaQueryHeader?, Object>(
        key: 'header',
        parse:
            (v) => proto_query_header.HederaQueryHeader.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      accountID: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'accountID',
        parse:
            (v) => proto_basic_types.HederaAccountID.fromJson(
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

  factory HederaTokenGetAccountNftInfosQuery.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTokenGetAccountNftInfosQuery(
      header: decode.messageTo<proto_query_header.HederaQueryHeader?>(
        1,
        (b) => proto_query_header.HederaQueryHeader.deserialize(b),
      ),
      accountID: decode.messageTo<proto_basic_types.HederaAccountID?>(
        2,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
      start: decode.getBigInt<BigInt?>(3),
      end: decode.getBigInt<BigInt?>(4),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoTokenGetAccountNftInfosQuery;
}

/// *
///  * Deleted and unsupported.
class HederaTokenGetAccountNftInfosResponse extends HederaProtoMessage
    with Equality, IHederaQueryRespone {
  /// *
  ///      * The standard response information for queries.&lt;br/&gt;
  ///      * This includes the values requested in the `QueryHeader`
  ///      * (cost, state proof, both, or neither).
  @override
  final proto_response_header.HederaResponseHeader? header;

  /// *
  ///      * List of NFTs associated to the account
  final List<proto_token_get_nft_info.HederaTokenNftInfo> nfts;

  const HederaTokenGetAccountNftInfosResponse({
    this.header,
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
        ProtoFieldConfig.repeated(
          fieldNumber: 2,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [header, nfts];

  HederaTokenGetAccountNftInfosResponse copyWith({
    proto_response_header.HederaResponseHeader? header,

    List<proto_token_get_nft_info.HederaTokenNftInfo>? nfts,
  }) {
    return HederaTokenGetAccountNftInfosResponse(
      header: header ?? this.header,
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
      'nfts': nfts.map((e) => config.encodeMessage(e)).toList(),
    };
  }

  factory HederaTokenGetAccountNftInfosResponse.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaTokenGetAccountNftInfosResponse(
      header: json.valueTo<proto_response_header.HederaResponseHeader?, Object>(
        key: 'header',
        parse:
            (v) => proto_response_header.HederaResponseHeader.fromJson(
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

  factory HederaTokenGetAccountNftInfosResponse.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTokenGetAccountNftInfosResponse(
      header: decode.messageTo<proto_response_header.HederaResponseHeader?>(
        1,
        (b) => proto_response_header.HederaResponseHeader.deserialize(b),
      ),
      nfts:
          decode
              .getListOfBytes(2)
              .map(
                (b) =>
                    proto_token_get_nft_info.HederaTokenNftInfo.deserialize(b),
              )
              .toList(),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoTokenGetAccountNftInfosResponse;
}
