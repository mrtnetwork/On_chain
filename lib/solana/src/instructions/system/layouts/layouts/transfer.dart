import 'package:on_chain/solana/src/instructions/system/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

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
  static final Structure _layout = LayoutUtils.struct(
      [LayoutUtils.u32("instruction"), LayoutUtils.u64("lamports")]);

  @override
  Structure get layout => _layout;
  @override
  int get instruction => SystemProgramInstruction.transfer.insturction;
  @override
  Map<String, dynamic> serialize() {
    return {"lamports": lamports};
  }
}
