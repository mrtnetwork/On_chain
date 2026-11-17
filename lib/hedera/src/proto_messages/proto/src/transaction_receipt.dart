import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/response_code.dart"
    as proto_response_code;
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;
import "package:on_chain/hedera/src/proto_messages/proto/src/exchange_rate.dart"
    as proto_exchange_rate;
import "package:on_chain/hedera/src/proto_messages/google/protobuf/src/wrappers.dart"
    as google_protobuf_wrappers;

/// *
///  * # Transaction Receipt
///  * The receipt returned when the results of a transaction are requested via
///  * `TransactionGetReceiptQuery`.
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
///  * The summary of a transaction's result so far.&lt;br/&gt;
///  * If the transaction has not reached consensus, this result will
///  * be necessarily incomplete.
///  *
///  * Most items in this object are only set for specific transactions.
///  * Those values SHALL be unset for all other transactions.
class HederaTransactionReceipt extends HederaProtoMessage with Equality {
  /// *
  ///      * The consensus status of the transaction.
  ///      * &lt;p&gt;
  ///      * This SHALL be `UNKNOWN` if consensus has not been reached.&lt;br/&gt;
  ///      * This SHALL be `UNKNOWN` if the associated transaction did not have
  ///      * a valid payer signature.
  final proto_response_code.HederaResponseCodeEnum? status;

  /// *
  ///      * In the receipt of a `CryptoCreate`, the id of the newly created account.
  final proto_basic_types.HederaAccountID? accountID;

  /// *
  ///      * In the receipt of a `FileCreate`, the id of the newly created file.
  final proto_basic_types.HederaFileID? fileID;

  /// *
  ///      * In the receipt of a `ContractCreate`, the id of the newly created
  ///      * contract.
  final proto_basic_types.HederaContractID? contractID;

  /// *
  ///      * The exchange rates in effect when the transaction reached consensus.
  final proto_exchange_rate.HederaExchangeRateSet? exchangeRate;

  /// *
  ///      * In the receipt of a `ConsensusCreateTopic`, the id of the newly
  ///      * created topic.
  final proto_basic_types.HederaTopicID? topicID;

  /// *
  ///      * In the receipt of a `ConsensusSubmitMessage`, the new sequence
  ///      * number for the topic that received the message.
  final BigInt? topicSequenceNumber;

