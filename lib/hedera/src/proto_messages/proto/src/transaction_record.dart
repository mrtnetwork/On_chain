import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/transaction_receipt.dart"
    as proto_transaction_receipt;
import "package:on_chain/hedera/src/proto_messages/proto/src/timestamp.dart"
    as proto_timestamp;
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;
import "package:on_chain/hedera/src/proto_messages/proto/src/contract_types.dart"
    as proto_contract_types;
import "package:on_chain/hedera/src/proto_messages/proto/src/custom_fees.dart"
    as proto_custom_fees;

/// *
///  * # Transaction Record
///  * The record of a single transaction, including receipt and transaction
///  * results such as transfer lists, entropy, contract call result, etc...&lt;br/&gt;
///  * The record also includes fees, consensus time, EVM information, and
///  * other result metadata.&lt;br/&gt;
///  * Only values appropriate to the requested transaction are populated, all
///  * other fields will not be set (i.e. null or default values).
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
///  * Response when the client sends the node TransactionGetRecordResponse
class HederaTransactionRecord extends HederaProtoMessage with Equality {
  /// *
  ///      * A transaction receipt.
  ///      * &lt;p&gt;
  ///      * This SHALL report consensus status (reach consensus, failed,
  ///      * unknown) and the ID of any new entity (i.e. account, file,
  ///      * contract, schedule, etc...) created.
  final proto_transaction_receipt.HederaTransactionReceipt? receipt;

  /// *
  ///      * A transaction hash value.
  ///      * &lt;p&gt;
  ///      * This SHALL be the hash of the Transaction that executed and
  ///      * SHALL NOT be the hash of any Transaction that failed for
  ///      * having a duplicate TransactionID.
  final List<int>? transactionHash;

  /// *
  ///      * A consensus timestamp.
  ///      * &lt;p&gt;
  ///      * This SHALL be null if the transaction did not reach consensus yet.
  final proto_timestamp.HederaTimestamp? consensusTimestamp;

  /// *
  ///      * A transaction identifier to the transaction associated to this record.
  final proto_basic_types.HederaTransactionID? transactionID;

  /// *
  ///      * A transaction memo.&lt;br/&gt;
  ///      * This is the memo that was submitted as part of the transaction.
  ///      * &lt;p&gt;
  ///      * This value, if set, MUST NOT exceed `transaction.maxMemoUtf8Bytes`
  ///      * (default 100) bytes when encoded as UTF-8.
  final String? memo;

  /// *
  ///      * A transaction fee charged.
  ///      * &lt;p&gt;
  ///      * This SHALL be the actual transaction fee charged.&lt;br/&gt;
  ///      * This MAY NOT match the original `transactionFee` value
  ///      * from the `TransactionBody`.
  final BigInt? transactionFee;

  /// *
  ///          * A contract call result.&lt;br/&gt;
  ///          * A record of the value returned by the smart contract function (if
  ///          * it completed and didn't fail) from a `ContractCallTransaction`.
  final proto_contract_types.HederaContractFunctionResult? contractCallResult;

  /// *
  ///          * A contract creation result.&lt;br/&gt;
  ///          * A record of the value returned by the smart contract constructor (if
  ///          * it completed and didn't fail) from a `ContractCreateTransaction`.
  final proto_contract_types.HederaContractFunctionResult? contractCreateResult;

  /// *
  ///      * A transfer list for this transaction.&lt;br/&gt;
  ///      * This is a list of all HBAR transfers completed for this transaction.
  ///      * &lt;p&gt;
  ///      * This MAY include fees, transfers performed by the transaction,
  ///      * transfers initiated by a smart contract it calls, or the creation
  ///      * of threshold records that it triggers.
  final proto_basic_types.HederaTransferList? transferList;

  /// *
  ///      * A token transfer list for this transaction.&lt;br/&gt;
  ///      * This is a list of all non-HBAR token transfers
  ///      * completed for this transaction.&lt;br/&gt;
  final List<proto_basic_types.HederaTokenTransferList> tokenTransferLists;

