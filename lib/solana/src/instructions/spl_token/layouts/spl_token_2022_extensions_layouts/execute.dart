// Manages the layout structure for the SPL token approve checked operation.
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

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

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    LayoutUtils.u64("amount")
  ]);

  @override
  Structure get layout => _layout;

  @override
  final List<int> instruction = discriminator;

  @override
  Map<String, dynamic> serialize() {
    return {"amount": amount};
  }
}
