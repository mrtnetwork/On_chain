import 'package:blockchain_utils/blockchain_utils.dart';

enum AptosKeyAlgorithm {
  ed25519(value: 0, aip80: "ed25519-priv-"),
  secp256k1(value: 1, aip80: "secp256k1-priv-");

  final int value;
  final String aip80;
  const AptosKeyAlgorithm({required this.value, required this.aip80});

  static AptosKeyAlgorithm fromName(String name) {
    return values.firstWhere(
      (e) => e.name == name,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "Cannot find key algorithm from the given name.",
                details: {"name": name},
              ),
    );
  }

  static AptosKeyAlgorithm fromAip80(String aip80) {
    return values.firstWhere(
      (e) => e.aip80 == aip80,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid aptos AIP-80 private prefix.",
                details: {"AIP-80": aip80},
              ),
    );
  }

  static AptosKeyAlgorithm fromEllipticCurveType(CryptoKeyType type) {
    return switch (type) {
      CryptoKeyType.ed25519 => AptosKeyAlgorithm.ed25519,
      CryptoKeyType.secp256k1 => AptosKeyAlgorithm.secp256k1,
      _ =>
        throw BuError(
          DefaultErrorType.unsupported,
          "Unsupported elliptic curve type.",
          details: {"algorithm": type.name},
        ),
    };
  }

  CryptoKeyType get curveType {
    return switch (this) {
      AptosKeyAlgorithm.ed25519 => CryptoKeyType.ed25519,
      AptosKeyAlgorithm.secp256k1 => CryptoKeyType.secp256k1,
    };
  }
}
