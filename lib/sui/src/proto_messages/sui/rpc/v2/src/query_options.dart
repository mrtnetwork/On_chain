import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/sui/src/proto_messages/types.dart';
import 'package:on_chain/sui/src/serialization/protobuf/proto.dart';

/// Copyright (c) Mysten Labs, Inc.
/// SPDX-License-Identifier: Apache-2.0
/// Ordering for the returned result set.
enum SuiOrdering implements ProtoEnumVariant {
    /// Return results in increasing cursor order.
  orderingAscending(0, 'ORDERING_ASCENDING'),
    /// Return results in decreasing cursor order.
  orderingDescending(1, 'ORDERING_DESCENDING');

  const SuiOrdering(this.value, this.protoName);
  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static SuiOrdering fromValue(int? value) {
    value ??=0;
    return SuiOrdering.values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching SuiOrdering found for the given value. $value", details: {"name": "SuiOrdering", "value": value?.toString()})
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static SuiOrdering from(Object? value) {
    value ??=0;
    return SuiOrdering.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching SuiOrdering found for the given value. $value", details: {"name": "SuiOrdering", "value": value?.toString()})
    );
  }

}


/// Reason the server stopped this query response.
enum SuiQueryEndReason implements ProtoEnumVariant {
    /// The stop reason was not specified.
  queryEndReasonUnknown(0, 'QUERY_END_REASON_UNKNOWN'),
    /// The response reached the requested item limit. The final matching item's
  /// frame carries `QueryEnd` and the final watermark. Resume from that frame's
  /// `Watermark.cursor` to continue reading the same effective interval.
  queryEndReasonItemLimit(1, 'QUERY_END_REASON_ITEM_LIMIT'),
    /// The response reached the server's per-request bucket-fetch budget for
  /// filtered scans before reaching the effective interval bound. The terminal
  /// frame carries no item. Its watermark cursor is the authoritative scan
  /// frontier from which to resume.
  queryEndReasonScanLimit(2, 'QUERY_END_REASON_SCAN_LIMIT'),
    /// The scan reached a requested checkpoint range bound. The terminal frame
  /// carries no item.
  queryEndReasonCheckpointBound(3, 'QUERY_END_REASON_CHECKPOINT_BOUND'),
    /// The scan reached an exclusive cursor bound. The terminal frame carries no
  /// item. Its watermark cursor represents that resolved bound without claiming
  /// that its containing checkpoint was fully covered.
  queryEndReasonCursorBound(4, 'QUERY_END_REASON_CURSOR_BOUND'),
    /// The scan reached the currently indexed ledger tip. The terminal frame
  /// carries no item.
  queryEndReasonLedgerTip(5, 'QUERY_END_REASON_LEDGER_TIP');

  const SuiQueryEndReason(this.value, this.protoName);
  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static SuiQueryEndReason fromValue(int? value) {
    value ??=0;
    return SuiQueryEndReason.values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching SuiQueryEndReason found for the given value. $value", details: {"name": "SuiQueryEndReason", "value": value?.toString()})
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static SuiQueryEndReason from(Object? value) {
    value ??=0;
    return SuiQueryEndReason.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching SuiQueryEndReason found for the given value. $value", details: {"name": "SuiQueryEndReason", "value": value?.toString()})
    );
  }

}


/// Cursor-bounded query options.
///
/// `after` and `before` are canonical ledger-position bounds, not
/// ordering-relative cursors. `after` always excludes items at or below that
/// cursor, and `before` always excludes items at or above that cursor. Ordering
/// only controls the order of returned items within the resulting open interval.
///
/// When a request also specifies a checkpoint range, cursor bounds and
/// checkpoint bounds compose by intersection: results come only from ledger
/// positions inside both. Checkpoint bounds are likewise canonical and
/// ordering-independent.
///
/// For example, with `after = A`, `before = B`, `ordering = DESCENDING`, and
/// `limit = N`, the response contains up to N matching items in descending
/// order from the interval `(A, B)`. If the response ends with
/// `QUERY_END_REASON_ITEM_LIMIT`, resume by keeping `after = A` and setting
/// `before` to the last `Watermark.cursor` received. That cursor is the
/// lowest position reached in ledger order, so it becomes the next exclusive
/// upper bound.
class SuiQueryOptions extends SuiProtoMessage {
    /// The maximum number of items to return. Each method applies its own default
  /// and maximum. QueryEnd does not count against this limit.
  final int? limit;

    /// Opaque exclusive lower bound. Results must be strictly after this cursor in
  /// canonical ledger order.
  final BuBytes? after;

    /// Opaque exclusive upper bound. Results must be strictly before this cursor
  /// in canonical ledger order.
  final BuBytes? before;

    /// Ordering for returned results. Defaults to ASCENDING.
  ///
  /// Ordering only controls the order of results within the bounded interval;
  /// cursor bounds keep the same meaning for ascending and descending reads.
  final SuiOrdering? ordering;

