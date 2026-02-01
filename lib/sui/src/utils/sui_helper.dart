import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/sui/sui.dart';

/// Helper class for converting SUI to Mist and vice versa with 9 decimal precision.
class SuiHelper {
  /// Converts a SUI value (string) to its equivalent Mist (BigInt).
  static BigInt toMist(String sui) {
    return AmountConverter.sui.toUnit(sui);
  }

  /// Converts a Mist value (BigInt) to its SUI representation (string) with 9 decimal places.
  static String toSui(BigInt mist) {
    return AmountConverter.sui.toAmount(mist);
  }

  static String generateTransactionDigest(List<int> transactionData) {
    return Base58Encoder.encode(QuickCrypto.blake2b256Hash([
      ...StringUtils.encode(SuiTransactionConst.transactionDataDomain),
      ...transactionData
    ]));
  }
}
