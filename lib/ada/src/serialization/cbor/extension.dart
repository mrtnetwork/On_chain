import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/exception/exception.dart';

/// An extension providing quick utility methods for handling [CborObject] instances.
extension QuickCborObject on CborObject {
  /// Checks whether the value stored in the [CborObject] has the specified type [T].
  bool hasType<T>() {
    return this is T;
  }

  T as<T extends CborObject>([String? name]) {
    try {
      return this as T;
    } catch (_) {
      throw ADAPluginException(
        "Failed to cast CBOR object${name != null ? ' for "$name"' : ''} as $T",
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
      throw ADAPluginException(
        "Failed to cast CBOR object${name != null ? ' for "$name"' : ''} as Map<$T,$E>",
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
      throw ADAPluginException(
        "Failed to cast CBOR object value for $name as $T",
        details: {'expected': '$T', 'type': value.toString()},
      );
    }
  }
}

/// An extension providing quick utility methods for handling [CborListValue] instances.
extension QuickCborList on CborIterableObject {
  // /// Returns a new [CborListValue] containing elements from this list from
  // /// [start] inclusive to [end] exclusive.
  // ///
  // /// If [start] or [end] are out of bounds, throws a [MessageException]
  CborListValue<T> sublist<T extends CborObject>(int start, [int? end]) {
    if (start >= value.length || (end != null && end >= value.length)) {
      throw ADAPluginException('Index out of bounds.',
          details: {'length': value.length, 'Start': start, 'End': end});
    }
    final values = valueAsListOf<T>();
    return CborListValue.definite(values.sublist(start, end).toList());
  }

  List<T> valueAsListOf<T extends CborObject>([String? name]) {
    try {
      return value.cast<T>().toList();
    } catch (e) {
      throw ADAPluginException(
        "Failed to cast CBOR object values${name != null ? ' for "$name"' : ''} as $T",
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

      throw ADAPluginException(
        'Missing ${name ?? "element"} at index $index.',
        details: {
          'length': value.length,
          'index': index,
          'expected': '$T',
        },
      );
    }

    final element = value.elementAt(index);
    if (element is CborNullValue && null is T) {
      return null as T;
    }
    if (element is T) {
      return element;
    }
    throw ADAPluginException(
      "Failed to cast CBOR object at index $index${name != null ? ' for "$name"' : ''} as $T",
      details: {'expected': '$T', 'type': runtimeType.toString()},
    );
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
}

/// An extension providing quick utility methods for handling [CborMapValue] instances.
extension QuickCborMap on CborMapValue {
  T getIntValueAs<T extends CborObject?>(int key) {
    final val = value[CborIntValue(key)];
    if (val == null && null is T) return null as T;
    if (null is T && val is CborNullValue) return null as T;
    if (val is! T) {
      throw ADAPluginException("Failed to cast CBOR object for $key as $T",
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
      throw ADAPluginException("Failed to cast CBOR map value as Map<$T,$E>",
          details: {'expected': 'Map<$T,$E>', 'type': value.toString()});
    }
  }
}
