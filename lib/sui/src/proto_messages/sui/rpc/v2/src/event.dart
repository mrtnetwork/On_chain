import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/sui/src/proto_messages/types.dart';
import 'package:on_chain/sui/src/serialization/protobuf/proto.dart';
import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/bcs.dart" as sui_rpc_v2_bcs;
import "package:on_chain/sui/src/proto_messages/google/protobuf/src/struct.dart" as google_protobuf_struct;

/// Copyright (c) Mysten Labs, Inc.
/// SPDX-License-Identifier: Apache-2.0
/// Events emitted during the successful execution of a transaction.
class SuiTransactionEvents extends SuiProtoMessage {
    /// This TransactionEvents serialized as BCS.
  final sui_rpc_v2_bcs.SuiBcs? bcs;

    /// The digest of this TransactionEvents.
  final String? digest;

    /// Set of events emitted by a transaction.
  final List<SuiEvent> events;

  const SuiTransactionEvents({
    this.bcs,
    this.digest,
    this.events = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1, hasOptionalFlags: true),
        ProtoFieldConfig.string(2, hasOptionalFlags: true),
        ProtoFieldConfig.repeated(
          fieldNumber: 3,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        bcs,
        digest,
        events,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'bcs': config.encodeMessage(bcs),
      'digest': digest,
      'events': events.map((e) => config.encodeMessage(e)).toList(),
    };
  }


  factory SuiTransactionEvents.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiTransactionEvents(
      bcs: json.valueTo<sui_rpc_v2_bcs.SuiBcs?, Object>(
        key: 'bcs',
        parse: (v) => sui_rpc_v2_bcs.SuiBcs.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      digest: json.valueAsString<String?>('digest', normalizeKeyLookup: config.normalizeKeys),
      events: (json.valueEnsureAsList<dynamic>('events', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<SuiEvent, Object>(
          value: e,
          parse: (v) => SuiEvent.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
    );
  }

  factory SuiTransactionEvents.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiTransactionEvents(
      bcs: decode.messageTo<sui_rpc_v2_bcs.SuiBcs?>(1, (b) => sui_rpc_v2_bcs.SuiBcs.deserialize(b)),
      digest: decode.getString<String?>(2),
      events: decode.getListOfBytes(3).map((b) => SuiEvent.deserialize(b)).toList(),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2TransactionEvents;

}


/// An event.
class SuiEvent extends SuiProtoMessage {
    /// Package ID of the top-level function invoked by a `MoveCall` command that triggered this
  /// event to be emitted.
  final String? packageId;

    /// Module name of the top-level function invoked by a `MoveCall` command that triggered this
  /// event to be emitted.
  final String? module;

    /// Address of the account that sent the transaction where this event was emitted.
  final String? sender;

    /// The type of the event emitted.
  final String? eventType;

    /// BCS serialized bytes of the event.
  final sui_rpc_v2_bcs.SuiBcs? contents;

    /// JSON rendering of the event.
  final google_protobuf_struct.SuiValue? json;

    /// The sequence number of the checkpoint that includes the transaction
  /// that emitted this event. Populated when the event is delivered on its
  /// own (for example via `LedgerService.ListEvents`); left unset when the
  /// event is carried inside its transaction's `events` list, where the
  /// enclosing `ExecutedTransaction` already provides this context.
  final BigInt? checkpoint;

    /// The digest of the transaction that emitted this event.
  final String? transactionDigest;

    /// Zero-based position of the emitting transaction within its containing
  /// checkpoint. For clients verifying authenticated event streams this
  /// index is part of the BCS-encoded `EventCommitment` leaf used to
  /// construct the per-checkpoint merkle root.
  final BigInt? transactionIndex;

    /// Zero-based index of this event within its transaction's event list.
  final int? eventIndex;

  const SuiEvent({
    this.packageId,
    this.module,
    this.sender,
    this.eventType,
    this.contents,
    this.json,
    this.checkpoint,
    this.transactionDigest,
    this.transactionIndex,
    this.eventIndex,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(1, hasOptionalFlags: true),
        ProtoFieldConfig.string(2, hasOptionalFlags: true),
        ProtoFieldConfig.string(3, hasOptionalFlags: true),
        ProtoFieldConfig.string(4, hasOptionalFlags: true),
        ProtoFieldConfig.message(5, hasOptionalFlags: true),
        ProtoFieldConfig.message(6, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(7, hasOptionalFlags: true),
        ProtoFieldConfig.string(8, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(9, hasOptionalFlags: true),
        ProtoFieldConfig.uint32(10, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        packageId,
        module,
        sender,
        eventType,
        contents,
        json,
        checkpoint,
        transactionDigest,
        transactionIndex,
        eventIndex,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'package_id': packageId,
      'module': module,
      'sender': sender,
      'event_type': eventType,
      'contents': config.encodeMessage(contents),
      'json': config.encodeMessage(json),
      'checkpoint': config.encodeBigint(checkpoint),
      'transaction_digest': transactionDigest,
      'transaction_index': config.encodeBigint(transactionIndex),
      'event_index': eventIndex,
    };
  }


  factory SuiEvent.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiEvent(
      packageId: json.valueAsString<String?>('package_id', normalizeKeyLookup: config.normalizeKeys),
      module: json.valueAsString<String?>('module', normalizeKeyLookup: config.normalizeKeys),
      sender: json.valueAsString<String?>('sender', normalizeKeyLookup: config.normalizeKeys),
      eventType: json.valueAsString<String?>('event_type', normalizeKeyLookup: config.normalizeKeys),
      contents: json.valueTo<sui_rpc_v2_bcs.SuiBcs?, Object>(
        key: 'contents',
        parse: (v) => sui_rpc_v2_bcs.SuiBcs.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      json: json.valueTo<google_protobuf_struct.SuiValue?, Object>(
        key: 'json',
        parse: (v) => google_protobuf_struct.SuiValue.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      checkpoint: json.valueAsBigInt<BigInt?>('checkpoint', normalizeKeyLookup: config.normalizeKeys),
      transactionDigest: json.valueAsString<String?>('transaction_digest', normalizeKeyLookup: config.normalizeKeys),
      transactionIndex: json.valueAsBigInt<BigInt?>('transaction_index', normalizeKeyLookup: config.normalizeKeys),
      eventIndex: json.valueAsInt<int?>('event_index', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory SuiEvent.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiEvent(
      packageId: decode.getString<String?>(1),
      module: decode.getString<String?>(2),
      sender: decode.getString<String?>(3),
      eventType: decode.getString<String?>(4),
      contents: decode.messageTo<sui_rpc_v2_bcs.SuiBcs?>(5, (b) => sui_rpc_v2_bcs.SuiBcs.deserialize(b)),
      json: decode.messageTo<google_protobuf_struct.SuiValue?>(6, (b) => google_protobuf_struct.SuiValue.deserialize(b)),
      checkpoint: decode.getBigInt<BigInt?>(7),
      transactionDigest: decode.getString<String?>(8),
      transactionIndex: decode.getBigInt<BigInt?>(9),
      eventIndex: decode.getInt<int?>(10),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2Event;

}


