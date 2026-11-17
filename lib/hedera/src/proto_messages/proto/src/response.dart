import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/get_by_key.dart"
    as proto_get_by_key;
import "package:on_chain/hedera/src/proto_messages/proto/src/get_by_solidity_id.dart"
    as proto_get_by_solidity_id;
import "package:on_chain/hedera/src/proto_messages/proto/src/contract_call_local.dart"
    as proto_contract_call_local;
import "package:on_chain/hedera/src/proto_messages/proto/src/contract_get_bytecode.dart"
    as proto_contract_get_bytecode;
import "package:on_chain/hedera/src/proto_messages/proto/src/contract_get_info.dart"
    as proto_contract_get_info;
import "package:on_chain/hedera/src/proto_messages/proto/src/contract_get_records.dart"
    as proto_contract_get_records;
import "package:on_chain/hedera/src/proto_messages/proto/src/crypto_get_account_balance.dart"
    as proto_crypto_get_account_balance;
import "package:on_chain/hedera/src/proto_messages/proto/src/crypto_get_account_records.dart"
    as proto_crypto_get_account_records;
import "package:on_chain/hedera/src/proto_messages/proto/src/crypto_get_info.dart"
    as proto_crypto_get_info;
import "package:on_chain/hedera/src/proto_messages/proto/src/crypto_get_live_hash.dart"
    as proto_crypto_get_live_hash;
import "package:on_chain/hedera/src/proto_messages/proto/src/crypto_get_stakers.dart"
    as proto_crypto_get_stakers;
import "package:on_chain/hedera/src/proto_messages/proto/src/file_get_contents.dart"
    as proto_file_get_contents;
import "package:on_chain/hedera/src/proto_messages/proto/src/file_get_info.dart"
    as proto_file_get_info;
import "package:on_chain/hedera/src/proto_messages/proto/src/transaction_get_receipt.dart"
    as proto_transaction_get_receipt;
import "package:on_chain/hedera/src/proto_messages/proto/src/transaction_get_record.dart"
    as proto_transaction_get_record;
import "package:on_chain/hedera/src/proto_messages/proto/src/transaction_get_fast_record.dart"
    as proto_transaction_get_fast_record;
import "package:on_chain/hedera/src/proto_messages/proto/src/consensus_get_topic_info.dart"
    as proto_consensus_get_topic_info;
import "package:on_chain/hedera/src/proto_messages/proto/src/network_get_version_info.dart"
    as proto_network_get_version_info;
import "package:on_chain/hedera/src/proto_messages/proto/src/token_get_info.dart"
    as proto_token_get_info;
import "package:on_chain/hedera/src/proto_messages/proto/src/schedule_get_info.dart"
    as proto_schedule_get_info;
import "package:on_chain/hedera/src/proto_messages/proto/src/token_get_account_nft_infos.dart"
    as proto_token_get_account_nft_infos;
import "package:on_chain/hedera/src/proto_messages/proto/src/token_get_nft_info.dart"
    as proto_token_get_nft_info;
import "package:on_chain/hedera/src/proto_messages/proto/src/token_get_nft_infos.dart"
    as proto_token_get_nft_infos;
import "package:on_chain/hedera/src/proto_messages/proto/src/network_get_execution_time.dart"
    as proto_network_get_execution_time;
import "package:on_chain/hedera/src/proto_messages/proto/src/get_account_details.dart"
    as proto_get_account_details;

/// *
///  * # Query Response
///  * The `Response` message is returned from a query transaction.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in
///  * [RFC2119](https://www.ietf.org/rfc/rfc2119) and clarified in
///  * [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.transaction"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * A single query response.
///  *
///  * Each query MUST define its specific response type.&lt;br/&gt;
///  * Each query response MUST include both the information request and a
///  * `ResponseHeader`.&lt;br/&gt;
///  * All possible query response types MUST be listed here in a `oneof`.
class HederaResponse extends HederaProtoMessage with Equality {
  /// *
  ///          * A response for a query requesting all accounts, claims, files, and
  ///          * smart contract instances whose associated keys include the given Key.
  ///          * &lt;p&gt;
  ///          * &gt; This query is no longer supported.
  final proto_get_by_key.HederaGetByKeyResponse? getByKey;