  /// *
  ///      * A schedule reference.&lt;br/&gt;
  ///      * The reference to a schedule ID for the schedule that initiated this
  ///      * transaction, if this this transaction record represents a scheduled
  ///      * transaction.
  final proto_basic_types.HederaScheduleID? scheduleRef;

  /// *
  ///      * A list of all custom fees that were assessed during a CryptoTransfer.
  ///      * &lt;p&gt;
  ///      * These SHALL be paid if the transaction status resolved to SUCCESS.
  final List<proto_custom_fees.HederaAssessedCustomFee> assessedCustomFees;

  /// *
  ///      * A list of all token associations implicitly or automatically
  ///      * created while handling this transaction.
  final List<proto_basic_types.HederaTokenAssociation>
  automaticTokenAssociations;

  /// *
  ///      * A consensus timestamp for a child record.
  ///      * &lt;p&gt;
  ///      * This SHALL be the consensus timestamp of a user transaction that
  ///      * spawned an internal child transaction.
  final proto_timestamp.HederaTimestamp? parentConsensusTimestamp;

  /// *
  ///      * A new account alias.&lt;br/&gt;
  ///      * &lt;p&gt;
  ///      * This is the new alias assigned to an account created as part
  ///      * of a CryptoCreate transaction triggered by a user transaction
  ///      * with a (previously unused) alias.
  final List<int>? alias;

  /// *
  ///      * A keccak256 hash of the ethereumData.
  ///      * &lt;p&gt;
  ///      * This field SHALL only be populated for EthereumTransaction.
  final List<int>? ethereumHash;

  /// *
  ///      * A list of staking rewards paid.
  ///      * &lt;p&gt;
  ///      * This SHALL be a list accounts with the corresponding staking
  ///      * rewards paid as a result of this transaction.
  final List<proto_basic_types.HederaAccountAmount> paidStakingRewards;

  /// *
  ///          * A pseudorandom 384-bit sequence.
  ///          * &lt;p&gt;
  ///          * This SHALL be returned in the record of a UtilPrng transaction
  ///          * with no output range,
  final List<int>? prngBytes;

  /// *
  ///          * A pseudorandom 32-bit integer.&lt;br/&gt;
  ///          * &lt;p&gt;
  ///          * This SHALL be returned in the record of a PRNG transaction with
  ///          * an output range specified.
  final int? prngNumber;

  /// *
  ///      * A new default EVM address for an account created by
  ///      * this transaction.
  ///      * &lt;p&gt;
  ///      * This field SHALL be populated only when the EVM address is not
  ///      * specified in the related transaction body.
  final List<int>? evmAddress;

  /// *
  ///      * A list of pending token airdrops.
  ///      * &lt;p&gt;
  ///      * Each pending airdrop SHALL represent a single requested transfer
  ///      * from a sending account to a recipient account.&lt;br/&gt;
  ///      * These pending transfers are issued unilaterally by the sending
  ///      * account, and MUST be claimed by the recipient account before
  ///      * the transfer SHALL complete.&lt;br/&gt;
  ///      * A sender MAY cancel a pending airdrop before it is claimed.&lt;br/&gt;
  ///      * An airdrop transaction SHALL emit a pending airdrop when the
  ///      * recipient has no available automatic association slots available
  ///      * or when the recipient has set `receiver_sig_required`.
  final List<HederaPendingAirdropRecord> newPendingAirdrops;

  /// *
  ///      * A high volume pricing multiplier.
  ///      * &lt;p&gt;
  ///      * This SHALL be the multiplier that is applied to the transaction
  ///      * fees charged for this transaction if the high volume flag is set.
  ///      * This is scaled by 1000.
  final BigInt? highVolumePricingMultiplier;

