import 'package:on_chain/solana/src/instructions/stake_pool/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// Withdraw the token from the pool layout.
class StakePoolWithdrawSolLayout extends StakePoolProgramLayout {
  final BigInt poolTokens;
  const StakePoolWithdrawSolLayout({required this.poolTokens});

  factory StakePoolWithdrawSolLayout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: bytes,
        instruction: StakePoolProgramInstruction.withdrawSol.insturction);
    return StakePoolWithdrawSolLayout(poolTokens: decode['poolTokens']);
  }

  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: 'instruction'),
    LayoutConst.ns64(property: 'poolTokens')
  ]);
  @override
  StructLayout get layout => _layout;
  @override
  StakePoolProgramInstruction get instruction =>
      StakePoolProgramInstruction.withdrawSol;
  @override
  Map<String, dynamic> serialize() {
    return {'poolTokens': poolTokens};
  }
}
