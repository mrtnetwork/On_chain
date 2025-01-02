import 'package:blockchain_utils/blockchain_utils.dart';

class PluginBigintUtils {
  static BigInt hexToBigint(String v) {
    if (v == '0x') return BigInt.zero;
    final val = StringUtils.strip0x(v);
    return BigInt.parse(val, radix: 16);
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
  static int hexToInt(String v) {
    if (v == '0x') return 0;
    final val = StringUtils.strip0x(v);
    return int.parse(val, radix: 16);
  }

  static int? tryHexToInt(String? v) {
    if (v == null || v == '0x') return null;
    try {
      return hexToInt(v);
    } catch (e) {
      return null;
    }
  }

  static double toDouble(dynamic v) {
    if (v is double) return v;
    if (v is int) return v.toDouble();
    return double.parse(v);
  }
}

class PluginBooleanUtils {
  static bool? tryHexToBool(String? v) {
    if (v == '0x' || v != '0x1' && v != '0x0') {
      return null;
    }
    return v == '0x1';
  }
}