  const HederaTransactionRecord({
    this.receipt,
    this.transactionHash,
    this.consensusTimestamp,
    this.transactionID,
    this.memo,
    this.transactionFee,
    this.contractCallResult,
    this.contractCreateResult,
    this.transferList,
    this.tokenTransferLists = const [],
    this.scheduleRef,
    this.assessedCustomFees = const [],
    this.automaticTokenAssociations = const [],
    this.parentConsensusTimestamp,
    this.alias,
    this.ethereumHash,
    this.paidStakingRewards = const [],
    this.prngBytes,
    this.prngNumber,
    this.evmAddress,
    this.newPendingAirdrops = const [],
    this.highVolumePricingMultiplier,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.bytes(2),
        ProtoFieldConfig.message(3),
        ProtoFieldConfig.message(4),
        ProtoFieldConfig.string(5),
        ProtoFieldConfig.uint64(6),
        ProtoFieldConfig.message(7),
        ProtoFieldConfig.message(8),
        ProtoFieldConfig.message(10),
        ProtoFieldConfig.repeated(
          fieldNumber: 11,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.message(12),
        ProtoFieldConfig.repeated(
          fieldNumber: 13,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.repeated(
          fieldNumber: 14,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.message(15),
        ProtoFieldConfig.bytes(16),
        ProtoFieldConfig.bytes(17),
        ProtoFieldConfig.repeated(
          fieldNumber: 18,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.bytes(19),
        ProtoFieldConfig.int32(20),
        ProtoFieldConfig.bytes(21),
        ProtoFieldConfig.repeated(
          fieldNumber: 22,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.uint64(23),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    receipt,
    transactionHash,
    consensusTimestamp,
    transactionID,
    memo,
    transactionFee,
    contractCallResult,
    contractCreateResult,
    transferList,
    tokenTransferLists,
    scheduleRef,
    assessedCustomFees,
    automaticTokenAssociations,
    parentConsensusTimestamp,
    alias,
    ethereumHash,
    paidStakingRewards,
    prngBytes,
    prngNumber,
    evmAddress,
    newPendingAirdrops,
    highVolumePricingMultiplier,
  ];

  HederaTransactionRecord copyWith({
    proto_transaction_receipt.HederaTransactionReceipt? receipt,

    List<int>? transactionHash,

    proto_timestamp.HederaTimestamp? consensusTimestamp,

    proto_basic_types.HederaTransactionID? transactionID,

    String? memo,

    BigInt? transactionFee,

    proto_contract_types.HederaContractFunctionResult? contractCallResult,

    proto_contract_types.HederaContractFunctionResult? contractCreateResult,

    proto_basic_types.HederaTransferList? transferList,

    List<proto_basic_types.HederaTokenTransferList>? tokenTransferLists,

    proto_basic_types.HederaScheduleID? scheduleRef,

    List<proto_custom_fees.HederaAssessedCustomFee>? assessedCustomFees,

    List<proto_basic_types.HederaTokenAssociation>? automaticTokenAssociations,

    proto_timestamp.HederaTimestamp? parentConsensusTimestamp,

    List<int>? alias,

    List<int>? ethereumHash,

    List<proto_basic_types.HederaAccountAmount>? paidStakingRewards,

    List<int>? prngBytes,

    int? prngNumber,

    List<int>? evmAddress,

    List<HederaPendingAirdropRecord>? newPendingAirdrops,

    BigInt? highVolumePricingMultiplier,
  }) {
    return HederaTransactionRecord(
      receipt: receipt ?? this.receipt,
      transactionHash: transactionHash ?? this.transactionHash,
      consensusTimestamp: consensusTimestamp ?? this.consensusTimestamp,
      transactionID: transactionID ?? this.transactionID,
      memo: memo ?? this.memo,
      transactionFee: transactionFee ?? this.transactionFee,
      contractCallResult: contractCallResult ?? this.contractCallResult,
      contractCreateResult: contractCreateResult ?? this.contractCreateResult,
      transferList: transferList ?? this.transferList,
      tokenTransferLists: tokenTransferLists ?? this.tokenTransferLists,
      scheduleRef: scheduleRef ?? this.scheduleRef,
      assessedCustomFees: assessedCustomFees ?? this.assessedCustomFees,
      automaticTokenAssociations:
          automaticTokenAssociations ?? this.automaticTokenAssociations,
      parentConsensusTimestamp:
          parentConsensusTimestamp ?? this.parentConsensusTimestamp,
      alias: alias ?? this.alias,
      ethereumHash: ethereumHash ?? this.ethereumHash,
      paidStakingRewards: paidStakingRewards ?? this.paidStakingRewards,
      prngBytes: prngBytes ?? this.prngBytes,
      prngNumber: prngNumber ?? this.prngNumber,
      evmAddress: evmAddress ?? this.evmAddress,
      newPendingAirdrops: newPendingAirdrops ?? this.newPendingAirdrops,
      highVolumePricingMultiplier:
          highVolumePricingMultiplier ?? this.highVolumePricingMultiplier,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'receipt': config.encodeMessage(receipt),
      'transactionHash': config.encodeBinary(transactionHash),
      'consensusTimestamp': config.encodeMessage(consensusTimestamp),
      'transactionID': config.encodeMessage(transactionID),
      'memo': memo,
      'transactionFee': config.encodeBigint(transactionFee),
      'contractCallResult': config.encodeMessage(contractCallResult),
      'contractCreateResult': config.encodeMessage(contractCreateResult),
      'transferList': config.encodeMessage(transferList),
      'tokenTransferLists':
          tokenTransferLists.map((e) => config.encodeMessage(e)).toList(),
      'scheduleRef': config.encodeMessage(scheduleRef),
      'assessed_custom_fees':
          assessedCustomFees.map((e) => config.encodeMessage(e)).toList(),
      'automatic_token_associations':
          automaticTokenAssociations
              .map((e) => config.encodeMessage(e))
              .toList(),
      'parent_consensus_timestamp': config.encodeMessage(
        parentConsensusTimestamp,
      ),
      'alias': config.encodeBinary(alias),
      'ethereum_hash': config.encodeBinary(ethereumHash),
      'paid_staking_rewards':
          paidStakingRewards.map((e) => config.encodeMessage(e)).toList(),
      'prng_bytes': config.encodeBinary(prngBytes),
      'prng_number': prngNumber,
      'evm_address': config.encodeBinary(evmAddress),
      'new_pending_airdrops':
          newPendingAirdrops.map((e) => config.encodeMessage(e)).toList(),
      'high_volume_pricing_multiplier': config.encodeBigint(
        highVolumePricingMultiplier,
      ),
    };
  }

  factory HederaTransactionRecord.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaTransactionRecord(
      receipt: json
          .valueTo<proto_transaction_receipt.HederaTransactionReceipt?, Object>(
            key: 'receipt',
            parse:
                (v) =>
                    proto_transaction_receipt.HederaTransactionReceipt.fromJson(
                      JsonParser.valueAs(v),
                      config: config,
                    ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      transactionHash: config.decodeBinary<List<int>?>(
        json.valueAs(
          'transactionHash',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      consensusTimestamp: json
          .valueTo<proto_timestamp.HederaTimestamp?, Object>(
            key: 'consensusTimestamp',
            parse:
                (v) => proto_timestamp.HederaTimestamp.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      transactionID: json
          .valueTo<proto_basic_types.HederaTransactionID?, Object>(
            key: 'transactionID',
            parse:
                (v) => proto_basic_types.HederaTransactionID.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      memo: json.valueAsString<String?>(
        'memo',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      transactionFee: json.valueAsBigInt<BigInt?>(
        'transactionFee',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      contractCallResult: json
          .valueTo<proto_contract_types.HederaContractFunctionResult?, Object>(
            key: 'contractCallResult',
            parse:
                (v) =>
                    proto_contract_types.HederaContractFunctionResult.fromJson(
                      JsonParser.valueAs(v),
                      config: config,
                    ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      contractCreateResult: json
          .valueTo<proto_contract_types.HederaContractFunctionResult?, Object>(
            key: 'contractCreateResult',
            parse:
                (v) =>
                    proto_contract_types.HederaContractFunctionResult.fromJson(
                      JsonParser.valueAs(v),
                      config: config,
                    ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      transferList: json.valueTo<proto_basic_types.HederaTransferList?, Object>(
        key: 'transferList',
        parse:
            (v) => proto_basic_types.HederaTransferList.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      tokenTransferLists:
          (json.valueEnsureAsList<dynamic>(
                'tokenTransferLists',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<
                  proto_basic_types.HederaTokenTransferList,
                  Object
                >(
                  value: e,
                  parse:
                      (v) => proto_basic_types.HederaTokenTransferList.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      scheduleRef: json.valueTo<proto_basic_types.HederaScheduleID?, Object>(
        key: 'scheduleRef',
        parse:
            (v) => proto_basic_types.HederaScheduleID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      assessedCustomFees:
          (json.valueEnsureAsList<dynamic>(
                'assessed_custom_fees',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<
                  proto_custom_fees.HederaAssessedCustomFee,
                  Object
                >(
                  value: e,
                  parse:
                      (v) => proto_custom_fees.HederaAssessedCustomFee.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      automaticTokenAssociations:
          (json.valueEnsureAsList<dynamic>(
                'automatic_token_associations',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<
                  proto_basic_types.HederaTokenAssociation,
                  Object
                >(
                  value: e,
                  parse:
                      (v) => proto_basic_types.HederaTokenAssociation.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      parentConsensusTimestamp: json
          .valueTo<proto_timestamp.HederaTimestamp?, Object>(
            key: 'parent_consensus_timestamp',
            parse:
                (v) => proto_timestamp.HederaTimestamp.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      alias: config.decodeBinary<List<int>?>(
        json.valueAs('alias', normalizeKeyLookup: config.normalizeKeys),
      ),
      ethereumHash: config.decodeBinary<List<int>?>(
        json.valueAs('ethereum_hash', normalizeKeyLookup: config.normalizeKeys),
      ),
      paidStakingRewards:
          (json.valueEnsureAsList<dynamic>(
                'paid_staking_rewards',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<
                  proto_basic_types.HederaAccountAmount,
                  Object
                >(
                  value: e,
                  parse:
                      (v) => proto_basic_types.HederaAccountAmount.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      prngBytes: config.decodeBinary<List<int>?>(
        json.valueAs('prng_bytes', normalizeKeyLookup: config.normalizeKeys),
      ),
      prngNumber: json.valueAsInt<int?>(
        'prng_number',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      evmAddress: config.decodeBinary<List<int>?>(
        json.valueAs('evm_address', normalizeKeyLookup: config.normalizeKeys),
      ),
      newPendingAirdrops:
          (json.valueEnsureAsList<dynamic>(
                'new_pending_airdrops',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<HederaPendingAirdropRecord, Object>(
                  value: e,
                  parse:
                      (v) => HederaPendingAirdropRecord.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      highVolumePricingMultiplier: json.valueAsBigInt<BigInt?>(
        'high_volume_pricing_multiplier',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaTransactionRecord.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTransactionRecord(
      receipt: decode
          .messageTo<proto_transaction_receipt.HederaTransactionReceipt?>(
            1,
            (b) => proto_transaction_receipt
                .HederaTransactionReceipt.deserialize(b),
          ),
      transactionHash: decode.getBytes<List<int>?>(2),
      consensusTimestamp: decode.messageTo<proto_timestamp.HederaTimestamp?>(
        3,
        (b) => proto_timestamp.HederaTimestamp.deserialize(b),
      ),
      transactionID: decode.messageTo<proto_basic_types.HederaTransactionID?>(
        4,
        (b) => proto_basic_types.HederaTransactionID.deserialize(b),
      ),
      memo: decode.getString<String?>(5),
      transactionFee: decode.getBigInt<BigInt?>(6),
      contractCallResult: decode.messageTo<
        proto_contract_types.HederaContractFunctionResult?
      >(
        7,
        (b) => proto_contract_types.HederaContractFunctionResult.deserialize(b),
      ),
      contractCreateResult: decode.messageTo<
        proto_contract_types.HederaContractFunctionResult?
      >(
        8,
        (b) => proto_contract_types.HederaContractFunctionResult.deserialize(b),
      ),
      transferList: decode.messageTo<proto_basic_types.HederaTransferList?>(
        10,
        (b) => proto_basic_types.HederaTransferList.deserialize(b),
      ),
      tokenTransferLists:
          decode
              .getListOfBytes(11)
              .map(
                (b) => proto_basic_types.HederaTokenTransferList.deserialize(b),
              )
              .toList(),
      scheduleRef: decode.messageTo<proto_basic_types.HederaScheduleID?>(
        12,
        (b) => proto_basic_types.HederaScheduleID.deserialize(b),
      ),
      assessedCustomFees:
          decode
              .getListOfBytes(13)
              .map(
                (b) => proto_custom_fees.HederaAssessedCustomFee.deserialize(b),
              )
              .toList(),
      automaticTokenAssociations:
          decode
              .getListOfBytes(14)
              .map(
                (b) => proto_basic_types.HederaTokenAssociation.deserialize(b),
              )
              .toList(),
      parentConsensusTimestamp: decode
          .messageTo<proto_timestamp.HederaTimestamp?>(
            15,
            (b) => proto_timestamp.HederaTimestamp.deserialize(b),
          ),
      alias: decode.getBytes<List<int>?>(16),
      ethereumHash: decode.getBytes<List<int>?>(17),
      paidStakingRewards:
          decode
              .getListOfBytes(18)
              .map((b) => proto_basic_types.HederaAccountAmount.deserialize(b))
              .toList(),
      prngBytes: decode.getBytes<List<int>?>(19),
      prngNumber: decode.getInt<int?>(20),
      evmAddress: decode.getBytes<List<int>?>(21),
      newPendingAirdrops:
          decode
              .getListOfBytes(22)
              .map((b) => HederaPendingAirdropRecord.deserialize(b))
              .toList(),
      highVolumePricingMultiplier: decode.getBigInt<BigInt?>(23),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoTransactionRecord;
}

/// *
///  * A record of a new pending airdrop.
class HederaPendingAirdropRecord extends HederaProtoMessage with Equality {
  /// *
  ///      * A unique, composite, identifier for a pending airdrop.
  ///      * &lt;p&gt;
  ///      * This field is REQUIRED.
  final proto_basic_types.HederaPendingAirdropId? pendingAirdropId;

  /// *
  ///      * A single pending airdrop amount.
  ///      * &lt;p&gt;
  ///      * If the pending airdrop is for a fungible/common token this field
  ///      * is REQUIRED and SHALL be the current amount of tokens offered.&lt;br/&gt;
  ///      * If the pending airdrop is for a non-fungible/unique token,
  ///      * this field SHALL NOT be set.
  final proto_basic_types.HederaPendingAirdropValue? pendingAirdropValue;

  const HederaPendingAirdropRecord({
    this.pendingAirdropId,
    this.pendingAirdropValue,
  });

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
  List<Object?> get protoValues => [pendingAirdropId, pendingAirdropValue];

  HederaPendingAirdropRecord copyWith({
    proto_basic_types.HederaPendingAirdropId? pendingAirdropId,

    proto_basic_types.HederaPendingAirdropValue? pendingAirdropValue,
  }) {
    return HederaPendingAirdropRecord(
      pendingAirdropId: pendingAirdropId ?? this.pendingAirdropId,
      pendingAirdropValue: pendingAirdropValue ?? this.pendingAirdropValue,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'pending_airdrop_id': config.encodeMessage(pendingAirdropId),
      'pending_airdrop_value': config.encodeMessage(pendingAirdropValue),
    };
  }

  factory HederaPendingAirdropRecord.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaPendingAirdropRecord(
      pendingAirdropId: json
          .valueTo<proto_basic_types.HederaPendingAirdropId?, Object>(
            key: 'pending_airdrop_id',
            parse:
                (v) => proto_basic_types.HederaPendingAirdropId.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      pendingAirdropValue: json
          .valueTo<proto_basic_types.HederaPendingAirdropValue?, Object>(
            key: 'pending_airdrop_value',
            parse:
                (v) => proto_basic_types.HederaPendingAirdropValue.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
    );
  }

  factory HederaPendingAirdropRecord.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaPendingAirdropRecord(
      pendingAirdropId: decode
          .messageTo<proto_basic_types.HederaPendingAirdropId?>(
            1,
            (b) => proto_basic_types.HederaPendingAirdropId.deserialize(b),
          ),
      pendingAirdropValue: decode
          .messageTo<proto_basic_types.HederaPendingAirdropValue?>(
            2,
            (b) => proto_basic_types.HederaPendingAirdropValue.deserialize(b),
          ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoPendingAirdropRecord;
}
