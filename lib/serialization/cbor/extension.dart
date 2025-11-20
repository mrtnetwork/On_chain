import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/serialization/cbor/exception.dart';

/// An extension providing quick utility methods for handling [CborObject] instances.
extension QuickCborObject on CborObject {
  static CborListValue cborTagValue(
      {List<int>? cborBytes,
      CborObject? object,
      String? hex,
      List<int>? tags}) {
    assert(cborBytes != null || object != null || hex != null,
        "cbor bytes or cbor object must not be null");
    if (object == null) {
      cborBytes ??= BytesUtils.tryFromHexString(hex);
      if (cborBytes != null) {
        object = CborObject.fromCbor(cborBytes);
      }
    }
    final value = object?.value;
    if (object is! CborTagValue || value is! CborListValue) {
      throw CborSerializationException("Failed to deserialize CBOR object.");
    }
    if (tags != null && !BytesUtils.bytesEqual(object.tags, tags)) {
      throw CborSerializationException("CBOR tags mismatch.",
          details: {"expected": tags, "tags": object.tags});
    }
    return value;
  }

  static T decode<T extends CborObject>(
      {List<int>? cborBytes, CborObject? object, String? hex}) {
    try {
      if (object == null) {
        cborBytes ??= BytesUtils.tryFromHexString(hex);
        if (cborBytes != null) {
          object = CborObject.fromCbor(cborBytes);
        }
      }
      if (object is T) {
        return object;
      }
    } catch (_) {}
    throw CborSerializationException(
        "Failed to deserialize CBOR object to $T.");
  }

  /// Checks whether the value stored in the [CborObject] has the specified type [T].
  bool hasType<T>() {
    return this is T;
  }

  T as<T extends CborObject>([String? name]) {
    try {
      return this as T;
    } catch (_) {
      throw CborSerializationException(
        "Failed to convert CBOR object${name != null ? ' for "$name"' : ''} to $T",
        details: {'expected': '$T', 'type': runtimeType.toString()},
      );
    }
  }

  E convertTo<E, T extends CborObject>(E Function(T e) toe) {
    return toe(as<T>());
  }

  CborMapValue<T, E> asMap<T extends CborObject, E extends CborObject>(
      [String? name]) {
    try {
      if (this is CborMapValue<T, E>) return this as CborMapValue<T, E>;
      final map = as<CborMapValue>(name);
      if (map.isDefinite) {
        return CborMapValue<T, E>.definite(map.valueAsMap<T, E>());
      }
      return CborMapValue<T, E>.inDefinite(map.valueAsMap<T, E>());
    } catch (_) {
      throw CborSerializationException(
        "Failed to convert CBOR object${name != null ? ' for "$name"' : ''} to Map<$T,$E>",
        details: {'expected': 'Map<$T,$E>', 'type': runtimeType.toString()},
      );
    }
  }
}

extension QuickCborTag on CborTagValue {
  T valueAs<T extends CborObject>(String name) {
    try {
      return value as T;
    } catch (_) {
      throw CborSerializationException(
        "Failed to convert CBOR object for $name to $T",
        details: {'expected': '$T', 'type': value.toString()},
      );
    }
  }
}

extension QuickCborList on CborIterableObject {
  CborListValue<T> sublist<T extends CborObject>(int start, [int? end]) {
    if (start >= value.length || (end != null && end >= value.length)) {
      throw CborSerializationException('Index out of bounds.',
          details: {'length': value.length, 'Start': start, 'End': end});
    }
    final values = valueAsListOf<T>();
    return CborListValue.definite(values.sublist(start, end).toList());
  }

  List<T> valueAsListOf<T extends CborObject>([String? name]) {
    try {
      return value.cast<T>().toList();
    } catch (e) {
      throw CborSerializationException(
        "Failed to convert CBOR object values${name != null ? ' for "$name"' : ''} to $T",
        details: {
          'expected': '$T',
          'types': value.map((e) => e.runtimeType).join(", ")
        },
      );
    }
  }

