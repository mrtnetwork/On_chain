import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/block/stream/output/src/util_service.dart"
    as com_hedera_hapi_block_stream_output_util_service;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/block/stream/output/src/smart_contract_service.dart"
    as com_hedera_hapi_block_stream_output_smart_contract_service;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/block/stream/output/src/schedule_service.dart"
    as com_hedera_hapi_block_stream_output_schedule_service;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/block/stream/output/src/crypto_service.dart"
    as com_hedera_hapi_block_stream_output_crypto_service;

/// *
///  * # Transaction Output
///  * Messages that describe the output of a transaction; data reported
///  * in the block stream that is not in the transaction body and is
///  * not reported in state changes.
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
///  * Output from a transaction.
///  *
///  * The values in transaction outputs SHALL be data that is neither present
///  * in the original transaction nor present in state changes.
///  *
///  * &gt; Note
///  * &gt;&gt; Only a few transactions produce output that is not in the transaction
///  * &gt;&gt; and also not reflected in state changes. All other transaction types
///  * &gt;&gt; are _currently_ not included here. We have, however, allocated names
///  * &gt;&gt; for those transaction types to preserve consistency if we
///  * &gt;&gt; add them later.
///  *
///  * &lt;!--
///  * Reserved definitions:
///  * import "stream/smart_contract_service.proto";
///  *    UpdateContractOutput contract_update;
///  *    DeleteContractOutput contract_delete;
///  *    SystemDeleteContractOutput
///  *    SystemUnDeleteContractOutput
///  *    CreateTopicOutput create_topic;
///  *    UpdateTopicOutput update_topic;
///  *
///  * import "stream/file_service.proto";
///  *    CreateFileOutput file_create;
///  *    AppendFileOutput file_append;
///  *    UpdateFileOutput file_update;
///  *    DeleteFileOutput file_delete;
///  *    SystemDeleteOutput system_delete;
///  *    SystemUndeleteOutput system_undelete;
///  *
///  * import "stream/crypto_service.proto";
///  *    CryptoTransferOutput crypto_transfer;
///  *    UpdateNodeStakeOutput update_node_stake;
///  *    ApproveAllowanceOutput approve_allowance;
///  *    DeleteAllowanceOutput delete_allowance;
///  *    UpdateAccountOutput update_account;
///  *    DeleteAccountOutput delete_account;
///  *
///  * import "stream/token_service.proto";
///  *    CreateTokenOutput create_token;
///  *    DeleteTokenOutput delete_token;
///  *    FreezeTokenAccountOutput freeze_token_account;
///  *    UnfreezeTokenAccountOutput unfreeze_token_account;
///  *    GrantTokenKycOutput grant_token_account_kyc;
///  *    RevokeTokenKycOutput revoke_token_account_kyc;
///  *    UpdateTokenOutput update_token;
///  *    UpdateTokenNftsOutput update_token_nfts;
///  *    MintTokenOutput mint_token;
///  *    BurnTokenOutput burn_token;
///  *    WipeTokenAccountOutput wipe_token_account;
///  *    AssociateTokenOutput associate_token;
///  *    DissociateTokenOutput dissociate_token;
///  *    UpdateTokenFeeScheduleOutput update_token_fee_schedule;
///  *    PauseTokenOutput pause_token;
///  *    UnpauseTokenOutput unpause_token;
///  *    TokenAirdropOutput token_airdrop;
///  *
///  * import "stream/consensus_service.proto";
///  *    DeleteTopicOutput delete_topic;
///  *    SubmitMessageOutput submit_message;
///  *
///  * import "stream/schedule_service.proto";
///  *    DeleteScheduleOutput delete_schedule;
///  *
///  * import "stream/network_service.proto";
///  *    FreezeOutput freeze_network;
///  * --&gt;
class HederaTransactionOutput extends HederaProtoMessage with Equality {
  /// *
  ///          * Output from a utilPrng transaction to request a
  ///          * deterministic pseudo-random number.
  final com_hedera_hapi_block_stream_output_util_service.HederaUtilPrngOutput?
  utilPrng;

