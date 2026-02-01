import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';

/// Utility class providing helper methods for Tron-related operations.
class TronHelper {
  /// Converts a string amount to SUN (smallest unit in Tron).
  static BigInt toSun(String amount) {
    return AmountConverter.tron.toUnit(amount);
  }

  /// Converts a bigint sun to trx with decimal.
  static String fromSun(BigInt amount) {
    return AmountConverter.tron.toAmount(amount);
  }

  /// Decodes permission operations from a hex representation.
  static List<TransactionContractType> decodePermissionOperation(
      final String operations) {
    final List<TransactionContractType> accountPermissions = [];
    final operationBytes = BytesUtils.fromHexString(operations);
    for (int i = 0; i < 32; i++) {
      for (int j = 0; j < 8; j++) {
        if ((operationBytes[i] >> j & 0x1) == 1) {
          final int permissionValue = i * 8 + j;
          final operation =
              TransactionContractType.findByValue(permissionValue);
          if (operation != null) {
            accountPermissions.add(operation);
          }
        }
      }
    }
    return accountPermissions;
  }

  /// Encodes permission operations into a bytes representation.
  static List<int> encodePermissionOperations(
      List<TransactionContractType> values) {
    final valuesInt = values.map((e) => e.value).toList();
    final List<int> operationBuffer = List<int>.filled(32, 0);
    for (final int value in valuesInt) {
      operationBuffer[value ~/ 8] |= (1 << (value % 8));
    }
    return List<int>.from(operationBuffer);
  }
}
