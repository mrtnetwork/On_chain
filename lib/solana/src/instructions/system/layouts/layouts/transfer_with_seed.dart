import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/system/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

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
        lamports: decode["lamports"],
        seed: decode["seed"],
        programId: decode["programId"]);
  }
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u32("instruction"),
    LayoutUtils.u64('lamports'),
    LayoutUtils.rustString('seed'),
    LayoutUtils.publicKey('programId'),
  ]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction => SystemProgramInstruction.transferWithSeed.insturction;
  @override
  Map<String, dynamic> serialize() {
    return {"lamports": lamports, "seed": seed, "programId": programId};
  }
}
