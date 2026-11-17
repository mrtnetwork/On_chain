import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/get_by_key.dart"
    as proto_get_by_key;
import "package:on_chain/hedera/src/proto_messages/proto/src/get_by_solidity_id.dart"
    as proto_get_by_solidity_id;
import "package:on_chain/hedera/src/proto_messages/proto/src/contract_call_local.dart"
    as proto_contract_call_local;
import "package:on_chain/hedera/src/proto_messages/proto/src/contract_get_info.dart"
    as proto_contract_get_info;
import "package:on_chain/hedera/src/proto_messages/proto/src/contract_get_bytecode.dart"
    as proto_contract_get_bytecode;
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
import "package:on_chain/hedera/src/proto_messages/proto/src/response.dart"
    as proto_response;

/// *
///  * # Query
///  * This is the parent message for all queries, and this message is
///  * serialized and signed, with the signature included in the QueryHeader.
///  *
///  * All of the entries in the `query` `oneof` are fully specified elsewhere;
///  * we only include a short summary here.
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
///  * A query transaction.&lt;br/&gt;
///  * This message is serialized to bytes and those bytes are signed by the
///  * submitter, with the signature included in the QueryHeader for the query
///  * request.
class HederaQuery extends HederaProtoMessage with Equality {
  /// *
  ///          * Get all entities associated with a given key.
  final proto_get_by_key.HederaGetByKeyQuery? getByKey;

  /// *
  ///          * Get an Hedera identifier associated with an identifier in EVM
  ///          * "Solidity" form.&lt;br/&gt;
  ///          * Most often used in smart contracts to find an Hedera account,
  ///          * file, or contract identifier to pass to a system contract or
  ///          * precompile.
  final proto_get_by_solidity_id.HederaGetBySolidityIDQuery? getBySolidityID;

  /// *
  ///          * Call a function of a smart contract.&lt;br/&gt;
  ///          * This call is executed exclusively on the node to which it is
  ///          * submitted, and is much less expensive than a `contractCall`
  ///          * transaction.
  final proto_contract_call_local.HederaContractCallLocalQuery?
  contractCallLocal;

  /// *
  ///          * Get information about a smart contract.
  final proto_contract_get_info.HederaContractGetInfoQuery? contractGetInfo;

  /// *
  ///          * Get runtime bytecode used by a smart contract.
  final proto_contract_get_bytecode.HederaContractGetBytecodeQuery?
  contractGetBytecode;

  /// *
  ///          * This query is unsupported and SHALL fail.&lt;br/&gt;
  ///          * Requests for this information MUST be directed to a mirror node.
  ///          * &lt;p&gt;
  ///          * Get Records of a smart contract.
  final proto_contract_get_records.HederaContractGetRecordsQuery?
  contractGetRecords;

  /// *
  ///          * Get the current HBAR balance of an Hedera account or smart contract.
  final proto_crypto_get_account_balance.HederaCryptoGetAccountBalanceQuery?
  cryptogetAccountBalance;

  /// *
  ///          * Get records of all "recent" transactions for which a specified
  ///          * account is the effective payer.
  final proto_crypto_get_account_records.HederaCryptoGetAccountRecordsQuery?
  cryptoGetAccountRecords;

  /// *
  ///          * Get information about an account, including the balance.&lt;br/&gt;
  ///          * This does not get the list of account records.
  final proto_crypto_get_info.HederaCryptoGetInfoQuery? cryptoGetInfo;

  /// *
  ///          * This query is unsupported and SHALL fail.&lt;br/&gt;
  ///          * Requests for this information MUST be directed to a mirror node.
  ///          * &lt;p&gt;
  ///          * Get a single livehash from a single account, if present.
  final proto_crypto_get_live_hash.HederaCryptoGetLiveHashQuery?
  cryptoGetLiveHash;

  /// *
  ///          * This query is unsupported and SHALL fail.&lt;br/&gt;
  ///          * Requests for this information MUST be directed to a mirror node.
  ///          * &lt;p&gt;
  ///          * Get all the accounts that are proxy staking to this account.
  final proto_crypto_get_stakers.HederaCryptoGetStakersQuery?
  cryptoGetProxyStakers;

  /// *
  ///          * Get the content of a file.
  final proto_file_get_contents.HederaFileGetContentsQuery? fileGetContents;

  /// *
  ///          * Get metadata for a file.
  final proto_file_get_info.HederaFileGetInfoQuery? fileGetInfo;

  /// *
  ///          * Get a receipt for a transaction.&lt;br/&gt;
  ///          * This only returns a receipt if the transaction is "recent", which
  ///          * is typically within the previous 180 seconds (3 minutes).
  final proto_transaction_get_receipt.HederaTransactionGetReceiptQuery?
  transactionGetReceipt;

  /// *
  ///          * Get a record for a transaction.
  ///          * This only returns a record if the transaction is "available", which
  ///          * is typically within the previous 1 hour.
  final proto_transaction_get_record.HederaTransactionGetRecordQuery?
  transactionGetRecord;

  /// *
  ///          * Get a record for a transaction.
  ///          * This only returns a record if the transaction is "recent", which
  ///          * is typically within the previous 180 seconds (3 minutes).
  final proto_transaction_get_fast_record.HederaTransactionGetFastRecordQuery?
  transactionGetFastRecord;

  /// *
  ///          * Get metadata for a consensus topic.
  final proto_consensus_get_topic_info.HederaConsensusGetTopicInfoQuery?
  consensusGetTopicInfo;

  /// *
  ///          * Get the versions of Hedera Services and the HAPI API deployed on
  ///          * the responding consensus node.
  final proto_network_get_version_info.HederaNetworkGetVersionInfoQuery?
  networkGetVersionInfo;

  /// *
  ///          * Get metadata for a token.
  final proto_token_get_info.HederaTokenGetInfoQuery? tokenGetInfo;

  /// *
  ///          * Get metadata for a schedule.&lt;br/&gt;
  ///          * A schedule is a request to execute a transaction at a future
  ///          * time.
  final proto_schedule_get_info.HederaScheduleGetInfoQuery? scheduleGetInfo;

  /// *
  ///          * This query is unsupported and SHALL fail.&lt;br/&gt;
  ///          * Requests for this information MUST be directed to a mirror node.
  ///          * &lt;p&gt;
  ///          * Get a list of non-fungible/unique tokens associated with an account.
  final proto_token_get_account_nft_infos.HederaTokenGetAccountNftInfosQuery?
  tokenGetAccountNftInfos;

  /// *
  ///          * Get metadata for a specific, serial numbered, non-fungible/unique
  ///          * token (NFT).
  final proto_token_get_nft_info.HederaTokenGetNftInfoQuery? tokenGetNftInfo;

  /// *
  ///          * This query is unsupported and SHALL fail.&lt;br/&gt;
  ///          * Requests for this information MUST be directed to a mirror node.
  ///          * &lt;p&gt;
  ///          * Get metadata for all non-fungible/unique tokens (NFTs) of a single
  ///          * type within a range of indices (0-based count of minted tokens).
  final proto_token_get_nft_infos.HederaTokenGetNftInfosQuery? tokenGetNftInfos;

