import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/exception/exception.dart';

/// Utility class for Solana-related operations.
class SolanaUtils {
  static const int lamportsPerSol = 1000000000;

  static const int maxSeedLength = 32;
  static const String programDerivedAddressSeed = 'ProgramDerivedAddress';
  static const int decimal = 9;

  /// Converts a Solana value in string format to lamports.
  static BigInt toLamports(String value) {
    return AmountConverter.sol.toUnit(value);
  }

  /// Converts a Solana value to lamports.
  static (SolAddress, int) findProgramAddress(
      {required List<List<int>> seeds, required SolAddress programId}) {
    int nonce = 255;
    List<int> seedBytes = [];
    for (final i in seeds) {
      if (i.length > maxSeedLength) {
        throw const SolanaPluginException('Max seed length exceeded');
      }
      seedBytes = [...seedBytes, ...i];
    }
    while (nonce != 0) {
      try {
        final List<int> seedsWithNonce = [...seedBytes, nonce];
        final addr = createProgramAddress(
            seedBytes: seedsWithNonce, programId: programId);
        return (addr, nonce);
      } catch (e) {
        nonce--;
        continue;
      }
    }
    throw const SolanaPluginException(
        'Unable to find a viable program address nonce');
  }

  /// Finds a program address for the given seeds and program ID.
  static SolAddress createProgramAddress(
      {required List<int> seedBytes, required SolAddress programId}) {
    seedBytes = [
      ...seedBytes,
      ...programId.toBytes(),
      ...programDerivedAddressSeed.codeUnits
    ];

    seedBytes = QuickCrypto.sha256Hash(seedBytes);
    if (Ed25519PublicKey.isValidBytes(seedBytes)) {
      throw const SolanaPluginException(
          'Invalid seeds, address must fall off the curve');
    }
    return SolAddress.uncheckBytes(seedBytes);
  }
}