  SuiQueryOptions({
    this.limit,
    List<int>? after,
    List<int>? before,
    this.ordering,
  }) : 
    after = after?.asImmutableBytes,
    before = before?.asImmutableBytes;

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.uint32(1, hasOptionalFlags: true),
        ProtoFieldConfig.bytes(2, hasOptionalFlags: true),
        ProtoFieldConfig.bytes(3, hasOptionalFlags: true),
        ProtoFieldConfig.enumType(4, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        limit,
        after,
        before,
        ordering,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'limit': limit,
      'after': config.encodeBinary(after),
      'before': config.encodeBinary(before),
      'ordering': config.encodeEnum(ordering),
    };
  }


  factory SuiQueryOptions.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiQueryOptions(
      limit: json.valueAsInt<int?>('limit', normalizeKeyLookup: config.normalizeKeys),
      after: config.decodeBinary<List<int>?>(json.valueAs('after', normalizeKeyLookup: config.normalizeKeys)),
      before: config.decodeBinary<List<int>?>(json.valueAs('before', normalizeKeyLookup: config.normalizeKeys)),
      ordering: json.valueTo<SuiOrdering?, Object?>(
        key: 'ordering',
        parse: (v) => SuiOrdering.from(v),
      ),
    );
  }

  factory SuiQueryOptions.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiQueryOptions(
      limit: decode.getInt<int?>(1),
      after: decode.getBytes<List<int>?>(2),
      before: decode.getBytes<List<int>?>(3),
      ordering: decode.getEnum<SuiOrdering?>(4, SuiOrdering.values),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2QueryOptions;

}


/// Progress marker for a query scan. Carried on every response frame, whether or
/// not the frame delivers a matching item. Watermarks never regress in the
/// requested ordering, but consecutive frames may carry the same watermark when
/// additional work does not advance the safe resume frontier.
class SuiWatermark extends SuiProtoMessage {
    /// Opaque cursor at this scan position. Set on every watermark. Use as
  /// `options.after` (ascending) or `options.before` (descending) on the next
  /// request to resume from here. The most recently received cursor is always
  /// the safe resume point.
  final BuBytes? cursor;

    /// The inclusive boundary checkpoint that the scan has fully covered within
  /// the request's effective interval, in the request's ordering direction: an
  /// ascending scan has emitted every matching item in the interval at
  /// checkpoints `&lt;= checkpoint` (strictly greater ones may still hold
  /// matches); a descending scan has emitted every matching item in the
  /// interval at checkpoints `&gt;= checkpoint`. This boundary never regresses in
  /// the scan direction, but it may repeat while the cursor advances.
  ///
  /// Unset until the scan's first checkpoint is fully covered. For example, a
  /// scan resumed from a cursor that lands mid-checkpoint leaves this unset
  /// until the next checkpoint boundary in the scan direction is fully covered.
  /// A watermark still has a valid resume cursor while this field is unset.
  final BigInt? checkpoint;

  SuiWatermark({
    List<int>? cursor,
    this.checkpoint,
  }) : 
    cursor = cursor?.asImmutableBytes;

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(2, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        cursor,
        checkpoint,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'cursor': config.encodeBinary(cursor),
      'checkpoint': config.encodeBigint(checkpoint),
    };
  }


  factory SuiWatermark.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiWatermark(
      cursor: config.decodeBinary<List<int>?>(json.valueAs('cursor', normalizeKeyLookup: config.normalizeKeys)),
      checkpoint: json.valueAsBigInt<BigInt?>('checkpoint', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory SuiWatermark.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiWatermark(
      cursor: decode.getBytes<List<int>?>(1),
      checkpoint: decode.getBigInt<BigInt?>(2),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2Watermark;

}


/// Marker for the final frame of a successful query stream. Every successful
/// stream sets `QueryEnd` on exactly one frame, after which no further frames
/// are sent. That frame always carries the final watermark. For `ItemLimit`, it
/// also carries the final matching item; for every other reason it carries no
/// item. A ScanLimit terminal watermark may repeat the previous frame's cursor
/// when its authoritative scan frontier was already emitted; this does not
/// repeat an item.
///
/// A stream that fails or is cancelled terminates with a gRPC status and does
/// not send `QueryEnd`.
class SuiQueryEnd extends SuiProtoMessage {
    /// Reason this response stopped.
  final SuiQueryEndReason? reason;

  const SuiQueryEnd({
    this.reason,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.enumType(1, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        reason,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'reason': config.encodeEnum(reason),
    };
  }


  factory SuiQueryEnd.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiQueryEnd(
      reason: json.valueTo<SuiQueryEndReason?, Object?>(
        key: 'reason',
        parse: (v) => SuiQueryEndReason.from(v),
      ),
    );
  }

  factory SuiQueryEnd.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiQueryEnd(
      reason: decode.getEnum<SuiQueryEndReason?>(1, SuiQueryEndReason.values),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2QueryEnd;

}


