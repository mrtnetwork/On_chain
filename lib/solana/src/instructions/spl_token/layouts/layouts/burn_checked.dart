// Manages the layout structure for the SPL token burn checked operation.
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

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

  /// StructLayout structure for SPLTokenBurnCheckedLayout.
  static StructLayout get _layout => LayoutConst.struct([
        LayoutConst.u8(property: 'instruction'),
        LayoutConst.u64(property: 'amount'),
        LayoutConst.u8(property: 'decimals')
      ]);

  /// Constructs an SPLTokenBurnCheckedLayout instance from buffer.
  factory SPLTokenBurnCheckedLayout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: bytes,
        instruction: SPLTokenProgramInstruction.burnChecked.insturction);
    return SPLTokenBurnCheckedLayout(
        amount: decode['amount'], decimals: decode['decimals']);
  }

  /// Gets the layout structure.
  @override
  StructLayout get layout => _layout;

  /// Instruction associated with the layout.
  @override
  final SPLTokenProgramInstruction instruction =
      SPLTokenProgramInstruction.burnChecked;

  /// Serializes the layout.
  @override
  Map<String, dynamic> serialize() {
    return {'amount': amount, 'decimals': decimals};
  }
}
