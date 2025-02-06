import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/sui/src/intent/intent.dart';

class SuiCryptoUtils {
  /// generate sui personal message
  static List<int> generatePersonalMessageDigest(List<int> message) {
    final intent =
        SuiIntentMessage.personalMessage(SuiPersonalMessage(message: message));
    return QuickCrypto.blake2b256Hash(intent.toBcs());
  }

  /// generate sui transaction digest for signing.
  static List<int> generateTransactionDigest(
      {required List<int> txBytes, required bool hashDigest}) {
    if (!hashDigest) return txBytes.asImmutableBytes;
    return QuickCrypto.blake2b256Hash(txBytes).asImmutableBytes;
  }

  /// get public key indexes from signature bitmat.
  static List<int> getIndexesFromBitmap(int bitMap) {
    List<int> indexes = [];
    int index = 0;

    while (bitMap != 0) {
      if ((bitMap & 1) == 1) {
        indexes.add(index);
      }
      bitMap >>= 1;
      index++;
      if (index > mask8) break;
    }

    return indexes;
  }
}