  /// *
  ///      * In the receipt of a `ConsensusSubmitMessage`, the new running hash of
  ///      * the topic that received the message.&lt;br/&gt;
  ///      * &lt;p&gt;
  ///      * The inputs to the topic running hash have changed over time.&lt;br/&gt;
  ///      * This 48-byte field is the output of a SHA-384 digest with input data
  ///      * determined by the value of the `topicRunningHashVersion` field.&lt;br/&gt;
  ///      * All new transactions SHALL use `topicRunningHashVersion` `3`.&lt;br/&gt;
  ///      * The bytes of each uint64 or uint32 encoded for the hash input MUST be
  ///      * in Big-Endian format.
  ///      * &lt;p&gt;
  ///      * &lt;hr style="margin: 0.2em 5em 0.2em 5em; height: 0.5em; border-style: solid none solid none; border-width: 2px;"/&gt;
  ///      * &lt;p&gt;
  ///      * The most recent version is denoted by `topicRunningHashVersion = 3`.
  ///      * &lt;p&gt;
  ///      * This version SHALL include, in order
  ///      * &lt;ol&gt;
  ///      *  &lt;li&gt;The previous running hash of the topic (48 bytes)&lt;/li&gt;
  ///      *  &lt;li&gt;The `topic_running_hash_version` field (8 bytes)&lt;/li&gt;
  ///      *  &lt;li&gt;The payer account's shard (8 bytes)&lt;/li&gt;
  ///      *  &lt;li&gt;The payer account's realm (8 bytes)&lt;/li&gt;
  ///      *  &lt;li&gt;The payer account's number (8 bytes)&lt;/li&gt;
  ///      *  &lt;li&gt;The topic's shard (8 bytes)&lt;/li&gt;
  ///      *  &lt;li&gt;The topic's realm (8 bytes)&lt;/li&gt;
  ///      *  &lt;li&gt;The topic's number (8 bytes)&lt;/li&gt;
  ///      *  &lt;li&gt;The number of seconds since the epoch when the
  ///      *      `ConsensusSubmitMessage` reached consensus (8 bytes)&lt;/li&gt;
  ///      *  &lt;li&gt;The number of nanoseconds within the second when the
  ///      *      `ConsensusSubmitMessage` reached consensus (4 bytes)&lt;/li&gt;
  ///      *  &lt;li&gt;The `topic_sequence_number` field (8 bytes)&lt;/li&gt;
  ///      *  &lt;li&gt;The output of a SHA-384 digest of the message bytes from the
  ///      *      `ConsensusSubmitMessage` (48 bytes)&lt;/li&gt;
  ///      * &lt;/ol&gt;
  ///      * &lt;hr style="margin: 0.2em 5em 0.2em 5em; height: 0.5em; border-style: solid none solid none; border-width: 2px;"/&gt;
  ///      * &lt;p&gt;
  ///      * The next older version is denoted by `topicRunningHashVersion = 2`.
  ///      * &lt;p&gt;
  ///      * This version SHALL include, in order
  ///      * &lt;ol&gt;
  ///      *  &lt;li&gt;The previous running hash of the topic (48 bytes)&lt;/li&gt;
  ///      *  &lt;li&gt;The `topic_running_hash_version` field (8 bytes)&lt;/li&gt;
  ///      *  &lt;li&gt;The topic's shard (8 bytes)&lt;/li&gt;
  ///      *  &lt;li&gt;The topic's realm (8 bytes)&lt;/li&gt;
  ///      *  &lt;li&gt;The topic's number (8 bytes)&lt;/li&gt;
  ///      *  &lt;li&gt;The number of seconds since the epoch when the
  ///      *      `ConsensusSubmitMessage` reached consensus (8 bytes)&lt;/li&gt;
  ///      *  &lt;li&gt;The number of nanoseconds within the second when the
  ///      *      `ConsensusSubmitMessage` reached consensus (4 bytes)&lt;/li&gt;
  ///      *  &lt;li&gt;The `topic_sequence_number` field (8 bytes)&lt;/li&gt;
  ///      *  &lt;li&gt;The output of a SHA-384 digest of the message bytes from the
  ///      *      `ConsensusSubmitMessage` (48 bytes)&lt;/li&gt;
  ///      * &lt;/ol&gt;
  ///      * &lt;hr style="margin: 0.2em 5em 0.2em 5em; height: 0.5em; border-style: solid none solid none; border-width: 2px;"/&gt;
  ///      * &lt;p&gt;
  ///      * The original version, used at genesis, is denoted
  ///      * by `topicRunningHashVersion = 1` or `topicRunningHashVersion = 0`.
  ///      * &lt;p&gt;
  ///      * This version SHALL include, in order
  ///      * &lt;ol&gt;
  ///      *  &lt;li&gt;The previous running hash of the topic (48 bytes)&lt;/li&gt;
  ///      *  &lt;li&gt;The topic's shard (8 bytes)&lt;/li&gt;
  ///      *  &lt;li&gt;The topic's realm (8 bytes)&lt;/li&gt;
  ///      *  &lt;li&gt;The topic's number (8 bytes)&lt;/li&gt;
  ///      *  &lt;li&gt;The number of seconds since the epoch when the
  ///      *      `ConsensusSubmitMessage` reached consensus (8 bytes)&lt;/li&gt;
  ///      *  &lt;li&gt;The number of nanoseconds within the second when the
  ///      *      `ConsensusSubmitMessage` reached consensus (4 bytes)&lt;/li&gt;
  ///      *  &lt;li&gt;The `topic_sequence_number` field (8 bytes)&lt;/li&gt;
  ///      *  &lt;li&gt;The message bytes from the `ConsensusSubmitMessage`
  ///      *      (variable)&lt;/li&gt;
  ///      * &lt;/ol&gt;
  final List<int>? topicRunningHash;

