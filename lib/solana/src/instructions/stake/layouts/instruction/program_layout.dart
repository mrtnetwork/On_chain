import 'package:blockchain_utils/exception/exception.dart';
import 'package:on_chain/solana/src/instructions/stake/layouts/layouts.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

abstract class StakeProgramLayout extends ProgramLayout {
  const StakeProgramLayout();
  static final StructLayout _layout =
      LayoutConst.struct([LayoutConst.u32(property: "instruction")]);
  static ProgramLayout fromBytes(List<int> data) {
    try {
      final decode =
          ProgramLayout.decodeAndValidateStruct(layout: _layout, bytes: data);
      final instruction =
          StakeProgramInstruction.getInstruction(decode["instruction"]);
      switch (instruction) {
        case StakeProgramInstruction.authorizeWithSeed:
          return StakeAuthorizeWithSeedLayout.fromBuffer(data);
        case StakeProgramInstruction.authorize:
          return StakeAuthorizeLayout.fromBuffer(data);
        case StakeProgramInstruction.deactivate:
          return StakeDeactivateLayout.fromBuffer(data);
        case StakeProgramInstruction.delegate:
          return StakeDelegateLayout.fromBuffer(data);
        case StakeProgramInstruction.initialize:
          return StakeInitializeLayout.fromBuffer(data);
        case StakeProgramInstruction.merge:
          return StakeMergeLayout.fromBuffer(data);
        case StakeProgramInstruction.split:
          return StakeSplitLayout.fromBuffer(data);
        case StakeProgramInstruction.withdraw:
          return StakeWithdrawLayout.fromBuffer(data);
        default:
          throw const MessageException("unknown program layout");
      }
    } catch (e) {
      return UnknownProgramLayout(data);
    }
  }
}