  bool get isEmpty => value.isEmpty;

  bool valueIsListOf<T extends CborObject>() {
    return value.every((e) => e is T);
  }

  T elementAt<T extends CborObject?>(int index, {String? name}) {
    if (index >= value.length) {
      if (null is T) return null as T;

      throw CborSerializationException(
        'Missing ${name ?? "element"} at index $index.',
        details: {'length': value.length, 'index': index, 'expected': '$T'},
      );
    }

    final element = value.elementAt(index);
    if (element is CborNullValue && null is T) {
      return null as T;
    }
    if (element is T) {
      return element;
    }
    throw CborSerializationException(
        "Failed to convert CBOR object at index $index${name != null ? ' for "$name"' : ''} to $T",
        details: {'expected': '$T', 'type': runtimeType.toString()});
  }

  T elementAsInteger<T extends BigInt?>(int index, {String? name}) {
    if (null is T) {
      final elem = elementAt<CborNumeric?>(index, name: name);
      return elem?.toBigInt() as T;
    } else {
      final elem = elementAt<CborNumeric>(index, name: name);
      return elem.toBigInt() as T;
    }
  }

  T elementAtBytes<T extends List<int>?>(int index, {String? name}) {
    if (null is T) {
      final elem = elementAt<CborBytesValue?>(index, name: name);
      return elem?.value as T;
    } else {
      final elem = elementAt<CborBytesValue>(index, name: name);
      return elem.value as T;
    }
  }

  T elementAtString<T extends String?>(int index, {String? name}) {
    if (null is T) {
      final elem = elementAt<CborStringValue?>(index, name: name);
      return elem?.value as T;
    } else {
      final elem = elementAt<CborStringValue>(index, name: name);
      return elem.value as T;
    }
  }

  E? elementMaybeAt<E, T extends CborObject>(
      int index, E Function(T e) onValue) {
    if (index > value.length - 1) {
      return null;
    }
    try {
      final CborObject cborValue = value.elementAt(index);
      if (cborValue == const CborNullValue()) {
        return null;
      }
      if (cborValue is T) {
        return onValue(cborValue);
      }
    } catch (_) {}
    throw CborSerializationException(
        "Failed to convert CBOR object at index $index to $T",
        details: {'expected': '$T', 'type': runtimeType.toString()});
  }

  bool hasIndex(int index) {
    return index < value.length;
  }

  List<T> elementAsListOf<T extends CborObject>(int index,
      {bool emyptyOnNull = false}) {
    if (emyptyOnNull && !hasIndex(index)) {
      return [];
    }
    try {
      return (value.elementAt(index) as CborListValue).value.cast<T>();
    } catch (_) {
      throw CborSerializationException(
          "Failed to convert CBOR object at index $index to $T",
          details: {'expected': '$T', 'type': runtimeType.toString()});
    }
  }
}

/// An extension providing quick utility methods for handling [CborMapValue] instances.
extension QuickCborMap on CborMapValue {
  T getIntValueAs<T extends CborObject?>(int key) {
    final val = value[CborIntValue(key)];
    if (val == null && null is T) return null as T;
    if (null is T && val is CborNullValue) return null as T;
    if (val is! T) {
      throw CborSerializationException("Failed to convert CBOR to $T",
          details: {'expected': '$T', 'type': val.runtimeType});
    }
    return val;
  }

  bool containsInt(int key) {
    return value.containsKey(CborIntValue(key));
  }

  Map<T, E> valueAsMap<T extends CborObject, E extends CborObject>(
      [String? name]) {
    try {
      if (value is Map<T, E>) return value as Map<T, E>;
      return Map<T, E>.from(value);
    } catch (_) {
      throw CborSerializationException("Failed to convert CBOR to Map<$T, $E>",
          details: {'expected': 'Map<$T,$E>', 'type': value.toString()});
    }
  }
}
