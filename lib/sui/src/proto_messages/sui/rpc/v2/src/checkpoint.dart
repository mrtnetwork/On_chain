import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/sui/src/proto_messages/types.dart';
import 'package:on_chain/sui/src/serialization/protobuf/proto.dart';
import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/checkpoint_summary.dart" as sui_rpc_v2_checkpoint_summary;
import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/signature.dart" as sui_rpc_v2_signature;
import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/checkpoint_contents.dart" as sui_rpc_v2_checkpoint_contents;
import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/executed_transaction.dart" as sui_rpc_v2_executed_transaction;
import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/object.dart" as sui_rpc_v2_object;

/// Copyright (c) Mysten Labs, Inc.
/// SPDX-License-Identifier: Apache-2.0
class SuiCheckpoint extends SuiProtoMessage {
    /// The height of this checkpoint.
  final BigInt? sequenceNumber;

    /// The digest of this Checkpoint's CheckpointSummary.
  final String? digest;

    /// The `CheckpointSummary` for this checkpoint.
  final sui_rpc_v2_checkpoint_summary.SuiCheckpointSummary? summary;

    /// An aggregated quorum signature from the validator committee that
  /// certified this checkpoint.
  final sui_rpc_v2_signature.SuiValidatorAggregatedSignature? signature;

    /// The `CheckpointContents` for this checkpoint.
  final sui_rpc_v2_checkpoint_contents.SuiCheckpointContents? contents;

    /// List of transactions included in this checkpoint.
  final List<sui_rpc_v2_executed_transaction.SuiExecutedTransaction> transactions;

    /// Set of objects either referenced as inputs or produced as
  /// outputs by transactions included in this checkpoint.
  ///
  /// In order to benefit from deduplication of objects that
  /// appear in multiple transactions in this checkpoint, objects
  /// will only be present here and the `transactions.objects`
  /// field will not be populated.
  final sui_rpc_v2_object.SuiObjectSet? objects;

  const SuiCheckpoint({
    this.sequenceNumber,
    this.digest,
    this.summary,
    this.signature,
    this.contents,
    this.transactions = const [],
    this.objects,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.uint64(1, hasOptionalFlags: true),
        ProtoFieldConfig.string(2, hasOptionalFlags: true),
        ProtoFieldConfig.message(3, hasOptionalFlags: true),
        ProtoFieldConfig.message(4, hasOptionalFlags: true),
        ProtoFieldConfig.message(5, hasOptionalFlags: true),
        ProtoFieldConfig.repeated(
          fieldNumber: 6,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.message(7, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        sequenceNumber,
        digest,
        summary,
        signature,
        contents,
        transactions,
        objects,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'sequence_number': config.encodeBigint(sequenceNumber),
      'digest': digest,
      'summary': config.encodeMessage(summary),
      'signature': config.encodeMessage(signature),
      'contents': config.encodeMessage(contents),
      'transactions': transactions.map((e) => config.encodeMessage(e)).toList(),
      'objects': config.encodeMessage(objects),
    };
  }


  factory SuiCheckpoint.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiCheckpoint(
      sequenceNumber: json.valueAsBigInt<BigInt?>('sequence_number', normalizeKeyLookup: config.normalizeKeys),
      digest: json.valueAsString<String?>('digest', normalizeKeyLookup: config.normalizeKeys),
      summary: json.valueTo<sui_rpc_v2_checkpoint_summary.SuiCheckpointSummary?, Object>(
        key: 'summary',
        parse: (v) => sui_rpc_v2_checkpoint_summary.SuiCheckpointSummary.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      signature: json.valueTo<sui_rpc_v2_signature.SuiValidatorAggregatedSignature?, Object>(
        key: 'signature',
        parse: (v) => sui_rpc_v2_signature.SuiValidatorAggregatedSignature.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      contents: json.valueTo<sui_rpc_v2_checkpoint_contents.SuiCheckpointContents?, Object>(
        key: 'contents',
        parse: (v) => sui_rpc_v2_checkpoint_contents.SuiCheckpointContents.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      transactions: (json.valueEnsureAsList<dynamic>('transactions', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<sui_rpc_v2_executed_transaction.SuiExecutedTransaction, Object>(
          value: e,
          parse: (v) => sui_rpc_v2_executed_transaction.SuiExecutedTransaction.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
      objects: json.valueTo<sui_rpc_v2_object.SuiObjectSet?, Object>(
        key: 'objects',
        parse: (v) => sui_rpc_v2_object.SuiObjectSet.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory SuiCheckpoint.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiCheckpoint(
      sequenceNumber: decode.getBigInt<BigInt?>(1),
      digest: decode.getString<String?>(2),
      summary: decode.messageTo<sui_rpc_v2_checkpoint_summary.SuiCheckpointSummary?>(3, (b) => sui_rpc_v2_checkpoint_summary.SuiCheckpointSummary.deserialize(b)),
      signature: decode.messageTo<sui_rpc_v2_signature.SuiValidatorAggregatedSignature?>(4, (b) => sui_rpc_v2_signature.SuiValidatorAggregatedSignature.deserialize(b)),
      contents: decode.messageTo<sui_rpc_v2_checkpoint_contents.SuiCheckpointContents?>(5, (b) => sui_rpc_v2_checkpoint_contents.SuiCheckpointContents.deserialize(b)),
      transactions: decode.getListOfBytes(6).map((b) => sui_rpc_v2_executed_transaction.SuiExecutedTransaction.deserialize(b)).toList(),
      objects: decode.messageTo<sui_rpc_v2_object.SuiObjectSet?>(7, (b) => sui_rpc_v2_object.SuiObjectSet.deserialize(b)),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2Checkpoint;

}


