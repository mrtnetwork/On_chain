import 'package:blockchain_utils/blockchain_utils.dart';

/// Helper class for Ethereum-related operations.
class ETHHelper {
  /// Converts the specified Ethereum amount in decimal string format to Wei.
  ///
  /// The `amount` parameter is expected to be a string representation of an
  /// Ethereum amount, and the result is returned as a BigInt representing the
  /// equivalent value in Wei.
  static BigInt toWei(String amount) {
    return AmountConverter.eth.toUnit(amount);
  }

  static String fromWei(BigInt wei) {
    return AmountConverter.eth.toAmount(wei);
  }
}