  /// *
  ///          * A response for a query requesting Contract, Account, and File
  ///          * identifiers for a smart contract, given a Solidity identifier.
  final proto_get_by_solidity_id.HederaGetBySolidityIDResponse? getBySolidityID;

  /// *
  ///          * A response for a _local_ call to a query function of a given smart
  ///          * contract, providing function parameter inputs as needed.
  ///          * &lt;p&gt;
  ///          * &gt; This call is only performed on the local node. It is _not_ a
  ///          * &gt; network consensus result.
  final proto_contract_call_local.HederaContractCallLocalResponse?
  contractCallLocal;

  /// *
  ///          * A response for a query requesting the current bytecode for
  ///          * a smart contract.
  final proto_contract_get_bytecode.HederaContractGetBytecodeResponse?
  contractGetBytecodeResponse;

  /// *
  ///          * A response for a query requesting detailed information about
  ///          * a smart contract.
  final proto_contract_get_info.HederaContractGetInfoResponse? contractGetInfo;

  /// *
  ///          * A response for a query requesting records of all transactions
  ///          * against the given contract in the last 25 hours.
  ///          * &lt;p&gt;
  ///          * &gt; This query is no longer supported.
  final proto_contract_get_records.HederaContractGetRecordsResponse?
  contractGetRecordsResponse;

  /// *
  ///          * A response for a query requesting the HBAR balance of an account
  ///          * or contract.
  final proto_crypto_get_account_balance.HederaCryptoGetAccountBalanceResponse?
  cryptogetAccountBalance;

  /// *
  ///          * A response for a query requesting records of all "recent"
  ///          * transactions for which the specified account is the effective payer.
  final proto_crypto_get_account_records.HederaCryptoGetAccountRecordsResponse?
  cryptoGetAccountRecords;

  /// *
  ///          * A response for a query requesting information for an account.&lt;br/&gt;
  ///          * This query includes balance, but not allowances or token
  ///          * relationships.
  final proto_crypto_get_info.HederaCryptoGetInfoResponse? cryptoGetInfo;

  /// *
  ///          * A response for a query requesting detail for a specific live hash
  ///          * associated to a specific account.
  ///          * &lt;p&gt;
  ///          * &gt; This query is no longer supported.
  final proto_crypto_get_live_hash.HederaCryptoGetLiveHashResponse?
  cryptoGetLiveHash;

  /// *
  ///          * A response for a query requesting all the accounts that are proxy
  ///          * staking to this account.
  ///          * &lt;p&gt;
  ///          * &gt; This query is no longer supported.
  final proto_crypto_get_stakers.HederaCryptoGetStakersResponse?
  cryptoGetProxyStakers;

  /// *
  ///          * A response for a query requesting the content of a file in the
  ///          * Hedera File Service (HFS).
  final proto_file_get_contents.HederaFileGetContentsResponse? fileGetContents;

  /// *
  ///          * A response for a query requesting file metadata from the
  ///          * Hedera File Service (HFS).
  final proto_file_get_info.HederaFileGetInfoResponse? fileGetInfo;

  /// *
  ///          * A response for a query requesting the post-consensus (final)
  ///          * result of a transaction.
  final proto_transaction_get_receipt.HederaTransactionGetReceiptResponse?
  transactionGetReceipt;

  /// *
  ///          * A response for a query requesting a transaction record; the detail
  ///          * changes completed in response to a transaction.
  final proto_transaction_get_record.HederaTransactionGetRecordResponse?
  transactionGetRecord;

  /// *
  ///          * A response for a query requesting a very recent transaction record.
  ///          * &lt;p&gt;
  ///          * &gt; This query is no longer supported.
  final proto_transaction_get_fast_record.HederaTransactionGetFastRecordResponse?
  transactionGetFastRecord;

  /// *
  ///          * A response for a query requesting the current state of a topic for
  ///          * the Hedera Consensus Service (HCS).
  final proto_consensus_get_topic_info.HederaConsensusGetTopicInfoResponse?
  consensusGetTopicInfo;

  /// *
  ///          * A response for a query requesting the deployed versions of Hedera
  ///          * Services and the API definitions in semantic version format
  final proto_network_get_version_info.HederaNetworkGetVersionInfoResponse?
  networkGetVersionInfo;

