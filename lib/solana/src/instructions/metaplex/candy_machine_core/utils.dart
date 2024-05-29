import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/constant.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/models/pda/pda.dart';

class MetaplexCandyMachineProgramUtils {
  static ProgramDerivedAddress findMintCounterPda(
      // A unique identifier in the context of a Candy Machine/Candy Guard combo
      {required int id,

      /// The address of the wallet trying to mint
      required SolAddress user,

      /// The address of the Candy Guard account
      required SolAddress candyGuard,

      /// The address of the Candy Machine account
      required SolAddress candyMachine,
      SolAddress programId =
          MetaplexCandyMachineCoreProgramConst.candyGuardProgramId}) {
    return ProgramDerivedAddress.find(seedBytes: [
      "mint_limit".codeUnits,
      LayoutConst.u8().serialize(id),
      user.toBytes(),
      candyGuard.toBytes(),
      candyMachine.toBytes()
    ], programId: programId);
  }

  static ProgramDerivedAddress findAllowListProofPda(

      /// The Merkle Root used when verifying the user
      {required List<int> merkleRoot,

      /// The address of the wallet trying to mint
      required SolAddress user,

      /// The address of the Candy Guard account
      required SolAddress candyGuard,

      /// The address of the Candy Machine account
      required SolAddress candyMachine,
      SolAddress programId =
          MetaplexCandyMachineCoreProgramConst.candyGuardProgramId}) {
    return ProgramDerivedAddress.find(seedBytes: [
      "allow_list".codeUnits,
      merkleRoot,
      user.toBytes(),
      candyGuard.toBytes(),
      candyMachine.toBytes()
    ], programId: programId);
  }

  static ProgramDerivedAddress findCandyGuardPda(

      /// The base address which the Candy Guard PDA derives from
      {required SolAddress base,
      SolAddress programId =
          MetaplexCandyMachineCoreProgramConst.candyGuardProgramId}) {
    return ProgramDerivedAddress.find(seedBytes: [
      "candy_guard".codeUnits,
      base.toBytes(),
    ], programId: programId);
  }

  static ProgramDerivedAddress findAllocationTrackerPda(

      /// Unique identifier of the allocation
      {required int id,

      /// The address of the Candy Guard account
      required SolAddress candyGuard,

      /// The address of the Candy Machine account
      required SolAddress candyMachine,
      SolAddress programId =
          MetaplexCandyMachineCoreProgramConst.candyGuardProgramId}) {
    return ProgramDerivedAddress.find(seedBytes: [
      "allocation".codeUnits,
      LayoutConst.u8().serialize(id),
      candyGuard.toBytes(),
      candyMachine.toBytes()
    ], programId: programId);
  }

  static ProgramDerivedAddress findFreezeEscrowPda(

      /// The wallet that will eventually receive the funds
      {required SolAddress destination,

      /// The address of the Candy Guard account
      required SolAddress candyGuard,

      /// The address of the Candy Machine account
      required SolAddress candyMachine,
      SolAddress programId =
          MetaplexCandyMachineCoreProgramConst.candyGuardProgramId}) {
    return ProgramDerivedAddress.find(seedBytes: [
      "freeze_escrow".codeUnits,
      destination.toBytes(),
      candyGuard.toBytes(),
      candyMachine.toBytes()
    ], programId: programId);
  }
}
