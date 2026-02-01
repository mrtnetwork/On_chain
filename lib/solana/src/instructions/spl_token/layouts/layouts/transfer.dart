// Manages the layout structure for transferring tokens in SPL.
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// Transfers tokens layout.
class SPLTokenTransferLayout extends SPLTokenProgramLayout {
  /// The amount of tokens to transfer.
  final BigInt amount;

  /// Constructs an SPLTokenTransferLayout instance.
  SPLTokenTransferLayout({required this.amount});

  /// StructLayout structure for transferring tokens in SPL.
  static StructLayout get _layout => LayoutConst.struct([
        LayoutConst.u8(property: 'instruction'),
        LayoutConst.u64(property: 'amount'),
      ]);

  /// Constructs an SPLTokenTransferLayout instance from buffer.
  factory SPLTokenTransferLayout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction: SPLTokenProgramInstruction.transfer.insturction,
    );
    return SPLTokenTransferLayout(amount: decode['amount']);
  }

  /// Returns the layout structure.
  @override
  StructLayout get layout => _layout;

  /// Instruction associated with the layout.
  @override
  final SPLTokenProgramInstruction instruction =
      SPLTokenProgramInstruction.transfer;

  /// Serializes the layout data.
  @override
  Map<String, dynamic> serialize() {
    return {'amount': amount};
  }
}
