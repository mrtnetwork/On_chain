import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/system/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

/// Transfer with seed layout
class SystemTransferWithSeedLayout extends SystemProgramLayout {
  /// Amount of lamports to transfer
  final BigInt lamports;

  /// Seed to use to derive the funding account address
  final String seed;

  /// Program id to use to derive the funding account address
  final SolAddress programId;
  const SystemTransferWithSeedLayout(
      {required this.lamports, required this.seed, required this.programId});
  factory SystemTransferWithSeedLayout.fromBuffer(List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: SystemProgramInstruction.transferWithSeed.insturction);
    return SystemTransferWithSeedLayout(
        lamports: decode['lamports'],
        seed: decode['seed'],
        programId: decode['programId']);
  }
  static StructLayout get _layout => LayoutConst.struct([
        LayoutConst.u32(property: 'instruction'),
        LayoutConst.u64(property: 'lamports'),
        LayoutConst.rustString(property: 'seed'),
        SolanaLayoutUtils.publicKey('programId'),
      ]);

  @override
  StructLayout get layout => _layout;

  @override
  SystemProgramInstruction get instruction =>
      SystemProgramInstruction.transferWithSeed;
  @override
  Map<String, dynamic> serialize() {
    return {'lamports': lamports, 'seed': seed, 'programId': programId};
  }
}
