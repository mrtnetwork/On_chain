import 'package:on_chain/solana/src/instructions/system/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Withdraw nonce account system layout
class SystemWithdrawNonceLayout extends SystemProgramLayout {
  /// Amount of lamports to withdraw from the nonce account
  final BigInt lamports;
  const SystemWithdrawNonceLayout({required this.lamports});
  factory SystemWithdrawNonceLayout.fromBuffer(List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: SystemProgramInstruction.withdrawNonceAccount.insturction);
    return SystemWithdrawNonceLayout(lamports: decode["lamports"]);
  }
  static final Structure _layout = LayoutUtils.struct(
      [LayoutUtils.u32("instruction"), LayoutUtils.ns64("lamports")]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction =>
      SystemProgramInstruction.withdrawNonceAccount.insturction;
  @override
  Map<String, dynamic> serialize() {
    return {"lamports": lamports};
  }
}
