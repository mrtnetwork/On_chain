import 'package:blockchain_utils/signer/signer.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';

/// Constants for the Ed25519 program.
class Ed25519ProgramConst {
  /// The program ID for the Ed25519 program.
  static const SolAddress programId =
      SolAddress.unchecked('Ed25519SigVerify111111111111111111111111111');

  static final int signatureLen = SolanaSignerConst.signatureLen;
}
