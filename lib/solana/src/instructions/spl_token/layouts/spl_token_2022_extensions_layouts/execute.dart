// Manages the layout structure for the SPL token approve checked operation.
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class SPLToken2022ExecuteLayout extends SPLTokenProgramLayout {
  static const List<int> discriminator = [105, 37, 101, 197, 75, 251, 102, 26];
  final BigInt amount;
  SPLToken2022ExecuteLayout({required this.amount});

  factory SPLToken2022ExecuteLayout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction: SPLTokenProgramInstruction.transferFeeExtension.insturction,
    );
    return SPLToken2022ExecuteLayout(amount: decode["amount"]);
  }

  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.blob(8, property: "instruction"),
    LayoutConst.u64(property: "amount")
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  final List<int> instruction = discriminator;

  @override
  Map<String, dynamic> serialize() {
    return {"amount": amount};
  }
}
