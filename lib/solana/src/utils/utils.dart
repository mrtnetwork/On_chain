import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';

/// Utility class for Solana-related operations.
class SolanaUtils {
  static const int lamportsPerSol = 1000000000;

  static const int maxSeedLength = 32;
  static const String programDerivedAddressSeed = "ProgramDerivedAddress";
  static const int decimal = 9;
  static final BigRational _decimalPlaces = BigRational.from(10).pow(decimal);

  /// Converts a Solana value in string format to lamports.
  static BigInt toLamports(String value) {
    final BigRational r = BigRational.parseDecimal(value);
    return (r * _decimalPlaces).toBigInt();
  }

  /// Converts a Solana value to lamports.
  static Tuple<SolAddress, int> findProgramAddress(
      {required List<List<int>> seeds, required SolAddress programId}) {
    int nonce = 255;
    List<int> seedBytes = [];
    for (final i in seeds) {
      if (i.length > maxSeedLength) {
        throw const MessageException("Max seed length exceeded");
      }
      seedBytes = [...seedBytes, ...i];
    }
    while (nonce != 0) {
      try {
        final List<int> seedsWithNonce = [...seedBytes, nonce];
        final addr = createProgramAddress(
            seedBytes: seedsWithNonce, programId: programId);
        return Tuple(addr, nonce);
      } catch (e) {
        nonce--;
        continue;
      }
    }
    throw const MessageException(
        "Unable to find a viable program address nonce");
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
      throw const MessageException(
          "Invalid seeds, address must fall off the curve");
    }
    return SolAddress.uncheckBytes(seedBytes);
  }
}