  /// *
  ///      * In the receipt of a `ConsensusSubmitMessage`, the version of the
  ///      * SHA-384 digest inputs used to update the running hash.
  final BigInt? topicRunningHashVersion;

  /// *
  ///      * In the receipt of a `CreateToken`, the id of the newly created token
  final proto_basic_types.HederaTokenID? tokenID;

  /// *
  ///      * In the receipt of `TokenMint`, `TokenWipe`, or `TokenBurn`.&lt;br/&gt;
  ///      * For non-unique tokens, the current total supply of that token.&lt;br/&gt;
  ///      * For unique tokens,the total number of NFTs issued for that token.
  final BigInt? newTotalSupply;

  /// *
  ///      * In the receipt of a `ScheduleCreate`, the id of the newly created
  ///      * Scheduled Entity
  final proto_basic_types.HederaScheduleID? scheduleID;

  /// *
  ///      * In the receipt of a `ScheduleCreate` or `ScheduleSign` that enables the
  ///      * scheduled transaction to execute immediately, the `TransactionID` that
  ///      * should be used to query for the receipt or record of the scheduled
  ///      * transaction that was executed.
  final proto_basic_types.HederaTransactionID? scheduledTransactionID;

  /// *
  ///      * In the receipt of a `TokenMint` for non-fungible/unique tokens,
  ///      * the serial numbers of the newly created tokens.
  final List<BigInt> serialNumbers;

  /// *
  ///      * An affected node identifier.&lt;br/&gt;
  ///      * In the receipt of a NodeCreate, the id of the newly created node.
  ///      * &lt;p&gt;
  ///      * This value SHALL be set following a `createNode` transaction.&lt;br/&gt;
  ///      * This value SHALL NOT be set following any other transaction.
  final BigInt? nodeId;

  /// *
  ///      * The identifier of a newly created RegisteredNode.
  ///      * &lt;p&gt;
  ///      * This value SHALL be set following a `createRegisteredNode`
  ///      * transaction.&lt;br/&gt;
  ///      * This value SHALL NOT be set following any other transaction.&lt;br/&gt;
  ///      * This value SHALL be unique within a given network.
  final BigInt? registeredNodeId;

  /// *
  ///      * The block number containing this transaction.
  ///      * &lt;p&gt;
  ///      * This value SHALL be unset or default if consensus has not been reached
  ///      * or the block assignment is not yet known.&lt;br/&gt;
  ///      * Once known, this value SHALL identify the block containing the
  ///      * transaction represented by this receipt.
  final google_protobuf_wrappers.HederaUInt64Value? blockNumber;

