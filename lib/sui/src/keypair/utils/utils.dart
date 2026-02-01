import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/sui/src/exception/exception.dart';
import 'package:on_chain/sui/src/intent/intent.dart';
import 'package:on_chain/sui/src/keypair/constant/constant.dart';
import 'package:on_chain/sui/src/keypair/core/core.dart';

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
      if (index > BinaryOps.mask8) break;
    }

    return indexes;
  }

  /// Decodes a Sui Bech32 secret key into its corresponding private key.
  static (SuiKeyAlgorithm, List<int>) decodeSuiSecretKey(String secretKey) {
    try {
      final decode =
          Bech32Decoder.decode(SuiKeypairConst.suiPrivateKeyPrefix, secretKey);
      final algorithm = SuiKeyAlgorithm.fromFlag(decode[0]);
      return (algorithm, decode.sublist(1).asImmutableBytes);
    } on DartSuiPluginException {
      rethrow;
    } catch (e) {
      throw DartSuiPluginException("Invalid sui bech32 secret key.",
          details: {"error": e.toString()});
    }
  }

  /// Encodes the Sui private key to a Bech32 string.
  ///
  /// The encoded format includes the `suiprivkey` HRP,
  /// the key scheme flag, and the secret key bytes.
  static String encodeSuiSecretKey(List<int> secretKey,
      {EllipticCurveTypes? type, SuiKeyAlgorithm? keyScheme}) {
    if (keyScheme == null && type == null) {
      throw DartSuiPluginException(
          "Key scheme or Elliptic curve type required for generate sui Bech32 secret key.");
    }
    keyScheme ??= SuiKeyAlgorithm.fromEllipticCurveType(type!);
    final key = IPrivateKey.fromBytes(secretKey, keyScheme.curveType);
    return Bech32Encoder.encode(
        SuiKeypairConst.suiPrivateKeyPrefix, [keyScheme.flag, ...key.raw]);
  }
}
