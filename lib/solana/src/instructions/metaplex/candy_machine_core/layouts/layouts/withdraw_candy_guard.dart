import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/encoding/encoding.dart';

class MetaplexCandyMachineWithdrawCandyGuardLayout
    extends MetaplexCandyMachineProgramLayout {
  const MetaplexCandyMachineWithdrawCandyGuardLayout();

  factory MetaplexCandyMachineWithdrawCandyGuardLayout.fromBuffer(
    List<int> data,
  ) {
    MetaplexCandyMachineProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: data,
      instruction:
          MetaplexCandyMachineProgramInstruction.withdrawCandyGuard.instruction,
    );
    return const MetaplexCandyMachineWithdrawCandyGuardLayout();
  }

  static StructLayout get _layout =>
      LayoutConst.struct([LayoutConst.blob(8, property: 'instruction')]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexCandyMachineProgramInstruction get instruction =>
      MetaplexCandyMachineProgramInstruction.withdrawCandyGuard;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
