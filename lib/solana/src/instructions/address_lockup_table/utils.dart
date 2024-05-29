import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/models/pda/pda.dart';

import 'constant.dart';

class AddressLookupTableProgramUtils {
  static ProgramDerivedAddress findAddressLookupTableProgram(
      {required SolAddress authority, required BigInt recentSlot}) {
    return ProgramDerivedAddress.find(seedBytes: [
      authority.toBytes(),
      LayoutConst.u64().serialize(recentSlot)
    ], programId: AddressLookupTableProgramConst.programId);
  }
}
