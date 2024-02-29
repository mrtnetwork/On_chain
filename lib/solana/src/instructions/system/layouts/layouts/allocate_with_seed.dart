import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/system/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Allocate account with seed layout
class SystemAllocateWithSeedLayout extends SystemProgramLayout {
  /// base address to use to derive the address of the allocated account
  final SolAddress base;

  /// Seed to use to derive the address of the allocated account
  final String seed;

  /// Amount of space in bytes to allocate
  final BigInt space;

  /// address of the program to assign as the owner of the allocated account
  final SolAddress programId;
  const SystemAllocateWithSeedLayout(
      {required this.base,
      required this.seed,
      required this.space,
      required this.programId});
  factory SystemAllocateWithSeedLayout.fromBuffer(List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: SystemProgramInstruction.allocateWithSeed.insturction);
    return SystemAllocateWithSeedLayout(
        base: decode["base"],
        seed: decode["seed"],
        space: decode["space"],
        programId: decode["programId"]);
  }
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u32("instruction"),
    LayoutUtils.publicKey('base'),
    LayoutUtils.rustString('seed'),
    LayoutUtils.ns64('space'),
    LayoutUtils.publicKey('programId'),
  ]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction => SystemProgramInstruction.allocateWithSeed.insturction;
  @override
  Map<String, dynamic> serialize() {
    return {"base": base, "seed": seed, "space": space, "programId": programId};
  }
}
