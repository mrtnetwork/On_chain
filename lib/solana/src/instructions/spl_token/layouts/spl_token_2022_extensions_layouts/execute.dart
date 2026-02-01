// Manages the layout structure for the SPL token approve checked operation.
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class SPLToken2022ExecuteLayout extends SPLTokenProgramLayout {
  final BigInt amount;
  SPLToken2022ExecuteLayout({required this.amount});

  factory SPLToken2022ExecuteLayout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction: SPLTokenProgramInstruction.execute.insturction,
    );
    return SPLToken2022ExecuteLayout(amount: decode['amount']);
  }

  static StructLayout get _layout => LayoutConst.struct([
        LayoutConst.blob(8, property: 'instruction'),
        LayoutConst.u64(property: 'amount')
      ]);

  @override
  StructLayout get layout => _layout;

  @override
  Map<String, dynamic> serialize() {
    return {'amount': amount};
  }

  @override
  SPLTokenProgramInstruction get instruction =>
      SPLTokenProgramInstruction.execute;
}
