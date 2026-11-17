import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/response_code.dart" as proto_response_code;
import "package:on_chain/hedera/src/proto_messages/proto/src/timestamp.dart" as proto_timestamp;
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart" as proto_basic_types;
import "package:on_chain/hedera/src/proto_messages/proto/src/custom_fees.dart" as proto_custom_fees;

/// *
///  * # Transaction Result
///  * The result of a transaction, sometimes called a receipt.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in
///  * [RFC2119](https://www.ietf.org/rfc/rfc2119) and clarified in
///  * [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// * Copyright (C) 2024 Hedera Hashgraph, LLC
///  *
///  * Licensed under the Apache License, Version 2.0 (the "License");
///  * you may not use this file except in compliance with the License.
///  * You may obtain a copy of the License at
///  *
///  *      http://www.apache.org/licenses/LICENSE-2.0
///  *
///  * Unless required by applicable law or agreed to in writing, software
///  * distributed under the License is distributed on an "AS IS" BASIS,
///  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
///  * See the License for the specific language governing permissions and
///  * limitations under the License.
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.block.stream.output"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * While we have the state changes as part of the block stream,
///  * we may not have the full data set needed. To surface information
///  * such as staking rewards, fees, etc. we need to include some of the
///  * data from the original TransactionRecord.
///  *
///  * &gt; REVIEW NOTE
///  * &gt;&gt; Should we have custom fees here, and remove that from the
///  * &gt;&gt; CryptoTransfer output message? That would make more sense, as I believe
///  * &gt;&gt; TokenTransfer output would also need custom fees, and we may wish
///  * &gt;&gt; to add custom fees to other transactions in the future.
class HederaTransactionResult extends HederaProtoMessage with Equality {
    /// *
  ///      * A response code.
  ///      * &lt;p&gt;
  ///      * This value SHALL indicate the status of this transaction.&lt;br/&gt;
  ///      * This code SHALL indicate success or a specific failure.
  final proto_response_code.HederaResponseCodeEnum? status;

    /// *
  ///      * A consensus timestamp.
  ///      * &lt;p&gt;
  ///      * The time index, agreed by all network nodes, when this transaction
  ///      * reached consensus.&lt;br/&gt;
  ///      * This field SHALL be set for all transactions.
  final proto_timestamp.HederaTimestamp? consensusTimestamp;

    /// *
  ///      * A consensus timestamp.
  ///      * &lt;p&gt;
  ///      * The time index, agreed by all network nodes, when the "parent"
  ///      * transaction, if any, for this transaction reached consensus.&lt;br/&gt;
  ///      * This SHALL NOT be set on a user-submitted transaction.&lt;br/&gt;
  ///      * This SHALL be set on an internal "child" transaction initiated as
  ///      * part of completing a user-submitted transaction.
  final proto_timestamp.HederaTimestamp? parentConsensusTimestamp;

    /// *
  ///      * A schedule that executed this transaction, if this transaction
  ///      * was scheduled.
  ///      * &lt;p&gt;
  ///      * This value SHALL NOT be set unless this transaction result represents
  ///      * the result of a _scheduled_ child transaction.
  final proto_basic_types.HederaScheduleID? scheduleRef;

    /// *
  ///      * An amount, in tinybar, charged for this transaction.
  ///      * &lt;p&gt;
  ///      * This SHALL be the actual transaction fee charged, and SHALL NOT be the
  ///      * transactionFee value from TransactionBody.
  final BigInt? transactionFeeCharged;

    /// *
  ///      * A list of HBAR transfers, in double-entry form.
  ///      * &lt;p&gt;
  ///      * This SHALL include all HBAR transfers completed as a result
  ///      * of this transaction.&lt;br/&gt;
  ///      * This MUST include, at least,
  ///      * &lt;ul&gt;
  ///      *   &lt;li&gt;Each source and recipient of transaction fees&lt;/li&gt;
  ///      *   &lt;li&gt;All transfers directly performed by this transaction&lt;/li&gt;
  ///      *   &lt;li&gt;All transfers due to staking rewards paid as a result of
  ///      *       this transaction&lt;/li&gt;
  ///      *   &lt;li&gt;Any transfers performed by a smart contract call associated
  ///      *       with this transaction&lt;/li&gt;
  ///      *   &lt;li&gt;Any transfers caused by the creation of threshold records&lt;/li&gt;
  ///      * &lt;/ul&gt;
  ///      * &lt;p&gt;
  ///      * This transfer list is exposed in the Mirror Node API (MAPI) and in use
  ///      * by clients of the MAPI. Additionally, there are some transfers that
  ///      * are mingled with transactions and only split out here.
  final proto_basic_types.HederaTransferList? transferList;

