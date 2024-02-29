// Manages the layout structure for the SPL token approve checked operation.
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Represents the layout for the SPL token approve checked operation.
class SPLTokenApproveCheckedLayout extends SPLTokenProgramLayout {
  /// The amount of tokens the delegate is approved for.
  final BigInt amount;

  /// Expected number of base 10 digits to the right of the decimal place.
  final int decimals;

  /// Constructs an SPLTokenApproveCheckedLayout instance.
  SPLTokenApproveCheckedLayout({
    required this.amount,
    required this.decimals,
  });

  /// Structure structure for SPLTokenApproveCheckedLayout.
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8("instruction"),
    LayoutUtils.u64("amount"),
    LayoutUtils.u8("decimals")
  ]);

  /// Constructs an SPLTokenApproveCheckedLayout instance from buffer.
  factory SPLTokenApproveCheckedLayout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: bytes,
        instruction: SPLTokenProgramInstruction.approveChecked.insturction);
    return SPLTokenApproveCheckedLayout(
        amount: decode["amount"], decimals: decode["decimals"]);
  }

  /// Gets the layout structure.
  @override
  Structure get layout => _layout;

  /// Instruction associated with the layout.
  @override
  final int instruction = SPLTokenProgramInstruction.approveChecked.insturction;

  /// Serializes the layout.
  @override
  Map<String, dynamic> serialize() {
    return {"amount": amount, "decimals": decimals};
  }
}
