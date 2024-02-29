// Manages the layout structure for transferring checked tokens in SPL.
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// transfer checked layout.
class SPLTokenTransferCheckedLayout extends SPLTokenProgramLayout {
  /// The amount of tokens to transfer.
  final BigInt amount;

  /// Expected number of base 10 digits to the right of the decimal place.
  final int decimals;

  /// Constructs an SPLTokenTransferCheckedLayout instance.
  SPLTokenTransferCheckedLayout({
    required this.amount,
    required this.decimals,
  });

  /// Structure structure for transferring checked tokens in SPL.
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8("instruction"),
    LayoutUtils.u64("amount"),
    LayoutUtils.u8("decimals"),
  ]);

  /// Constructs an SPLTokenTransferCheckedLayout instance from buffer.
  factory SPLTokenTransferCheckedLayout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction: SPLTokenProgramInstruction.transferChecked.insturction,
    );
    return SPLTokenTransferCheckedLayout(
      amount: decode["amount"],
      decimals: decode["decimals"],
    );
  }

  /// Returns the layout structure.
  @override
  Structure get layout => _layout;

  /// Instruction associated with the layout.
  @override
  final int instruction =
      SPLTokenProgramInstruction.transferChecked.insturction;

  /// Serializes the layout data.
  @override
  Map<String, dynamic> serialize() {
    return {"amount": amount, "decimals": decimals};
  }
}
