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
import "package:on_chain/hedera/src/proto_messages/proto/src/duration.dart"
    as proto_duration;
import "package:on_chain/hedera/src/proto_messages/proto/src/query.dart"
    as proto_query;

/// *
///  * # Contract Get Info
///  * A standard query to obtain detailed information about a smart contract.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in
///  * [RFC2119](https://www.ietf.org/rfc/rfc2119) and clarified in
///  * [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.contract"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * Request detailed information about a smart contract.
class HederaContractGetInfoQuery extends HederaProtoMessage
    with Equality, IHederaQuery<HederaContractGetInfoResponse> {
  /// *
  ///      * Standard information sent with every query operation.&lt;br/&gt;
  ///      * This includes the signed payment and what kind of response is requested
  ///      * (cost, state proof, both, or neither).
  @override
  final proto_query_header.HederaQueryHeader? header;

  /// *
  ///      * A smart contract ID.
  ///      * &lt;p&gt;
  ///      * The network SHALL return information for this smart contract,
  ///      * if successful.
  final proto_basic_types.HederaContractID? contractID;

  const HederaContractGetInfoQuery({this.header, this.contractID});

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
  List<Object?> get protoValues => [header, contractID];

  @override
  HederaContractGetInfoQuery copyWith({
    proto_query_header.HederaQueryHeader? header,

    proto_basic_types.HederaContractID? contractID,
  }) {
    return HederaContractGetInfoQuery(
      header: header ?? this.header,
      contractID: contractID ?? this.contractID,
    );
  }

  @override
  proto_query.HederaQuery toQueryRequest({
    proto_query_header.HederaQueryHeader? header,
  }) => proto_query.HederaQuery(contractGetInfo: copyWith(header: header));
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'header': config.encodeMessage(header),
      'contractID': config.encodeMessage(contractID),
    };
  }

  factory HederaContractGetInfoQuery.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaContractGetInfoQuery(
      header: json.valueTo<proto_query_header.HederaQueryHeader?, Object>(
        key: 'header',
        parse:
            (v) => proto_query_header.HederaQueryHeader.fromJson(
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

  factory HederaContractGetInfoQuery.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaContractGetInfoQuery(
      header: decode.messageTo<proto_query_header.HederaQueryHeader?>(
        1,
        (b) => proto_query_header.HederaQueryHeader.deserialize(b),
      ),
      contractID: decode.messageTo<proto_basic_types.HederaContractID?>(
        2,
        (b) => proto_basic_types.HederaContractID.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoContractGetInfoQuery;
}

/// *
///  * Information returned in response to a "get info" query for a smart contract.
class HederaContractGetInfoResponse extends HederaProtoMessage
    with Equality, IHederaQueryRespone {
  /// *
  ///      * The standard response information for queries.&lt;br/&gt;
  ///      * This includes the values requested in the `QueryHeader`
  ///      * (cost, state proof, both, or neither).
  @override
  final proto_response_header.HederaResponseHeader? header;

  /// *
  ///      * The information, as requested, for a smart contract.
  ///      * A state proof MAY be generated for this value.
  final HederaContractGetInfoResponseContractInfo? contractInfo;

  const HederaContractGetInfoResponse({this.header, this.contractInfo});

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
  List<Object?> get protoValues => [header, contractInfo];

  HederaContractGetInfoResponse copyWith({
    proto_response_header.HederaResponseHeader? header,

    HederaContractGetInfoResponseContractInfo? contractInfo,
  }) {
    return HederaContractGetInfoResponse(
      header: header ?? this.header,
      contractInfo: contractInfo ?? this.contractInfo,
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
      'contractInfo': config.encodeMessage(contractInfo),
    };
  }

  factory HederaContractGetInfoResponse.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaContractGetInfoResponse(
      header: json.valueTo<proto_response_header.HederaResponseHeader?, Object>(
        key: 'header',
        parse:
            (v) => proto_response_header.HederaResponseHeader.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      contractInfo: json
          .valueTo<HederaContractGetInfoResponseContractInfo?, Object>(
            key: 'contractInfo',
            parse:
                (v) => HederaContractGetInfoResponseContractInfo.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
    );
  }

  factory HederaContractGetInfoResponse.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaContractGetInfoResponse(
      header: decode.messageTo<proto_response_header.HederaResponseHeader?>(
        1,
        (b) => proto_response_header.HederaResponseHeader.deserialize(b),
      ),
      contractInfo: decode
          .messageTo<HederaContractGetInfoResponseContractInfo?>(
            2,
            (b) => HederaContractGetInfoResponseContractInfo.deserialize(b),
          ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoContractGetInfoResponse;
}

class HederaContractGetInfoResponseContractInfo extends HederaProtoMessage
    with Equality {
  /// *
  ///          * The ID of the smart contract requested in the query.
  final proto_basic_types.HederaContractID? contractID;

  /// *
  ///          * The Account ID for the account entry associated with this
  ///          * smart contract.
  final proto_basic_types.HederaAccountID? accountID;

  /// *
  ///          * The "Solidity" form contract ID.&lt;br/&gt;
  ///          * This is a hexadecimal string form of the 20-byte EVM address
  ///          * of the contract.
  final String? contractAccountID;

  /// *
  ///          * The key that MUST sign any transaction to update or modify this
  ///          * smart contract.
  ///          * &lt;p&gt;
  ///          * If this value is null, or is an empty `KeyList` then the contract
  ///          * CANNOT be deleted, modified, or updated, but MAY still expire.
  final proto_basic_types.HederaKey? adminKey;

  /// *
  ///          * The point in time at which this contract will expire.
  final proto_timestamp.HederaTimestamp? expirationTime;

  /// *
  ///          * The duration, in seconds, for which the contract lifetime will be
  ///          * automatically extended upon expiration, provide sufficient HBAR is
  ///          * available at that time to pay the renewal fee.&lt;br/&gt;
  ///          * See `auto_renew_account_id` for additional conditions.
  final proto_duration.HederaDuration? autoRenewPeriod;

  /// *
  ///          * The amount of storage used by this smart contract.
  final BigInt? storage;

  /// *
  ///          * A short description of this smart contract.
  ///          * &lt;p&gt;
  ///          * This value, if set, MUST NOT exceed `transaction.maxMemoUtf8Bytes`
  ///          * (default 100) bytes when encoded as UTF-8.
  final String? memo;

  /// *
  ///          * The current HBAR balance, in tinybar, of the smart contract account.
  final BigInt? balance;

  /// *
  ///          * A flag indicating that this contract is deleted.
  final bool? deleted;

  /// *
  ///          * Because &lt;a href="https://hips.hedera.com/hip/hip-367"&gt;HIP-367&lt;/a&gt;,
  ///          * which allows an account to be associated to an unlimited number of
  ///          * tokens, it became necessary to only provide this information from
  ///          * a Mirror Node.&lt;br/&gt;
  ///          * The list of tokens associated to this contract.
  final List<proto_basic_types.HederaTokenRelationship> tokenRelationships;

  /// *
  ///          * The ledger ID of the network that generated this response.
  ///          * &lt;p&gt;
  ///          * This value SHALL identify the distributed ledger that responded to
  ///          * this query.
  final List<int>? ledgerId;

  /// *
  ///          * An account designated to pay the renewal fee upon automatic renewal
  ///          * of this contract.
  ///          * &lt;p&gt;
  ///          * If this is not set, or is set to an account with zero HBAR
  ///          * available, the HBAR balance of the contract, if available,
  ///          * SHALL be used to pay the renewal fee.
  final proto_basic_types.HederaAccountID? autoRenewAccountId;

  /// *
  ///          * The maximum number of tokens that the contract can be
  ///          * associated to automatically.
  final int? maxAutomaticTokenAssociations;

  /// *
  ///          * Staking information for this contract.
  final proto_basic_types.HederaStakingInfo? stakingInfo;

  const HederaContractGetInfoResponseContractInfo({
    this.contractID,
    this.accountID,
    this.contractAccountID,
    this.adminKey,
    this.expirationTime,
    this.autoRenewPeriod,
    this.storage,
    this.memo,
    this.balance,
    this.deleted,
    this.tokenRelationships = const [],
    this.ledgerId,
    this.autoRenewAccountId,
    this.maxAutomaticTokenAssociations,
    this.stakingInfo,
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
        ProtoFieldConfig.string(3),
        ProtoFieldConfig.message(4),
        ProtoFieldConfig.message(5),
        ProtoFieldConfig.message(6),
        ProtoFieldConfig.int64(7),
        ProtoFieldConfig.string(8),
        ProtoFieldConfig.uint64(9),
        ProtoFieldConfig.bool(10),
        ProtoFieldConfig.repeated(
          fieldNumber: 11,
          elementType: ProtoFieldType.message,
          options: [ProtoOptionBool(name: "deprecated", value: true)],
        ),
        ProtoFieldConfig.bytes(12),
        ProtoFieldConfig.message(13),
        ProtoFieldConfig.int32(14),
        ProtoFieldConfig.message(15),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    contractID,
    accountID,
    contractAccountID,
    adminKey,
    expirationTime,
    autoRenewPeriod,
    storage,
    memo,
    balance,
    deleted,
    tokenRelationships,
    ledgerId,
    autoRenewAccountId,
    maxAutomaticTokenAssociations,
    stakingInfo,
  ];

  HederaContractGetInfoResponseContractInfo copyWith({
    proto_basic_types.HederaContractID? contractID,

    proto_basic_types.HederaAccountID? accountID,

    String? contractAccountID,

    proto_basic_types.HederaKey? adminKey,

    proto_timestamp.HederaTimestamp? expirationTime,

    proto_duration.HederaDuration? autoRenewPeriod,

    BigInt? storage,

    String? memo,

    BigInt? balance,

    bool? deleted,

    List<proto_basic_types.HederaTokenRelationship>? tokenRelationships,

    List<int>? ledgerId,

    proto_basic_types.HederaAccountID? autoRenewAccountId,

    int? maxAutomaticTokenAssociations,

    proto_basic_types.HederaStakingInfo? stakingInfo,
  }) {
    return HederaContractGetInfoResponseContractInfo(
      contractID: contractID ?? this.contractID,
      accountID: accountID ?? this.accountID,
      contractAccountID: contractAccountID ?? this.contractAccountID,
      adminKey: adminKey ?? this.adminKey,
      expirationTime: expirationTime ?? this.expirationTime,
      autoRenewPeriod: autoRenewPeriod ?? this.autoRenewPeriod,
      storage: storage ?? this.storage,
      memo: memo ?? this.memo,
      balance: balance ?? this.balance,
      deleted: deleted ?? this.deleted,
      tokenRelationships: tokenRelationships ?? this.tokenRelationships,
      ledgerId: ledgerId ?? this.ledgerId,
      autoRenewAccountId: autoRenewAccountId ?? this.autoRenewAccountId,
      maxAutomaticTokenAssociations:
          maxAutomaticTokenAssociations ?? this.maxAutomaticTokenAssociations,
      stakingInfo: stakingInfo ?? this.stakingInfo,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'contractID': config.encodeMessage(contractID),
      'accountID': config.encodeMessage(accountID),
      'contractAccountID': contractAccountID,
      'adminKey': config.encodeMessage(adminKey),
      'expirationTime': config.encodeMessage(expirationTime),
      'autoRenewPeriod': config.encodeMessage(autoRenewPeriod),
      'storage': config.encodeBigint(storage),
      'memo': memo,
      'balance': config.encodeBigint(balance),
      'deleted': deleted,
      'tokenRelationships':
          tokenRelationships.map((e) => config.encodeMessage(e)).toList(),
      'ledger_id': config.encodeBinary(ledgerId),
      'auto_renew_account_id': config.encodeMessage(autoRenewAccountId),
      'max_automatic_token_associations': maxAutomaticTokenAssociations,
      'staking_info': config.encodeMessage(stakingInfo),
    };
  }

  factory HederaContractGetInfoResponseContractInfo.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaContractGetInfoResponseContractInfo(
      contractID: json.valueTo<proto_basic_types.HederaContractID?, Object>(
        key: 'contractID',
        parse:
            (v) => proto_basic_types.HederaContractID.fromJson(
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
      contractAccountID: json.valueAsString<String?>(
        'contractAccountID',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      adminKey: json.valueTo<proto_basic_types.HederaKey?, Object>(
        key: 'adminKey',
        parse:
            (v) => proto_basic_types.HederaKey.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
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
      autoRenewPeriod: json.valueTo<proto_duration.HederaDuration?, Object>(
        key: 'autoRenewPeriod',
        parse:
            (v) => proto_duration.HederaDuration.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      storage: json.valueAsBigInt<BigInt?>(
        'storage',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      memo: json.valueAsString<String?>(
        'memo',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      balance: json.valueAsBigInt<BigInt?>(
        'balance',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      deleted: json.valueAsBool<bool?>(
        'deleted',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      tokenRelationships:
          (json.valueEnsureAsList<dynamic>(
                'tokenRelationships',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<
                  proto_basic_types.HederaTokenRelationship,
                  Object
                >(
                  value: e,
                  parse:
                      (v) => proto_basic_types.HederaTokenRelationship.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      ledgerId: config.decodeBinary<List<int>?>(
        json.valueAs('ledger_id', normalizeKeyLookup: config.normalizeKeys),
      ),
      autoRenewAccountId: json
          .valueTo<proto_basic_types.HederaAccountID?, Object>(
            key: 'auto_renew_account_id',
            parse:
                (v) => proto_basic_types.HederaAccountID.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      maxAutomaticTokenAssociations: json.valueAsInt<int?>(
        'max_automatic_token_associations',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      stakingInfo: json.valueTo<proto_basic_types.HederaStakingInfo?, Object>(
        key: 'staking_info',
        parse:
            (v) => proto_basic_types.HederaStakingInfo.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaContractGetInfoResponseContractInfo.deserialize(
    List<int> bytes,
  ) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaContractGetInfoResponseContractInfo(
      contractID: decode.messageTo<proto_basic_types.HederaContractID?>(
        1,
        (b) => proto_basic_types.HederaContractID.deserialize(b),
      ),
      accountID: decode.messageTo<proto_basic_types.HederaAccountID?>(
        2,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
      contractAccountID: decode.getString<String?>(3),
      adminKey: decode.messageTo<proto_basic_types.HederaKey?>(
        4,
        (b) => proto_basic_types.HederaKey.deserialize(b),
      ),
      expirationTime: decode.messageTo<proto_timestamp.HederaTimestamp?>(
        5,
        (b) => proto_timestamp.HederaTimestamp.deserialize(b),
      ),
      autoRenewPeriod: decode.messageTo<proto_duration.HederaDuration?>(
        6,
        (b) => proto_duration.HederaDuration.deserialize(b),
      ),
      storage: decode.getBigInt<BigInt?>(7),
      memo: decode.getString<String?>(8),
      balance: decode.getBigInt<BigInt?>(9),
      deleted: decode.getBool<bool?>(10),
      tokenRelationships:
          decode
              .getListOfBytes(11)
              .map(
                (b) => proto_basic_types.HederaTokenRelationship.deserialize(b),
              )
              .toList(),
      ledgerId: decode.getBytes<List<int>?>(12),
      autoRenewAccountId: decode.messageTo<proto_basic_types.HederaAccountID?>(
        13,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
      maxAutomaticTokenAssociations: decode.getInt<int?>(14),
      stakingInfo: decode.messageTo<proto_basic_types.HederaStakingInfo?>(
        15,
        (b) => proto_basic_types.HederaStakingInfo.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoContractGetInfoResponseContractInfo;
}
