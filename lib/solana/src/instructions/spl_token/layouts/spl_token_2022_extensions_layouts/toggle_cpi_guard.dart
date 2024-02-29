import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Allow or lock all token operations to happen via CPI as normal.
class SPLToken2022ToggleCpiGuardLayout extends SPLTokenProgramLayout {
  /// Enable or disable cip guard
  final CpiGuardInstructionInstruction guard;

  SPLToken2022ToggleCpiGuardLayout({required this.guard});

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8("instruction"),
    LayoutUtils.wrap(CpiGuardInstructionInstruction.staticLayout,
        property: "guard"),
  ]);

  factory SPLToken2022ToggleCpiGuardLayout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: bytes,
        instruction: SPLTokenProgramInstruction.cpiGuardExtension.insturction);
    return SPLToken2022ToggleCpiGuardLayout(
        guard: CpiGuardInstructionInstruction.fromJson(decode["guard"]));
  }

  @override
  Structure get layout => _layout;

  @override
  final int instruction =
      SPLTokenProgramInstruction.cpiGuardExtension.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"guard": guard.serialize()};
  }
}
