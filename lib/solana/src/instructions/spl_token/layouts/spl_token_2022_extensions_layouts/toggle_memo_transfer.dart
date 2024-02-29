// Manages the layout structure for the SPL token approve checked operation.
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/instructions/spl_token/types/types.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Require memos or Stop requiring memos layout.
class SPLToken2022ToggleMemoTransferLayout extends SPLTokenProgramLayout {
  /// toggle memo tranfer
  final MemoTransferInstruction memoTransfer;

  SPLToken2022ToggleMemoTransferLayout({required this.memoTransfer});

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8("instruction"),
    LayoutUtils.wrap(MemoTransferInstruction.staticLayout,
        property: "memoTransfer"),
  ]);

  factory SPLToken2022ToggleMemoTransferLayout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: bytes,
        instruction:
            SPLTokenProgramInstruction.memoTransferExtension.insturction);
    return SPLToken2022ToggleMemoTransferLayout(
        memoTransfer: MemoTransferInstruction.fromJson(decode["memoTransfer"]));
  }

  @override
  Structure get layout => _layout;

  @override
  final int instruction =
      SPLTokenProgramInstruction.memoTransferExtension.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"memoTransfer": memoTransfer.serialize()};
  }
}
