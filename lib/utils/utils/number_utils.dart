import 'package:blockchain_utils/blockchain_utils.dart';

class PluginBigintUtils {
  static BigInt hexToBigint(Object? v) {
    if (v == null || v == '0x') return BigInt.zero;
    return JsonParser.valueAsBigInt(v, allowHex: true);
  }

  static BigInt? tryHexToBigint(String? v) {
    if (v == null || v == '0x') return null;
    try {
      return hexToBigint(v);
    } catch (e) {
      return null;
    }
  }
}

class PluginIntUtils {
  static double toDouble(Object? v) {
    return JsonParser.valueAsDouble(v);
  }

  static int hexToInt(Object? v) {
    if (v == null || v == '0x') return 0;
    return JsonParser.valueAsInt(v, allowHex: true);
  }

  static int? tryHexToInt(String? v) {
    if (v == null || v == '0x') return null;
    try {
      return hexToInt(v);
    } catch (e) {
      return null;
    }
  }

  static bool? tryHexToBool(Object? v) {
    if (v == null) return null;
    if (v is bool) return v;
    if (v == '0x' || v != '0x1' && v != '0x0') {
      return null;
    }
    return v == '0x1';
  }
}