  /// *
  ///          * A response for a query requesting metadata for a specific Token.
  final proto_token_get_info.HederaTokenGetInfoResponse? tokenGetInfo;

  /// *
  ///          * A response for a query requesting detail for a scheduled transaction.
  final proto_schedule_get_info.HederaScheduleGetInfoResponse? scheduleGetInfo;

  /// *
  ///          * A response for a query requesting detail for a subset of individual
  ///          * non-fungible/unique tokens owned by an account.&lt;br/&gt;
  ///          * The requested tokens are selected by a list index, which is based
  ///          * on the order in which the tokens were added to the account.
  final proto_token_get_account_nft_infos.HederaTokenGetAccountNftInfosResponse?
  tokenGetAccountNftInfos;

  /// *
  ///          * A response for a query requesting detail for a specific
  ///          * non-fungible/unique token selected by both token identifier and
  ///          * serial number.
  final proto_token_get_nft_info.HederaTokenGetNftInfoResponse? tokenGetNftInfo;

  /// *
  ///          * A response for a query requesting detail for a subset of individual
  ///          * non-fungible/unique tokens.&lt;br/&gt;
  ///          * The requested tokens are selected by a list index, which is based
  ///          * on the order in which the tokens were minted.
  final proto_token_get_nft_infos.HederaTokenGetNftInfosResponse?
  tokenGetNftInfos;

  /// *
  ///          * A response for a query requesting the time, in nanoseconds, spent
  ///          * in direct processing for one or more recent transactions.
  ///          * &lt;p&gt;
  ///          * &gt; This query is no longer supported.
  final proto_network_get_execution_time.HederaNetworkGetExecutionTimeResponse?
  networkGetExecutionTime;

  /// *
  ///          * A response for a query requesting detail information
  ///          * about an account.
  ///          * &lt;p&gt;
  ///          * This query is a privileged query and "system" account authorization
  ///          * is REQUIRED for this query.
  final proto_get_account_details.HederaGetAccountDetailsResponse?
  accountDetails;

