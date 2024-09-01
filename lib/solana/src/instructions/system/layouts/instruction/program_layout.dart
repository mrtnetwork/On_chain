import 'package:on_chain/solana/src/instructions/system/layouts/layouts.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

abstract class SystemProgramLayout extends ProgramLayout {
  const SystemProgramLayout();
  @override
  SystemProgramInstruction get instruction;
  static final StructLayout _layout =
      LayoutConst.struct([LayoutConst.u32(property: "instruction")]);
  static ProgramLayout fromBytes(List<int> data) {
    final decode =
        ProgramLayout.decodeAndValidateStruct(layout: _layout, bytes: data);
    final instruction =
        SystemProgramInstruction.getInstruction(decode["instruction"]);
    switch (instruction) {
      case SystemProgramInstruction.create:
        return SystemCreateLayout.fromBuffer(data);
      case SystemProgramInstruction.assign:
        return SystemAssignLayout.fromBuffer(data);
      case SystemProgramInstruction.transfer:
        return SystemTransferLayout.fromBuffer(data);
      case SystemProgramInstruction.createWithSeed:
        return SystemCreateWithSeedLayout.fromBuffer(data);
      //
      case SystemProgramInstruction.advanceNonceAccount:
        return SystemAdvanceNonceLayout.fromBuffer(data);
      case SystemProgramInstruction.withdrawNonceAccount:
        return SystemAdvanceNonceLayout.fromBuffer(data);
      case SystemProgramInstruction.initializeNonceAccount:
        return SystemInitializeNonceAccountLayout.fromBuffer(data);
      case SystemProgramInstruction.authorizeNonceAccount:
        return SystemAuthorizeNonceAccountLayout.fromBuffer(data);
      case SystemProgramInstruction.allocate:
        return SystemAllocateLayout.fromBuffer(data);
      case SystemProgramInstruction.allocateWithSeed:
        return SystemAllocateWithSeedLayout.fromBuffer(data);
      case SystemProgramInstruction.assignWithSeed:
        return SystemAssignWithSeedLayout.fromBuffer(data);
      case SystemProgramInstruction.transferWithSeed:
        return SystemTransferWithSeedLayout.fromBuffer(data);
      case SystemProgramInstruction.upgradeNonceAccount:
        return SystemUpgradeNonceAccountLayout.fromBuffer(data);
      default:
        return UnknownProgramLayout(data);
    }
  }
}
