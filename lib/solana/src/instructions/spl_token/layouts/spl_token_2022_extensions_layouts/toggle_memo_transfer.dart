// Manages the layout structure for the SPL token approve checked operation.
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/instructions/spl_token/types/types.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// Require memos or Stop requiring memos layout.
class SPLToken2022ToggleMemoTransferLayout extends SPLTokenProgramLayout {
  /// toggle memo tranfer
  final MemoTransferInstruction memoTransfer;

  SPLToken2022ToggleMemoTransferLayout({required this.memoTransfer});

  static StructLayout get _layout => LayoutConst.struct([
        LayoutConst.u8(property: 'instruction'),
        LayoutConst.wrap(MemoTransferInstruction.staticLayout,
            property: 'memoTransfer'),
      ]);

  factory SPLToken2022ToggleMemoTransferLayout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: bytes,
        instruction:
            SPLTokenProgramInstruction.memoTransferExtension.insturction);
    return SPLToken2022ToggleMemoTransferLayout(
        memoTransfer: MemoTransferInstruction.fromJson(decode['memoTransfer']));
  }

  @override
  StructLayout get layout => _layout;

  @override
  final SPLTokenProgramInstruction instruction =
      SPLTokenProgramInstruction.memoTransferExtension;

  @override
  Map<String, dynamic> serialize() {
    return {'memoTransfer': memoTransfer.serialize()};
  }
}
