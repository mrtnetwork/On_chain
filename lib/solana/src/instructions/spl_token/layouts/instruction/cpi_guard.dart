import 'package:on_chain/solana/src/exception/exception.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class CpiGuardInstructionInstruction extends LayoutSerializable {
  final String name;
  const CpiGuardInstructionInstruction._(this.name);

  /// Lock certain token operations from taking place within CPI for this
  /// Account, namely:
  static const CpiGuardInstructionInstruction enable =
      CpiGuardInstructionInstruction._('Enable');

  /// Allow all token operations to happen via CPI as normal.
  static const CpiGuardInstructionInstruction disable =
      CpiGuardInstructionInstruction._('Disable');
  static const List<CpiGuardInstructionInstruction> values = [enable, disable];

  static StructLayout staticLayout = LayoutConst.struct([
    LayoutConst.rustEnum(
        values.map((e) => LayoutConst.none(property: e.name)).toList(),
        property: 'cpiGuard')
  ]);
  @override
  StructLayout get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'cpiGuard': {name: null}
    };
  }

  factory CpiGuardInstructionInstruction.fromJson(Map<String, dynamic> json) {
    return fromName(json['cpiGuard']['key']);
  }
  static CpiGuardInstructionInstruction fromName(String? value) {
    return values.firstWhere(
      (element) => element.name == value,
      orElse: () => throw SolanaPluginException(
          'No CpiGuardInstructionInstruction found matching the specified value',
          details: {'value': value}),
    );
  }
}