  const HederaResponse({
    this.getByKey,
    this.getBySolidityID,
    this.contractCallLocal,
    this.contractGetBytecodeResponse,
    this.contractGetInfo,
    this.contractGetRecordsResponse,
    this.cryptogetAccountBalance,
    this.cryptoGetAccountRecords,
    this.cryptoGetInfo,
    this.cryptoGetLiveHash,
    this.cryptoGetProxyStakers,
    this.fileGetContents,
    this.fileGetInfo,
    this.transactionGetReceipt,
    this.transactionGetRecord,
    this.transactionGetFastRecord,
    this.consensusGetTopicInfo,
    this.networkGetVersionInfo,
    this.tokenGetInfo,
    this.scheduleGetInfo,
    this.tokenGetAccountNftInfos,
    this.tokenGetNftInfo,
    this.tokenGetNftInfos,
    this.networkGetExecutionTime,
    this.accountDetails,
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
        ProtoFieldConfig.message(5),
        ProtoFieldConfig.message(4),
        ProtoFieldConfig.message(6),
        ProtoFieldConfig.message(7),
        ProtoFieldConfig.message(8),
        ProtoFieldConfig.message(9),
        ProtoFieldConfig.message(10),
        ProtoFieldConfig.message(11),
        ProtoFieldConfig.message(12),
        ProtoFieldConfig.message(13),
        ProtoFieldConfig.message(14),
        ProtoFieldConfig.message(15),
        ProtoFieldConfig.message(16),
        ProtoFieldConfig.message(150),
        ProtoFieldConfig.message(151),
        ProtoFieldConfig.message(152),
        ProtoFieldConfig.message(153),
        ProtoFieldConfig.message(154),
        ProtoFieldConfig.message(155),
        ProtoFieldConfig.message(156),
        ProtoFieldConfig.message(157),
        ProtoFieldConfig.message(158),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    getByKey,
    getBySolidityID,
    contractCallLocal,
    contractGetBytecodeResponse,
    contractGetInfo,
    contractGetRecordsResponse,
    cryptogetAccountBalance,
    cryptoGetAccountRecords,
    cryptoGetInfo,
    cryptoGetLiveHash,
    cryptoGetProxyStakers,
    fileGetContents,
    fileGetInfo,
    transactionGetReceipt,
    transactionGetRecord,
    transactionGetFastRecord,
    consensusGetTopicInfo,
    networkGetVersionInfo,
    tokenGetInfo,
    scheduleGetInfo,
    tokenGetAccountNftInfos,
    tokenGetNftInfo,
    tokenGetNftInfos,
    networkGetExecutionTime,
    accountDetails,
  ];

  HederaResponse copyWith({
    proto_get_by_key.HederaGetByKeyResponse? getByKey,

    proto_get_by_solidity_id.HederaGetBySolidityIDResponse? getBySolidityID,

    proto_contract_call_local.HederaContractCallLocalResponse?
    contractCallLocal,

    proto_contract_get_bytecode.HederaContractGetBytecodeResponse?
    contractGetBytecodeResponse,

    proto_contract_get_info.HederaContractGetInfoResponse? contractGetInfo,

    proto_contract_get_records.HederaContractGetRecordsResponse?
    contractGetRecordsResponse,

    proto_crypto_get_account_balance.HederaCryptoGetAccountBalanceResponse?
    cryptogetAccountBalance,

    proto_crypto_get_account_records.HederaCryptoGetAccountRecordsResponse?
    cryptoGetAccountRecords,

    proto_crypto_get_info.HederaCryptoGetInfoResponse? cryptoGetInfo,

    proto_crypto_get_live_hash.HederaCryptoGetLiveHashResponse?
    cryptoGetLiveHash,

    proto_crypto_get_stakers.HederaCryptoGetStakersResponse?
    cryptoGetProxyStakers,

    proto_file_get_contents.HederaFileGetContentsResponse? fileGetContents,

    proto_file_get_info.HederaFileGetInfoResponse? fileGetInfo,

    proto_transaction_get_receipt.HederaTransactionGetReceiptResponse?
    transactionGetReceipt,

    proto_transaction_get_record.HederaTransactionGetRecordResponse?
    transactionGetRecord,

    proto_transaction_get_fast_record.HederaTransactionGetFastRecordResponse?
    transactionGetFastRecord,

    proto_consensus_get_topic_info.HederaConsensusGetTopicInfoResponse?
    consensusGetTopicInfo,

    proto_network_get_version_info.HederaNetworkGetVersionInfoResponse?
    networkGetVersionInfo,

    proto_token_get_info.HederaTokenGetInfoResponse? tokenGetInfo,

    proto_schedule_get_info.HederaScheduleGetInfoResponse? scheduleGetInfo,

    proto_token_get_account_nft_infos.HederaTokenGetAccountNftInfosResponse?
    tokenGetAccountNftInfos,

    proto_token_get_nft_info.HederaTokenGetNftInfoResponse? tokenGetNftInfo,

    proto_token_get_nft_infos.HederaTokenGetNftInfosResponse? tokenGetNftInfos,

    proto_network_get_execution_time.HederaNetworkGetExecutionTimeResponse?
    networkGetExecutionTime,

    proto_get_account_details.HederaGetAccountDetailsResponse? accountDetails,
  }) {
    return HederaResponse(
      getByKey: getByKey ?? this.getByKey,
      getBySolidityID: getBySolidityID ?? this.getBySolidityID,
      contractCallLocal: contractCallLocal ?? this.contractCallLocal,
      contractGetBytecodeResponse:
          contractGetBytecodeResponse ?? this.contractGetBytecodeResponse,
      contractGetInfo: contractGetInfo ?? this.contractGetInfo,
      contractGetRecordsResponse:
          contractGetRecordsResponse ?? this.contractGetRecordsResponse,
      cryptogetAccountBalance:
          cryptogetAccountBalance ?? this.cryptogetAccountBalance,
      cryptoGetAccountRecords:
          cryptoGetAccountRecords ?? this.cryptoGetAccountRecords,
      cryptoGetInfo: cryptoGetInfo ?? this.cryptoGetInfo,
      cryptoGetLiveHash: cryptoGetLiveHash ?? this.cryptoGetLiveHash,
      cryptoGetProxyStakers:
          cryptoGetProxyStakers ?? this.cryptoGetProxyStakers,
      fileGetContents: fileGetContents ?? this.fileGetContents,
      fileGetInfo: fileGetInfo ?? this.fileGetInfo,
      transactionGetReceipt:
          transactionGetReceipt ?? this.transactionGetReceipt,
      transactionGetRecord: transactionGetRecord ?? this.transactionGetRecord,
      transactionGetFastRecord:
          transactionGetFastRecord ?? this.transactionGetFastRecord,
      consensusGetTopicInfo:
          consensusGetTopicInfo ?? this.consensusGetTopicInfo,
      networkGetVersionInfo:
          networkGetVersionInfo ?? this.networkGetVersionInfo,
      tokenGetInfo: tokenGetInfo ?? this.tokenGetInfo,
      scheduleGetInfo: scheduleGetInfo ?? this.scheduleGetInfo,
      tokenGetAccountNftInfos:
          tokenGetAccountNftInfos ?? this.tokenGetAccountNftInfos,
      tokenGetNftInfo: tokenGetNftInfo ?? this.tokenGetNftInfo,
      tokenGetNftInfos: tokenGetNftInfos ?? this.tokenGetNftInfos,
      networkGetExecutionTime:
          networkGetExecutionTime ?? this.networkGetExecutionTime,
      accountDetails: accountDetails ?? this.accountDetails,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'getByKey': config.encodeMessage(getByKey),
      'getBySolidityID': config.encodeMessage(getBySolidityID),
      'contractCallLocal': config.encodeMessage(contractCallLocal),
      'contractGetBytecodeResponse': config.encodeMessage(
        contractGetBytecodeResponse,
      ),
      'contractGetInfo': config.encodeMessage(contractGetInfo),
      'contractGetRecordsResponse': config.encodeMessage(
        contractGetRecordsResponse,
      ),
      'cryptogetAccountBalance': config.encodeMessage(cryptogetAccountBalance),
      'cryptoGetAccountRecords': config.encodeMessage(cryptoGetAccountRecords),
      'cryptoGetInfo': config.encodeMessage(cryptoGetInfo),
      'cryptoGetLiveHash': config.encodeMessage(cryptoGetLiveHash),
      'cryptoGetProxyStakers': config.encodeMessage(cryptoGetProxyStakers),
      'fileGetContents': config.encodeMessage(fileGetContents),
      'fileGetInfo': config.encodeMessage(fileGetInfo),
      'transactionGetReceipt': config.encodeMessage(transactionGetReceipt),
      'transactionGetRecord': config.encodeMessage(transactionGetRecord),
      'transactionGetFastRecord': config.encodeMessage(
        transactionGetFastRecord,
      ),
      'consensusGetTopicInfo': config.encodeMessage(consensusGetTopicInfo),
      'networkGetVersionInfo': config.encodeMessage(networkGetVersionInfo),
      'tokenGetInfo': config.encodeMessage(tokenGetInfo),
      'scheduleGetInfo': config.encodeMessage(scheduleGetInfo),
      'tokenGetAccountNftInfos': config.encodeMessage(tokenGetAccountNftInfos),
      'tokenGetNftInfo': config.encodeMessage(tokenGetNftInfo),
      'tokenGetNftInfos': config.encodeMessage(tokenGetNftInfos),
      'networkGetExecutionTime': config.encodeMessage(networkGetExecutionTime),
      'accountDetails': config.encodeMessage(accountDetails),
    };
  }

  factory HederaResponse.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaResponse(
      getByKey: json.valueTo<proto_get_by_key.HederaGetByKeyResponse?, Object>(
        key: 'getByKey',
        parse:
            (v) => proto_get_by_key.HederaGetByKeyResponse.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      getBySolidityID: json.valueTo<
        proto_get_by_solidity_id.HederaGetBySolidityIDResponse?,
        Object
      >(
        key: 'getBySolidityID',
        parse:
            (v) =>
                proto_get_by_solidity_id.HederaGetBySolidityIDResponse.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      contractCallLocal: json.valueTo<
        proto_contract_call_local.HederaContractCallLocalResponse?,
        Object
      >(
        key: 'contractCallLocal',
        parse:
            (v) => proto_contract_call_local
                .HederaContractCallLocalResponse.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      contractGetBytecodeResponse: json.valueTo<
        proto_contract_get_bytecode.HederaContractGetBytecodeResponse?,
        Object
      >(
        key: 'contractGetBytecodeResponse',
        parse:
            (v) => proto_contract_get_bytecode
                .HederaContractGetBytecodeResponse.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      contractGetInfo: json.valueTo<
        proto_contract_get_info.HederaContractGetInfoResponse?,
        Object
      >(
        key: 'contractGetInfo',
        parse:
            (v) =>
                proto_contract_get_info.HederaContractGetInfoResponse.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      contractGetRecordsResponse: json.valueTo<
        proto_contract_get_records.HederaContractGetRecordsResponse?,
        Object
      >(
        key: 'contractGetRecordsResponse',
        parse:
            (v) => proto_contract_get_records
                .HederaContractGetRecordsResponse.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      cryptogetAccountBalance: json.valueTo<
        proto_crypto_get_account_balance.HederaCryptoGetAccountBalanceResponse?,
        Object
      >(
        key: 'cryptogetAccountBalance',
        parse:
            (v) => proto_crypto_get_account_balance
                .HederaCryptoGetAccountBalanceResponse.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      cryptoGetAccountRecords: json.valueTo<
        proto_crypto_get_account_records.HederaCryptoGetAccountRecordsResponse?,
        Object
      >(
        key: 'cryptoGetAccountRecords',
        parse:
            (v) => proto_crypto_get_account_records
                .HederaCryptoGetAccountRecordsResponse.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      cryptoGetInfo: json
          .valueTo<proto_crypto_get_info.HederaCryptoGetInfoResponse?, Object>(
            key: 'cryptoGetInfo',
            parse:
                (v) =>
                    proto_crypto_get_info.HederaCryptoGetInfoResponse.fromJson(
                      JsonParser.valueAs(v),
                      config: config,
                    ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      cryptoGetLiveHash: json.valueTo<
        proto_crypto_get_live_hash.HederaCryptoGetLiveHashResponse?,
        Object
      >(
        key: 'cryptoGetLiveHash',
        parse:
            (v) => proto_crypto_get_live_hash
                .HederaCryptoGetLiveHashResponse.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      cryptoGetProxyStakers: json.valueTo<
        proto_crypto_get_stakers.HederaCryptoGetStakersResponse?,
        Object
      >(
        key: 'cryptoGetProxyStakers',
        parse:
            (v) => proto_crypto_get_stakers
                .HederaCryptoGetStakersResponse.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      fileGetContents: json.valueTo<
        proto_file_get_contents.HederaFileGetContentsResponse?,
        Object
      >(
        key: 'fileGetContents',
        parse:
            (v) =>
                proto_file_get_contents.HederaFileGetContentsResponse.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      fileGetInfo: json
          .valueTo<proto_file_get_info.HederaFileGetInfoResponse?, Object>(
            key: 'fileGetInfo',
            parse:
                (v) => proto_file_get_info.HederaFileGetInfoResponse.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      transactionGetReceipt: json.valueTo<
        proto_transaction_get_receipt.HederaTransactionGetReceiptResponse?,
        Object
      >(
        key: 'transactionGetReceipt',
        parse:
            (v) => proto_transaction_get_receipt
                .HederaTransactionGetReceiptResponse.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      transactionGetRecord: json.valueTo<
        proto_transaction_get_record.HederaTransactionGetRecordResponse?,
        Object
      >(
        key: 'transactionGetRecord',
        parse:
            (v) => proto_transaction_get_record
                .HederaTransactionGetRecordResponse.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      transactionGetFastRecord: json.valueTo<
        proto_transaction_get_fast_record.HederaTransactionGetFastRecordResponse?,
        Object
      >(
        key: 'transactionGetFastRecord',
        parse:
            (v) => proto_transaction_get_fast_record
                .HederaTransactionGetFastRecordResponse.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      consensusGetTopicInfo: json.valueTo<
        proto_consensus_get_topic_info.HederaConsensusGetTopicInfoResponse?,
        Object
      >(
        key: 'consensusGetTopicInfo',
        parse:
            (v) => proto_consensus_get_topic_info
                .HederaConsensusGetTopicInfoResponse.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      networkGetVersionInfo: json.valueTo<
        proto_network_get_version_info.HederaNetworkGetVersionInfoResponse?,
        Object
      >(
        key: 'networkGetVersionInfo',
        parse:
            (v) => proto_network_get_version_info
                .HederaNetworkGetVersionInfoResponse.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      tokenGetInfo: json
          .valueTo<proto_token_get_info.HederaTokenGetInfoResponse?, Object>(
            key: 'tokenGetInfo',
            parse:
                (v) => proto_token_get_info.HederaTokenGetInfoResponse.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      scheduleGetInfo: json.valueTo<
        proto_schedule_get_info.HederaScheduleGetInfoResponse?,
        Object
      >(
        key: 'scheduleGetInfo',
        parse:
            (v) =>
                proto_schedule_get_info.HederaScheduleGetInfoResponse.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      tokenGetAccountNftInfos: json.valueTo<
        proto_token_get_account_nft_infos.HederaTokenGetAccountNftInfosResponse?,
        Object
      >(
        key: 'tokenGetAccountNftInfos',
        parse:
            (v) => proto_token_get_account_nft_infos
                .HederaTokenGetAccountNftInfosResponse.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      tokenGetNftInfo: json.valueTo<
        proto_token_get_nft_info.HederaTokenGetNftInfoResponse?,
        Object
      >(
        key: 'tokenGetNftInfo',
        parse:
            (v) =>
                proto_token_get_nft_info.HederaTokenGetNftInfoResponse.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      tokenGetNftInfos: json.valueTo<
        proto_token_get_nft_infos.HederaTokenGetNftInfosResponse?,
        Object
      >(
        key: 'tokenGetNftInfos',
        parse:
            (v) => proto_token_get_nft_infos
                .HederaTokenGetNftInfosResponse.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      networkGetExecutionTime: json.valueTo<
        proto_network_get_execution_time.HederaNetworkGetExecutionTimeResponse?,
        Object
      >(
        key: 'networkGetExecutionTime',
        parse:
            (v) => proto_network_get_execution_time
                .HederaNetworkGetExecutionTimeResponse.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      accountDetails: json.valueTo<
        proto_get_account_details.HederaGetAccountDetailsResponse?,
        Object
      >(
        key: 'accountDetails',
        parse:
            (v) => proto_get_account_details
                .HederaGetAccountDetailsResponse.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaResponse.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaResponse(
      getByKey: decode.messageTo<proto_get_by_key.HederaGetByKeyResponse?>(
        1,
        (b) => proto_get_by_key.HederaGetByKeyResponse.deserialize(b),
      ),
      getBySolidityID: decode
          .messageTo<proto_get_by_solidity_id.HederaGetBySolidityIDResponse?>(
            2,
            (b) => proto_get_by_solidity_id
                .HederaGetBySolidityIDResponse.deserialize(b),
          ),
      contractCallLocal: decode.messageTo<
        proto_contract_call_local.HederaContractCallLocalResponse?
      >(
        3,
        (b) => proto_contract_call_local
            .HederaContractCallLocalResponse.deserialize(b),
      ),
      contractGetBytecodeResponse: decode.messageTo<
        proto_contract_get_bytecode.HederaContractGetBytecodeResponse?
      >(
        5,
        (b) => proto_contract_get_bytecode
            .HederaContractGetBytecodeResponse.deserialize(b),
      ),
      contractGetInfo: decode
          .messageTo<proto_contract_get_info.HederaContractGetInfoResponse?>(
            4,
            (b) => proto_contract_get_info
                .HederaContractGetInfoResponse.deserialize(b),
          ),
      contractGetRecordsResponse: decode.messageTo<
        proto_contract_get_records.HederaContractGetRecordsResponse?
      >(
        6,
        (b) => proto_contract_get_records
            .HederaContractGetRecordsResponse.deserialize(b),
      ),
      cryptogetAccountBalance: decode.messageTo<
        proto_crypto_get_account_balance.HederaCryptoGetAccountBalanceResponse?
      >(
        7,
        (b) => proto_crypto_get_account_balance
            .HederaCryptoGetAccountBalanceResponse.deserialize(b),
      ),
      cryptoGetAccountRecords: decode.messageTo<
        proto_crypto_get_account_records.HederaCryptoGetAccountRecordsResponse?
      >(
        8,
        (b) => proto_crypto_get_account_records
            .HederaCryptoGetAccountRecordsResponse.deserialize(b),
      ),
      cryptoGetInfo: decode.messageTo<
        proto_crypto_get_info.HederaCryptoGetInfoResponse?
      >(
        9,
        (b) => proto_crypto_get_info.HederaCryptoGetInfoResponse.deserialize(b),
      ),
      cryptoGetLiveHash: decode.messageTo<
        proto_crypto_get_live_hash.HederaCryptoGetLiveHashResponse?
      >(
        10,
        (b) => proto_crypto_get_live_hash
            .HederaCryptoGetLiveHashResponse.deserialize(b),
      ),
      cryptoGetProxyStakers: decode
          .messageTo<proto_crypto_get_stakers.HederaCryptoGetStakersResponse?>(
            11,
            (b) => proto_crypto_get_stakers
                .HederaCryptoGetStakersResponse.deserialize(b),
          ),
      fileGetContents: decode
          .messageTo<proto_file_get_contents.HederaFileGetContentsResponse?>(
            12,
            (b) => proto_file_get_contents
                .HederaFileGetContentsResponse.deserialize(b),
          ),
      fileGetInfo: decode
          .messageTo<proto_file_get_info.HederaFileGetInfoResponse?>(
            13,
            (b) => proto_file_get_info.HederaFileGetInfoResponse.deserialize(b),
          ),
      transactionGetReceipt: decode.messageTo<
        proto_transaction_get_receipt.HederaTransactionGetReceiptResponse?
      >(
        14,
        (b) => proto_transaction_get_receipt
            .HederaTransactionGetReceiptResponse.deserialize(b),
      ),
      transactionGetRecord: decode.messageTo<
        proto_transaction_get_record.HederaTransactionGetRecordResponse?
      >(
        15,
        (b) => proto_transaction_get_record
            .HederaTransactionGetRecordResponse.deserialize(b),
      ),
      transactionGetFastRecord: decode.messageTo<
        proto_transaction_get_fast_record.HederaTransactionGetFastRecordResponse?
      >(
        16,
        (b) => proto_transaction_get_fast_record
            .HederaTransactionGetFastRecordResponse.deserialize(b),
      ),
      consensusGetTopicInfo: decode.messageTo<
        proto_consensus_get_topic_info.HederaConsensusGetTopicInfoResponse?
      >(
        150,
        (b) => proto_consensus_get_topic_info
            .HederaConsensusGetTopicInfoResponse.deserialize(b),
      ),
      networkGetVersionInfo: decode.messageTo<
        proto_network_get_version_info.HederaNetworkGetVersionInfoResponse?
      >(
        151,
        (b) => proto_network_get_version_info
            .HederaNetworkGetVersionInfoResponse.deserialize(b),
      ),
      tokenGetInfo: decode
          .messageTo<proto_token_get_info.HederaTokenGetInfoResponse?>(
            152,
            (b) =>
                proto_token_get_info.HederaTokenGetInfoResponse.deserialize(b),
          ),
      scheduleGetInfo: decode
          .messageTo<proto_schedule_get_info.HederaScheduleGetInfoResponse?>(
            153,
            (b) => proto_schedule_get_info
                .HederaScheduleGetInfoResponse.deserialize(b),
          ),
      tokenGetAccountNftInfos: decode.messageTo<
        proto_token_get_account_nft_infos.HederaTokenGetAccountNftInfosResponse?
      >(
        154,
        (b) => proto_token_get_account_nft_infos
            .HederaTokenGetAccountNftInfosResponse.deserialize(b),
      ),
      tokenGetNftInfo: decode
          .messageTo<proto_token_get_nft_info.HederaTokenGetNftInfoResponse?>(
            155,
            (b) => proto_token_get_nft_info
                .HederaTokenGetNftInfoResponse.deserialize(b),
          ),
      tokenGetNftInfos: decode
          .messageTo<proto_token_get_nft_infos.HederaTokenGetNftInfosResponse?>(
            156,
            (b) => proto_token_get_nft_infos
                .HederaTokenGetNftInfosResponse.deserialize(b),
          ),
      networkGetExecutionTime: decode.messageTo<
        proto_network_get_execution_time.HederaNetworkGetExecutionTimeResponse?
      >(
        157,
        (b) => proto_network_get_execution_time
            .HederaNetworkGetExecutionTimeResponse.deserialize(b),
      ),
      accountDetails: decode.messageTo<
        proto_get_account_details.HederaGetAccountDetailsResponse?
      >(
        158,
        (b) => proto_get_account_details
            .HederaGetAccountDetailsResponse.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoResponse;
}
