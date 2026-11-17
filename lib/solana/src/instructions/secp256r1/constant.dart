// Constants related to the Secp256r1 program.
import 'package:on_chain/solana/src/address/sol_address.dart';

/// Represents constant values for the Secp256r1 signature
/// verify precompile (SIMD-0075). Verifies P-256 signatures directly against
/// a 33-byte compressed public key (unlike secp256k1 which recovers).
class Secp256r1ProgramConst {
  /// The program ID associated with the Secp256r1 program.
  static const SolAddress programId = SolAddress.unchecked(
    'Secp256r1SigVerify1111111111111111111111111',
  );

  /// Compressed P-256 public key length in bytes.
  static const int compressedPubkeyLength = 33;

  /// Compact P-256 signature length in bytes (r || s).
  static const int signatureLength = 64;

  /// Maximum signatures per instruction.
  static const int maxSignatures = 8;
}
