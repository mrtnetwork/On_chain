// Manages the layout structure for the SPL token approve operation.
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// Represents the layout for the SPL token approve operation.
class SPLTokenApproveLayout extends SPLTokenProgramLayout {
  /// The amount of tokens the delegate is approved for.
  final BigInt amount;

  /// Constructs an SPLTokenApproveLayout instance.
  SPLTokenApproveLayout({required this.amount});

  /// StructLayout structure for SPLTokenApproveLayout.
  static StructLayout get _layout => LayoutConst.struct([
        LayoutConst.u8(property: 'instruction'),
        LayoutConst.u64(property: 'amount')
      ]);

  /// Constructs an SPLTokenApproveLayout instance from buffer.
  factory SPLTokenApproveLayout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: bytes,
        instruction: SPLTokenProgramInstruction.approve.insturction);
    return SPLTokenApproveLayout(amount: decode['amount']);
  }

  /// Gets the layout structure.
  @override
  StructLayout get layout => _layout;

  /// Instruction associated with the layout.
  @override
  final SPLTokenProgramInstruction instruction =
      SPLTokenProgramInstruction.approve;

  /// Serializes the layout.
  @override
  Map<String, dynamic> serialize() {
    return {'amount': amount};
  }
}
