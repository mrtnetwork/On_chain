import 'package:on_chain/algorand/src/abi/src/abi_type.dart';
import 'package:on_chain/exception/onchain_error.dart';

class AlgoAbiUtils {
  /// Maximum length for dynamic types (uint16 max).
  static const int maxLen = 65535;

  /// Single byte size.
  static const int singleByteSize = 1;

  /// Single bool size.
  static const int singleBoolSize = 1;

  /// Length prefix size for dynamic types (uint16).
  static const int lengthEncodeByteSize = 2;

  /// Compresses up to 8 consecutive bool values into a single byte.
  static int compressMultipleBool(List<ABIValue> valueList) {
    if (valueList.length > 8) {
      throw OnChainErrors.algoPlugin(
        'compressMultipleBool',
        reason: 'value list length must be ≤ 8',
      );
    }
    var res = 0;
    for (var i = 0; i < valueList.length; i++) {
      final val = valueList[i];
      if (val is! bool) {
        throw OnChainErrors.algoPlugin(
          'compressMultipleBool',
          reason: 'non-boolean values cannot be compressed into a byte',
        );
      }
      if (val) res |= 1 << (7 - i);
    }
    return res;
  }

  /// Finds consecutive [ABIBoolType]s starting from [index] in direction [delta].
  static int findBoolLR(List<ABIType> typeList, int index, int delta) {
    var until = 0;
    while (true) {
      final curr = index + delta * until;
      if (curr < 0 || curr >= typeList.length) {
        until--;
        break;
      }
      if (typeList[curr] is ABIBoolType) {
        if (curr != typeList.length - 1 && delta == 1) {
          until++;
        } else if (curr > 0 && delta == -1) {
          until++;
        } else {
          break;
        }
      } else {
        until--;
        break;
      }
    }
    return until;
  }
}