  /// *
  ///          * Output from a contract call transaction.
  final com_hedera_hapi_block_stream_output_smart_contract_service.HederaCallContractOutput?
  contractCall;

  /// *
  ///          * Output from an ethereum call transaction.
  final com_hedera_hapi_block_stream_output_smart_contract_service.HederaEthereumOutput?
  ethereumCall;

  /// *
  ///          * Output from a contract create transaction.
  final com_hedera_hapi_block_stream_output_smart_contract_service.HederaCreateContractOutput?
  contractCreate;

  /// *
  ///          * Output from a schedule create transaction that executed
  ///          * immediately on creation.
  final com_hedera_hapi_block_stream_output_schedule_service.HederaCreateScheduleOutput?
  createSchedule;

  /// *
  ///          * Output from a schedule sign transaction that resulted in
  ///          * executing the scheduled transaction.
  final com_hedera_hapi_block_stream_output_schedule_service.HederaSignScheduleOutput?
  signSchedule;

  /// *
  ///          * Output from a transaction that includes the creation of a new
  ///          * CryptoService Account.
  final com_hedera_hapi_block_stream_output_crypto_service.HederaCreateAccountOutput?
  accountCreate;

  const HederaTransactionOutput({
    this.utilPrng,
    this.contractCall,
    this.ethereumCall,
    this.contractCreate,
    this.createSchedule,
    this.signSchedule,
    this.accountCreate,
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
        ProtoFieldConfig.message(6),
        ProtoFieldConfig.message(7),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    utilPrng,
    contractCall,
    ethereumCall,
    contractCreate,
    createSchedule,
    signSchedule,
    accountCreate,
  ];

  HederaTransactionOutput copyWith({
    com_hedera_hapi_block_stream_output_util_service.HederaUtilPrngOutput?
    utilPrng,

    com_hedera_hapi_block_stream_output_smart_contract_service.HederaCallContractOutput?
    contractCall,

    com_hedera_hapi_block_stream_output_smart_contract_service.HederaEthereumOutput?
    ethereumCall,

    com_hedera_hapi_block_stream_output_smart_contract_service.HederaCreateContractOutput?
    contractCreate,

    com_hedera_hapi_block_stream_output_schedule_service.HederaCreateScheduleOutput?
    createSchedule,

    com_hedera_hapi_block_stream_output_schedule_service.HederaSignScheduleOutput?
    signSchedule,

    com_hedera_hapi_block_stream_output_crypto_service.HederaCreateAccountOutput?
    accountCreate,
  }) {
    return HederaTransactionOutput(
      utilPrng: utilPrng ?? this.utilPrng,
      contractCall: contractCall ?? this.contractCall,
      ethereumCall: ethereumCall ?? this.ethereumCall,
      contractCreate: contractCreate ?? this.contractCreate,
      createSchedule: createSchedule ?? this.createSchedule,
      signSchedule: signSchedule ?? this.signSchedule,
      accountCreate: accountCreate ?? this.accountCreate,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'util_prng': config.encodeMessage(utilPrng),
      'contract_call': config.encodeMessage(contractCall),
      'ethereum_call': config.encodeMessage(ethereumCall),
      'contract_create': config.encodeMessage(contractCreate),
      'create_schedule': config.encodeMessage(createSchedule),
      'sign_schedule': config.encodeMessage(signSchedule),
      'account_create': config.encodeMessage(accountCreate),
    };
  }

  factory HederaTransactionOutput.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaTransactionOutput(
      utilPrng: json.valueTo<
        com_hedera_hapi_block_stream_output_util_service.HederaUtilPrngOutput?,
        Object
      >(
        key: 'util_prng',
        parse:
            (v) => com_hedera_hapi_block_stream_output_util_service
                .HederaUtilPrngOutput.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      contractCall: json.valueTo<
        com_hedera_hapi_block_stream_output_smart_contract_service.HederaCallContractOutput?,
        Object
      >(
        key: 'contract_call',
        parse:
            (v) => com_hedera_hapi_block_stream_output_smart_contract_service
                .HederaCallContractOutput.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      ethereumCall: json.valueTo<
        com_hedera_hapi_block_stream_output_smart_contract_service.HederaEthereumOutput?,
        Object
      >(
        key: 'ethereum_call',
        parse:
            (v) => com_hedera_hapi_block_stream_output_smart_contract_service
                .HederaEthereumOutput.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      contractCreate: json.valueTo<
        com_hedera_hapi_block_stream_output_smart_contract_service.HederaCreateContractOutput?,
        Object
      >(
        key: 'contract_create',
        parse:
            (v) => com_hedera_hapi_block_stream_output_smart_contract_service
                .HederaCreateContractOutput.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      createSchedule: json.valueTo<
        com_hedera_hapi_block_stream_output_schedule_service.HederaCreateScheduleOutput?,
        Object
      >(
        key: 'create_schedule',
        parse:
            (v) => com_hedera_hapi_block_stream_output_schedule_service
                .HederaCreateScheduleOutput.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      signSchedule: json.valueTo<
        com_hedera_hapi_block_stream_output_schedule_service.HederaSignScheduleOutput?,
        Object
      >(
        key: 'sign_schedule',
        parse:
            (v) => com_hedera_hapi_block_stream_output_schedule_service
                .HederaSignScheduleOutput.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      accountCreate: json.valueTo<
        com_hedera_hapi_block_stream_output_crypto_service.HederaCreateAccountOutput?,
        Object
      >(
        key: 'account_create',
        parse:
            (v) => com_hedera_hapi_block_stream_output_crypto_service
                .HederaCreateAccountOutput.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaTransactionOutput.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTransactionOutput(
      utilPrng: decode.messageTo<
        com_hedera_hapi_block_stream_output_util_service.HederaUtilPrngOutput?
      >(
        1,
        (b) => com_hedera_hapi_block_stream_output_util_service
            .HederaUtilPrngOutput.deserialize(b),
      ),
      contractCall: decode.messageTo<
        com_hedera_hapi_block_stream_output_smart_contract_service.HederaCallContractOutput?
      >(
        2,
        (b) => com_hedera_hapi_block_stream_output_smart_contract_service
            .HederaCallContractOutput.deserialize(b),
      ),
      ethereumCall: decode.messageTo<
        com_hedera_hapi_block_stream_output_smart_contract_service.HederaEthereumOutput?
      >(
        3,
        (b) => com_hedera_hapi_block_stream_output_smart_contract_service
            .HederaEthereumOutput.deserialize(b),
      ),
      contractCreate: decode.messageTo<
        com_hedera_hapi_block_stream_output_smart_contract_service.HederaCreateContractOutput?
      >(
        4,
        (b) => com_hedera_hapi_block_stream_output_smart_contract_service
            .HederaCreateContractOutput.deserialize(b),
      ),
      createSchedule: decode.messageTo<
        com_hedera_hapi_block_stream_output_schedule_service.HederaCreateScheduleOutput?
      >(
        5,
        (b) => com_hedera_hapi_block_stream_output_schedule_service
            .HederaCreateScheduleOutput.deserialize(b),
      ),
      signSchedule: decode.messageTo<
        com_hedera_hapi_block_stream_output_schedule_service.HederaSignScheduleOutput?
      >(
        6,
        (b) => com_hedera_hapi_block_stream_output_schedule_service
            .HederaSignScheduleOutput.deserialize(b),
      ),
      accountCreate: decode.messageTo<
        com_hedera_hapi_block_stream_output_crypto_service.HederaCreateAccountOutput?
      >(
        7,
        (b) => com_hedera_hapi_block_stream_output_crypto_service
            .HederaCreateAccountOutput.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiBlockStreamOutputTransactionOutput;
}
