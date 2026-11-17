import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/sui/src/proto_messages/types.dart';
import 'package:on_chain/sui/src/serialization/protobuf/proto.dart';
import "package:on_chain/sui/src/proto_messages/google/protobuf/src/field_mask.dart"
    as google_protobuf_field_mask;
import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/filter.dart"
    as sui_rpc_v2_filter;
import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/checkpoint.dart"
    as sui_rpc_v2_checkpoint;
import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/executed_transaction.dart"
    as sui_rpc_v2_executed_transaction;
import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/query_options.dart"
    as sui_rpc_v2_query_options;
import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/event.dart"
    as sui_rpc_v2_event;

/// Request message for SubscriptionService.SubscribeCheckpoints.
class SuiSubscribeCheckpointsRequest extends SuiProtoMessage
    with ISuiProtoServiceMessage<SuiSubscribeCheckpointsResponse> {
  /// Optional. Mask for specifying which parts of the Checkpoint should be
  /// returned (e.g. summary, contents, signatures). `cursor` is always
  /// populated and is not subject to the mask.
  final google_protobuf_field_mask.SuiFieldMask? readMask;

  /// Optional. DNF filter over indexed transaction dimensions. A checkpoint
  /// matches if any transaction it contains satisfies the filter. If absent,
  /// every checkpoint is streamed.
  final sui_rpc_v2_filter.SuiTransactionFilter? filter;

  const SuiSubscribeCheckpointsRequest({this.readMask, this.filter});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1, hasOptionalFlags: true),
        ProtoFieldConfig.message(2, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [readMask, filter];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'read_mask': config.encodeMessage(readMask),
      'filter': config.encodeMessage(filter),
    };
  }

  factory SuiSubscribeCheckpointsRequest.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiSubscribeCheckpointsRequest(
      readMask: json.valueTo<google_protobuf_field_mask.SuiFieldMask?, Object>(
        key: 'read_mask',
        parse:
            (v) => google_protobuf_field_mask.SuiFieldMask.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      filter: json.valueTo<sui_rpc_v2_filter.SuiTransactionFilter?, Object>(
        key: 'filter',
        parse:
            (v) => sui_rpc_v2_filter.SuiTransactionFilter.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiSubscribeCheckpointsRequest.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiSubscribeCheckpointsRequest(
      readMask: decode.messageTo<google_protobuf_field_mask.SuiFieldMask?>(
        1,
        (b) => google_protobuf_field_mask.SuiFieldMask.deserialize(b),
      ),
      filter: decode.messageTo<sui_rpc_v2_filter.SuiTransactionFilter?>(
        2,
        (b) => sui_rpc_v2_filter.SuiTransactionFilter.deserialize(b),
      ),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2SubscribeCheckpointsRequest;
  @override
  SuiSubscribeCheckpointsResponse onServiceResponse(List<int> bytes) {
    return SuiSubscribeCheckpointsResponse.deserialize(bytes);
  }

  @override
  SuiSubscribeCheckpointsResponse onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return SuiSubscribeCheckpointsResponse.fromJson(json);
  }
}

/// Response message for SubscriptionService.SubscribeCheckpoints.
///
/// A checkpoint stream's position is checkpoint-granular, so the `cursor`
/// sequence number stands in for the `Watermark` message the other
/// subscription responses carry. Progress-only frames (with `checkpoint`
/// unset) occur only on filtered streams: on an unfiltered stream every frame
/// carries both fields, in order and without gaps.
class SuiSubscribeCheckpointsResponse extends SuiProtoMessage {
  /// Required. The checkpoint sequence number the stream has fully covered,
  /// inclusive: every matching checkpoint from the stream's start position
  /// through `cursor` has been delivered. Present on every frame and
  /// advances monotonically.
  final BigInt? cursor;

  /// The matching checkpoint. Unset when this frame only advances the
  /// cursor past non-matching checkpoints.
  final sui_rpc_v2_checkpoint.SuiCheckpoint? checkpoint;

  const SuiSubscribeCheckpointsResponse({this.cursor, this.checkpoint});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.uint64(1, hasOptionalFlags: true),
        ProtoFieldConfig.message(2, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [cursor, checkpoint];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'cursor': config.encodeBigint(cursor),
      'checkpoint': config.encodeMessage(checkpoint),
    };
  }

  factory SuiSubscribeCheckpointsResponse.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiSubscribeCheckpointsResponse(
      cursor: json.valueAsBigInt<BigInt?>(
        'cursor',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      checkpoint: json.valueTo<sui_rpc_v2_checkpoint.SuiCheckpoint?, Object>(
        key: 'checkpoint',
        parse:
            (v) => sui_rpc_v2_checkpoint.SuiCheckpoint.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiSubscribeCheckpointsResponse.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiSubscribeCheckpointsResponse(
      cursor: decode.getBigInt<BigInt?>(1),
      checkpoint: decode.messageTo<sui_rpc_v2_checkpoint.SuiCheckpoint?>(
        2,
        (b) => sui_rpc_v2_checkpoint.SuiCheckpoint.deserialize(b),
      ),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2SubscribeCheckpointsResponse;
}

/// Request message for SubscriptionService.SubscribeTransactions.
class SuiSubscribeTransactionsRequest extends SuiProtoMessage
    with ISuiProtoServiceMessage<SuiSubscribeTransactionsResponse> {
  /// Optional. Mask for specifying which parts of the ExecutedTransaction
  /// should be returned.
  final google_protobuf_field_mask.SuiFieldMask? readMask;

  /// Optional. DNF filter over indexed dimensions. If absent, every
  /// transaction is streamed.
  final sui_rpc_v2_filter.SuiTransactionFilter? filter;

  const SuiSubscribeTransactionsRequest({this.readMask, this.filter});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1, hasOptionalFlags: true),
        ProtoFieldConfig.message(2, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [readMask, filter];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'read_mask': config.encodeMessage(readMask),
      'filter': config.encodeMessage(filter),
    };
  }

  factory SuiSubscribeTransactionsRequest.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiSubscribeTransactionsRequest(
      readMask: json.valueTo<google_protobuf_field_mask.SuiFieldMask?, Object>(
        key: 'read_mask',
        parse:
            (v) => google_protobuf_field_mask.SuiFieldMask.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      filter: json.valueTo<sui_rpc_v2_filter.SuiTransactionFilter?, Object>(
        key: 'filter',
        parse:
            (v) => sui_rpc_v2_filter.SuiTransactionFilter.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiSubscribeTransactionsRequest.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiSubscribeTransactionsRequest(
      readMask: decode.messageTo<google_protobuf_field_mask.SuiFieldMask?>(
        1,
        (b) => google_protobuf_field_mask.SuiFieldMask.deserialize(b),
      ),
      filter: decode.messageTo<sui_rpc_v2_filter.SuiTransactionFilter?>(
        2,
        (b) => sui_rpc_v2_filter.SuiTransactionFilter.deserialize(b),
      ),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2SubscribeTransactionsRequest;
  @override
  SuiSubscribeTransactionsResponse onServiceResponse(List<int> bytes) {
    return SuiSubscribeTransactionsResponse.deserialize(bytes);
  }

  @override
  SuiSubscribeTransactionsResponse onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return SuiSubscribeTransactionsResponse.fromJson(json);
  }
}

/// Response message for SubscriptionService.SubscribeTransactions.
///
/// Mirrors ListTransactionsResponse, except there is no `end` field: a
/// subscription stream has no successful end.
class SuiSubscribeTransactionsResponse extends SuiProtoMessage {
  /// One matching transaction. Its position within the containing checkpoint
  /// is reported by `ExecutedTransaction.transaction_index`.
  final sui_rpc_v2_executed_transaction.SuiExecutedTransaction? transaction;

  /// Progress watermark as of this frame. Present on every frame.
  final sui_rpc_v2_query_options.SuiWatermark? watermark;

  const SuiSubscribeTransactionsResponse({this.transaction, this.watermark});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1, hasOptionalFlags: true),
        ProtoFieldConfig.message(2, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [transaction, watermark];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'transaction': config.encodeMessage(transaction),
      'watermark': config.encodeMessage(watermark),
    };
  }

  factory SuiSubscribeTransactionsResponse.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiSubscribeTransactionsResponse(
      transaction: json.valueTo<
        sui_rpc_v2_executed_transaction.SuiExecutedTransaction?,
        Object
      >(
        key: 'transaction',
        parse:
            (v) =>
                sui_rpc_v2_executed_transaction.SuiExecutedTransaction.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      watermark: json.valueTo<sui_rpc_v2_query_options.SuiWatermark?, Object>(
        key: 'watermark',
        parse:
            (v) => sui_rpc_v2_query_options.SuiWatermark.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiSubscribeTransactionsResponse.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiSubscribeTransactionsResponse(
      transaction: decode
          .messageTo<sui_rpc_v2_executed_transaction.SuiExecutedTransaction?>(
            1,
            (b) => sui_rpc_v2_executed_transaction
                .SuiExecutedTransaction.deserialize(b),
          ),
      watermark: decode.messageTo<sui_rpc_v2_query_options.SuiWatermark?>(
        2,
        (b) => sui_rpc_v2_query_options.SuiWatermark.deserialize(b),
      ),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2SubscribeTransactionsResponse;
}

/// Request message for SubscriptionService.SubscribeEvents.
class SuiSubscribeEventsRequest extends SuiProtoMessage
    with ISuiProtoServiceMessage<SuiSubscribeEventsResponse> {
  /// Optional. Mask for specifying which parts of the Event should be
  /// returned.
  final google_protobuf_field_mask.SuiFieldMask? readMask;

  /// Optional. DNF filter over indexed dimensions. If absent, every event is
  /// streamed.
  final sui_rpc_v2_filter.SuiEventFilter? filter;

  const SuiSubscribeEventsRequest({this.readMask, this.filter});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1, hasOptionalFlags: true),
        ProtoFieldConfig.message(2, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [readMask, filter];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'read_mask': config.encodeMessage(readMask),
      'filter': config.encodeMessage(filter),
    };
  }

  factory SuiSubscribeEventsRequest.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiSubscribeEventsRequest(
      readMask: json.valueTo<google_protobuf_field_mask.SuiFieldMask?, Object>(
        key: 'read_mask',
        parse:
            (v) => google_protobuf_field_mask.SuiFieldMask.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      filter: json.valueTo<sui_rpc_v2_filter.SuiEventFilter?, Object>(
        key: 'filter',
        parse:
            (v) => sui_rpc_v2_filter.SuiEventFilter.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiSubscribeEventsRequest.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiSubscribeEventsRequest(
      readMask: decode.messageTo<google_protobuf_field_mask.SuiFieldMask?>(
        1,
        (b) => google_protobuf_field_mask.SuiFieldMask.deserialize(b),
      ),
      filter: decode.messageTo<sui_rpc_v2_filter.SuiEventFilter?>(
        2,
        (b) => sui_rpc_v2_filter.SuiEventFilter.deserialize(b),
      ),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2SubscribeEventsRequest;
  @override
  SuiSubscribeEventsResponse onServiceResponse(List<int> bytes) {
    return SuiSubscribeEventsResponse.deserialize(bytes);
  }

  @override
  SuiSubscribeEventsResponse onServiceResponseJson(Map<String, dynamic> json) {
    return SuiSubscribeEventsResponse.fromJson(json);
  }
}

/// Response message for SubscriptionService.SubscribeEvents.
///
/// Mirrors ListEventsResponse, except there is no `end` field: a subscription
/// stream has no successful end.
class SuiSubscribeEventsResponse extends SuiProtoMessage {
  /// One matching event. Its ledger position -- containing checkpoint,
  /// emitting transaction digest and offset, and index within that
  /// transaction's event list -- is reported by the corresponding fields on
  /// `Event`.
  final sui_rpc_v2_event.SuiEvent? event;

  /// Progress watermark as of this frame. Present on every frame.
  final sui_rpc_v2_query_options.SuiWatermark? watermark;

  const SuiSubscribeEventsResponse({this.event, this.watermark});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1, hasOptionalFlags: true),
        ProtoFieldConfig.message(2, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [event, watermark];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'event': config.encodeMessage(event),
      'watermark': config.encodeMessage(watermark),
    };
  }

  factory SuiSubscribeEventsResponse.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiSubscribeEventsResponse(
      event: json.valueTo<sui_rpc_v2_event.SuiEvent?, Object>(
        key: 'event',
        parse:
            (v) => sui_rpc_v2_event.SuiEvent.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      watermark: json.valueTo<sui_rpc_v2_query_options.SuiWatermark?, Object>(
        key: 'watermark',
        parse:
            (v) => sui_rpc_v2_query_options.SuiWatermark.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiSubscribeEventsResponse.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiSubscribeEventsResponse(
      event: decode.messageTo<sui_rpc_v2_event.SuiEvent?>(
        1,
        (b) => sui_rpc_v2_event.SuiEvent.deserialize(b),
      ),
      watermark: decode.messageTo<sui_rpc_v2_query_options.SuiWatermark?>(
        2,
        (b) => sui_rpc_v2_query_options.SuiWatermark.deserialize(b),
      ),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2SubscribeEventsResponse;
}