  /// *
  ///          * This query is unsupported and SHALL fail.&lt;br/&gt;
  ///          * Requests for this information MUST be directed to a mirror node.
  ///          * &lt;p&gt;
  ///          * Get the execution time for a recent transaction.
  final proto_network_get_execution_time.HederaNetworkGetExecutionTimeQuery?
  networkGetExecutionTime;

  /// *
  ///          * Get detail metadata for an account.
  final proto_get_account_details.HederaGetAccountDetailsQuery? accountDetails;

  const HederaQuery({
    this.getByKey,
    this.getBySolidityID,
    this.contractCallLocal,
    this.contractGetInfo,
    this.contractGetBytecode,
    this.contractGetRecords,
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
        ProtoFieldConfig.message(4),
        ProtoFieldConfig.message(5),
        ProtoFieldConfig.message(
          6,
          options: [ProtoOptionBool(name: "deprecated", value: true)],
        ),
        ProtoFieldConfig.message(7),
        ProtoFieldConfig.message(8),
        ProtoFieldConfig.message(9),
        ProtoFieldConfig.message(
          10,
          options: [ProtoOptionBool(name: "deprecated", value: true)],
        ),
        ProtoFieldConfig.message(
          11,
          options: [ProtoOptionBool(name: "deprecated", value: true)],
        ),
        ProtoFieldConfig.message(12),
        ProtoFieldConfig.message(13),
        ProtoFieldConfig.message(14),
        ProtoFieldConfig.message(15),
        ProtoFieldConfig.message(16),
        ProtoFieldConfig.message(50),
        ProtoFieldConfig.message(51),
        ProtoFieldConfig.message(52),
        ProtoFieldConfig.message(53),
        ProtoFieldConfig.message(
          54,
          options: [ProtoOptionBool(name: "deprecated", value: true)],
        ),
        ProtoFieldConfig.message(55),
        ProtoFieldConfig.message(
          56,
          options: [ProtoOptionBool(name: "deprecated", value: true)],
        ),
        ProtoFieldConfig.message(
          57,
          options: [ProtoOptionBool(name: "deprecated", value: true)],
        ),
        ProtoFieldConfig.message(58),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    getByKey,
    getBySolidityID,
    contractCallLocal,
    contractGetInfo,
    contractGetBytecode,
    contractGetRecords,
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

  HederaQuery copyWith({
    proto_get_by_key.HederaGetByKeyQuery? getByKey,

    proto_get_by_solidity_id.HederaGetBySolidityIDQuery? getBySolidityID,

    proto_contract_call_local.HederaContractCallLocalQuery? contractCallLocal,

    proto_contract_get_info.HederaContractGetInfoQuery? contractGetInfo,

    proto_contract_get_bytecode.HederaContractGetBytecodeQuery?
    contractGetBytecode,

    proto_contract_get_records.HederaContractGetRecordsQuery?
    contractGetRecords,

    proto_crypto_get_account_balance.HederaCryptoGetAccountBalanceQuery?
    cryptogetAccountBalance,

    proto_crypto_get_account_records.HederaCryptoGetAccountRecordsQuery?
    cryptoGetAccountRecords,

    proto_crypto_get_info.HederaCryptoGetInfoQuery? cryptoGetInfo,

    proto_crypto_get_live_hash.HederaCryptoGetLiveHashQuery? cryptoGetLiveHash,

    proto_crypto_get_stakers.HederaCryptoGetStakersQuery? cryptoGetProxyStakers,

    proto_file_get_contents.HederaFileGetContentsQuery? fileGetContents,

    proto_file_get_info.HederaFileGetInfoQuery? fileGetInfo,

    proto_transaction_get_receipt.HederaTransactionGetReceiptQuery?
    transactionGetReceipt,

    proto_transaction_get_record.HederaTransactionGetRecordQuery?
    transactionGetRecord,

    proto_transaction_get_fast_record.HederaTransactionGetFastRecordQuery?
    transactionGetFastRecord,

    proto_consensus_get_topic_info.HederaConsensusGetTopicInfoQuery?
    consensusGetTopicInfo,

    proto_network_get_version_info.HederaNetworkGetVersionInfoQuery?
    networkGetVersionInfo,

    proto_token_get_info.HederaTokenGetInfoQuery? tokenGetInfo,

    proto_schedule_get_info.HederaScheduleGetInfoQuery? scheduleGetInfo,

    proto_token_get_account_nft_infos.HederaTokenGetAccountNftInfosQuery?
    tokenGetAccountNftInfos,

    proto_token_get_nft_info.HederaTokenGetNftInfoQuery? tokenGetNftInfo,

    proto_token_get_nft_infos.HederaTokenGetNftInfosQuery? tokenGetNftInfos,

    proto_network_get_execution_time.HederaNetworkGetExecutionTimeQuery?
    networkGetExecutionTime,

    proto_get_account_details.HederaGetAccountDetailsQuery? accountDetails,
  }) {
    return HederaQuery(
      getByKey: getByKey ?? this.getByKey,
      getBySolidityID: getBySolidityID ?? this.getBySolidityID,
      contractCallLocal: contractCallLocal ?? this.contractCallLocal,
      contractGetInfo: contractGetInfo ?? this.contractGetInfo,
      contractGetBytecode: contractGetBytecode ?? this.contractGetBytecode,
      contractGetRecords: contractGetRecords ?? this.contractGetRecords,
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
      'contractGetInfo': config.encodeMessage(contractGetInfo),
      'contractGetBytecode': config.encodeMessage(contractGetBytecode),
      'ContractGetRecords': config.encodeMessage(contractGetRecords),
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

  factory HederaQuery.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaQuery(
      getByKey: json.valueTo<proto_get_by_key.HederaGetByKeyQuery?, Object>(
        key: 'getByKey',
        parse:
            (v) => proto_get_by_key.HederaGetByKeyQuery.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      getBySolidityID: json.valueTo<
        proto_get_by_solidity_id.HederaGetBySolidityIDQuery?,
        Object
      >(
        key: 'getBySolidityID',
        parse:
            (v) => proto_get_by_solidity_id.HederaGetBySolidityIDQuery.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      contractCallLocal: json.valueTo<
        proto_contract_call_local.HederaContractCallLocalQuery?,
        Object
      >(
        key: 'contractCallLocal',
        parse:
            (v) =>
                proto_contract_call_local.HederaContractCallLocalQuery.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      contractGetInfo: json
          .valueTo<proto_contract_get_info.HederaContractGetInfoQuery?, Object>(
            key: 'contractGetInfo',
            parse:
                (v) =>
                    proto_contract_get_info.HederaContractGetInfoQuery.fromJson(
                      JsonParser.valueAs(v),
                      config: config,
                    ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      contractGetBytecode: json.valueTo<
        proto_contract_get_bytecode.HederaContractGetBytecodeQuery?,
        Object
      >(
        key: 'contractGetBytecode',
        parse:
            (v) => proto_contract_get_bytecode
                .HederaContractGetBytecodeQuery.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      contractGetRecords: json.valueTo<
        proto_contract_get_records.HederaContractGetRecordsQuery?,
        Object
      >(
        key: 'ContractGetRecords',
        parse:
            (v) => proto_contract_get_records
                .HederaContractGetRecordsQuery.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      cryptogetAccountBalance: json.valueTo<
        proto_crypto_get_account_balance.HederaCryptoGetAccountBalanceQuery?,
        Object
      >(
        key: 'cryptogetAccountBalance',
        parse:
            (v) => proto_crypto_get_account_balance
                .HederaCryptoGetAccountBalanceQuery.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      cryptoGetAccountRecords: json.valueTo<
        proto_crypto_get_account_records.HederaCryptoGetAccountRecordsQuery?,
        Object
      >(
        key: 'cryptoGetAccountRecords',
        parse:
            (v) => proto_crypto_get_account_records
                .HederaCryptoGetAccountRecordsQuery.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      cryptoGetInfo: json
          .valueTo<proto_crypto_get_info.HederaCryptoGetInfoQuery?, Object>(
            key: 'cryptoGetInfo',
            parse:
                (v) => proto_crypto_get_info.HederaCryptoGetInfoQuery.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      cryptoGetLiveHash: json.valueTo<
        proto_crypto_get_live_hash.HederaCryptoGetLiveHashQuery?,
        Object
      >(
        key: 'cryptoGetLiveHash',
        parse:
            (v) => proto_crypto_get_live_hash
                .HederaCryptoGetLiveHashQuery.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      cryptoGetProxyStakers: json.valueTo<
        proto_crypto_get_stakers.HederaCryptoGetStakersQuery?,
        Object
      >(
        key: 'cryptoGetProxyStakers',
        parse:
            (v) =>
                proto_crypto_get_stakers.HederaCryptoGetStakersQuery.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      fileGetContents: json
          .valueTo<proto_file_get_contents.HederaFileGetContentsQuery?, Object>(
            key: 'fileGetContents',
            parse:
                (v) =>
                    proto_file_get_contents.HederaFileGetContentsQuery.fromJson(
                      JsonParser.valueAs(v),
                      config: config,
                    ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      fileGetInfo: json
          .valueTo<proto_file_get_info.HederaFileGetInfoQuery?, Object>(
            key: 'fileGetInfo',
            parse:
                (v) => proto_file_get_info.HederaFileGetInfoQuery.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      transactionGetReceipt: json.valueTo<
        proto_transaction_get_receipt.HederaTransactionGetReceiptQuery?,
        Object
      >(
        key: 'transactionGetReceipt',
        parse:
            (v) => proto_transaction_get_receipt
                .HederaTransactionGetReceiptQuery.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      transactionGetRecord: json.valueTo<
        proto_transaction_get_record.HederaTransactionGetRecordQuery?,
        Object
      >(
        key: 'transactionGetRecord',
        parse:
            (v) => proto_transaction_get_record
                .HederaTransactionGetRecordQuery.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      transactionGetFastRecord: json.valueTo<
        proto_transaction_get_fast_record.HederaTransactionGetFastRecordQuery?,
        Object
      >(
        key: 'transactionGetFastRecord',
        parse:
            (v) => proto_transaction_get_fast_record
                .HederaTransactionGetFastRecordQuery.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      consensusGetTopicInfo: json.valueTo<
        proto_consensus_get_topic_info.HederaConsensusGetTopicInfoQuery?,
        Object
      >(
        key: 'consensusGetTopicInfo',
        parse:
            (v) => proto_consensus_get_topic_info
                .HederaConsensusGetTopicInfoQuery.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      networkGetVersionInfo: json.valueTo<
        proto_network_get_version_info.HederaNetworkGetVersionInfoQuery?,
        Object
      >(
        key: 'networkGetVersionInfo',
        parse:
            (v) => proto_network_get_version_info
                .HederaNetworkGetVersionInfoQuery.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      tokenGetInfo: json
          .valueTo<proto_token_get_info.HederaTokenGetInfoQuery?, Object>(
            key: 'tokenGetInfo',
            parse:
                (v) => proto_token_get_info.HederaTokenGetInfoQuery.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      scheduleGetInfo: json
          .valueTo<proto_schedule_get_info.HederaScheduleGetInfoQuery?, Object>(
            key: 'scheduleGetInfo',
            parse:
                (v) =>
                    proto_schedule_get_info.HederaScheduleGetInfoQuery.fromJson(
                      JsonParser.valueAs(v),
                      config: config,
                    ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      tokenGetAccountNftInfos: json.valueTo<
        proto_token_get_account_nft_infos.HederaTokenGetAccountNftInfosQuery?,
        Object
      >(
        key: 'tokenGetAccountNftInfos',
        parse:
            (v) => proto_token_get_account_nft_infos
                .HederaTokenGetAccountNftInfosQuery.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      tokenGetNftInfo: json.valueTo<
        proto_token_get_nft_info.HederaTokenGetNftInfoQuery?,
        Object
      >(
        key: 'tokenGetNftInfo',
        parse:
            (v) => proto_token_get_nft_info.HederaTokenGetNftInfoQuery.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      tokenGetNftInfos: json.valueTo<
        proto_token_get_nft_infos.HederaTokenGetNftInfosQuery?,
        Object
      >(
        key: 'tokenGetNftInfos',
        parse:
            (v) =>
                proto_token_get_nft_infos.HederaTokenGetNftInfosQuery.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      networkGetExecutionTime: json.valueTo<
        proto_network_get_execution_time.HederaNetworkGetExecutionTimeQuery?,
        Object
      >(
        key: 'networkGetExecutionTime',
        parse:
            (v) => proto_network_get_execution_time
                .HederaNetworkGetExecutionTimeQuery.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      accountDetails: json.valueTo<
        proto_get_account_details.HederaGetAccountDetailsQuery?,
        Object
      >(
        key: 'accountDetails',
        parse:
            (v) =>
                proto_get_account_details.HederaGetAccountDetailsQuery.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaQuery.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaQuery(
      getByKey: decode.messageTo<proto_get_by_key.HederaGetByKeyQuery?>(
        1,
        (b) => proto_get_by_key.HederaGetByKeyQuery.deserialize(b),
      ),
      getBySolidityID: decode
          .messageTo<proto_get_by_solidity_id.HederaGetBySolidityIDQuery?>(
            2,
            (b) => proto_get_by_solidity_id
                .HederaGetBySolidityIDQuery.deserialize(b),
          ),
      contractCallLocal: decode
          .messageTo<proto_contract_call_local.HederaContractCallLocalQuery?>(
            3,
            (b) => proto_contract_call_local
                .HederaContractCallLocalQuery.deserialize(b),
          ),
      contractGetInfo: decode
          .messageTo<proto_contract_get_info.HederaContractGetInfoQuery?>(
            4,
            (b) => proto_contract_get_info
                .HederaContractGetInfoQuery.deserialize(b),
          ),
      contractGetBytecode: decode.messageTo<
        proto_contract_get_bytecode.HederaContractGetBytecodeQuery?
      >(
        5,
        (b) => proto_contract_get_bytecode
            .HederaContractGetBytecodeQuery.deserialize(b),
      ),
      contractGetRecords: decode
          .messageTo<proto_contract_get_records.HederaContractGetRecordsQuery?>(
            6,
            (b) => proto_contract_get_records
                .HederaContractGetRecordsQuery.deserialize(b),
          ),
      cryptogetAccountBalance: decode.messageTo<
        proto_crypto_get_account_balance.HederaCryptoGetAccountBalanceQuery?
      >(
        7,
        (b) => proto_crypto_get_account_balance
            .HederaCryptoGetAccountBalanceQuery.deserialize(b),
      ),
      cryptoGetAccountRecords: decode.messageTo<
        proto_crypto_get_account_records.HederaCryptoGetAccountRecordsQuery?
      >(
        8,
        (b) => proto_crypto_get_account_records
            .HederaCryptoGetAccountRecordsQuery.deserialize(b),
      ),
      cryptoGetInfo: decode
          .messageTo<proto_crypto_get_info.HederaCryptoGetInfoQuery?>(
            9,
            (b) =>
                proto_crypto_get_info.HederaCryptoGetInfoQuery.deserialize(b),
          ),
      cryptoGetLiveHash: decode
          .messageTo<proto_crypto_get_live_hash.HederaCryptoGetLiveHashQuery?>(
            10,
            (b) => proto_crypto_get_live_hash
                .HederaCryptoGetLiveHashQuery.deserialize(b),
          ),
      cryptoGetProxyStakers: decode
          .messageTo<proto_crypto_get_stakers.HederaCryptoGetStakersQuery?>(
            11,
            (b) => proto_crypto_get_stakers
                .HederaCryptoGetStakersQuery.deserialize(b),
          ),
      fileGetContents: decode
          .messageTo<proto_file_get_contents.HederaFileGetContentsQuery?>(
            12,
            (b) => proto_file_get_contents
                .HederaFileGetContentsQuery.deserialize(b),
          ),
      fileGetInfo: decode
          .messageTo<proto_file_get_info.HederaFileGetInfoQuery?>(
            13,
            (b) => proto_file_get_info.HederaFileGetInfoQuery.deserialize(b),
          ),
      transactionGetReceipt: decode.messageTo<
        proto_transaction_get_receipt.HederaTransactionGetReceiptQuery?
      >(
        14,
        (b) => proto_transaction_get_receipt
            .HederaTransactionGetReceiptQuery.deserialize(b),
      ),
      transactionGetRecord: decode.messageTo<
        proto_transaction_get_record.HederaTransactionGetRecordQuery?
      >(
        15,
        (b) => proto_transaction_get_record
            .HederaTransactionGetRecordQuery.deserialize(b),
      ),
      transactionGetFastRecord: decode.messageTo<
        proto_transaction_get_fast_record.HederaTransactionGetFastRecordQuery?
      >(
        16,
        (b) => proto_transaction_get_fast_record
            .HederaTransactionGetFastRecordQuery.deserialize(b),
      ),
      consensusGetTopicInfo: decode.messageTo<
        proto_consensus_get_topic_info.HederaConsensusGetTopicInfoQuery?
      >(
        50,
        (b) => proto_consensus_get_topic_info
            .HederaConsensusGetTopicInfoQuery.deserialize(b),
      ),
      networkGetVersionInfo: decode.messageTo<
        proto_network_get_version_info.HederaNetworkGetVersionInfoQuery?
      >(
        51,
        (b) => proto_network_get_version_info
            .HederaNetworkGetVersionInfoQuery.deserialize(b),
      ),
      tokenGetInfo: decode
          .messageTo<proto_token_get_info.HederaTokenGetInfoQuery?>(
            52,
            (b) => proto_token_get_info.HederaTokenGetInfoQuery.deserialize(b),
          ),
      scheduleGetInfo: decode
          .messageTo<proto_schedule_get_info.HederaScheduleGetInfoQuery?>(
            53,
            (b) => proto_schedule_get_info
                .HederaScheduleGetInfoQuery.deserialize(b),
          ),
      tokenGetAccountNftInfos: decode.messageTo<
        proto_token_get_account_nft_infos.HederaTokenGetAccountNftInfosQuery?
      >(
        54,
        (b) => proto_token_get_account_nft_infos
            .HederaTokenGetAccountNftInfosQuery.deserialize(b),
      ),
      tokenGetNftInfo: decode
          .messageTo<proto_token_get_nft_info.HederaTokenGetNftInfoQuery?>(
            55,
            (b) => proto_token_get_nft_info
                .HederaTokenGetNftInfoQuery.deserialize(b),
          ),
      tokenGetNftInfos: decode
          .messageTo<proto_token_get_nft_infos.HederaTokenGetNftInfosQuery?>(
            56,
            (b) => proto_token_get_nft_infos
                .HederaTokenGetNftInfosQuery.deserialize(b),
          ),
      networkGetExecutionTime: decode.messageTo<
        proto_network_get_execution_time.HederaNetworkGetExecutionTimeQuery?
      >(
        57,
        (b) => proto_network_get_execution_time
            .HederaNetworkGetExecutionTimeQuery.deserialize(b),
      ),
      accountDetails: decode
          .messageTo<proto_get_account_details.HederaGetAccountDetailsQuery?>(
            58,
            (b) => proto_get_account_details
                .HederaGetAccountDetailsQuery.deserialize(b),
          ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoQuery;
}

class HederaServiceFileServiceGetFileContent extends HederaProtoMessage
    with Equality, IHederaServiceMessage<proto_response.HederaResponse> {
  /// *
  ///      * Retrieve the content of a file in HFS.&lt;br/&gt;
  ///      * Note that this query retrieves _only_ the file content, not any of
  ///      * the metadata for the file.
  final HederaQuery? getFileContent;

  const HederaServiceFileServiceGetFileContent({this.getFileContent});

  HederaServiceFileServiceGetFileContent copyWith({
    HederaQuery? getFileContent,
  }) {
    return HederaServiceFileServiceGetFileContent(
      getFileContent: getFileContent ?? this.getFileContent,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      getFileContent?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getFileContent?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'getFileContent': config.encodeMessage(getFileContent)};
  }

  factory HederaServiceFileServiceGetFileContent.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceFileServiceGetFileContent(
      getFileContent: json.valueTo<HederaQuery?, Object>(
        key: 'getFileContent',
        parse:
            (v) => HederaQuery.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceFileServiceGetFileContent;
  @override
  proto_response.HederaResponse onServiceResponse(List<int> bytes) {
    return proto_response.HederaResponse.deserialize(bytes);
  }
}

class HederaServiceFileServiceGetFileInfo extends HederaProtoMessage
    with Equality, IHederaServiceMessage<proto_response.HederaResponse> {
  /// *
  ///      * Retrieve the metadata for a file in HFS.&lt;br/&gt;
  ///      * Note that this query does not retrieve the file _content_.
  final HederaQuery? getFileInfo;

  const HederaServiceFileServiceGetFileInfo({this.getFileInfo});

  HederaServiceFileServiceGetFileInfo copyWith({HederaQuery? getFileInfo}) {
    return HederaServiceFileServiceGetFileInfo(
      getFileInfo: getFileInfo ?? this.getFileInfo,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      getFileInfo?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getFileInfo?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'getFileInfo': config.encodeMessage(getFileInfo)};
  }

  factory HederaServiceFileServiceGetFileInfo.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceFileServiceGetFileInfo(
      getFileInfo: json.valueTo<HederaQuery?, Object>(
        key: 'getFileInfo',
        parse:
            (v) => HederaQuery.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceFileServiceGetFileInfo;
  @override
  proto_response.HederaResponse onServiceResponse(List<int> bytes) {
    return proto_response.HederaResponse.deserialize(bytes);
  }
}

class HederaServiceConsensusServiceGetTopicInfo extends HederaProtoMessage
    with Equality, IHederaServiceMessage<proto_response.HederaResponse> {
  /// *
  ///      * Retrieve the latest state of a topic. This method is unrestricted and
  ///      * allowed on any topic by any payer account.
  ///      * &lt;p&gt;
  ///      * The request body MUST be a
  ///      * [ConsensusGetTopicInfoQuery](#proto.ConsensusGetTopicInfoQuery)&lt;br/&gt;
  ///      * The response body SHALL be a
  ///      * [ConsensusGetTopicInfoResponse](#proto.ConsensusGetTopicInfoResponse)
  final HederaQuery? getTopicInfo;

  const HederaServiceConsensusServiceGetTopicInfo({this.getTopicInfo});

  HederaServiceConsensusServiceGetTopicInfo copyWith({
    HederaQuery? getTopicInfo,
  }) {
    return HederaServiceConsensusServiceGetTopicInfo(
      getTopicInfo: getTopicInfo ?? this.getTopicInfo,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      getTopicInfo?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getTopicInfo?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'getTopicInfo': config.encodeMessage(getTopicInfo)};
  }

  factory HederaServiceConsensusServiceGetTopicInfo.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceConsensusServiceGetTopicInfo(
      getTopicInfo: json.valueTo<HederaQuery?, Object>(
        key: 'getTopicInfo',
        parse:
            (v) => HederaQuery.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceConsensusServiceGetTopicInfo;
  @override
  proto_response.HederaResponse onServiceResponse(List<int> bytes) {
    return proto_response.HederaResponse.deserialize(bytes);
  }
}

class HederaServiceNetworkServiceGetVersionInfo extends HederaProtoMessage
    with Equality, IHederaServiceMessage<proto_response.HederaResponse> {
  /// *
  ///      * Retrieve the active versions of Hedera Services and API messages.
  final HederaQuery? getVersionInfo;

  const HederaServiceNetworkServiceGetVersionInfo({this.getVersionInfo});

  HederaServiceNetworkServiceGetVersionInfo copyWith({
    HederaQuery? getVersionInfo,
  }) {
    return HederaServiceNetworkServiceGetVersionInfo(
      getVersionInfo: getVersionInfo ?? this.getVersionInfo,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      getVersionInfo?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getVersionInfo?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'getVersionInfo': config.encodeMessage(getVersionInfo)};
  }

  factory HederaServiceNetworkServiceGetVersionInfo.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceNetworkServiceGetVersionInfo(
      getVersionInfo: json.valueTo<HederaQuery?, Object>(
        key: 'getVersionInfo',
        parse:
            (v) => HederaQuery.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceNetworkServiceGetVersionInfo;
  @override
  proto_response.HederaResponse onServiceResponse(List<int> bytes) {
    return proto_response.HederaResponse.deserialize(bytes);
  }
}

class HederaServiceNetworkServiceGetAccountDetails extends HederaProtoMessage
    with Equality, IHederaServiceMessage<proto_response.HederaResponse> {
  /// *
  ///      * Request detail information about an account.
  ///      * &lt;p&gt;
  ///      * The returned information SHALL include balance and allowances.&lt;br/&gt;
  ///      * The returned information SHALL NOT include a list of account records.
  final HederaQuery? getAccountDetails;

  const HederaServiceNetworkServiceGetAccountDetails({this.getAccountDetails});

  HederaServiceNetworkServiceGetAccountDetails copyWith({
    HederaQuery? getAccountDetails,
  }) {
    return HederaServiceNetworkServiceGetAccountDetails(
      getAccountDetails: getAccountDetails ?? this.getAccountDetails,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      getAccountDetails?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getAccountDetails?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'getAccountDetails': config.encodeMessage(getAccountDetails)};
  }

  factory HederaServiceNetworkServiceGetAccountDetails.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceNetworkServiceGetAccountDetails(
      getAccountDetails: json.valueTo<HederaQuery?, Object>(
        key: 'getAccountDetails',
        parse:
            (v) => HederaQuery.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceNetworkServiceGetAccountDetails;
  @override
  proto_response.HederaResponse onServiceResponse(List<int> bytes) {
    return proto_response.HederaResponse.deserialize(bytes);
  }
}

class HederaServiceNetworkServiceGetExecutionTime extends HederaProtoMessage
    with Equality, IHederaServiceMessage<proto_response.HederaResponse> {
  /// *
  ///      * Retrieve the time, in nanoseconds, spent in direct processing for one or
  ///      * more recent transactions.
  ///      * &lt;p&gt;
  ///      * For each transaction identifier provided, if that transaction is
  ///      * sufficiently recent (that is, it is within the range of the
  ///      * configuration value `stats.executionTimesToTrack`), the node SHALL
  ///      * return the time, in nanoseconds, spent to directly process that
  ///      * transaction (that is, excluding time to reach consensus).&lt;br/&gt;
  ///      * Note that because each node processes every transaction for the Hedera
  ///      * network, this query MAY be sent to any node.
  ///      * &lt;p&gt;
  ///      * &lt;blockquote&gt;Important&lt;blockquote&gt;
  ///      * This query is obsolete, not supported, and SHALL fail with a pre-check
  ///      * result of `NOT_SUPPORTED`.&lt;/blockquote&gt;&lt;/blockquote&gt;
  final HederaQuery? getExecutionTime;

  const HederaServiceNetworkServiceGetExecutionTime({this.getExecutionTime});

  HederaServiceNetworkServiceGetExecutionTime copyWith({
    HederaQuery? getExecutionTime,
  }) {
    return HederaServiceNetworkServiceGetExecutionTime(
      getExecutionTime: getExecutionTime ?? this.getExecutionTime,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      getExecutionTime?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getExecutionTime?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'getExecutionTime': config.encodeMessage(getExecutionTime)};
  }

  factory HederaServiceNetworkServiceGetExecutionTime.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceNetworkServiceGetExecutionTime(
      getExecutionTime: json.valueTo<HederaQuery?, Object>(
        key: 'getExecutionTime',
        parse:
            (v) => HederaQuery.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceNetworkServiceGetExecutionTime;
  @override
  proto_response.HederaResponse onServiceResponse(List<int> bytes) {
    return proto_response.HederaResponse.deserialize(bytes);
  }
}

class HederaServiceTokenServiceGetTokenInfo extends HederaProtoMessage
    with Equality, IHederaServiceMessage<proto_response.HederaResponse> {
  /// *
  ///      * Retrieve the detail characteristics for a token.
  ///      * &lt;p&gt;
  ///      * This query SHALL return information for the token type as a whole.&lt;br/&gt;
  ///      * This query SHALL NOT return information for individual tokens.
  final HederaQuery? getTokenInfo;

  const HederaServiceTokenServiceGetTokenInfo({this.getTokenInfo});

  HederaServiceTokenServiceGetTokenInfo copyWith({HederaQuery? getTokenInfo}) {
    return HederaServiceTokenServiceGetTokenInfo(
      getTokenInfo: getTokenInfo ?? this.getTokenInfo,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      getTokenInfo?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getTokenInfo?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'getTokenInfo': config.encodeMessage(getTokenInfo)};
  }

  factory HederaServiceTokenServiceGetTokenInfo.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceTokenServiceGetTokenInfo(
      getTokenInfo: json.valueTo<HederaQuery?, Object>(
        key: 'getTokenInfo',
        parse:
            (v) => HederaQuery.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceTokenServiceGetTokenInfo;
  @override
  proto_response.HederaResponse onServiceResponse(List<int> bytes) {
    return proto_response.HederaResponse.deserialize(bytes);
  }
}

class HederaServiceTokenServiceGetTokenNftInfo extends HederaProtoMessage
    with Equality, IHederaServiceMessage<proto_response.HederaResponse> {
  /// *
  ///      * Retrieve the metadata for a specific non-fungible/unique token.&lt;br/&gt;
  ///      * The NFT to query is identified by token identifier and serial number.
  ///      * &lt;p&gt;
  ///      * This query SHALL return token metadata and, if an allowance is defined,
  ///      * the designated "spender" account for the queried NFT.
  final HederaQuery? getTokenNftInfo;

  const HederaServiceTokenServiceGetTokenNftInfo({this.getTokenNftInfo});

  HederaServiceTokenServiceGetTokenNftInfo copyWith({
    HederaQuery? getTokenNftInfo,
  }) {
    return HederaServiceTokenServiceGetTokenNftInfo(
      getTokenNftInfo: getTokenNftInfo ?? this.getTokenNftInfo,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      getTokenNftInfo?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getTokenNftInfo?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'getTokenNftInfo': config.encodeMessage(getTokenNftInfo)};
  }

  factory HederaServiceTokenServiceGetTokenNftInfo.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceTokenServiceGetTokenNftInfo(
      getTokenNftInfo: json.valueTo<HederaQuery?, Object>(
        key: 'getTokenNftInfo',
        parse:
            (v) => HederaQuery.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceTokenServiceGetTokenNftInfo;
  @override
  proto_response.HederaResponse onServiceResponse(List<int> bytes) {
    return proto_response.HederaResponse.deserialize(bytes);
  }
}

class HederaServiceScheduleServiceGetScheduleInfo extends HederaProtoMessage
    with Equality, IHederaServiceMessage<proto_response.HederaResponse> {
  /// *
  ///    * Retrieve the metadata for a schedule.
  final HederaQuery? getScheduleInfo;

  const HederaServiceScheduleServiceGetScheduleInfo({this.getScheduleInfo});

  HederaServiceScheduleServiceGetScheduleInfo copyWith({
    HederaQuery? getScheduleInfo,
  }) {
    return HederaServiceScheduleServiceGetScheduleInfo(
      getScheduleInfo: getScheduleInfo ?? this.getScheduleInfo,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      getScheduleInfo?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getScheduleInfo?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'getScheduleInfo': config.encodeMessage(getScheduleInfo)};
  }

  factory HederaServiceScheduleServiceGetScheduleInfo.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceScheduleServiceGetScheduleInfo(
      getScheduleInfo: json.valueTo<HederaQuery?, Object>(
        key: 'getScheduleInfo',
        parse:
            (v) => HederaQuery.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceScheduleServiceGetScheduleInfo;
  @override
  proto_response.HederaResponse onServiceResponse(List<int> bytes) {
    return proto_response.HederaResponse.deserialize(bytes);
  }
}

class HederaServiceSmartContractServiceContractCallLocalMethod
    extends HederaProtoMessage
    with Equality, IHederaServiceMessage<proto_response.HederaResponse> {
  /// *
  ///      * Call a query function of a given smart contract, providing
  ///      * function parameter inputs as needed.&lt;br/&gt;
  ///      * This is performed locally on the particular node that the client is
  ///      * communicating with. Executing the call locally is faster and less
  ///      * costly, but imposes certain restrictions.
  ///      * &lt;p&gt;
  ///      * The call MUST NOT change the state of the contract instance. This also
  ///      * precludes any expenditure or transfer of HBAR or other tokens.&lt;br/&gt;
  ///      * The call SHALL NOT have a separate consensus timestamp.&lt;br/&gt;
  ///      * The call SHALL NOT generate a record nor a receipt.&lt;br/&gt;
  ///      * The response SHALL contain the output returned by the function call.&lt;br/&gt;
  ///      * &lt;p&gt;
  ///      * This is generally useful for calling accessor functions which read
  ///      * (query) state without changes or side effects. Any contract call that
  ///      * would use the `STATICCALL` opcode MAY be called via contract call local
  ///      * with performance and cost benefits.
  ///      * &lt;p&gt;
  ///      * Unlike a ContractCall transaction, the node SHALL always consume the
  ///      * _entire_ amount of offered "gas" in determining the fee for this query,
  ///      * so accurate gas estimation is important.
  final HederaQuery? contractCallLocalMethod;

  const HederaServiceSmartContractServiceContractCallLocalMethod({
    this.contractCallLocalMethod,
  });

  HederaServiceSmartContractServiceContractCallLocalMethod copyWith({
    HederaQuery? contractCallLocalMethod,
  }) {
    return HederaServiceSmartContractServiceContractCallLocalMethod(
      contractCallLocalMethod:
          contractCallLocalMethod ?? this.contractCallLocalMethod,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      contractCallLocalMethod?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => contractCallLocalMethod?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'contractCallLocalMethod': config.encodeMessage(contractCallLocalMethod),
    };
  }

  factory HederaServiceSmartContractServiceContractCallLocalMethod.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceSmartContractServiceContractCallLocalMethod(
      contractCallLocalMethod: json.valueTo<HederaQuery?, Object>(
        key: 'contractCallLocalMethod',
        parse:
            (v) => HederaQuery.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl
          .protoServiceSmartContractServiceContractCallLocalMethod;
  @override
  proto_response.HederaResponse onServiceResponse(List<int> bytes) {
    return proto_response.HederaResponse.deserialize(bytes);
  }
}

class HederaServiceSmartContractServiceGetContractInfo
    extends HederaProtoMessage
    with Equality, IHederaServiceMessage<proto_response.HederaResponse> {
  /// *
  ///      * A standard query to obtain detailed information for a smart contract.
  final HederaQuery? getContractInfo;

  const HederaServiceSmartContractServiceGetContractInfo({
    this.getContractInfo,
  });

  HederaServiceSmartContractServiceGetContractInfo copyWith({
    HederaQuery? getContractInfo,
  }) {
    return HederaServiceSmartContractServiceGetContractInfo(
      getContractInfo: getContractInfo ?? this.getContractInfo,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      getContractInfo?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getContractInfo?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'getContractInfo': config.encodeMessage(getContractInfo)};
  }

  factory HederaServiceSmartContractServiceGetContractInfo.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceSmartContractServiceGetContractInfo(
      getContractInfo: json.valueTo<HederaQuery?, Object>(
        key: 'getContractInfo',
        parse:
            (v) => HederaQuery.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceSmartContractServiceGetContractInfo;
  @override
  proto_response.HederaResponse onServiceResponse(List<int> bytes) {
    return proto_response.HederaResponse.deserialize(bytes);
  }
}

class HederaServiceSmartContractServiceContractGetBytecode
    extends HederaProtoMessage
    with Equality, IHederaServiceMessage<proto_response.HederaResponse> {
  /// *
  ///      * A standard query to read the current bytecode for a smart contract.
  final HederaQuery? contractGetBytecode;

  const HederaServiceSmartContractServiceContractGetBytecode({
    this.contractGetBytecode,
  });

  HederaServiceSmartContractServiceContractGetBytecode copyWith({
    HederaQuery? contractGetBytecode,
  }) {
    return HederaServiceSmartContractServiceContractGetBytecode(
      contractGetBytecode: contractGetBytecode ?? this.contractGetBytecode,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      contractGetBytecode?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => contractGetBytecode?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'ContractGetBytecode': config.encodeMessage(contractGetBytecode)};
  }

  factory HederaServiceSmartContractServiceContractGetBytecode.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceSmartContractServiceContractGetBytecode(
      contractGetBytecode: json.valueTo<HederaQuery?, Object>(
        key: 'ContractGetBytecode',
        parse:
            (v) => HederaQuery.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl
          .protoServiceSmartContractServiceContractGetBytecode;
  @override
  proto_response.HederaResponse onServiceResponse(List<int> bytes) {
    return proto_response.HederaResponse.deserialize(bytes);
  }
}

class HederaServiceSmartContractServiceGetBySolidityID
    extends HederaProtoMessage
    with Equality, IHederaServiceMessage<proto_response.HederaResponse> {
  /// *
  ///      * A standard query to obtain account and contract identifiers for a smart
  ///      * contract, given the Solidity identifier for that contract.
  final HederaQuery? getBySolidityID;

  const HederaServiceSmartContractServiceGetBySolidityID({
    this.getBySolidityID,
  });

  HederaServiceSmartContractServiceGetBySolidityID copyWith({
    HederaQuery? getBySolidityID,
  }) {
    return HederaServiceSmartContractServiceGetBySolidityID(
      getBySolidityID: getBySolidityID ?? this.getBySolidityID,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      getBySolidityID?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getBySolidityID?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'getBySolidityID': config.encodeMessage(getBySolidityID)};
  }

  factory HederaServiceSmartContractServiceGetBySolidityID.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceSmartContractServiceGetBySolidityID(
      getBySolidityID: json.valueTo<HederaQuery?, Object>(
        key: 'getBySolidityID',
        parse:
            (v) => HederaQuery.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceSmartContractServiceGetBySolidityID;
  @override
  proto_response.HederaResponse onServiceResponse(List<int> bytes) {
    return proto_response.HederaResponse.deserialize(bytes);
  }
}

class HederaServiceSmartContractServiceGetTxRecordByContractID
    extends HederaProtoMessage
    with Equality, IHederaServiceMessage<proto_response.HederaResponse> {
  /// *
  ///      * &lt;blockquote&gt;This query is no longer supported.&lt;/blockquote&gt;
  ///      * This query always returned an empty record list.
  final HederaQuery? getTxRecordByContractID;

  const HederaServiceSmartContractServiceGetTxRecordByContractID({
    this.getTxRecordByContractID,
  });

  HederaServiceSmartContractServiceGetTxRecordByContractID copyWith({
    HederaQuery? getTxRecordByContractID,
  }) {
    return HederaServiceSmartContractServiceGetTxRecordByContractID(
      getTxRecordByContractID:
          getTxRecordByContractID ?? this.getTxRecordByContractID,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      getTxRecordByContractID?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getTxRecordByContractID?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'getTxRecordByContractID': config.encodeMessage(getTxRecordByContractID),
    };
  }

  factory HederaServiceSmartContractServiceGetTxRecordByContractID.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceSmartContractServiceGetTxRecordByContractID(
      getTxRecordByContractID: json.valueTo<HederaQuery?, Object>(
        key: 'getTxRecordByContractID',
        parse:
            (v) => HederaQuery.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl
          .protoServiceSmartContractServiceGetTxRecordByContractID;
  @override
  proto_response.HederaResponse onServiceResponse(List<int> bytes) {
    return proto_response.HederaResponse.deserialize(bytes);
  }
}

class HederaServiceCryptoServiceGetLiveHash extends HederaProtoMessage
    with Equality, IHederaServiceMessage<proto_response.HederaResponse> {
  /// *
  ///      * Retrieve a livehash for an account
  ///      * &lt;blockquote&gt;Important&lt;blockquote&gt;
  ///      * This query is obsolete, not supported, and SHALL fail with a pre-check
  ///      * result of `NOT_SUPPORTED`.&lt;/blockquote&gt;&lt;/blockquote&gt;
  final HederaQuery? getLiveHash;

  const HederaServiceCryptoServiceGetLiveHash({this.getLiveHash});

  HederaServiceCryptoServiceGetLiveHash copyWith({HederaQuery? getLiveHash}) {
    return HederaServiceCryptoServiceGetLiveHash(
      getLiveHash: getLiveHash ?? this.getLiveHash,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      getLiveHash?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getLiveHash?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'getLiveHash': config.encodeMessage(getLiveHash)};
  }

  factory HederaServiceCryptoServiceGetLiveHash.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceCryptoServiceGetLiveHash(
      getLiveHash: json.valueTo<HederaQuery?, Object>(
        key: 'getLiveHash',
        parse:
            (v) => HederaQuery.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceCryptoServiceGetLiveHash;
  @override
  proto_response.HederaResponse onServiceResponse(List<int> bytes) {
    return proto_response.HederaResponse.deserialize(bytes);
  }
}

class HederaServiceCryptoServiceGetAccountRecords extends HederaProtoMessage
    with Equality, IHederaServiceMessage<proto_response.HederaResponse> {
  /// *
  ///      * Return all transactions in the last 180s of consensus time for which
  ///      * the given account was the effective payer **and** network property
  ///      * `ledger.keepRecordsInState` was `true`.
  final HederaQuery? getAccountRecords;

  const HederaServiceCryptoServiceGetAccountRecords({this.getAccountRecords});

  HederaServiceCryptoServiceGetAccountRecords copyWith({
    HederaQuery? getAccountRecords,
  }) {
    return HederaServiceCryptoServiceGetAccountRecords(
      getAccountRecords: getAccountRecords ?? this.getAccountRecords,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      getAccountRecords?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getAccountRecords?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'getAccountRecords': config.encodeMessage(getAccountRecords)};
  }

  factory HederaServiceCryptoServiceGetAccountRecords.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceCryptoServiceGetAccountRecords(
      getAccountRecords: json.valueTo<HederaQuery?, Object>(
        key: 'getAccountRecords',
        parse:
            (v) => HederaQuery.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceCryptoServiceGetAccountRecords;
  @override
  proto_response.HederaResponse onServiceResponse(List<int> bytes) {
    return proto_response.HederaResponse.deserialize(bytes);
  }
}

class HederaServiceCryptoServiceCryptoGetBalance extends HederaProtoMessage
    with Equality, IHederaServiceMessage<proto_response.HederaResponse> {
  /// *
  ///      * Retrieve the balance of an account
  final HederaQuery? cryptoGetBalance;

  const HederaServiceCryptoServiceCryptoGetBalance({this.cryptoGetBalance});

  HederaServiceCryptoServiceCryptoGetBalance copyWith({
    HederaQuery? cryptoGetBalance,
  }) {
    return HederaServiceCryptoServiceCryptoGetBalance(
      cryptoGetBalance: cryptoGetBalance ?? this.cryptoGetBalance,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      cryptoGetBalance?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => cryptoGetBalance?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'cryptoGetBalance': config.encodeMessage(cryptoGetBalance)};
  }

  factory HederaServiceCryptoServiceCryptoGetBalance.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceCryptoServiceCryptoGetBalance(
      cryptoGetBalance: json.valueTo<HederaQuery?, Object>(
        key: 'cryptoGetBalance',
        parse:
            (v) => HederaQuery.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceCryptoServiceCryptoGetBalance;
  @override
  proto_response.HederaResponse onServiceResponse(List<int> bytes) {
    return proto_response.HederaResponse.deserialize(bytes);
  }
}

class HederaServiceCryptoServiceGetAccountInfo extends HederaProtoMessage
    with Equality, IHederaServiceMessage<proto_response.HederaResponse> {
  /// *
  ///      * Retrieve the metadata of an account
  final HederaQuery? getAccountInfo;

  const HederaServiceCryptoServiceGetAccountInfo({this.getAccountInfo});

  HederaServiceCryptoServiceGetAccountInfo copyWith({
    HederaQuery? getAccountInfo,
  }) {
    return HederaServiceCryptoServiceGetAccountInfo(
      getAccountInfo: getAccountInfo ?? this.getAccountInfo,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      getAccountInfo?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getAccountInfo?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'getAccountInfo': config.encodeMessage(getAccountInfo)};
  }

  factory HederaServiceCryptoServiceGetAccountInfo.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceCryptoServiceGetAccountInfo(
      getAccountInfo: json.valueTo<HederaQuery?, Object>(
        key: 'getAccountInfo',
        parse:
            (v) => HederaQuery.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceCryptoServiceGetAccountInfo;
  @override
  proto_response.HederaResponse onServiceResponse(List<int> bytes) {
    return proto_response.HederaResponse.deserialize(bytes);
  }
}

class HederaServiceCryptoServiceGetTransactionReceipts
    extends HederaProtoMessage
    with Equality, IHederaServiceMessage<proto_response.HederaResponse> {
  /// *
  ///      * Retrieve the latest receipt for a transaction that is either awaiting
  ///      * consensus, or reached consensus in the last 180 seconds
  final HederaQuery? getTransactionReceipts;

  const HederaServiceCryptoServiceGetTransactionReceipts({
    this.getTransactionReceipts,
  });

  HederaServiceCryptoServiceGetTransactionReceipts copyWith({
    HederaQuery? getTransactionReceipts,
  }) {
    return HederaServiceCryptoServiceGetTransactionReceipts(
      getTransactionReceipts:
          getTransactionReceipts ?? this.getTransactionReceipts,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      getTransactionReceipts?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getTransactionReceipts?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'getTransactionReceipts': config.encodeMessage(getTransactionReceipts),
    };
  }

  factory HederaServiceCryptoServiceGetTransactionReceipts.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceCryptoServiceGetTransactionReceipts(
      getTransactionReceipts: json.valueTo<HederaQuery?, Object>(
        key: 'getTransactionReceipts',
        parse:
            (v) => HederaQuery.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceCryptoServiceGetTransactionReceipts;
  @override
  proto_response.HederaResponse onServiceResponse(List<int> bytes) {
    return proto_response.HederaResponse.deserialize(bytes);
  }
}

class HederaServiceCryptoServiceGetTxRecordByTxID extends HederaProtoMessage
    with Equality, IHederaServiceMessage<proto_response.HederaResponse> {
  /// *
  ///      * Retrieve the record of a transaction that is either awaiting consensus,
  ///      * or reached consensus in the last 180 seconds
  final HederaQuery? getTxRecordByTxID;

  const HederaServiceCryptoServiceGetTxRecordByTxID({this.getTxRecordByTxID});

  HederaServiceCryptoServiceGetTxRecordByTxID copyWith({
    HederaQuery? getTxRecordByTxID,
  }) {
    return HederaServiceCryptoServiceGetTxRecordByTxID(
      getTxRecordByTxID: getTxRecordByTxID ?? this.getTxRecordByTxID,
    );
  }

  @override
  ProtoMessageConfig protoConfig() =>
      getTxRecordByTxID?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getTxRecordByTxID?.protoValues ?? [];
  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'getTxRecordByTxID': config.encodeMessage(getTxRecordByTxID)};
  }

  factory HederaServiceCryptoServiceGetTxRecordByTxID.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaServiceCryptoServiceGetTxRecordByTxID(
      getTxRecordByTxID: json.valueTo<HederaQuery?, Object>(
        key: 'getTxRecordByTxID',
        parse:
            (v) => HederaQuery.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoServiceCryptoServiceGetTxRecordByTxID;
  @override
  proto_response.HederaResponse onServiceResponse(List<int> bytes) {
    return proto_response.HederaResponse.deserialize(bytes);
  }
}
