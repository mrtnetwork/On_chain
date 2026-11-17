import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/query_header.dart"
    as proto_query_header;
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;
import "package:on_chain/hedera/src/proto_messages/proto/src/timestamp.dart"
    as proto_timestamp;
import "package:on_chain/hedera/src/proto_messages/proto/src/response_header.dart"
    as proto_response_header;
import "package:on_chain/hedera/src/proto_messages/proto/src/query.dart"
    as proto_query;

/// *
///  * # Get NFT Info Query
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
///  * Applicable only to tokens of type NON_FUNGIBLE_UNIQUE. Gets info on a NFT for a given TokenID (of
///  * type NON_FUNGIBLE_UNIQUE) and serial number
class HederaTokenGetNftInfoQuery extends HederaProtoMessage
    with Equality, IHederaQuery<HederaTokenGetNftInfoResponse> {
  /// *
  ///      * Standard information sent with every query operation.&lt;br/&gt;
  ///      * This includes the signed payment and what kind of response is requested
  ///      * (cost, state proof, both, or neither).
  @override
  final proto_query_header.HederaQueryHeader? header;

  /// *
  ///      * A non-fungible/unique token (NFT) identifier.
  ///      * &lt;p&gt;
  ///      * This SHALL identify the NFT to query.&lt;br/&gt;
  ///      * The identified NFT MUST exist, and MUST NOT be deleted.
  final proto_basic_types.HederaNftID? nftID;

  const HederaTokenGetNftInfoQuery({this.header, this.nftID});

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
  List<Object?> get protoValues => [header, nftID];

  @override
  HederaTokenGetNftInfoQuery copyWith({
    proto_query_header.HederaQueryHeader? header,

    proto_basic_types.HederaNftID? nftID,
  }) {
    return HederaTokenGetNftInfoQuery(
      header: header ?? this.header,
      nftID: nftID ?? this.nftID,
    );
  }

  @override
  proto_query.HederaQuery toQueryRequest({
    proto_query_header.HederaQueryHeader? header,
  }) => proto_query.HederaQuery(tokenGetNftInfo: copyWith(header: header));
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'header': config.encodeMessage(header),
      'nftID': config.encodeMessage(nftID),
    };
  }

  factory HederaTokenGetNftInfoQuery.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaTokenGetNftInfoQuery(
      header: json.valueTo<proto_query_header.HederaQueryHeader?, Object>(
        key: 'header',
        parse:
            (v) => proto_query_header.HederaQueryHeader.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      nftID: json.valueTo<proto_basic_types.HederaNftID?, Object>(
        key: 'nftID',
        parse:
            (v) => proto_basic_types.HederaNftID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaTokenGetNftInfoQuery.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTokenGetNftInfoQuery(
      header: decode.messageTo<proto_query_header.HederaQueryHeader?>(
        1,
        (b) => proto_query_header.HederaQueryHeader.deserialize(b),
      ),
      nftID: decode.messageTo<proto_basic_types.HederaNftID?>(
        2,
        (b) => proto_basic_types.HederaNftID.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoTokenGetNftInfoQuery;
}

/// *
///  * Information for one non-fungible/unique token (NFT).
///  *
class HederaTokenNftInfo extends HederaProtoMessage with Equality {
  /// *
  ///      * A non-fungible/unique token (NFT) identifier.
  ///      * &lt;p&gt;
  ///      * This SHALL match the NFT requested.&lt;br/&gt;
  final proto_basic_types.HederaNftID? nftID;

  /// *
  ///      * The current owner of the NFT
  final proto_basic_types.HederaAccountID? accountID;

  /// *
  ///      * The effective consensus timestamp at which the NFT was minted
  final proto_timestamp.HederaTimestamp? creationTime;

  /// *
  ///      * Represents the unique metadata of the NFT
  final List<int>? metadata;

  /// *
  ///      * The ledger ID of the network that generated this response.
  ///      * &lt;p&gt;
  ///      * This value SHALL identify the distributed ledger that responded to
  ///      * this query.
  final List<int>? ledgerId;

  /// *
  ///      * If an allowance is granted for the NFT, its corresponding spender account
  final proto_basic_types.HederaAccountID? spenderId;

  const HederaTokenNftInfo({
    this.nftID,
    this.accountID,
    this.creationTime,
    this.metadata,
    this.ledgerId,
    this.spenderId,
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
        ProtoFieldConfig.bytes(5),
        ProtoFieldConfig.message(6),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    nftID,
    accountID,
    creationTime,
    metadata,
    ledgerId,
    spenderId,
  ];

  HederaTokenNftInfo copyWith({
    proto_basic_types.HederaNftID? nftID,

    proto_basic_types.HederaAccountID? accountID,

    proto_timestamp.HederaTimestamp? creationTime,

    List<int>? metadata,

    List<int>? ledgerId,

    proto_basic_types.HederaAccountID? spenderId,
  }) {
    return HederaTokenNftInfo(
      nftID: nftID ?? this.nftID,
      accountID: accountID ?? this.accountID,
      creationTime: creationTime ?? this.creationTime,
      metadata: metadata ?? this.metadata,
      ledgerId: ledgerId ?? this.ledgerId,
      spenderId: spenderId ?? this.spenderId,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'nftID': config.encodeMessage(nftID),
      'accountID': config.encodeMessage(accountID),
      'creationTime': config.encodeMessage(creationTime),
      'metadata': config.encodeBinary(metadata),
      'ledger_id': config.encodeBinary(ledgerId),
      'spender_id': config.encodeMessage(spenderId),
    };
  }

  factory HederaTokenNftInfo.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaTokenNftInfo(
      nftID: json.valueTo<proto_basic_types.HederaNftID?, Object>(
        key: 'nftID',
        parse:
            (v) => proto_basic_types.HederaNftID.fromJson(
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
      creationTime: json.valueTo<proto_timestamp.HederaTimestamp?, Object>(
        key: 'creationTime',
        parse:
            (v) => proto_timestamp.HederaTimestamp.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      metadata: config.decodeBinary<List<int>?>(
        json.valueAs('metadata', normalizeKeyLookup: config.normalizeKeys),
      ),
      ledgerId: config.decodeBinary<List<int>?>(
        json.valueAs('ledger_id', normalizeKeyLookup: config.normalizeKeys),
      ),
      spenderId: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'spender_id',
        parse:
            (v) => proto_basic_types.HederaAccountID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaTokenNftInfo.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTokenNftInfo(
      nftID: decode.messageTo<proto_basic_types.HederaNftID?>(
        1,
        (b) => proto_basic_types.HederaNftID.deserialize(b),
      ),
      accountID: decode.messageTo<proto_basic_types.HederaAccountID?>(
        2,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
      creationTime: decode.messageTo<proto_timestamp.HederaTimestamp?>(
        3,
        (b) => proto_timestamp.HederaTimestamp.deserialize(b),
      ),
      metadata: decode.getBytes<List<int>?>(4),
      ledgerId: decode.getBytes<List<int>?>(5),
      spenderId: decode.messageTo<proto_basic_types.HederaAccountID?>(
        6,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoTokenNftInfo;
}

/// *
///  * UNDOCUMENTED
class HederaTokenGetNftInfoResponse extends HederaProtoMessage
    with Equality, IHederaQueryRespone {
  /// *
  ///      * The standard response information for queries.&lt;br/&gt;
  ///      * This includes the values requested in the `QueryHeader`
  ///      * (cost, state proof, both, or neither).
  @override
  final proto_response_header.HederaResponseHeader? header;

  /// *
  ///      * The information about this NFT
  final HederaTokenNftInfo? nft;

  const HederaTokenGetNftInfoResponse({this.header, this.nft});

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
  List<Object?> get protoValues => [header, nft];

  HederaTokenGetNftInfoResponse copyWith({
    proto_response_header.HederaResponseHeader? header,

    HederaTokenNftInfo? nft,
  }) {
    return HederaTokenGetNftInfoResponse(
      header: header ?? this.header,
      nft: nft ?? this.nft,
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
      'nft': config.encodeMessage(nft),
    };
  }

  factory HederaTokenGetNftInfoResponse.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaTokenGetNftInfoResponse(
      header: json.valueTo<proto_response_header.HederaResponseHeader?, Object>(
        key: 'header',
        parse:
            (v) => proto_response_header.HederaResponseHeader.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      nft: json.valueTo<HederaTokenNftInfo?, Object>(
        key: 'nft',
        parse:
            (v) => HederaTokenNftInfo.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaTokenGetNftInfoResponse.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTokenGetNftInfoResponse(
      header: decode.messageTo<proto_response_header.HederaResponseHeader?>(
        1,
        (b) => proto_response_header.HederaResponseHeader.deserialize(b),
      ),
      nft: decode.messageTo<HederaTokenNftInfo?>(
        2,
        (b) => HederaTokenNftInfo.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoTokenGetNftInfoResponse;
}
