import 'package:blockchain_utils/blockchain_utils.dart';

import 'reference.dart';
import 'types.dart';
import 'value.dart';
import 'utils.dart';

/// Types that know their Candid shape and how to (de)serialize.
abstract mixin class CandidSerializable {
  /// The Candid type of this value (used for encoding).
  CType get candidType;

  /// Plain value accepted by [serializeTyped] / [encode]:
  /// primitives, Map for records, List for vec, [Variant], [FuncRef], etc.
  dynamic get candidValue;

  /// Encode this value alone as a Candid message (`DIDL…`).
  BuBytes toCandidBytes() =>
      CandidUtils.encodeOneTyped(candidType, candidValue);

  /// Encode as an IDLValue (for low-level builders).
  IDLValue toIDLValue() {
    // Round-trip through typed encode/decode is wasteful; prefer direct path
    // when value is already structured. For now use encode + decodeOne.
    return CandidUtils.decodeOne(toCandidBytes());
  }
}

/// Companion decode helpers (static, like CborTagSerializable.decode*).
abstract final class CandidCodec {
  /// Decode a single-argument Candid message into [T].
  static T decodeOne<T>(
    List<int> bytes, {
    required CType type,
    required T Function(dynamic value) fromCandid,
  }) {
    final raw = CandidUtils.decodeOneTyped(bytes, type);
    return fromCandid(raw);
  }

  /// Decode a multi-argument message.
  static List<dynamic> decodeArgs(
    List<int> bytes, {
    required List<CType> types,
    List<dynamic Function(dynamic value)?>? fromCandid,
  }) {
    final raw = CandidUtils.decode(bytes, types);
    if (fromCandid == null) return raw;
    return [
      for (var i = 0; i < raw.length; i++)
        fromCandid[i] != null ? fromCandid[i]!(raw[i]) : raw[i],
    ];
  }

  /// Encode one [CandidSerializable].
  static BuBytes encodeOne(CandidSerializable value) => value.toCandidBytes();

  /// Encode several serializable values (or mix with plain + types).
  static BuBytes encodeMany(List<CandidSerializable> values) {
    return CandidUtils.encode(
      values.map((v) => v.candidType).toList(),
      values.map((v) => v.candidValue).toList(),
    );
  }

  /// Encode with explicit types + plain/serializable values.
  static BuBytes encodeValues(List<CType> types, List<dynamic> values) {
    final plain = [
      for (final v in values) v is CandidSerializable ? v.candidValue : v,
    ];
    return CandidUtils.encode(types, plain);
  }
}

/// Describes a record field for codegen / hand-written models.
class CandidField<T> {
  final Label label;
  final CType type;
  final T Function(dynamic raw) fromCandid;
  final dynamic Function(T value) toCandid;

  const CandidField({
    required this.label,
    required this.type,
    required this.fromCandid,
    required this.toCandid,
  });

  factory CandidField.named(
    String name,
    CType type, {
    required T Function(dynamic raw) fromCandid,
    required dynamic Function(T value) toCandid,
  }) => CandidField(
    label: Label.named(name),
    type: type,
    fromCandid: fromCandid,
    toCandid: toCandid,
  );
}
