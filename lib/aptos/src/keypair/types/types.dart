import 'package:on_chain/aptos/src/exception/exception.dart';

enum AptosKeyAlgorithm {
  ed25519(value: 0),
  secp256k1(value: 1);

  final int value;
  const AptosKeyAlgorithm({required this.value});

  static AptosKeyAlgorithm fromName(String name) {
    return values.firstWhere((e) => e.name == name,
        orElse: () => throw DartAptosPluginException(
            "cannot find Key Algorithm from the given name.",
            details: {"name": name}));
  }
}
