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
///  * # Crypto Get Account Balance
///  * Query request to obtain balance information for a single account.
///  *
///  * This query SHOULD NOT be used by client software, queries to a
///  * Mirror Node provide more information at much lower cost.
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
///  * Query to read the HBAR balance of an account or contract.
///  *
///  * This query SHALL return _only_ the HBAR balance for an account
///  * or smart contract. Early releases of the network would return all
///  * fungible/common token balances, but HIP-367 made it infeasible to
///  * return all such balances. This query SHALL NOT return any information
///  * beyond the current HBAR balance.
class HederaCryptoGetAccountBalanceQuery extends HederaProtoMessage
    with Equality, IHederaQuery<HederaCryptoGetAccountBalanceResponse> {
  /// *
  ///      * Standard information sent with every query operation.&lt;br/&gt;
  ///      * This includes the signed payment and what kind of response is requested
  ///      * (cost, state proof, both, or neither).
  @override
  final proto_query_header.HederaQueryHeader? header;

  /// *
  ///          * An account identifier.&lt;br/&gt;
  ///          * This identifies an account for which the balance is requested.
  ///          * &lt;p&gt;
  ///          * Exactly one identifier MUST be provided.
  final proto_basic_types.HederaAccountID? accountID;

  /// *
  ///          * A smart contract identifier.&lt;br/&gt;
  ///          * This identifies a smart contract for which the balance is requested.
  ///          * &lt;p&gt;
  ///          * Exactly one identifier MUST be provided.
  final proto_basic_types.HederaContractID? contractID;

  const HederaCryptoGetAccountBalanceQuery({
    this.header,
    this.accountID,
    this.contractID,
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
  List<Object?> get protoValues => [header, accountID, contractID];

  @override
  HederaCryptoGetAccountBalanceQuery copyWith({
    proto_query_header.HederaQueryHeader? header,

    proto_basic_types.HederaAccountID? accountID,

    proto_basic_types.HederaContractID? contractID,
  }) {
    return HederaCryptoGetAccountBalanceQuery(
      header: header ?? this.header,
      accountID: accountID ?? this.accountID,
      contractID: contractID ?? this.contractID,
    );
  }

  @override
  proto_query.HederaQuery toQueryRequest({
    proto_query_header.HederaQueryHeader? header,
  }) => proto_query.HederaQuery(
    cryptogetAccountBalance: copyWith(header: header),
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
      'contractID': config.encodeMessage(contractID),
    };
  }

  factory HederaCryptoGetAccountBalanceQuery.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaCryptoGetAccountBalanceQuery(
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
      contractID: json.valueTo<proto_basic_types.HederaContractID?, Object>(
        key: 'contractID',
        parse:
            (v) => proto_basic_types.HederaContractID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaCryptoGetAccountBalanceQuery.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaCryptoGetAccountBalanceQuery(
      header: decode.messageTo<proto_query_header.HederaQueryHeader?>(
        1,
        (b) => proto_query_header.HederaQueryHeader.deserialize(b),
      ),
      accountID: decode.messageTo<proto_basic_types.HederaAccountID?>(
        2,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
      contractID: decode.messageTo<proto_basic_types.HederaContractID?>(
        3,
        (b) => proto_basic_types.HederaContractID.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoCryptoGetAccountBalanceQuery;
}

/// *
///  * Response to a CryptoGetAccountBalanceQuery.&lt;br/&gt;
///  *
///  * This response SHALL contain only the information needed to
///  * identify the query request and the actual HBAR balance of the
///  * identified account or contract.
class HederaCryptoGetAccountBalanceResponse extends HederaProtoMessage
    with Equality, IHederaQueryRespone {
  /// *
  ///      * The standard response information for queries.&lt;br/&gt;
  ///      * This includes the values requested in the `QueryHeader`
  ///      * (cost, state proof, both, or neither).
  @override
  final proto_response_header.HederaResponseHeader? header;

  /// *
  ///      * An account identifier.&lt;br/&gt;
  ///      * This is the account ID queried. &lt;br/&gt;
  ///      * The inclusion of the account queried is useful with state proofs,
  ///      * when needed to prove an account balance to a third party.
  final proto_basic_types.HederaAccountID? accountID;

  /// *
  ///      * A current account balance.&lt;br/&gt;
  ///      * This is the current HBAR balance denominated in tinybar
  ///      * (10&lt;sup&gt;-8&lt;/sup&gt; HBAR).
  final BigInt? balance;

  /// *
  ///      * This field became infeasible to support after HIP-367 removed limits on
  ///      * the number of associated tokens.&lt;br/&gt;
  ///      * A list of token balances for all tokens associated to the account.
  ///      * &lt;p&gt;
  ///      * This field was deprecated by
  ///      * &lt;a href="https://hips.hedera.com/hip/hip-367"&gt;HIP-367&lt;/a&gt;, which
  ///      * allowed an account to be associated to an unlimited number of tokens.
  ///      * This scale makes it more efficient for users to consult mirror nodes
  ///      * to review their token balances.
  final List<proto_basic_types.HederaTokenBalance> tokenBalances;

  const HederaCryptoGetAccountBalanceResponse({
    this.header,
    this.accountID,
    this.balance,
    this.tokenBalances = const [],
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
        ProtoFieldConfig.uint64(3),
        ProtoFieldConfig.repeated(
          fieldNumber: 4,
          elementType: ProtoFieldType.message,
          options: [ProtoOptionBool(name: "deprecated", value: true)],
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [header, accountID, balance, tokenBalances];

  HederaCryptoGetAccountBalanceResponse copyWith({
    proto_response_header.HederaResponseHeader? header,

    proto_basic_types.HederaAccountID? accountID,

    BigInt? balance,

    List<proto_basic_types.HederaTokenBalance>? tokenBalances,
  }) {
    return HederaCryptoGetAccountBalanceResponse(
      header: header ?? this.header,
      accountID: accountID ?? this.accountID,
      balance: balance ?? this.balance,
      tokenBalances: tokenBalances ?? this.tokenBalances,
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
      'accountID': config.encodeMessage(accountID),
      'balance': config.encodeBigint(balance),
      'tokenBalances':
          tokenBalances.map((e) => config.encodeMessage(e)).toList(),
    };
  }

  factory HederaCryptoGetAccountBalanceResponse.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaCryptoGetAccountBalanceResponse(
      header: json.valueTo<proto_response_header.HederaResponseHeader?, Object>(
        key: 'header',
        parse:
            (v) => proto_response_header.HederaResponseHeader.fromJson(
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
      balance: json.valueAsBigInt<BigInt?>(
        'balance',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      tokenBalances:
          (json.valueEnsureAsList<dynamic>(
                'tokenBalances',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<
                  proto_basic_types.HederaTokenBalance,
                  Object
                >(
                  value: e,
                  parse:
                      (v) => proto_basic_types.HederaTokenBalance.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory HederaCryptoGetAccountBalanceResponse.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaCryptoGetAccountBalanceResponse(
      header: decode.messageTo<proto_response_header.HederaResponseHeader?>(
        1,
        (b) => proto_response_header.HederaResponseHeader.deserialize(b),
      ),
      accountID: decode.messageTo<proto_basic_types.HederaAccountID?>(
        2,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
      balance: decode.getBigInt<BigInt?>(3),
      tokenBalances:
          decode
              .getListOfBytes(4)
              .map((b) => proto_basic_types.HederaTokenBalance.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoCryptoGetAccountBalanceResponse;
}
