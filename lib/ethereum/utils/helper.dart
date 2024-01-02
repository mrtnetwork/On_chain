import 'package:blockchain_utils/blockchain_utils.dart';

/// Helper class for Ethereum-related operations.
class ETHHelper {
  static const int _evmDecimal = 18;

  /// Decimal representation of 1 ETH in Wei.
  static final _ethDecimal = BigRational(BigInt.from(10).pow(_evmDecimal));

  /// Converts the specified Ethereum amount in decimal string format to Wei.
  ///
  /// The `amount` parameter is expected to be a string representation of an
  /// Ethereum amount, and the result is returned as a BigInt representing the
  /// equivalent value in Wei.
  static BigInt toWei(String amount) {
    final parse = BigRational.parseDecimal(amount);
    return (parse * _ethDecimal).toBigInt();
  }

  static String fromWei(BigInt wei) {
    final parse = BigRational(wei);
    return (parse / _ethDecimal).toDecimal();
  }
}
