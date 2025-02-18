import 'package:blockchain_utils/bip/ecc/curve/elliptic_curve_types.dart';
import 'package:blockchain_utils/bip/ecc/keys/i_keys.dart';
import 'package:blockchain_utils/utils/binary/utils.dart';
import 'package:on_chain/aptos/aptos.dart';

class AptosCryptoUtils {
  /// decode aptos AIP-80 private key style to private key.
  static (AptosKeyAlgorithm, List<int>) decodeAptosPrivateKey(
      String privateKey) {
    int index = privateKey.lastIndexOf("-");
    if (index == -1) {
      throw DartAptosPluginException("Invalid aptos AIP-80 private key style.");
    }
    index += 1;

    try {
      final algorithm =
          AptosKeyAlgorithm.fromAip80(privateKey.substring(0, index));
      final keyBytes = BytesUtils.fromHexString(privateKey.substring(index));
      return (algorithm, keyBytes);
    } catch (e) {
      throw DartAptosPluginException("Invalid aptos AIP-80 private key style.",
          details: {"error": e.toString()});
    }
  }

  /// encode aptos private key to AIP-80 style.
  static String encodeAptosPrivateKey(List<int> privateKey,
      {EllipticCurveTypes? type, AptosKeyAlgorithm? keyScheme}) {
    if (keyScheme == null && type == null) {
      throw DartAptosPluginException(
          "Key scheme or Elliptic curve type required for generate Aptos AIP-80 private key.");
    }
    keyScheme ??= AptosKeyAlgorithm.fromEllipticCurveType(type!);
    final key = IPrivateKey.fromBytes(privateKey, keyScheme.curveType);
    return keyScheme.aip80 + key.toHex(prefix: "0x");
  }
}
