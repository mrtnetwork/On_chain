import 'package:blockchain_utils/bip/address/aptos_addr.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/aptos/aptos.dart';
import 'package:on_chain/bcs/exeption/exeption.dart';

class MoveUtils {
  /// Parses a value into a boolean, supporting bool, 0/1, and 'true'/'false' strings.
  static bool parseBoolean({Object? value}) {
    if (value is bool) return value;
    final toint = IntUtils.tryParse(value);
    if (toint != null) {
      if (toint == 1) {
        return true;
      } else if (toint == 0) {
        return false;
      }
    } else {
      final str = value.toString().toLowerCase();
      if (str == 'true') {
        return true;
      } else if (str == 'false') {
        return false;
      }
    }
    throw BcsSerializationException(
        "Invalid value for move type 'Bool': Expected a boolean (true/false), a number (0/1), or a string ('true'/'false').",
        details: {"value": "$value"});
  }

  /// Parses a value into an unsigned 8-bit integer (0–255).
  static int parseU8({Object? value}) {
    try {
      final toint = IntUtils.parse(value);
      return toint.asUint8;
    } catch (e) {
      throw BcsSerializationException(
          "Invalid value for move type 'U8': Expected an unsigned 8-bit integer (0–255).",
          details: {"value": "$value"});
    }
  }

  /// Parses a value into an unsigned 16-bit integer (0–65,535).
  static int parseU16({Object? value}) {
    try {
      final toint = IntUtils.parse(value);
      return toint.asUint16;
    } catch (e) {
      throw BcsSerializationException(
          "Invalid value for move type 'U16': Expected an unsigned 16-bit integer (0–65,535).",
          details: {"value": "$value"});
    }
  }

  /// Parses a value into an unsigned 32-bit integer (0–4,294,967,295).
  static int parseU32({Object? value}) {
    try {
      final toint = IntUtils.parse(value);
      return toint.asUint32;
    } catch (e) {
      throw BcsSerializationException(
          "Invalid value for move type 'U32': Expected an unsigned 32-bit integer (0–4,294,967,295).",
          details: {"value": "$value"});
    }
  }

  /// Parses a value into an unsigned 64-bit integer (0–2^64−1).
  static BigInt parseU64({Object? value}) {
    try {
      final toint = BigintUtils.parse(value);
      return toint.asUint64;
    } catch (e) {
      throw BcsSerializationException(
          "Invalid value for move type 'U64': Expected an unsigned 64-bit integer (0–2^64−1).",
          details: {"value": "$value"});
    }
  }

  /// Parses a value into an unsigned 128-bit integer (0–2^128−1).
  static BigInt parseU128({Object? value}) {
    try {
      final toint = BigintUtils.parse(value);
      return toint.asUint128;
    } catch (e) {
      throw BcsSerializationException(
          "Invalid value for move type 'U128': Expected an unsigned 128-bit integer (0–2^128−1).",
          details: {"value": "$value"});
    }
  }

  /// Parses a value into an unsigned 256-bit integer (0–2^256−1).
  static BigInt parseU256({Object? value}) {
    try {
      final toint = BigintUtils.parse(value);
      return toint.asUint256;
    } catch (e) {
      throw BcsSerializationException(
          "Invalid value for move type 'U256': Expected an unsigned 256-bit integer (0–2^256−1).",
          details: {"value": "$value"});
    }
  }

  /// Parses a value into a string, validating it's of String type.
  static String parseString({Object? value}) {
    if (value is String) {
      return value;
    }
    throw BcsSerializationException("Invalid value for move type 'String'.",
        details: {"value": "$value"});
  }

  /// Parses a value into a byte list from a hex string or List<`int`>.
  static List<int> parseBytes({Object? value}) {
    try {
      if (value is String) {
        final bytes = BytesUtils.tryFromHexString(value);
        if (bytes != null) return bytes.asImmutableBytes;
      } else if (value is List) {
        return value.cast<int>().asImmutableBytes;
      }
    } catch (_) {}
    throw BcsSerializationException(
        "Invalid value for move type 'Bytes': Expected a List<int> or a hexadecimal string.",
        details: {"value": "$value"});
  }

  /// Parses a value into address bytes from a hex string or List<`int`>.
  static List<int> parseAddressBytes({Object? value}) {
    try {
      if (value is String) {
        return AptosAddressUtils.addressToBytes(value);
      } else if (value is List) {
        return AptosAddressUtils.praseAddressBytes(value.cast());
      }
    } catch (_) {}
    throw BcsSerializationException(
        "Invalid value for move type 'Address': Expected a List<int> or a hexadecimal string.",
        details: {"value": "$value"});
  }
}