    /// *
  ///      * A list of _non-HBAR_ token transfers, in single-entry form.
  ///      * &lt;p&gt;
  ///      * This SHALL include all _non-HBAR_ token transfers completed as a
  ///      * result of this transaction.&lt;br/&gt;
  ///      * This MUST include, at least,
  ///      * &lt;ul&gt;
  ///      *   &lt;li&gt;Each source and recipient of custom fees&lt;/li&gt;
  ///      *   &lt;li&gt;All transfers directly performed by this transaction&lt;/li&gt;
  ///      *   &lt;li&gt;Any transfers performed by a smart contract call associated
  ///      *       with this transaction&lt;/li&gt;
  ///      * &lt;/ul&gt;
  final List<proto_basic_types.HederaTokenTransferList> tokenTransferLists;

    /// *
  ///      * A list of token associations.
  ///      * &lt;p&gt;
  ///      * This field SHALL list all token associations created automatically
  ///      * while handling this transaction.
  final List<proto_basic_types.HederaTokenAssociation> automaticTokenAssociations;

    /// *
  ///      * A list of accounts and amounts.
  ///      * &lt;p&gt;
  ///      * This SHALL list all accounts paid staking rewards as a result
  ///      * of this transaction.&lt;br/&gt;
  ///      * Each entry SHALL contain both the account and the amount paid.
  final List<proto_basic_types.HederaAccountAmount> paidStakingRewards;

    /// *
  ///      * A congestion pricing multiplier.
  ///      * &lt;p&gt;
  ///      * This SHALL be the multiplier that is applied to the transaction
  ///      * fees charged for this transaction.
  final BigInt? congestionPricingMultiplier;

    /// *
  ///      * Custom fees assessed during a transaction execution.
  ///      * &lt;p&gt;
  ///      * These fees SHALL be present in the full transfer list for the transaction.
  final List<proto_custom_fees.HederaAssessedCustomFee> assessedCustomFees;

