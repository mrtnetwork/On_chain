import 'package:on_chain/solana/src/instructions/system/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// Transfer system layout
class SystemTransferLayout extends SystemProgramLayout {
  /// Amount of lamports to transfer
  final BigInt lamports;
  const SystemTransferLayout({required this.lamports});
  factory SystemTransferLayout.fromBuffer(List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: SystemProgramInstruction.transfer.insturction);
    return SystemTransferLayout(lamports: decode["lamports"]);
  }
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u32(property: "instruction"),
    LayoutConst.u64(property: "lamports")
  ]);

  @override
  StructLayout get layout => _layout;
  @override
  SystemProgramInstruction get instruction => SystemProgramInstruction.transfer;
  @override
  Map<String, dynamic> serialize() {
    return {"lamports": lamports};
  }
}
