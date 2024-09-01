import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/exception/exception.dart';

/// Abstract class for objects that can be serialized using a specific layout.
abstract class LayoutSerializable {
  const LayoutSerializable();

  /// The layout representing the structure of the object for serialization.
  abstract final StructLayout layout;

  /// Serializes the object to a map.
  Map<String, dynamic> serialize();

  /// Converts the object to bytes using Borsh serialization.
  List<int> toBytes() {
    return layout.serialize(serialize());
  }

  /// Converts the object to a hexadecimal string.
  String toHex() {
    return BytesUtils.toHexString(toBytes());
  }

  /// Decodes Borsh serialized bytes.
  ///
  /// - [bytes] : The bytes to decode.
  /// - [layout] : The layout representing the structure of the object.
  /// - [validator] (optional): A map used for validation.
  static Map<String, dynamic> decode(
      {required List<int> bytes,
      required StructLayout layout,
      Map<String, dynamic> validator = const {}}) {
    try {
      final decode = layout.deserialize(bytes).value;

      for (final i in validator.entries) {
        if (i.value is List) {
          if (!CompareUtils.iterableIsEqual(i.value, decode[i.key])) {
            throw SolanaPluginException("cannot validate borsh bytes",
                details: {"excepted": validator, "instruction": decode});
          }
        } else {
          if (i.value != decode[i.key]) {
            throw SolanaPluginException("cannot validate borsh bytes",
                details: {"excepted": validator, "instruction": decode});
          }
        }
      }
      return decode;
    } catch (e) {
      throw const SolanaPluginException("cannot validate borsh bytes");
    }
  }

  static _toString(dynamic value) {
    if (value is List<int>) {
      return BytesUtils.toHexString(value, prefix: "0x");
    } else if (value is BigInt) {
      return value.toString();
    } else if (value is LayoutSerializable) {
      return value.toJson();
    }
    return value.toString();
  }

  Map<String, dynamic> toJson() {
    final json = serialize()..removeWhere((k, v) => v == null);
    Map<String, dynamic> toHuman = {};
    for (final i in json.entries) {
      toHuman[i.key] = _toString(i.value);
    }
    return toHuman;
  }
}
