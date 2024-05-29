import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/system/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

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
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u32(property: "instruction"),
    SolanaLayoutUtils.publicKey('base'),
    LayoutConst.rustString(property: 'seed'),
    LayoutConst.ns64(property: 'space'),
    SolanaLayoutUtils.publicKey('programId'),
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  int get instruction => SystemProgramInstruction.allocateWithSeed.insturction;
  @override
  Map<String, dynamic> serialize() {
    return {"base": base, "seed": seed, "space": space, "programId": programId};
  }
}
