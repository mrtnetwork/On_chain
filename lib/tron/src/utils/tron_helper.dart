import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/proto_messages/protocol/src/tron.dart';

/// Helper methods for Tron-related operations.
class TronHelper {
  /// Converts a TRX decimal amount to SUN.
  static BigInt toSun(String amount) {
    return AmountConverter.tron.toUnit(amount);
  }

  /// Converts SUN to a TRX decimal amount.
  static String fromSun(BigInt amount) {
    return AmountConverter.tron.toAmount(amount);
  }

  /// Decodes a hex-encoded permission bitmask into contract types.
  static List<TronTransactionContractContractType> decodePermissionOperation(
    final String operations,
  ) {
    final List<TronTransactionContractContractType> accountPermissions = [];
    final operationBytes = BytesUtils.fromHexString(operations);
    for (int i = 0; i < 32; i++) {
      for (int j = 0; j < 8; j++) {
        if ((operationBytes[i] >> j & 0x1) == 1) {
          final int permissionValue = i * 8 + j;
          final operation = TronTransactionContractContractType.values
              .firstWhereNullable((e) => e.value == permissionValue);
          if (operation != null) {
            accountPermissions.add(operation);
          }
        }
      }
    }
    return accountPermissions;
  }

  /// Encodes contract types into a 32-byte permission bitmask.
  static BuBytes encodePermissionOperations(
    List<TronTransactionContractContractType> values,
  ) {
    final valuesInt = values.map((e) => e.value).toList();
    final List<int> operationBuffer = List<int>.filled(32, 0);
    for (final int value in valuesInt) {
      operationBuffer[value ~/ 8] |= (1 << (value % 8));
    }
    return operationBuffer.asImmutableBytes;
  }
}
