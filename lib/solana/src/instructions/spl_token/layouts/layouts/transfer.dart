// Manages the layout structure for transferring tokens in SPL.
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Transfers tokens layout.
class SPLTokenTransferLayout extends SPLTokenProgramLayout {
  /// The amount of tokens to transfer.
  final BigInt amount;

  /// Constructs an SPLTokenTransferLayout instance.
  SPLTokenTransferLayout({required this.amount});

  /// Structure structure for transferring tokens in SPL.
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8("instruction"),
    LayoutUtils.u64("amount"),
  ]);

  /// Constructs an SPLTokenTransferLayout instance from buffer.
  factory SPLTokenTransferLayout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction: SPLTokenProgramInstruction.transfer.insturction,
    );
    return SPLTokenTransferLayout(amount: decode["amount"]);
  }

  /// Returns the layout structure.
  @override
  Structure get layout => _layout;

  /// Instruction associated with the layout.
  @override
  final int instruction = SPLTokenProgramInstruction.transfer.insturction;

  /// Serializes the layout data.
  @override
  Map<String, dynamic> serialize() {
    return {"amount": amount};
  }
}
