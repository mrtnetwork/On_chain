import 'package:on_chain/solana/src/address/sol_address.dart';

/// Constants for the AddressLookupTable program.
class AddressLookupTableProgramConst {
  /// Size of the address lookup table metadata.
  static int lockupTableMetaSize = 56;

  /// The program ID for the AddressLookupTable program.
  static const SolAddress programId =
      SolAddress.unchecked("AddressLookupTab1e1111111111111111111111111");
}
