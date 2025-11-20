import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/serialization/bcs/exeption/exeption.dart';

/// Enum to define the serialization type: either an object or a variant (like an enum in other languages).
enum BcsSerializableType { object, variant }

/// Abstract class for handling BCS (Binary Canonical Serialization) serialization logic.
abstract class BcsSerialization {
  const BcsSerialization();

  /// Deserializes a byte array into a structured Map using the provided layout.
  ///
  /// [bytes] - The raw bytes to deserialize.
  /// [layout] - Defines the structure for deserialization.
  static Map<String, dynamic> deserialize(
      {required List<int> bytes,
      required Layout<Map<String, dynamic>> layout}) {
    final decode = layout.deserialize(bytes);
    return decode.value;
  }

  /// Returns the serialization type. Defaults to `object`.
  BcsSerializableType get serializableType => BcsSerializableType.object;

  /// Creates a layout structure for serialization.
  Layout<Map<String, dynamic>> createLayout({String? property});

  /// Converts the current object to a layout-friendly structure (Map format).
  Map<String, dynamic> toLayoutStruct();

  /// Serializes the object to BCS format (List of bytes).
  List<int> toBcs({String? property}) {
    final layout = createLayout(property: property);
    return layout.serialize(toLayoutStruct());
  }

  /// Converts the BCS-encoded bytes to a hexadecimal string.
  String toBcsHex() {
    return BytesUtils.toHexString(toBcs());
  }

  /// Converts the BCS-encoded bytes to a Base64 string.
  String toBcsBase64() {
    return StringUtils.decode(toBcs(), type: StringEncoding.base64);
  }

  /// Recursively converts complex objects into a human-readable format.
  /// Handles Maps, Lists, BigInt, byte arrays, etc.
  static Object? toReadableObject(Object? val) {
    if (val is Map) {
      final newMap =
          val.map((key, value) => MapEntry(key, toReadableObject(value)));
      return newMap..removeWhere((e, k) => k == null);
    }
    if (val is String || val is int) {
      return val;
    }
    if (val is BigInt) {
      return val.toString();
    }
    if (val is List<int>) {
      return BytesUtils.tryToHexString(val, prefix: '0x') ?? val;
    }
    if (val is List) {
      return val.map(toReadableObject).toList();
    }
    return val.toString();
  }

  /// Converts the serialized object to a JSON-compatible Map.
  Map<String, dynamic> toJson() {
    final toReadable = toReadableObject(toLayoutStruct());
    return (toReadable as Map).cast();
  }
}

/// Class to represent the result of decoding a BCS variant.
class BcsVariantDecodeResult {
  final Map<String, dynamic> result;

  /// Retrieves the variant name (key in the enum structure).
  String get variantName => result['key'];

  /// Retrieves the value associated with the variant.
  Map<String, dynamic> get value => result['value'];

  /// Constructor to create an immutable result.
  BcsVariantDecodeResult(Map<String, dynamic> result)
      : result = result.immutable;

  @override
  String toString() {
    return '$variantName: $value';
  }
}

/// Abstract class to handle serialization for BCS variants (similar to enums).
abstract class BcsVariantSerialization extends BcsSerialization {
  const BcsVariantSerialization();

  /// Converts JSON data into a BCS variant decode result.
  /// Ensures the JSON structure has both `key` and `value`.
  static BcsVariantDecodeResult toVariantDecodeResult(
      Map<String, dynamic> json) {
    if (json['key'] is! String || !json.containsKey('value')) {
      throw const BcsSerializationException(
          'Invalid variant layout. only use enum layout to deserialize with `BcsVariantSerialization.deserialize` method.');
    }
    return BcsVariantDecodeResult(json);
  }

  /// Deserializes bytes into a BCS variant structure.
  /// Validates the presence of `key` and `value` in the deserialized data.
  static Map<String, dynamic> deserialize(
      {required List<int> bytes,
      required Layout<Map<String, dynamic>> layout}) {
    final decode = layout.deserialize(bytes);
    final json = decode.value;
    if (json['key'] is! String || !json.containsKey('value')) {
      throw const BcsSerializationException(
          'Invalid variant layout. only use enum layout to deserialize with `BcsVariantSerialization.deserialize` method.');
    }
    return json;
  }

  /// Returns the name of the variant (used as the key during serialization).
  String get variantName;

  /// Creates a layout structure specifically for variants.
  Layout<Map<String, dynamic>> createVariantLayout({String? property});

  /// Converts the variant to a layout-friendly structure with the variant name as the key.
  Map<String, dynamic> toVariantLayoutStruct() {
    return {variantName: toLayoutStruct()};
  }

  /// Serializes the variant into BCS format (List of bytes).
  List<int> toVariantBcs({String? property}) {
    final layout = createVariantLayout(property: property);
    return layout.serialize(toVariantLayoutStruct());
  }

  /// Converts the serialized variant into a hexadecimal string.
  String toVariantBcsHex() {
    return BytesUtils.toHexString(toVariantBcs());
  }

  /// Converts the serialized variant into a Base64 string.
  String toVariantBcsBase64() {
    return StringUtils.decode(toVariantBcs(), type: StringEncoding.base64);
  }

  /// Converts the variant structure to a JSON-compatible Map.
  @override
  Map<String, dynamic> toJson() {
    final toReadable =
        BcsSerialization.toReadableObject(toVariantLayoutStruct());
    return (toReadable as Map).cast();
  }

  /// Specifies that this class represents a `variant` type.
  @override
  BcsSerializableType get serializableType => BcsSerializableType.variant;
}
