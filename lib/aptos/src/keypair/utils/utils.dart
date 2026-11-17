import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/aptos/aptos.dart';
import 'package:on_chain/exception/onchain_error.dart';

class AptosCryptoUtils {
  /// decode aptos AIP-80 private key style to private key.
  static (AptosKeyAlgorithm, List<int>) decodeAptosPrivateKey(
    String privateKey,
  ) {
    int index = privateKey.lastIndexOf("-");
    if (index == -1) {
      throw BuError(
        DefaultErrorType.badPrivateKey,
        "Invalid Aptos AIP-80 private key style.",
      );
    }
    index += 1;

    try {
      final algorithm = AptosKeyAlgorithm.fromAip80(
        privateKey.substring(0, index),
      );
      final keyBytes = BytesUtils.fromHexString(privateKey.substring(index));
      return (algorithm, keyBytes);
    } catch (e) {
      throw BuError(
        DefaultErrorType.badPrivateKey,
        "Invalid Aptos AIP-80 private key style.",
        details: {"error": e.toString()},
      );
    }
  }

  /// encode aptos private key to AIP-80 style.
  static String encodeAptosPrivateKey(
    List<int> privateKey, {
    CryptoKeyType? type,
    AptosKeyAlgorithm? keyScheme,
  }) {
    if (keyScheme == null && type == null) {
      throw BuError(
        OnChainErrorType.aptosPlugin,
        "Key scheme or elliptic curve type required to generate Aptos AIP-80 private key.",
      );
    }
    keyScheme ??= AptosKeyAlgorithm.fromEllipticCurveType(type!);
    final key = IPrivateKey.fromBytes(privateKey, keyScheme.curveType);
    return keyScheme.aip80 + key.takeSecretKey().toHex(prefix: "0x");
  }
}
