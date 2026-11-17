import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/sui/src/proto_messages/types.dart';
import 'package:on_chain/sui/src/serialization/protobuf/proto.dart';
import 'package:on_chain/sui/src/serialization/protobuf/wkt.dart';

import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/transaction.dart"
    as sui_rpc_v2_transaction;
import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/signature.dart"
    as sui_rpc_v2_signature;
import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/effects.dart"
    as sui_rpc_v2_effects;
import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/event.dart"
    as sui_rpc_v2_event;
import "package:on_chain/sui/src/proto_messages/google/protobuf/src/timestamp.dart"
    as google_protobuf_timestamp;
import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/balance_change.dart"
    as sui_rpc_v2_balance_change;
import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/object.dart"
    as sui_rpc_v2_object;

/// Copyright (c) Mysten Labs, Inc.
/// SPDX-License-Identifier: Apache-2.0
class SuiExecutedTransaction extends SuiProtoMessage {
  /// The digest of this Transaction.
  final String? digest;

  /// The transaction itself.
  final sui_rpc_v2_transaction.SuiTransaction? transaction;

  /// List of user signatures that are used to authorize the
  /// execution of this transaction.
  final List<sui_rpc_v2_signature.SuiUserSignature> signatures;

  /// The `TransactionEffects` for this transaction.
  final sui_rpc_v2_effects.SuiTransactionEffects? effects;

  /// The `TransactionEvents` for this transaction.
  ///
  /// This field might be empty, even if it was explicitly requested, if the
  /// transaction didn't produce any events.
  /// `sui.types.TransactionEffects.events_digest` is populated if the
  /// transaction produced any events.
  final sui_rpc_v2_event.SuiTransactionEvents? events;

  /// The sequence number for the checkpoint that includes this transaction.
  final BigInt? checkpoint;

  /// The Unix timestamp of the checkpoint that includes this transaction.
  final google_protobuf_timestamp.SuiTimestamp? timestamp;

  final List<sui_rpc_v2_balance_change.SuiBalanceChange> balanceChanges;

  /// Set of objects either referenced as inputs or produced as
  /// outputs from this Transaction.
  final sui_rpc_v2_object.SuiObjectSet? objects;

  /// Zero-based position of this transaction within the checkpoint that
  /// includes it.
  final BigInt? transactionIndex;

  const SuiExecutedTransaction({
    this.digest,
    this.transaction,
    this.signatures = const [],
    this.effects,
    this.events,
    this.checkpoint,
    this.timestamp,
    this.balanceChanges = const [],
    this.objects,
    this.transactionIndex,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(1, hasOptionalFlags: true),
        ProtoFieldConfig.message(2, hasOptionalFlags: true),
        ProtoFieldConfig.repeated(
          fieldNumber: 3,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.message(4, hasOptionalFlags: true),
        ProtoFieldConfig.message(5, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(6, hasOptionalFlags: true),
        ProtoFieldConfig.message(7, hasOptionalFlags: true),
        ProtoFieldConfig.repeated(
          fieldNumber: 8,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.message(9, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(10, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    digest,
    transaction,
    signatures,
    effects,
    events,
    checkpoint,
    timestamp,
    balanceChanges,
    objects,
    transactionIndex,
  ];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'digest': digest,
      'transaction': config.encodeMessage(transaction),
      'signatures': signatures.map((e) => config.encodeMessage(e)).toList(),
      'effects': config.encodeMessage(effects),
      'events': config.encodeMessage(events),
      'checkpoint': config.encodeBigint(checkpoint),
      'timestamp': timestamp?.toRfc3339(),
      'balance_changes':
          balanceChanges.map((e) => config.encodeMessage(e)).toList(),
      'objects': config.encodeMessage(objects),
      'transaction_index': config.encodeBigint(transactionIndex),
    };
  }

  factory SuiExecutedTransaction.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiExecutedTransaction(
      digest: json.valueAsString<String?>(
        'digest',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      transaction: json.valueTo<sui_rpc_v2_transaction.SuiTransaction?, Object>(
        key: 'transaction',
        parse:
            (v) => sui_rpc_v2_transaction.SuiTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      signatures:
          (json.valueEnsureAsList<dynamic>(
                'signatures',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<
                  sui_rpc_v2_signature.SuiUserSignature,
                  Object
                >(
                  value: e,
                  parse:
                      (v) => sui_rpc_v2_signature.SuiUserSignature.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      effects: json.valueTo<sui_rpc_v2_effects.SuiTransactionEffects?, Object>(
        key: 'effects',
        parse:
            (v) => sui_rpc_v2_effects.SuiTransactionEffects.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      events: json.valueTo<sui_rpc_v2_event.SuiTransactionEvents?, Object>(
        key: 'events',
        parse:
            (v) => sui_rpc_v2_event.SuiTransactionEvents.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      checkpoint: json.valueAsBigInt<BigInt?>(
        'checkpoint',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      timestamp: json.valueTo<google_protobuf_timestamp.SuiTimestamp?, Object>(
        key: 'timestamp',
        parse:
            (v) => google_protobuf_timestamp.SuiTimestamp.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      balanceChanges:
          (json.valueEnsureAsList<dynamic>(
                'balance_changes',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<
                  sui_rpc_v2_balance_change.SuiBalanceChange,
                  Object
                >(
                  value: e,
                  parse:
                      (v) =>
                          sui_rpc_v2_balance_change.SuiBalanceChange.fromJson(
                            JsonParser.valueAs(v),
                            config: config,
                          ),
                ),
              )
              .toList(),
      objects: json.valueTo<sui_rpc_v2_object.SuiObjectSet?, Object>(
        key: 'objects',
        parse:
            (v) => sui_rpc_v2_object.SuiObjectSet.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      transactionIndex: json.valueAsBigInt<BigInt?>(
        'transaction_index',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiExecutedTransaction.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiExecutedTransaction(
      digest: decode.getString<String?>(1),
      transaction: decode.messageTo<sui_rpc_v2_transaction.SuiTransaction?>(
        2,
        (b) => sui_rpc_v2_transaction.SuiTransaction.deserialize(b),
      ),
      signatures:
          decode
              .getListOfBytes(3)
              .map((b) => sui_rpc_v2_signature.SuiUserSignature.deserialize(b))
              .toList(),
      effects: decode.messageTo<sui_rpc_v2_effects.SuiTransactionEffects?>(
        4,
        (b) => sui_rpc_v2_effects.SuiTransactionEffects.deserialize(b),
      ),
      events: decode.messageTo<sui_rpc_v2_event.SuiTransactionEvents?>(
        5,
        (b) => sui_rpc_v2_event.SuiTransactionEvents.deserialize(b),
      ),
      checkpoint: decode.getBigInt<BigInt?>(6),
      timestamp: decode.messageTo<google_protobuf_timestamp.SuiTimestamp?>(
        7,
        (b) => google_protobuf_timestamp.SuiTimestamp.deserialize(b),
      ),
      balanceChanges:
          decode
              .getListOfBytes(8)
              .map(
                (b) =>
                    sui_rpc_v2_balance_change.SuiBalanceChange.deserialize(b),
              )
              .toList(),
      objects: decode.messageTo<sui_rpc_v2_object.SuiObjectSet?>(
        9,
        (b) => sui_rpc_v2_object.SuiObjectSet.deserialize(b),
      ),
      transactionIndex: decode.getBigInt<BigInt?>(10),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2ExecutedTransaction;
}
