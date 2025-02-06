import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/exception/exception.dart';

/// A mixin providing serialization functionality to classes.
mixin ADASerialization {
  /// Converts the object to a CBOR object.
  CborObject toCbor();

  /// Converts the object to a JSON representation.
  dynamic toJson();

  /// Serializes the object to CBOR bytes.
  List<int> serialize() => toCbor().encode();

  /// Serializes the object to hexadecimal string.
  String serializeHex() => BytesUtils.toHexString(serialize());

  /// Deserialize the provided CBOR bytes [cborBytes] into an object of type [T].
  /// Throws a MessageException with a descriptive message if deserialization fails.
  static T desrialize<T extends CborObject>(List<int> cborBytes) {
    final decode = CborObject.fromCbor(cborBytes);
    if (decode is! T) {
      throw ADAPluginException('Failed to deserialize CBOR bytes into type.',
          details: {'type': '$T', 'expected': decode.runtimeType});
    }
    return decode;
  }

  @override
  String toString() {
    final js = toJson();
    return js.toString();
  }
}

/// An extension providing quick utility methods for handling [CborObject] instances.
extension QuickCborObject on CborObject {
  /// Casts the value of the [CborObject] to the specified type,
  /// or throws a [MessageException] if casting fails.
  T cast<T>([String? onError]) {
    try {
      return this as T;
    } catch (e) {
      throw ADAPluginException(onError ?? 'Failed to cast CBOR object',
          details: {'Type': '$T', 'Value': value});
    }
  }

  /// Retrieves the value stored in the [CborObject] as the specified type [T].
  ///
  /// Throws a [MessageException] if the stored value cannot be cast to [T].
  T getValue<T>() {
    if (value is CborObject) {
      final cborObject = (value as CborObject);
      if (cborObject.value is T) return cborObject.value;
      if (null is T && cborObject is CborNullValue) return null as T;
    }
    if (null is T && value is CborNullValue) return null as T;
    if (value is! T) {
      throw ADAPluginException('Failed to cast value.', details: {
        'Value': value.runtimeType,
        'Type': '$T',
      });
    }
    return value as T;
  }

  /// Converts the value stored in the [CborObject] to a [BigInt].
  ///
  /// Throws a [MessageException] if the value is not of type [int] or [BigInt].
  BigInt getInteger() {
    if (value is! int && value is! BigInt) {
      throw ADAPluginException('Failed to cast value to integer.', details: {
        'Value': value,
        'Type': value.runtimeType,
      });
    }
    if (value is int) return BigInt.from(value);
    return value;
  }

  /// Converts the value of the [CborObject] to the specified type [E] using the provided function [toe].
  ///
  /// Throws a [MessageException] if the value cannot be converted to type [T].
  E castTo<E, T>(E Function(T e) toe) {
    if (this is T) {
      return toe(this as T);
    }
    if (value is! T) {
      throw ADAPluginException('Failed to cast value.', details: {
        'Value': '$value',
        'Type': '$T',
      });
    }
    return toe(value as T);
  }

  /// Checks whether the value stored in the [CborObject] has the specified type [T].
  bool hasType<T>() {
    return this is T;
  }
}

/// An extension providing quick utility methods for handling [CborListValue] instances.
extension QuickCborList on CborListValue {
  /// Gets the value at the specified [index] in the [CborListValue].
  ///
  /// If [index] is out of bounds and [T] is nullable, returns null. Otherwise, throws a [MessageException].
  T getIndex<T>(int index) {
    if (index >= value.length) {
      if (null is T) return null as T;
      throw ADAPluginException('Index out of bounds.',
          details: {'length': value.length, 'index': index});
    }

    final CborObject obj = value.elementAt(index);
    if (null is T && obj == const CborNullValue()) {
      return null as T;
    }
    if (obj is T) return obj as T;
    if (obj.value is! T) {
      throw ADAPluginException('Failed to cast value.',
          details: {'expected': obj.value.runtimeType, 'Type': '$T'});
    }
    return obj.value;
  }

  /// Returns a new [CborListValue] containing elements from this list from
  /// [start] inclusive to [end] exclusive.
  ///
  /// If [start] or [end] are out of bounds, throws a [MessageException]
  CborListValue<T> sublist<T>(int start, [int? end]) {
    if (start >= value.length || (end != null && end >= value.length)) {
      throw ADAPluginException('Index out of bounds.',
          details: {'length': value.length, 'Start': start, 'End': end});
    }
    return CborListValue.fixedLength((value as List<CborObject>)
        .sublist(start, end)
        .map((e) => e.cast<T>())
        .toList());
  }
}

/// An extension providing quick utility methods for handling [CborMapValue] instances.
extension QuickCborMap on CborMapValue {
  /// Retrieves the value associated with the specified integer [key] from the [CborMapValue].
  ///
  /// If [key] does not exist in the map and [T] is nullable, returns null. Otherwise, throws a [MessageException].
  T getValueFromIntKey<T>(int key) {
    final val = value[CborIntValue(key)];
    if (val == null && null is T) return null as T;
    if (null is T && val is CborNullValue) return null as T;
    if (val is CborObject && val.value is T) return val.value;
    if (val is! T) {
      throw ADAPluginException('Failed to cast value.',
          details: {'expected': val.runtimeType, 'Type': '$T'});
    }
    return val;
  }

  /// Retrieves the value associated with the specified [key] from the [CborMapValue].
  ///
  /// If [key] does not exist in the map and [T] is nullable, returns null. Otherwise, throws a [MessageException].
  T getValue<T>(CborObject key) {
    if (!value.containsKey(key)) {
      if (null is T) return null as T;
      throw ADAPluginException('Key does not exist.', details: {
        'Key': '${key.runtimeType}',
        'Keys': value.keys.map((e) => e.runtimeType).join(', ')
      });
    }
    final val = value[key];
    if (null is T && val is CborNullValue) return null as T;
    if (val is CborObject && val.value is T) return val.value;
    if (val is! T) {
      throw ADAPluginException('Failed to cast value.',
          details: {'expected': '${val.runtimeType}', 'Type': '$T'});
    }
    return val;
  }

  List<dynamic>? getIterableFromIntKey(int key, {bool throwOnNull = true}) {
    final val = value[CborIntValue(key)];
    if (val == null || val is CborNullValue) {
      if (throwOnNull) {
        throw ADAPluginException('Object not found.', details: {"key": key});
      }
    }
    if (val is CborListValue) {
      return val.value;
    }
    if (val is CborSetValue) {
      return val.value.toList();
    }
    throw ADAPluginException('value is not iterable.', details: {"key": key});
  }
}
