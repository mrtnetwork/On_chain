import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/system/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

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
        base: decode['base'],
        seed: decode['seed'],
        lamports: decode['lamports'],
        space: decode['space'],
        programId: decode['programId']);
  }

  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u32(property: 'instruction'),
    SolanaLayoutUtils.publicKey('base'),
    LayoutConst.rustString(property: 'seed'),
    LayoutConst.ns64(property: 'lamports'),
    LayoutConst.ns64(property: 'space'),
    SolanaLayoutUtils.publicKey('programId'),
  ]);

  @override
  StructLayout get layout => _layout;
  @override
  SystemProgramInstruction get instruction =>
      SystemProgramInstruction.createWithSeed;
  @override
  Map<String, dynamic> serialize() {
    return {
      'base': base,
      'seed': seed,
      'lamports': lamports,
      'space': space,
      'programId': programId
    };
  }
}
