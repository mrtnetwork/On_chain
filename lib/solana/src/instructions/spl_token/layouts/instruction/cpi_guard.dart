import 'package:blockchain_utils/exception/exception.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class CpiGuardInstructionInstruction extends LayoutSerializable {
  final String name;
  const CpiGuardInstructionInstruction._(this.name);

  /// Lock certain token operations from taking place within CPI for this
  /// Account, namely:
  static const CpiGuardInstructionInstruction enable =
      CpiGuardInstructionInstruction._("Enable");

  /// Allow all token operations to happen via CPI as normal.
  static const CpiGuardInstructionInstruction disable =
      CpiGuardInstructionInstruction._("Disable");
  static const List<CpiGuardInstructionInstruction> values = [enable, disable];

  static Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.rustEnum(
        values.map((e) => LayoutUtils.none(e.name)).toList(), LayoutUtils.u8(),
        property: "cpiGuard")
  ]);
  @override
  Structure get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      "cpiGuard": {name: null}
    };
  }

  factory CpiGuardInstructionInstruction.fromJson(Map<String, dynamic> json) {
    return fromName(json["cpiGuard"]["key"]);
  }
  static CpiGuardInstructionInstruction fromName(String? value) {
    return values.firstWhere(
      (element) => element.name == value,
      orElse: () => throw MessageException(
          "No CpiGuardInstructionInstruction found matching the specified value",
          details: {"value": value}),
    );
  }
}
