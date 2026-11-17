import 'package:blockchain_utils/blockchain_utils.dart';

/// Abstract class for objects that can be serialized using a specific layout.
abstract class BorshLayoutSerializable {
  const BorshLayoutSerializable();

  /// The layout representing the structure of the object for serialization.
  abstract final StructLayout layout;

  /// Serializes the object to a map.
  Map<String, dynamic> serialize();

  /// Converts the object to bytes using Borsh serialization.
  BuBytes toBytes() {
    return layout.serialize(serialize());
  }

  /// Converts the object to a hexadecimal string.
  String toHex() {
    return toBytes().toHex();
  }

  /// Decodes Borsh serialized bytes.
  ///
  /// - [bytes] : The bytes to decode.
  /// - [layout] : The layout representing the structure of the object.
  /// - [validator] (optional): A map used for validation.
  static Map<String, dynamic> decode({
    required List<int> bytes,
    required StructLayout layout,
    Map<String, dynamic> validator = const {},
  }) {
    try {
      final decode = layout.deserialize(bytes);
      for (final i in validator.entries) {
        if (i.value is List) {
          if (!CompareUtils.iterableIsEqual(i.value, decode.value[i.key])) {
            throw BuError(
              DefaultErrorType.invalidArgument,
              'Cannot validate Borsh bytes.',
            );
          }
        } else {
          if (i.value != decode.value[i.key]) {
            throw BuError(
              DefaultErrorType.invalidArgument,
              'Cannot validate Borsh bytes.',
            );
          }
        }
      }
      return decode.value;
    } catch (e) {
      throw const BuError(
        DefaultErrorType.invalidArgument,
        'Cannot validate Borsh bytes.',
      );
    }
  }

  static Object _toString(dynamic value) {
    if (value is List<int>) {
      return BytesUtils.toHexString(value, prefix: '0x');
    } else if (value is BigInt) {
      return value.toString();
    } else if (value is BorshLayoutSerializable) {
      return value.toJson();
    }
    return value.toString();
  }

  Map<String, dynamic> toJson() {
    final json = serialize()..removeWhere((k, v) => v == null);
    final Map<String, dynamic> toHuman = {};
    for (final i in json.entries) {
      toHuman[i.key] = _toString(i.value);
    }
    return toHuman;
  }
}
