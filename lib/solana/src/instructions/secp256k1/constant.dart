// Constants related to the Secp256k1 program.
import 'package:on_chain/solana/src/address/sol_address.dart';

/// Represents constant values for the Secp256k1 program.
class Secp256k1ProgramConst {
  /// The program ID associated with the Secp256k1 program.
  static const SolAddress programId =
      SolAddress.unchecked("KeccakSecp256k11111111111111111111111111111");
}
