import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/system/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

/// Assign account with seed layout
class SystemAssignWithSeedLayout extends SystemProgramLayout {
  /// Base address to use to derive the address of the assigned account.
  final SolAddress base;

  /// Seed to use to derive the address of the assigned account
  final String seed;

  /// address of the program to assign as the owner
  final SolAddress programId;
  const SystemAssignWithSeedLayout(
      {required this.base, required this.seed, required this.programId});
  factory SystemAssignWithSeedLayout.fromBuffer(List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: SystemProgramInstruction.assignWithSeed.insturction);
    return SystemAssignWithSeedLayout(
        base: decode["base"],
        seed: decode["seed"],
        programId: decode["programId"]);
  }
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u32(property: "instruction"),
    SolanaLayoutUtils.publicKey('base'),
    LayoutConst.rustString(property: 'seed'),
    SolanaLayoutUtils.publicKey('programId'),
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  int get instruction => SystemProgramInstruction.assignWithSeed.insturction;
  @override
  Map<String, dynamic> serialize() {
    return {"base": base, "seed": seed, "programId": programId};
  }
}
