import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/models/contract/base_contract/base.dart';

/// Utility class providing helper methods for Tron-related operations.
class TronHelper {
  /// Tron has 6 decimal places, and this is the representation of 1 TRX in SUN.
  static final BigRational _trxDecimal = BigRational(BigInt.from(10).pow(6));

  /// Converts a string amount to SUN (smallest unit in Tron).
  static BigInt toSun(String amount) {
    final parse = BigRational.parseDecimal(amount);
    return (parse * _trxDecimal).toBigInt();
  }

  /// Converts a bigint sun to trx with decimal.
  static String fromSun(BigInt amount) {
    final parse = BigRational(amount);
    return (parse / _trxDecimal).toDecimal(digits: 6);
  }

  /// Decodes permission operations from a hex representation.
  static List<TransactionContractType> decodePermissionOperation(
      final String operations) {
    List<TransactionContractType> accountPermissions = [];
    final bytes = BytesUtils.fromHexString(operations);
    for (int index = 0; index < bytes.length; index++) {
      int byte = bytes[index];
      int bitIndex = 0;
      while (bitIndex < 8) {
        if ((byte & (1 << bitIndex)) != 0) {
          int permissionValue = index * 8 + bitIndex;
          final findPermission =
              TransactionContractType.findByValue(permissionValue);
          if (findPermission != null) {
            accountPermissions.add(findPermission);
          }
        }
        bitIndex++;
      }
    }
    return accountPermissions;
  }

  /// Encodes permission operations into a bytes representation.
  static List<int> encodePermissionOperations(
      List<TransactionContractType> values) {
    final valuesInt = values.map((e) => e.value).toList();
    final List<int> newBuffer = List<int>.filled(32, 0);
    for (int value in valuesInt) {
      final int byteIndex = value ~/ 8;
      final int bitIndex = value % 8;
      newBuffer[byteIndex] |= (1 << bitIndex);
    }
    return List<int>.from(newBuffer);
  }
}