  const HederaTransactionResult({
    this.status,
    this.consensusTimestamp,
    this.parentConsensusTimestamp,
    this.scheduleRef,
    this.transactionFeeCharged,
    this.transferList,
    this.tokenTransferLists = const [],
    this.automaticTokenAssociations = const [],
    this.paidStakingRewards = const [],
    this.congestionPricingMultiplier,
    this.assessedCustomFees = const [],
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
        ProtoFieldConfig.message(5),
        ProtoFieldConfig.uint64(6),
        ProtoFieldConfig.message(7),
        ProtoFieldConfig.repeated(
          fieldNumber: 8,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.repeated(
          fieldNumber: 9,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.repeated(
          fieldNumber: 10,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.uint64(11),
        ProtoFieldConfig.repeated(
          fieldNumber: 12,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        status,
        consensusTimestamp,
        parentConsensusTimestamp,
        scheduleRef,
        transactionFeeCharged,
        transferList,
        tokenTransferLists,
        automaticTokenAssociations,
        paidStakingRewards,
        congestionPricingMultiplier,
        assessedCustomFees,
      ];


HederaTransactionResult copyWith(
{proto_response_code.HederaResponseCodeEnum? status,

proto_timestamp.HederaTimestamp? consensusTimestamp,

proto_timestamp.HederaTimestamp? parentConsensusTimestamp,

proto_basic_types.HederaScheduleID? scheduleRef,

BigInt? transactionFeeCharged,

proto_basic_types.HederaTransferList? transferList,

List<proto_basic_types.HederaTokenTransferList>? tokenTransferLists,

List<proto_basic_types.HederaTokenAssociation>? automaticTokenAssociations,

List<proto_basic_types.HederaAccountAmount>? paidStakingRewards,

BigInt? congestionPricingMultiplier,

List<proto_custom_fees.HederaAssessedCustomFee>? assessedCustomFees,

}) {
    return HederaTransactionResult(
status: status ?? this.status,
consensusTimestamp: consensusTimestamp ?? this.consensusTimestamp,
parentConsensusTimestamp: parentConsensusTimestamp ?? this.parentConsensusTimestamp,
scheduleRef: scheduleRef ?? this.scheduleRef,
transactionFeeCharged: transactionFeeCharged ?? this.transactionFeeCharged,
transferList: transferList ?? this.transferList,
tokenTransferLists: tokenTransferLists ?? this.tokenTransferLists,
automaticTokenAssociations: automaticTokenAssociations ?? this.automaticTokenAssociations,
paidStakingRewards: paidStakingRewards ?? this.paidStakingRewards,
congestionPricingMultiplier: congestionPricingMultiplier ?? this.congestionPricingMultiplier,
assessedCustomFees: assessedCustomFees ?? this.assessedCustomFees,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'status': config.encodeEnum(status),
      'consensus_timestamp': config.encodeMessage(consensusTimestamp),
      'parent_consensus_timestamp': config.encodeMessage(parentConsensusTimestamp),
      'schedule_ref': config.encodeMessage(scheduleRef),
      'transaction_fee_charged': config.encodeBigint(transactionFeeCharged),
      'transfer_list': config.encodeMessage(transferList),
      'token_transfer_lists': tokenTransferLists.map((e) => config.encodeMessage(e)).toList(),
      'automatic_token_associations': automaticTokenAssociations.map((e) => config.encodeMessage(e)).toList(),
      'paid_staking_rewards': paidStakingRewards.map((e) => config.encodeMessage(e)).toList(),
      'congestion_pricing_multiplier': config.encodeBigint(congestionPricingMultiplier),
      'assessed_custom_fees': assessedCustomFees.map((e) => config.encodeMessage(e)).toList(),
    };
  }


  factory HederaTransactionResult.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaTransactionResult(
      status: json.valueTo<proto_response_code.HederaResponseCodeEnum?, Object?>(
        key: 'status',
        parse: (v) => proto_response_code.HederaResponseCodeEnum.from(v),
      ),
      consensusTimestamp: json.valueTo<proto_timestamp.HederaTimestamp?, Object>(
        key: 'consensus_timestamp',
        parse: (v) => proto_timestamp.HederaTimestamp.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      parentConsensusTimestamp: json.valueTo<proto_timestamp.HederaTimestamp?, Object>(
        key: 'parent_consensus_timestamp',
        parse: (v) => proto_timestamp.HederaTimestamp.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      scheduleRef: json.valueTo<proto_basic_types.HederaScheduleID?, Object>(
        key: 'schedule_ref',
        parse: (v) => proto_basic_types.HederaScheduleID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      transactionFeeCharged: json.valueAsBigInt<BigInt?>('transaction_fee_charged', normalizeKeyLookup: config.normalizeKeys),
      transferList: json.valueTo<proto_basic_types.HederaTransferList?, Object>(
        key: 'transfer_list',
        parse: (v) => proto_basic_types.HederaTransferList.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      tokenTransferLists: (json.valueEnsureAsList<dynamic>('token_transfer_lists', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<proto_basic_types.HederaTokenTransferList, Object>(
          value: e,
          parse: (v) => proto_basic_types.HederaTokenTransferList.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
      automaticTokenAssociations: (json.valueEnsureAsList<dynamic>('automatic_token_associations', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<proto_basic_types.HederaTokenAssociation, Object>(
          value: e,
          parse: (v) => proto_basic_types.HederaTokenAssociation.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
      paidStakingRewards: (json.valueEnsureAsList<dynamic>('paid_staking_rewards', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<proto_basic_types.HederaAccountAmount, Object>(
          value: e,
          parse: (v) => proto_basic_types.HederaAccountAmount.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
      congestionPricingMultiplier: json.valueAsBigInt<BigInt?>('congestion_pricing_multiplier', normalizeKeyLookup: config.normalizeKeys),
      assessedCustomFees: (json.valueEnsureAsList<dynamic>('assessed_custom_fees', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<proto_custom_fees.HederaAssessedCustomFee, Object>(
          value: e,
          parse: (v) => proto_custom_fees.HederaAssessedCustomFee.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
    );
  }

  factory HederaTransactionResult.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTransactionResult(
      status: decode.getEnum<proto_response_code.HederaResponseCodeEnum?>(1, proto_response_code.HederaResponseCodeEnum.values),
      consensusTimestamp: decode.messageTo<proto_timestamp.HederaTimestamp?>(2, (b) => proto_timestamp.HederaTimestamp.deserialize(b)),
      parentConsensusTimestamp: decode.messageTo<proto_timestamp.HederaTimestamp?>(3, (b) => proto_timestamp.HederaTimestamp.deserialize(b)),
      scheduleRef: decode.messageTo<proto_basic_types.HederaScheduleID?>(5, (b) => proto_basic_types.HederaScheduleID.deserialize(b)),
      transactionFeeCharged: decode.getBigInt<BigInt?>(6),
      transferList: decode.messageTo<proto_basic_types.HederaTransferList?>(7, (b) => proto_basic_types.HederaTransferList.deserialize(b)),
      tokenTransferLists: decode.getListOfBytes(8).map((b) => proto_basic_types.HederaTokenTransferList.deserialize(b)).toList(),
      automaticTokenAssociations: decode.getListOfBytes(9).map((b) => proto_basic_types.HederaTokenAssociation.deserialize(b)).toList(),
      paidStakingRewards: decode.getListOfBytes(10).map((b) => proto_basic_types.HederaAccountAmount.deserialize(b)).toList(),
      congestionPricingMultiplier: decode.getBigInt<BigInt?>(11),
      assessedCustomFees: decode.getListOfBytes(12).map((b) => proto_custom_fees.HederaAssessedCustomFee.deserialize(b)).toList(),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiBlockStreamOutputTransactionResult;

}


