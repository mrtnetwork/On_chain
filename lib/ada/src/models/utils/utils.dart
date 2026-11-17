import 'package:blockchain_utils/blockchain_utils.dart';

class AdaTransactionUtils {
  static BuBytes validateFixedLengthBytes({
    required List<int> bytes,
    required int length,
    String? objectName,
  }) {
    if (bytes.length != length) {
      throw BuError(
        DefaultErrorType.invalidLength,
        "Invalid ${objectName ?? 'hash'} length.",
        details: {
          'expected': length.toString(),
          'length': bytes.length.toString(),
        },
      );
    }
    return bytes.asImmutableBytes;
  }

  static BuBytes validateFixedHexByteslength({
    required String hexBytes,
    required int length,
  }) {
    try {
      return validateFixedLengthBytes(
        bytes: BytesUtils.fromHexString(hexBytes),
        length: length,
      );
    } on BuError {
      rethrow;
    } catch (e) {
      throw BuError(
        DefaultErrorType.badHex,
        'Invalid hex bytes.',
        details: {'value': hexBytes},
      );
    }
  }
}
