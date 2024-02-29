import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/system/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

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
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u32("instruction"),
    LayoutUtils.publicKey('base'),
    LayoutUtils.rustString('seed'),
    LayoutUtils.publicKey('programId'),
  ]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction => SystemProgramInstruction.assignWithSeed.insturction;
  @override
  Map<String, dynamic> serialize() {
    return {"base": base, "seed": seed, "programId": programId};
  }
}
