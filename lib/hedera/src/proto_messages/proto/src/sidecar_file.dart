import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/timestamp.dart"
    as proto_timestamp;
import "package:on_chain/hedera/src/proto_messages/proto/src/contract_state_change.dart"
    as proto_contract_state_change;
import "package:on_chain/hedera/src/proto_messages/proto/src/contract_action.dart"
    as proto_contract_action;
import "package:on_chain/hedera/src/proto_messages/proto/src/contract_bytecode.dart"
    as proto_contract_bytecode;

/// -
///  * ‌
///  * Hedera Network Services Protobuf
///  * ​
///  * Copyright (C) 2018 - 2022 Hedera Hashgraph, LLC
///  * ​
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
///  * ‍
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.streams"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * A SidecarFile contains a list of TransactionSidecarRecords that are all created
///  * in the same period and related to the same RecordStreamFile.
class HederaSidecarFile extends HederaProtoMessage with Equality {
  /// *
  ///    * List of sidecar records
  final List<HederaTransactionSidecarRecord> sidecarRecords;

  const HederaSidecarFile({this.sidecarRecords = const []});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.repeated(
          fieldNumber: 1,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [sidecarRecords];

  HederaSidecarFile copyWith({
    List<HederaTransactionSidecarRecord>? sidecarRecords,
  }) {
    return HederaSidecarFile(
      sidecarRecords: sidecarRecords ?? this.sidecarRecords,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'sidecar_records':
          sidecarRecords.map((e) => config.encodeMessage(e)).toList(),
    };
  }

  factory HederaSidecarFile.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaSidecarFile(
      sidecarRecords:
          (json.valueEnsureAsList<dynamic>(
                'sidecar_records',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) =>
                    JsonParser.valueTo<HederaTransactionSidecarRecord, Object>(
                      value: e,
                      parse:
                          (v) => HederaTransactionSidecarRecord.fromJson(
                            JsonParser.valueAs(v),
                            config: config,
                          ),
                    ),
              )
              .toList(),
    );
  }

  factory HederaSidecarFile.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaSidecarFile(
      sidecarRecords:
          decode
              .getListOfBytes(1)
              .map((b) => HederaTransactionSidecarRecord.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoSidecarFile;
}

/// *
///  * TransactionSidecarRecord is used to create sidecar records complementing
///  * TransactionRecord and storing additional information about a transaction's execution.
class HederaTransactionSidecarRecord extends HederaProtoMessage with Equality {
  /// *
  ///    * Consensus timestamp will be the same as the consensus timestamp of the
  ///    * transaction the side car is related to. This offers a convenient
  ///    * way to match record to sidecar.
  final proto_timestamp.HederaTimestamp? consensusTimestamp;

  /// *
  ///   * Whether sidecar is from migration.
  final bool? migration;

  /// * List of sidecar types.
  ///   * In future there will be other categories.
  final proto_contract_state_change.HederaContractStateChanges? stateChanges;

  final proto_contract_action.HederaContractActions? actions;

  final proto_contract_bytecode.HederaContractBytecode? bytecode;

  const HederaTransactionSidecarRecord({
    this.consensusTimestamp,
    this.migration,
    this.stateChanges,
    this.actions,
    this.bytecode,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.bool(2),
        ProtoFieldConfig.message(3),
        ProtoFieldConfig.message(4),
        ProtoFieldConfig.message(5),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    consensusTimestamp,
    migration,
    stateChanges,
    actions,
    bytecode,
  ];

  HederaTransactionSidecarRecord copyWith({
    proto_timestamp.HederaTimestamp? consensusTimestamp,

    bool? migration,

    proto_contract_state_change.HederaContractStateChanges? stateChanges,

    proto_contract_action.HederaContractActions? actions,

    proto_contract_bytecode.HederaContractBytecode? bytecode,
  }) {
    return HederaTransactionSidecarRecord(
      consensusTimestamp: consensusTimestamp ?? this.consensusTimestamp,
      migration: migration ?? this.migration,
      stateChanges: stateChanges ?? this.stateChanges,
      actions: actions ?? this.actions,
      bytecode: bytecode ?? this.bytecode,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'consensus_timestamp': config.encodeMessage(consensusTimestamp),
      'migration': migration,
      'state_changes': config.encodeMessage(stateChanges),
      'actions': config.encodeMessage(actions),
      'bytecode': config.encodeMessage(bytecode),
    };
  }

  factory HederaTransactionSidecarRecord.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaTransactionSidecarRecord(
      consensusTimestamp: json
          .valueTo<proto_timestamp.HederaTimestamp?, Object>(
            key: 'consensus_timestamp',
            parse:
                (v) => proto_timestamp.HederaTimestamp.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      migration: json.valueAsBool<bool?>(
        'migration',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      stateChanges: json.valueTo<
        proto_contract_state_change.HederaContractStateChanges?,
        Object
      >(
        key: 'state_changes',
        parse:
            (v) =>
                proto_contract_state_change.HederaContractStateChanges.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      actions: json
          .valueTo<proto_contract_action.HederaContractActions?, Object>(
            key: 'actions',
            parse:
                (v) => proto_contract_action.HederaContractActions.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      bytecode: json
          .valueTo<proto_contract_bytecode.HederaContractBytecode?, Object>(
            key: 'bytecode',
            parse:
                (v) => proto_contract_bytecode.HederaContractBytecode.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
    );
  }

  factory HederaTransactionSidecarRecord.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTransactionSidecarRecord(
      consensusTimestamp: decode.messageTo<proto_timestamp.HederaTimestamp?>(
        1,
        (b) => proto_timestamp.HederaTimestamp.deserialize(b),
      ),
      migration: decode.getBool<bool?>(2),
      stateChanges: decode
          .messageTo<proto_contract_state_change.HederaContractStateChanges?>(
            3,
            (b) => proto_contract_state_change
                .HederaContractStateChanges.deserialize(b),
          ),
      actions: decode.messageTo<proto_contract_action.HederaContractActions?>(
        4,
        (b) => proto_contract_action.HederaContractActions.deserialize(b),
      ),
      bytecode: decode
          .messageTo<proto_contract_bytecode.HederaContractBytecode?>(
            5,
            (b) =>
                proto_contract_bytecode.HederaContractBytecode.deserialize(b),
          ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoTransactionSidecarRecord;
}
