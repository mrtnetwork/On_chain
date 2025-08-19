import 'package:blockchain_utils/helper/helper.dart';
import 'package:blockchain_utils/utils/utils.dart';
import 'package:blockchain_utils/exception/exceptions.dart';
import 'package:on_chain/ada/src/exception/exception.dart';

class AdaTransactionUtils {
  static List<int> validateFixedLengthBytes(
      {required List<int> bytes, required int length, String? objectName}) {
    if (bytes.length != length) {
      throw ADAPluginException("Invalid ${objectName ?? 'hash'} length.",
          details: {'expected': length, 'length': bytes.length});
    }
    return bytes.asImmutableBytes;
  }

  static List<int> validateFixeHexByteslength(
      {required String hexBytes, required int length}) {
    try {
      return validateFixedLengthBytes(
          bytes: BytesUtils.fromHexString(hexBytes), length: length);
    } on MessageException {
      rethrow;
    } catch (e) {
      throw ADAPluginException('Invalid hex bytes.',
          details: {'value': hexBytes});
    }
  }
}
