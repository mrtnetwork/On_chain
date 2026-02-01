// Manages the layout structure for transferring checked tokens in SPL.
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

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

  /// StructLayout structure for transferring checked tokens in SPL.
  static StructLayout get _layout => LayoutConst.struct([
        LayoutConst.u8(property: 'instruction'),
        LayoutConst.u64(property: 'amount'),
        LayoutConst.u8(property: 'decimals'),
      ]);

  /// Constructs an SPLTokenTransferCheckedLayout instance from buffer.
  factory SPLTokenTransferCheckedLayout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction: SPLTokenProgramInstruction.transferChecked.insturction,
    );
    return SPLTokenTransferCheckedLayout(
      amount: decode['amount'],
      decimals: decode['decimals'],
    );
  }

  /// Returns the layout structure.
  @override
  StructLayout get layout => _layout;

  /// Instruction associated with the layout.
  @override
  final SPLTokenProgramInstruction instruction =
      SPLTokenProgramInstruction.transferChecked;

  /// Serializes the layout data.
  @override
  Map<String, dynamic> serialize() {
    return {'amount': amount, 'decimals': decimals};
  }
}
