import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/instructions/metaplex/core_candy_machine/constant.dart';
import 'package:on_chain/solana/src/instructions/metaplex/core_candy_machine/layouts/instruction/instructions.dart';
import 'package:on_chain/solana/src/instructions/metaplex/core_candy_machine/layouts/layouts/core_candy_machine_layouts.dart';

/// Program-aware decode dispatch. The machine and guard programs
/// share Anchor discriminants, so callers must pass the transaction's
/// programId (unlike the legacy candy module, this is NOT first-match).
abstract class CoreCandyMachineProgramLayoutDispatch {
  static ProgramLayout fromBytes({
    required List<int> data,
    required SolAddress programId,
  }) {
    if (programId == CoreCandyMachineProgramConst.candyGuardProgramId) {
      return guardFromBytes(data);
    }
    return machineFromBytes(data);
  }

  /// Decode a Core Candy Machine instruction.
  static ProgramLayout machineFromBytes(List<int> data) {
    final prefix = data.sublist(0, 8);
    final instruction = CoreCandyMachineProgramInstruction.getInstruction(
      prefix,
    );
    switch (instruction) {
      case CoreCandyMachineProgramInstruction.addConfigLines:
        return CoreCandyMachineAddConfigLinesLayout.fromBuffer(data);
      case CoreCandyMachineProgramInstruction.initialize:
        return CoreCandyMachineRawArgsLayout.fromBuffer(
          data,
          instruction!,
          instruction.instruction,
        );
      case CoreCandyMachineProgramInstruction.mintAsset:
        return CoreCandyMachineRawArgsLayout.fromBuffer(
          data,
          instruction!,
          instruction.instruction,
        );
      case CoreCandyMachineProgramInstruction.setAuthority:
        return CoreCandyMachineSetAuthorityLayout.fromBuffer(
          data,
          instruction!,
          instruction.instruction,
        );
      case CoreCandyMachineProgramInstruction.setCollection:
      case CoreCandyMachineProgramInstruction.setMintAuthority:
      case CoreCandyMachineProgramInstruction.withdraw:
        return CoreCandyMachineEmptyLayout.fromBuffer(
          data,
          instruction!,
          instruction.instruction,
        );
      case CoreCandyMachineProgramInstruction.update:
        return CoreCandyMachineRawArgsLayout.fromBuffer(
          data,
          instruction!,
          instruction.instruction,
        );
      default:
        return UnknownProgramLayout(data);
    }
  }

  /// Decode a Core Candy Guard instruction.
  static ProgramLayout guardFromBytes(List<int> data) {
    final prefix = data.sublist(0, 8);
    final instruction = CoreCandyGuardProgramInstruction.getInstruction(prefix);
    switch (instruction) {
      case CoreCandyGuardProgramInstruction.initialize:
      case CoreCandyGuardProgramInstruction.update:
        return CoreCandyMachineRawArgsLayout.fromBuffer(
          data,
          instruction!,
          instruction.instruction,
        );
      case CoreCandyGuardProgramInstruction.mintV1:
        return CoreCandyGuardMintV1Layout.fromBuffer(data);
      case CoreCandyGuardProgramInstruction.route:
        return CoreCandyMachineRawArgsLayout.fromBuffer(
          data,
          instruction!,
          instruction.instruction,
        );
      case CoreCandyGuardProgramInstruction.setAuthority:
        return CoreCandyMachineSetAuthorityLayout.fromBuffer(
          data,
          instruction!,
          instruction.instruction,
        );
      case CoreCandyGuardProgramInstruction.unwrap:
      case CoreCandyGuardProgramInstruction.withdraw:
      case CoreCandyGuardProgramInstruction.wrap:
        return CoreCandyMachineEmptyLayout.fromBuffer(
          data,
          instruction!,
          instruction.instruction,
        );
      default:
        return UnknownProgramLayout(data);
    }
  }
}
