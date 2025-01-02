import 'package:on_chain/solana/src/instructions/vote/layouts/layouts.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

abstract class VoteProgramLayout extends ProgramLayout {
  const VoteProgramLayout();
  @override
  VoteProgramInstruction get instruction;
  static final StructLayout _layout =
      LayoutConst.struct([LayoutConst.u32(property: 'instruction')]);
  static ProgramLayout fromBytes(List<int> data) {
    final decode =
        ProgramLayout.decodeAndValidateStruct(layout: _layout, bytes: data);
    final instruction =
        VoteProgramInstruction.getInstruction(decode['instruction']);
    switch (instruction) {
      case VoteProgramInstruction.authorizeWithSeed:
        return VoteProgramAuthorizeWithSeedLayout.fromBuffer(data);
      case VoteProgramInstruction.authorize:
        return VoteProgramAuthorizeLayout.fromBuffer(data);
      case VoteProgramInstruction.initializeAccount:
        return VoteProgramInitializeAccountLayout.fromBuffer(data);
      case VoteProgramInstruction.withdraw:
        return VoteProgramWithdrawLayout.fromBuffer(data);
      default:
        return UnknownProgramLayout(data);
    }
  }
}
