// Manages the layout structure for the SPL token approve operation.
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Represents the layout for the SPL token approve operation.
class SPLTokenApproveLayout extends SPLTokenProgramLayout {
  /// The amount of tokens the delegate is approved for.
  final BigInt amount;

  /// Constructs an SPLTokenApproveLayout instance.
  SPLTokenApproveLayout({required this.amount});

  /// Structure structure for SPLTokenApproveLayout.
  static final Structure _layout = LayoutUtils.struct(
      [LayoutUtils.u8("instruction"), LayoutUtils.u64("amount")]);

  /// Constructs an SPLTokenApproveLayout instance from buffer.
  factory SPLTokenApproveLayout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: bytes,
        instruction: SPLTokenProgramInstruction.approve.insturction);
    return SPLTokenApproveLayout(amount: decode["amount"]);
  }

  /// Gets the layout structure.
  @override
  Structure get layout => _layout;

  /// Instruction associated with the layout.
  @override
  final int instruction = SPLTokenProgramInstruction.approve.insturction;

  /// Serializes the layout.
  @override
  Map<String, dynamic> serialize() {
    return {"amount": amount};
  }
}
