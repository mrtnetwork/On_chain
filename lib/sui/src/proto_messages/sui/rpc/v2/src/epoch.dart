import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/sui/src/proto_messages/types.dart';
import 'package:on_chain/sui/src/serialization/protobuf/proto.dart';
import 'package:on_chain/sui/src/serialization/protobuf/wkt.dart';

import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/signature.dart"
    as sui_rpc_v2_signature;
import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/system_state.dart"
    as sui_rpc_v2_system_state;
import "package:on_chain/sui/src/proto_messages/google/protobuf/src/timestamp.dart"
    as google_protobuf_timestamp;
import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/protocol_config.dart"
    as sui_rpc_v2_protocol_config;

/// Copyright (c) Mysten Labs, Inc.
/// SPDX-License-Identifier: Apache-2.0
class SuiEpoch extends SuiProtoMessage {
  final BigInt? epoch;

  /// The committee governing this epoch.
  final sui_rpc_v2_signature.SuiValidatorCommittee? committee;

  /// Snapshot of Sui's SystemState (`0x3::sui_system::SystemState`) at the
  /// beginning of the epoch, for past epochs, or the current state for the
  /// current epoch.
  final sui_rpc_v2_system_state.SuiSystemState? systemState;

  final BigInt? firstCheckpoint;

  final BigInt? lastCheckpoint;

  final google_protobuf_timestamp.SuiTimestamp? start;

  final google_protobuf_timestamp.SuiTimestamp? end;

  /// Reference gas price denominated in MIST
  final BigInt? referenceGasPrice;

  final sui_rpc_v2_protocol_config.SuiProtocolConfig? protocolConfig;

  const SuiEpoch({
    this.epoch,
    this.committee,
    this.systemState,
    this.firstCheckpoint,
    this.lastCheckpoint,
    this.start,
    this.end,
    this.referenceGasPrice,
    this.protocolConfig,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.uint64(1, hasOptionalFlags: true),
        ProtoFieldConfig.message(2, hasOptionalFlags: true),
        ProtoFieldConfig.message(3, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(4, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(5, hasOptionalFlags: true),
        ProtoFieldConfig.message(6, hasOptionalFlags: true),
        ProtoFieldConfig.message(7, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(8, hasOptionalFlags: true),
        ProtoFieldConfig.message(9, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    epoch,
    committee,
    systemState,
    firstCheckpoint,
    lastCheckpoint,
    start,
    end,
    referenceGasPrice,
    protocolConfig,
  ];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'epoch': config.encodeBigint(epoch),
      'committee': config.encodeMessage(committee),
      'system_state': config.encodeMessage(systemState),
      'first_checkpoint': config.encodeBigint(firstCheckpoint),
      'last_checkpoint': config.encodeBigint(lastCheckpoint),
      'start': start?.toRfc3339(),
      'end': end?.toRfc3339(),
      'reference_gas_price': config.encodeBigint(referenceGasPrice),
      'protocol_config': config.encodeMessage(protocolConfig),
    };
  }

  factory SuiEpoch.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiEpoch(
      epoch: json.valueAsBigInt<BigInt?>(
        'epoch',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      committee: json
          .valueTo<sui_rpc_v2_signature.SuiValidatorCommittee?, Object>(
            key: 'committee',
            parse:
                (v) => sui_rpc_v2_signature.SuiValidatorCommittee.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      systemState: json
          .valueTo<sui_rpc_v2_system_state.SuiSystemState?, Object>(
            key: 'system_state',
            parse:
                (v) => sui_rpc_v2_system_state.SuiSystemState.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      firstCheckpoint: json.valueAsBigInt<BigInt?>(
        'first_checkpoint',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      lastCheckpoint: json.valueAsBigInt<BigInt?>(
        'last_checkpoint',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      start: json.valueTo<google_protobuf_timestamp.SuiTimestamp?, Object>(
        key: 'start',
        parse:
            (v) => google_protobuf_timestamp.SuiTimestamp.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      end: json.valueTo<google_protobuf_timestamp.SuiTimestamp?, Object>(
        key: 'end',
        parse:
            (v) => google_protobuf_timestamp.SuiTimestamp.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      referenceGasPrice: json.valueAsBigInt<BigInt?>(
        'reference_gas_price',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      protocolConfig: json
          .valueTo<sui_rpc_v2_protocol_config.SuiProtocolConfig?, Object>(
            key: 'protocol_config',
            parse:
                (v) => sui_rpc_v2_protocol_config.SuiProtocolConfig.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
    );
  }

  factory SuiEpoch.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiEpoch(
      epoch: decode.getBigInt<BigInt?>(1),
      committee: decode.messageTo<sui_rpc_v2_signature.SuiValidatorCommittee?>(
        2,
        (b) => sui_rpc_v2_signature.SuiValidatorCommittee.deserialize(b),
      ),
      systemState: decode.messageTo<sui_rpc_v2_system_state.SuiSystemState?>(
        3,
        (b) => sui_rpc_v2_system_state.SuiSystemState.deserialize(b),
      ),
      firstCheckpoint: decode.getBigInt<BigInt?>(4),
      lastCheckpoint: decode.getBigInt<BigInt?>(5),
      start: decode.messageTo<google_protobuf_timestamp.SuiTimestamp?>(
        6,
        (b) => google_protobuf_timestamp.SuiTimestamp.deserialize(b),
      ),
      end: decode.messageTo<google_protobuf_timestamp.SuiTimestamp?>(
        7,
        (b) => google_protobuf_timestamp.SuiTimestamp.deserialize(b),
      ),
      referenceGasPrice: decode.getBigInt<BigInt?>(8),
      protocolConfig: decode
          .messageTo<sui_rpc_v2_protocol_config.SuiProtocolConfig?>(
            9,
            (b) => sui_rpc_v2_protocol_config.SuiProtocolConfig.deserialize(b),
          ),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2Epoch;
}
