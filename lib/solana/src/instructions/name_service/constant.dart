import 'package:on_chain/solana/src/address/sol_address.dart';

/// Constants related to the Name Service program.
class NameServiceProgramConst {
  /// Solana address of the Twitter verification authority.
  static const SolAddress twitterVerificationAuthority =
      SolAddress.unchecked('FvPH7PrVrLGKPfqaf3xJodFTjZriqrAXXLTVWEorTFBi');

  /// The address of the name registry that will be a parent to all twitter handle registries.
  static const SolAddress twitterRootPrentRegisteryKey =
      SolAddress.unchecked('4YcexoW3r78zz16J2aqmukBLRwGq6rAvWzJpkYAXqebv');

  /// Solana address of the Name Service program.
  static const SolAddress programId =
      SolAddress.unchecked('namesLPneVptA9Z5rqUDD9tMTWEJwofgaYwp8cawRkX');

  /// Prefix used for hashing names in the Name Service program.
  static const String hashPrefix = 'SPL Name Service';
}
