import 'package:on_chain/solana/src/instructions/vote/layouts/layouts.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

abstract class VoteProgramLayout extends ProgramLayout {
  const VoteProgramLayout();
  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.u32("instruction")]);
  static ProgramLayout fromBytes(List<int> data) {
    try {
      final decode =
          ProgramLayout.decodeAndValidateStruct(layout: _layout, bytes: data);
      final instruction =
          VoteProgramInstruction.getInstruction(decode["instruction"]);
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
    } catch (e) {
      return UnknownProgramLayout(data);
    }
  }
}
