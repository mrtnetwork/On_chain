import 'package:blockchain_utils/blockchain_utils.dart';

/// Helper class for converting SUI to Mist and vice versa with 9 decimal precision.
class SuiHelper {
  static const int decimal = 9;
  static final _suiDecimal = BigRational(BigInt.from(10).pow(decimal));

  /// Converts a SUI value (string) to its equivalent Mist (BigInt).
  static BigInt toMist(String sui) {
    final parse = BigRational.parseDecimal(sui);
    return (parse * _suiDecimal).toBigInt();
  }

  /// Converts a Mist value (BigInt) to its SUI representation (string) with 9 decimal places.
  static String toSui(BigInt mist) {
    final price = BigRational(mist);
    return (price / _suiDecimal).toDecimal(digits: decimal);
  }
}