  const HederaTransactionReceipt({
    this.status,
    this.accountID,
    this.fileID,
    this.contractID,
    this.exchangeRate,
    this.topicID,
    this.topicSequenceNumber,
    this.topicRunningHash,
    this.topicRunningHashVersion,
    this.tokenID,
    this.newTotalSupply,
    this.scheduleID,
    this.scheduledTransactionID,
    this.serialNumbers = const [],
    this.nodeId,
    this.registeredNodeId,
    this.blockNumber,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.enumType(1),
        ProtoFieldConfig.message(2),
        ProtoFieldConfig.message(3),
        ProtoFieldConfig.message(4),
        ProtoFieldConfig.message(5),
        ProtoFieldConfig.message(6),
        ProtoFieldConfig.uint64(7),
        ProtoFieldConfig.bytes(8),
        ProtoFieldConfig.uint64(9),
        ProtoFieldConfig.message(10),
        ProtoFieldConfig.uint64(11),
        ProtoFieldConfig.message(12),
        ProtoFieldConfig.message(13),
        ProtoFieldConfig.repeated(
          fieldNumber: 14,
          elementType: ProtoFieldType.int64,
        ),
        ProtoFieldConfig.uint64(15),
        ProtoFieldConfig.uint64(16),
        ProtoFieldConfig.message(17),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    status,
    accountID,
    fileID,
    contractID,
    exchangeRate,
    topicID,
    topicSequenceNumber,
    topicRunningHash,
    topicRunningHashVersion,
    tokenID,
    newTotalSupply,
    scheduleID,
    scheduledTransactionID,
    serialNumbers,
    nodeId,
    registeredNodeId,
    blockNumber,
  ];

  HederaTransactionReceipt copyWith({
    proto_response_code.HederaResponseCodeEnum? status,

    proto_basic_types.HederaAccountID? accountID,

    proto_basic_types.HederaFileID? fileID,

    proto_basic_types.HederaContractID? contractID,

    proto_exchange_rate.HederaExchangeRateSet? exchangeRate,

    proto_basic_types.HederaTopicID? topicID,

    BigInt? topicSequenceNumber,

    List<int>? topicRunningHash,

    BigInt? topicRunningHashVersion,

    proto_basic_types.HederaTokenID? tokenID,

    BigInt? newTotalSupply,

    proto_basic_types.HederaScheduleID? scheduleID,

    proto_basic_types.HederaTransactionID? scheduledTransactionID,

    List<BigInt>? serialNumbers,

    BigInt? nodeId,

    BigInt? registeredNodeId,

    google_protobuf_wrappers.HederaUInt64Value? blockNumber,
  }) {
    return HederaTransactionReceipt(
      status: status ?? this.status,
      accountID: accountID ?? this.accountID,
      fileID: fileID ?? this.fileID,
      contractID: contractID ?? this.contractID,
      exchangeRate: exchangeRate ?? this.exchangeRate,
      topicID: topicID ?? this.topicID,
      topicSequenceNumber: topicSequenceNumber ?? this.topicSequenceNumber,
      topicRunningHash: topicRunningHash ?? this.topicRunningHash,
      topicRunningHashVersion:
          topicRunningHashVersion ?? this.topicRunningHashVersion,
      tokenID: tokenID ?? this.tokenID,
      newTotalSupply: newTotalSupply ?? this.newTotalSupply,
      scheduleID: scheduleID ?? this.scheduleID,
      scheduledTransactionID:
          scheduledTransactionID ?? this.scheduledTransactionID,
      serialNumbers: serialNumbers ?? this.serialNumbers,
      nodeId: nodeId ?? this.nodeId,
      registeredNodeId: registeredNodeId ?? this.registeredNodeId,
      blockNumber: blockNumber ?? this.blockNumber,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'status': config.encodeEnum(status),
      'accountID': config.encodeMessage(accountID),
      'fileID': config.encodeMessage(fileID),
      'contractID': config.encodeMessage(contractID),
      'exchangeRate': config.encodeMessage(exchangeRate),
      'topicID': config.encodeMessage(topicID),
      'topicSequenceNumber': config.encodeBigint(topicSequenceNumber),
      'topicRunningHash': config.encodeBinary(topicRunningHash),
      'topicRunningHashVersion': config.encodeBigint(topicRunningHashVersion),
      'tokenID': config.encodeMessage(tokenID),
      'newTotalSupply': config.encodeBigint(newTotalSupply),
      'scheduleID': config.encodeMessage(scheduleID),
      'scheduledTransactionID': config.encodeMessage(scheduledTransactionID),
      'serialNumbers':
          serialNumbers.map((e) => config.encodeBigint(e)).toList(),
      'node_id': config.encodeBigint(nodeId),
      'registered_node_id': config.encodeBigint(registeredNodeId),
      'block_number': config.encodeMessage(blockNumber),
    };
  }

  factory HederaTransactionReceipt.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaTransactionReceipt(
      status: json
          .valueTo<proto_response_code.HederaResponseCodeEnum?, Object?>(
            key: 'status',
            parse: (v) => proto_response_code.HederaResponseCodeEnum.from(v),
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
      fileID: json.valueTo<proto_basic_types.HederaFileID?, Object>(
        key: 'fileID',
        parse:
            (v) => proto_basic_types.HederaFileID.fromJson(
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
      exchangeRate: json
          .valueTo<proto_exchange_rate.HederaExchangeRateSet?, Object>(
            key: 'exchangeRate',
            parse:
                (v) => proto_exchange_rate.HederaExchangeRateSet.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      topicID: json.valueTo<proto_basic_types.HederaTopicID?, Object>(
        key: 'topicID',
        parse:
            (v) => proto_basic_types.HederaTopicID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      topicSequenceNumber: json.valueAsBigInt<BigInt?>(
        'topicSequenceNumber',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      topicRunningHash: config.decodeBinary<List<int>?>(
        json.valueAs(
          'topicRunningHash',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      topicRunningHashVersion: json.valueAsBigInt<BigInt?>(
        'topicRunningHashVersion',
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
      newTotalSupply: json.valueAsBigInt<BigInt?>(
        'newTotalSupply',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      scheduleID: json.valueTo<proto_basic_types.HederaScheduleID?, Object>(
        key: 'scheduleID',
        parse:
            (v) => proto_basic_types.HederaScheduleID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      scheduledTransactionID: json
          .valueTo<proto_basic_types.HederaTransactionID?, Object>(
            key: 'scheduledTransactionID',
            parse:
                (v) => proto_basic_types.HederaTransactionID.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      serialNumbers:
          (json.valueEnsureAsList<dynamic>(
            'serialNumbers',
            normalizeKeyLookup: config.normalizeKeys,
            onMissing: () => [],
          )).map((e) => JsonParser.valueAsBigInt<BigInt>(e)).toList(),
      nodeId: json.valueAsBigInt<BigInt?>(
        'node_id',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      registeredNodeId: json.valueAsBigInt<BigInt?>(
        'registered_node_id',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      blockNumber: json
          .valueTo<google_protobuf_wrappers.HederaUInt64Value?, Object>(
            key: 'block_number',
            parse:
                (v) => google_protobuf_wrappers.HederaUInt64Value.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
    );
  }

  factory HederaTransactionReceipt.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTransactionReceipt(
      status: decode.getEnum<proto_response_code.HederaResponseCodeEnum?>(
        1,
        proto_response_code.HederaResponseCodeEnum.values,
      ),
      accountID: decode.messageTo<proto_basic_types.HederaAccountID?>(
        2,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
      fileID: decode.messageTo<proto_basic_types.HederaFileID?>(
        3,
        (b) => proto_basic_types.HederaFileID.deserialize(b),
      ),
      contractID: decode.messageTo<proto_basic_types.HederaContractID?>(
        4,
        (b) => proto_basic_types.HederaContractID.deserialize(b),
      ),
      exchangeRate: decode
          .messageTo<proto_exchange_rate.HederaExchangeRateSet?>(
            5,
            (b) => proto_exchange_rate.HederaExchangeRateSet.deserialize(b),
          ),
      topicID: decode.messageTo<proto_basic_types.HederaTopicID?>(
        6,
        (b) => proto_basic_types.HederaTopicID.deserialize(b),
      ),
      topicSequenceNumber: decode.getBigInt<BigInt?>(7),
      topicRunningHash: decode.getBytes<List<int>?>(8),
      topicRunningHashVersion: decode.getBigInt<BigInt?>(9),
      tokenID: decode.messageTo<proto_basic_types.HederaTokenID?>(
        10,
        (b) => proto_basic_types.HederaTokenID.deserialize(b),
      ),
      newTotalSupply: decode.getBigInt<BigInt?>(11),
      scheduleID: decode.messageTo<proto_basic_types.HederaScheduleID?>(
        12,
        (b) => proto_basic_types.HederaScheduleID.deserialize(b),
      ),
      scheduledTransactionID: decode
          .messageTo<proto_basic_types.HederaTransactionID?>(
            13,
            (b) => proto_basic_types.HederaTransactionID.deserialize(b),
          ),
      serialNumbers: decode.getListOrEmpty<BigInt>(14),
      nodeId: decode.getBigInt<BigInt?>(15),
      registeredNodeId: decode.getBigInt<BigInt?>(16),
      blockNumber: decode
          .messageTo<google_protobuf_wrappers.HederaUInt64Value?>(
            17,
            (b) => google_protobuf_wrappers.HederaUInt64Value.deserialize(b),
          ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoTransactionReceipt;
}
