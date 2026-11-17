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
///  * # Get Stakers
///  * Query all of the accounts proxy staking _to_ a specified account.
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
///  * Get all the accounts that are proxy staking to this account. For each of
///  * them, give the amount currently staked. This was never implemented.
class HederaCryptoGetStakersQuery extends HederaProtoMessage
    with Equality, IHederaQuery<HederaCryptoGetStakersResponse> {
  /// *
  ///      * Standard information sent with every query operation.&lt;br/&gt;
  ///      * This includes the signed payment and what kind of response is requested
  ///      * (cost, state proof, both, or neither).
  @override
  final proto_query_header.HederaQueryHeader? header;

  /// *
  ///      * The Account ID for which the records should be retrieved
  final proto_basic_types.HederaAccountID? accountID;

  const HederaCryptoGetStakersQuery({this.header, this.accountID});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: [ProtoOptionBool(name: "deprecated", value: true)],
      fields: [ProtoFieldConfig.message(1), ProtoFieldConfig.message(2)],
    );
  }

  @override
  List<Object?> get protoValues => [header, accountID];

  @override
  HederaCryptoGetStakersQuery copyWith({
    proto_query_header.HederaQueryHeader? header,

    proto_basic_types.HederaAccountID? accountID,
  }) {
    return HederaCryptoGetStakersQuery(
      header: header ?? this.header,
      accountID: accountID ?? this.accountID,
    );
  }

  @override
  proto_query.HederaQuery toQueryRequest({
    proto_query_header.HederaQueryHeader? header,
  }) =>
      proto_query.HederaQuery(cryptoGetProxyStakers: copyWith(header: header));
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'header': config.encodeMessage(header),
      'accountID': config.encodeMessage(accountID),
    };
  }

  factory HederaCryptoGetStakersQuery.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaCryptoGetStakersQuery(
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
    );
  }

  factory HederaCryptoGetStakersQuery.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaCryptoGetStakersQuery(
      header: decode.messageTo<proto_query_header.HederaQueryHeader?>(
        1,
        (b) => proto_query_header.HederaQueryHeader.deserialize(b),
      ),
      accountID: decode.messageTo<proto_basic_types.HederaAccountID?>(
        2,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoCryptoGetStakersQuery;
}

/// *
///  * information about a single account that is proxy staking
class HederaProxyStaker extends HederaProtoMessage with Equality {
  /// *
  ///      * The Account ID that is proxy staking
  final proto_basic_types.HederaAccountID? accountID;

  /// *
  ///      * The number of hbars that are currently proxy staked
  final BigInt? amount;

  const HederaProxyStaker({this.accountID, this.amount});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: [ProtoOptionBool(name: "deprecated", value: true)],
      fields: [ProtoFieldConfig.message(1), ProtoFieldConfig.int64(2)],
    );
  }

  @override
  List<Object?> get protoValues => [accountID, amount];

  HederaProxyStaker copyWith({
    proto_basic_types.HederaAccountID? accountID,

    BigInt? amount,
  }) {
    return HederaProxyStaker(
      accountID: accountID ?? this.accountID,
      amount: amount ?? this.amount,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'accountID': config.encodeMessage(accountID),
      'amount': config.encodeBigint(amount),
    };
  }

  factory HederaProxyStaker.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaProxyStaker(
      accountID: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'accountID',
        parse:
            (v) => proto_basic_types.HederaAccountID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      amount: json.valueAsBigInt<BigInt?>(
        'amount',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaProxyStaker.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaProxyStaker(
      accountID: decode.messageTo<proto_basic_types.HederaAccountID?>(
        1,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
      amount: decode.getBigInt<BigInt?>(2),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoProxyStaker;
}

/// *
///  * All of the accounts proxy staking to a given account, and the amounts proxy
///  * staked
class HederaAllProxyStakers extends HederaProtoMessage with Equality {
  /// *
  ///      * The Account ID that is being proxy staked to
  final proto_basic_types.HederaAccountID? accountID;

  /// *
  ///      * Each of the proxy staking accounts, and the amount they are proxy staking
  final List<HederaProxyStaker> proxyStaker;

  const HederaAllProxyStakers({this.accountID, this.proxyStaker = const []});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: [ProtoOptionBool(name: "deprecated", value: true)],
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
  List<Object?> get protoValues => [accountID, proxyStaker];

  HederaAllProxyStakers copyWith({
    proto_basic_types.HederaAccountID? accountID,

    List<HederaProxyStaker>? proxyStaker,
  }) {
    return HederaAllProxyStakers(
      accountID: accountID ?? this.accountID,
      proxyStaker: proxyStaker ?? this.proxyStaker,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'accountID': config.encodeMessage(accountID),
      'proxyStaker': proxyStaker.map((e) => config.encodeMessage(e)).toList(),
    };
  }

  factory HederaAllProxyStakers.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaAllProxyStakers(
      accountID: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'accountID',
        parse:
            (v) => proto_basic_types.HederaAccountID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      proxyStaker:
          (json.valueEnsureAsList<dynamic>(
                'proxyStaker',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<HederaProxyStaker, Object>(
                  value: e,
                  parse:
                      (v) => HederaProxyStaker.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory HederaAllProxyStakers.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaAllProxyStakers(
      accountID: decode.messageTo<proto_basic_types.HederaAccountID?>(
        1,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
      proxyStaker:
          decode
              .getListOfBytes(2)
              .map((b) => HederaProxyStaker.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoAllProxyStakers;
}

/// *
///  * Response when the client sends the node CryptoGetStakersQuery
class HederaCryptoGetStakersResponse extends HederaProtoMessage
    with Equality, IHederaQueryRespone {
  /// *
  ///      * The standard response information for queries.&lt;br/&gt;
  ///      * This includes the values requested in the `QueryHeader`
  ///      * (cost, state proof, both, or neither).
  @override
  final proto_response_header.HederaResponseHeader? header;

  /// *
  ///      * List of accounts proxy staking to this account, and the amount each is
  ///      * currently proxy staking
  final HederaAllProxyStakers? stakers;

  const HederaCryptoGetStakersResponse({this.header, this.stakers});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: [ProtoOptionBool(name: "deprecated", value: true)],
      fields: [ProtoFieldConfig.message(1), ProtoFieldConfig.message(3)],
    );
  }

  @override
  List<Object?> get protoValues => [header, stakers];

  HederaCryptoGetStakersResponse copyWith({
    proto_response_header.HederaResponseHeader? header,

    HederaAllProxyStakers? stakers,
  }) {
    return HederaCryptoGetStakersResponse(
      header: header ?? this.header,
      stakers: stakers ?? this.stakers,
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
      'stakers': config.encodeMessage(stakers),
    };
  }

  factory HederaCryptoGetStakersResponse.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaCryptoGetStakersResponse(
      header: json.valueTo<proto_response_header.HederaResponseHeader?, Object>(
        key: 'header',
        parse:
            (v) => proto_response_header.HederaResponseHeader.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      stakers: json.valueTo<HederaAllProxyStakers?, Object>(
        key: 'stakers',
        parse:
            (v) => HederaAllProxyStakers.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaCryptoGetStakersResponse.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaCryptoGetStakersResponse(
      header: decode.messageTo<proto_response_header.HederaResponseHeader?>(
        1,
        (b) => proto_response_header.HederaResponseHeader.deserialize(b),
      ),
      stakers: decode.messageTo<HederaAllProxyStakers?>(
        3,
        (b) => HederaAllProxyStakers.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoCryptoGetStakersResponse;
}
