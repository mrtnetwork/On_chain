import 'package:on_chain/solana/src/instructions/stake_pool/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Deposit SOL directly into the pool's reserve account layout.
class StakePoolDepositSolLayout extends StakePoolProgramLayout {
  final BigInt lamports;
  const StakePoolDepositSolLayout({required this.lamports});

  factory StakePoolDepositSolLayout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: bytes,
        instruction: StakePoolProgramInstruction.depositSol.insturction);
    return StakePoolDepositSolLayout(lamports: decode["lamports"]);
  }

  static final Structure _layout = LayoutUtils.struct(
      [LayoutUtils.u8("instruction"), LayoutUtils.ns64("lamports")]);
  @override
  Structure get layout => _layout;
  @override
  int get instruction => StakePoolProgramInstruction.depositSol.insturction;
  @override
  Map<String, dynamic> serialize() {
    return {"lamports": lamports};
  }
}
