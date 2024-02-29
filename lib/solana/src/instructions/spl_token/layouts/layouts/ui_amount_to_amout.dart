// Manages the layout structure for converting UI amount to amount in SPL.
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// uiAmount To Amount layout.
class SPLTokenUiAmountToAmountLayout extends SPLTokenProgramLayout {
  /// The ui_amount of tokens to reformat.
  final List<int> amount;

  /// Constructs an SPLTokenUiAmountToAmountLayout instance.
  SPLTokenUiAmountToAmountLayout({required String amount})
      : amount = StringUtils.encode(amount);

  /// Structure structure for converting UI amount to amount in SPL.
  static Structure _layout(int length) => LayoutUtils.struct([
        LayoutUtils.u8("instruction"),
        LayoutUtils.blob(length, property: "amount"),
      ]);

  /// Constructs an SPLTokenUiAmountToAmountLayout instance from buffer.
  factory SPLTokenUiAmountToAmountLayout.fromBuffer(List<int> bytes) {
    final length = bytes.length - 1;
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout(length),
        bytes: bytes,
        instruction: SPLTokenProgramInstruction.uiAmountToAmount.insturction);
    return SPLTokenUiAmountToAmountLayout(
        amount: StringUtils.decode(decode["amount"]));
  }

  /// Returns the layout structure.
  @override
  late final Structure layout = _layout(amount.length);

  /// Instruction associated with the layout.
  @override
  final int instruction =
      SPLTokenProgramInstruction.uiAmountToAmount.insturction;

  /// Serializes the layout data.
  @override
  Map<String, dynamic> serialize() {
    return {"amount": amount};
  }
}
