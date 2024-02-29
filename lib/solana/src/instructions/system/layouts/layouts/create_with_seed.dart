import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/system/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Create account with seed system layout
class SystemCreateWithSeedLayout extends SystemProgramLayout {
  /// Base address to use to derive the address of the created account.
  final SolAddress base;

  /// Seed to use to derive the address of the created account.
  final String seed;

  /// Amount of lamports to transfer to the created account
  final BigInt lamports;

  /// Amount of space in bytes to allocate to the created account
  final BigInt space;

  /// address of the program to assign as the owner of the created account
  final SolAddress programId;
  const SystemCreateWithSeedLayout(
      {required this.base,
      required this.seed,
      required this.lamports,
      required this.space,
      required this.programId});
  factory SystemCreateWithSeedLayout.fromBuffer(List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: SystemProgramInstruction.createWithSeed.insturction);
    return SystemCreateWithSeedLayout(
        base: decode["base"],
        seed: decode["seed"],
        lamports: decode["lamports"],
        space: decode["space"],
        programId: decode["programId"]);
  }

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u32("instruction"),
    LayoutUtils.publicKey('base'),
    LayoutUtils.rustString('seed'),
    LayoutUtils.ns64('lamports'),
    LayoutUtils.ns64('space'),
    LayoutUtils.publicKey('programId'),
  ]);

  @override
  Structure get layout => _layout;
  @override
  int get instruction => SystemProgramInstruction.createWithSeed.insturction;
  @override
  Map<String, dynamic> serialize() {
    return {
      "base": base,
      "seed": seed,
      "lamports": lamports,
      "space": space,
      "programId": programId
    };
  }
}
