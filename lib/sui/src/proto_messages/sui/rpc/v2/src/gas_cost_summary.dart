import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/sui/src/proto_messages/types.dart';
import 'package:on_chain/sui/src/serialization/protobuf/proto.dart';

/// Copyright (c) Mysten Labs, Inc.
/// SPDX-License-Identifier: Apache-2.0
/// Summary of gas charges.
class SuiGasCostSummary extends SuiProtoMessage {
  /// Cost of computation/execution.
  final BigInt? computationCost;

  /// Storage cost, it's the sum of all storage cost for all objects created or mutated.
  final BigInt? storageCost;

  /// The amount of storage cost refunded to the user for all objects deleted or mutated in the
  /// transaction.
  final BigInt? storageRebate;

  /// The fee for the rebate. The portion of the storage rebate kept by the system.
  final BigInt? nonRefundableStorageFee;

  const SuiGasCostSummary({
    this.computationCost,
    this.storageCost,
    this.storageRebate,
    this.nonRefundableStorageFee,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.uint64(1, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(2, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(3, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(4, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    computationCost,
    storageCost,
    storageRebate,
    nonRefundableStorageFee,
  ];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'computation_cost': config.encodeBigint(computationCost),
      'storage_cost': config.encodeBigint(storageCost),
      'storage_rebate': config.encodeBigint(storageRebate),
      'non_refundable_storage_fee': config.encodeBigint(
        nonRefundableStorageFee,
      ),
    };
  }

  factory SuiGasCostSummary.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiGasCostSummary(
      computationCost: json.valueAsBigInt<BigInt?>(
        'computation_cost',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      storageCost: json.valueAsBigInt<BigInt?>(
        'storage_cost',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      storageRebate: json.valueAsBigInt<BigInt?>(
        'storage_rebate',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      nonRefundableStorageFee: json.valueAsBigInt<BigInt?>(
        'non_refundable_storage_fee',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiGasCostSummary.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiGasCostSummary(
      computationCost: decode.getBigInt<BigInt?>(1),
      storageCost: decode.getBigInt<BigInt?>(2),
      storageRebate: decode.getBigInt<BigInt?>(3),
      nonRefundableStorageFee: decode.getBigInt<BigInt?>(4),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2GasCostSummary;
}
