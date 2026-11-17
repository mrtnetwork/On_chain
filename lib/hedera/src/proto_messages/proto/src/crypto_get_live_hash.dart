import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/query_header.dart"
    as proto_query_header;
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;
import "package:on_chain/hedera/src/proto_messages/proto/src/response_header.dart"
    as proto_response_header;
import "package:on_chain/hedera/src/proto_messages/proto/src/crypto_add_live_hash.dart"
    as proto_crypto_add_live_hash;
import "package:on_chain/hedera/src/proto_messages/proto/src/query.dart"
    as proto_query;

/// *
///  * # Get Live Hash
///  * Standard query to inspect associations between content and accounts
///  * via SHA-384 hashes.
///  *
///  * &gt; Important
///  * &gt;&gt; This query is obsolete and not supported.&lt;br/&gt;
///  * &gt;&gt; Any query of this type that is submitted SHALL fail with a `PRE_CHECK`
///  * &gt;&gt; result of `NOT_SUPPORTED`.
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
///  * Request detail for a specific live hash associated to a specific account.
class HederaCryptoGetLiveHashQuery extends HederaProtoMessage
    with Equality, IHederaQuery<HederaCryptoGetLiveHashResponse> {
  /// *
  ///      * Standard information sent with every query operation.&lt;br/&gt;
  ///      * This includes the signed payment and what kind of response is requested
  ///      * (cost, state proof, both, or neither).
  @override
  final proto_query_header.HederaQueryHeader? header;

  /// *
  ///      * An account ID.&lt;br/&gt;
  ///      * The network SHALL return live hash information for this account,
  ///          * if successful.
  final proto_basic_types.HederaAccountID? accountID;

  /// *
  ///      * The specific SHA-384 live hash to inspect
  final List<int>? hash;

  const HederaCryptoGetLiveHashQuery({this.header, this.accountID, this.hash});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.message(2),
        ProtoFieldConfig.bytes(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [header, accountID, hash];

  @override
  HederaCryptoGetLiveHashQuery copyWith({
    proto_query_header.HederaQueryHeader? header,

    proto_basic_types.HederaAccountID? accountID,

    List<int>? hash,
  }) {
    return HederaCryptoGetLiveHashQuery(
      header: header ?? this.header,
      accountID: accountID ?? this.accountID,
      hash: hash ?? this.hash,
    );
  }

  @override
  proto_query.HederaQuery toQueryRequest({
    proto_query_header.HederaQueryHeader? header,
  }) => proto_query.HederaQuery(cryptoGetLiveHash: copyWith(header: header));
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'header': config.encodeMessage(header),
      'accountID': config.encodeMessage(accountID),
      'hash': config.encodeBinary(hash),
    };
  }

  factory HederaCryptoGetLiveHashQuery.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaCryptoGetLiveHashQuery(
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
      hash: config.decodeBinary<List<int>?>(
        json.valueAs('hash', normalizeKeyLookup: config.normalizeKeys),
      ),
    );
  }

  factory HederaCryptoGetLiveHashQuery.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaCryptoGetLiveHashQuery(
      header: decode.messageTo<proto_query_header.HederaQueryHeader?>(
        1,
        (b) => proto_query_header.HederaQueryHeader.deserialize(b),
      ),
      accountID: decode.messageTo<proto_basic_types.HederaAccountID?>(
        2,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
      hash: decode.getBytes<List<int>?>(3),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoCryptoGetLiveHashQuery;
}

/// *
///  * Return the full live hash associated to an account, if it is present.
///  *
///  * &gt; Note that to generate a state proof of the _absence_ of a live hash from
///  * &gt; an account a transaction MUST retrieve a state proof of the `Account`
///  * &gt; with its list of live hashes.
class HederaCryptoGetLiveHashResponse extends HederaProtoMessage
    with Equality, IHederaQueryRespone {
  /// *
  ///      * The standard response information for queries.&lt;br/&gt;
  ///      * This includes the values requested in the `QueryHeader`
  ///      * (cost, state proof, both, or neither).
  @override
  final proto_response_header.HederaResponseHeader? header;

  /// *
  ///      * The requested live hash, if found.
  final proto_crypto_add_live_hash.HederaLiveHash? liveHash;

  const HederaCryptoGetLiveHashResponse({this.header, this.liveHash});

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
  List<Object?> get protoValues => [header, liveHash];

  HederaCryptoGetLiveHashResponse copyWith({
    proto_response_header.HederaResponseHeader? header,

    proto_crypto_add_live_hash.HederaLiveHash? liveHash,
  }) {
    return HederaCryptoGetLiveHashResponse(
      header: header ?? this.header,
      liveHash: liveHash ?? this.liveHash,
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
      'liveHash': config.encodeMessage(liveHash),
    };
  }

  factory HederaCryptoGetLiveHashResponse.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaCryptoGetLiveHashResponse(
      header: json.valueTo<proto_response_header.HederaResponseHeader?, Object>(
        key: 'header',
        parse:
            (v) => proto_response_header.HederaResponseHeader.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      liveHash: json
          .valueTo<proto_crypto_add_live_hash.HederaLiveHash?, Object>(
            key: 'liveHash',
            parse:
                (v) => proto_crypto_add_live_hash.HederaLiveHash.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
    );
  }

  factory HederaCryptoGetLiveHashResponse.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaCryptoGetLiveHashResponse(
      header: decode.messageTo<proto_response_header.HederaResponseHeader?>(
        1,
        (b) => proto_response_header.HederaResponseHeader.deserialize(b),
      ),
      liveHash: decode.messageTo<proto_crypto_add_live_hash.HederaLiveHash?>(
        2,
        (b) => proto_crypto_add_live_hash.HederaLiveHash.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoCryptoGetLiveHashResponse;
}
