import 'package:blockchain_utils/utils/binary/binary_operation.dart';
import 'package:blockchain_utils/utils/numbers/utils/int_utils.dart';

class COSEUtils {
  static List<int> fnv32aBytes(List<int> data) {
    const int fnvPrime = 0x01000193;
    const int offsetBasis = 0x811C9DC5;

    int hash = offsetBasis;
    for (final byte in data) {
      hash ^= byte;
      hash = (hash * fnvPrime) & mask32;
    }
    return IntUtils.toBytes(hash, length: 4);
  }
}
