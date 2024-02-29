// Manages the layout structure for the SPL token burn checked operation.
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Burns tokens by removing them from an account layout.
class SPLTokenBurnCheckedLayout extends SPLTokenProgramLayout {
  /// The amount of tokens to burn.
  final BigInt amount;

  /// Expected number of base 10 digits to the right of the decimal place.
  final int decimals;

  /// Constructs an SPLTokenBurnCheckedLayout instance.
  SPLTokenBurnCheckedLayout({
    required this.amount,
    required this.decimals,
  });

  /// Structure structure for SPLTokenBurnCheckedLayout.
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8("instruction"),
    LayoutUtils.u64("amount"),
    LayoutUtils.u8("decimals")
  ]);

  /// Constructs an SPLTokenBurnCheckedLayout instance from buffer.
  factory SPLTokenBurnCheckedLayout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: bytes,
        instruction: SPLTokenProgramInstruction.burnChecked.insturction);
    return SPLTokenBurnCheckedLayout(
        amount: decode["amount"], decimals: decode["decimals"]);
  }

  /// Gets the layout structure.
  @override
  Structure get layout => _layout;

  /// Instruction associated with the layout.
  @override
  final int instruction = SPLTokenProgramInstruction.burnChecked.insturction;

  /// Serializes the layout.
  @override
  Map<String, dynamic> serialize() {
    return {"amount": amount, "decimals": decimals};
  }
}
