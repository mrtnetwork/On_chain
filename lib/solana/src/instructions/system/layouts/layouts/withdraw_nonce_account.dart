import 'package:on_chain/solana/src/instructions/system/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

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
    return SystemWithdrawNonceLayout(lamports: decode['lamports']);
  }
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u32(property: 'instruction'),
    LayoutConst.ns64(property: 'lamports')
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  SystemProgramInstruction get instruction =>
      SystemProgramInstruction.withdrawNonceAccount;
  @override
  Map<String, dynamic> serialize() {
    return {'lamports': lamports};
  }
}
