import 'package:on_chain/solana/src/instructions/token_lending/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class TokenLendingRefreshReserveLayout extends TokenLendingProgramLayout {
  const TokenLendingRefreshReserveLayout();

  factory TokenLendingRefreshReserveLayout.fromBuffer(List<int> data) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: TokenLendingProgramInstruction.refreshReserve.insturction);
    return const TokenLendingRefreshReserveLayout();
  }

  static final StructLayout _layout =
      LayoutConst.struct([LayoutConst.u8(property: "instruction")]);
  @override
  StructLayout get layout => _layout;

  @override
  int get instruction =>
      TokenLendingProgramInstruction.refreshReserve.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
