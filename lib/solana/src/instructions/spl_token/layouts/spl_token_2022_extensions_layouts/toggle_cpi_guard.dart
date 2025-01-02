import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// Allow or lock all token operations to happen via CPI as normal.
class SPLToken2022ToggleCpiGuardLayout extends SPLTokenProgramLayout {
  /// Enable or disable cip guard
  final CpiGuardInstructionInstruction guard;

  SPLToken2022ToggleCpiGuardLayout({required this.guard});

  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: 'instruction'),
    LayoutConst.wrap(CpiGuardInstructionInstruction.staticLayout,
        property: 'guard'),
  ]);

  factory SPLToken2022ToggleCpiGuardLayout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: bytes,
        instruction: SPLTokenProgramInstruction.cpiGuardExtension.insturction);
    return SPLToken2022ToggleCpiGuardLayout(
        guard: CpiGuardInstructionInstruction.fromJson(decode['guard']));
  }

  @override
  StructLayout get layout => _layout;

  @override
  final SPLTokenProgramInstruction instruction =
      SPLTokenProgramInstruction.cpiGuardExtension;

  @override
  Map<String, dynamic> serialize() {
    return {'guard': guard.serialize()};
  }
}
