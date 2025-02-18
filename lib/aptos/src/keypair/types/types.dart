import 'package:blockchain_utils/bip/ecc/curve/elliptic_curve_types.dart';
import 'package:on_chain/aptos/src/exception/exception.dart';

enum AptosKeyAlgorithm {
  ed25519(value: 0, aip80: "ed25519-priv-"),
  secp256k1(value: 1, aip80: "secp256k1-priv-");

  final int value;
  final String aip80;
  const AptosKeyAlgorithm({required this.value, required this.aip80});

  static AptosKeyAlgorithm fromName(String name) {
    return values.firstWhere((e) => e.name == name,
        orElse: () => throw DartAptosPluginException(
            "cannot find Key Algorithm from the given name.",
            details: {"name": name}));
  }

  static AptosKeyAlgorithm fromAip80(String aip80) {
    return values.firstWhere((e) => e.aip80 == aip80,
        orElse: () => throw DartAptosPluginException(
            "Invalid aptos AIP-80 private prefix.",
            details: {"AIP-80": aip80}));
  }

  static AptosKeyAlgorithm fromEllipticCurveType(EllipticCurveTypes type) {
    return switch (type) {
      EllipticCurveTypes.ed25519 => AptosKeyAlgorithm.ed25519,
      EllipticCurveTypes.secp256k1 => AptosKeyAlgorithm.secp256k1,
      _ => throw DartAptosPluginException("Unsuported Elliptic curve type.",
          details: {"algorithm": type.name})
    };
  }

  EllipticCurveTypes get curveType {
    return switch (this) {
      AptosKeyAlgorithm.ed25519 => EllipticCurveTypes.ed25519,
      AptosKeyAlgorithm.secp256k1 => EllipticCurveTypes.secp256k1
    };
  }
}
