import 'package:on_chain/solana/src/instructions/stake_pool/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// Deposit SOL directly into the pool's reserve account layout.
class StakePoolDepositSolLayout extends StakePoolProgramLayout {
  final BigInt lamports;
  const StakePoolDepositSolLayout({required this.lamports});

  factory StakePoolDepositSolLayout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: bytes,
        instruction: StakePoolProgramInstruction.depositSol.insturction);
    return StakePoolDepositSolLayout(lamports: decode['lamports']);
  }

  static StructLayout get _layout => LayoutConst.struct([
        LayoutConst.u8(property: 'instruction'),
        LayoutConst.ns64(property: 'lamports')
      ]);
  @override
  StructLayout get layout => _layout;
  @override
  StakePoolProgramInstruction get instruction =>
      StakePoolProgramInstruction.depositSol;
  @override
  Map<String, dynamic> serialize() {
    return {'lamports': lamports};
  }
}
