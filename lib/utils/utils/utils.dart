import 'package:blockchain_utils/utils/binary/utils.dart';
import 'package:blockchain_utils/utils/numbers/utils/bigint_utils.dart';
import 'package:blockchain_utils/utils/numbers/utils/int_utils.dart';
import 'package:blockchain_utils/utils/string/string.dart';
import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/exception/exception.dart';

class OnChainUtils {
  static T parseInt<T>({required Object? value, required String name}) {
    if (0 is! T) {
      throw const TronPluginException(
          'Invalid type casting for numeric parser.');
    }
    if (value == null && null is T) return null as T;
    if (value == null) {
      throw TronPluginException('Missing parameter: $name.');
    }

    final parse = IntUtils.tryParse(value);
    if (parse != null) {
      return parse as T;
    }
    throw TronPluginException('Invalid numeric value for parameter: $name.');
  }

  static T parseBigInt<T>({required Object? value, required String name}) {
    if (BigInt.one is! T) {
      throw const TronPluginException(
          'Invalid type casting for BigInt parser.');
    }
    if (value == null && null is T) return null as T;
    if (value == null) {
      throw TronPluginException('Missing parameter: $name.');
    }

    final parse = BigintUtils.tryParse(value);
    if (parse != null) {
      return parse as T;
    }
    throw TronPluginException('Invalid BigInt value for parameter: $name.');
  }

  static T parseHex<T>({required Object? value, required String name}) {
    if (<int>[] is! T) {
      throw const TronPluginException(
          'Invalid type casting for String parser.');
    }
    if (value == null && null is T) return null as T;
    if (value == null) {
      throw TronPluginException('Missing parameter: $name.');
    }
    if (value is String) {
      final parse = BytesUtils.tryFromHexString(value);
      if (parse != null) {
        return parse as T;
      }
    }
    throw TronPluginException('Invalid Hex bytes value for parameter: $name.');
  }

  static T parseString<T>({required Object? value, required String name}) {
    if ('' is! T) {
      throw const TronPluginException(
          'Invalid type casting for String parser.');
    }
    if (value == null && null is T) return null as T;
    if (value == null) {
      throw TronPluginException('Missing parameter: $name.');
    }
    if (value is String) {
      return value as T;
    }
    throw TronPluginException('Invalid String value for parameter: $name.');
  }

  static T parseTronAddress<T>({required Object? value, required String name}) {
    if (value == null && null is T) return null as T;
    if (value == null) {
      throw TronPluginException('Missing parameter: $name.');
    }
    final String result = parseString(value: value, name: name);
    try {
      return TronAddress(result) as T;
    } catch (e) {
      throw TronPluginException('Invalid String value for parameter: $name.');
    }
  }

  static T parseBytes<T>({required Object? value, required String name}) {
    if (<int>[] is! T) {
      throw const TronPluginException('Invalid type casting for bytes parser.');
    }
    if (value == null && null is T) return null as T;
    if (value == null) {
      throw TronPluginException('Missing parameter: $name.');
    }
    if (value is String) {
      return StringUtils.toBytes(value) as T;
    }
    throw TronPluginException('Invalid value for parameter: $name.');
  }

  static Map<K, V>? parseMap<K, V>(
      {required Object? value, required String name, throwOnNull = false}) {
    try {
      return Map<K, V>.from(value as Map);
    } catch (e) {
      if (!throwOnNull) return null;
    }
    if (value == null) {
      throw TronPluginException('Missing parameter: $name.');
    }
    throw TronPluginException('Invalid value for parameter: $name.');
  }

  static List<T>? parseList<T>(
      {required Object? value,
      required String name,
      bool throwOnNull = false}) {
    if (value == null && !throwOnNull) return null;
    try {
      return List<T>.from(value as List);
    } catch (e) {
      if (!throwOnNull) return null;
    }
    if (value == null) {
      throw TronPluginException('Missing parameter: $name.');
    }
    throw TronPluginException('Invalid List value for parameter: $name.');
  }

  static T parseBoolean<T>({required Object? value, required String name}) {
    if (true is! T) {
      throw const TronPluginException(
          'Invalid type casting for BigInt parser.');
    }
    if (value == null && null is T) return null as T;
    if (value == null) {
      throw TronPluginException('Missing parameter: $name.');
    }

    if (value is bool) {
      return value as T;
    }
    throw TronPluginException('Invalid boolean value for parameter: $name.');
  }
}
