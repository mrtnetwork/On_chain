import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Update the transfer hook program id layout.
class SPLToken2022UpdateTransferHookLayout extends SPLTokenProgramLayout {
  /// The program id that performs logic during transfers
  final SolAddress transferHookProgramId;

  SPLToken2022UpdateTransferHookLayout({required this.transferHookProgramId});

  factory SPLToken2022UpdateTransferHookLayout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction: SPLTokenProgramInstruction.transferFeeExtension.insturction,
    );
    return SPLToken2022UpdateTransferHookLayout(
        transferHookProgramId: decode["transferHookProgramId"]);
  }

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8("instruction"),
    LayoutUtils.wrap(TransferHookInstruction.staticLayout,
        property: "transferHook"),
    LayoutUtils.publicKey("transferHookProgramId")
  ]);

  @override
  Structure get layout => _layout;

  @override
  final int instruction =
      SPLTokenProgramInstruction.transferHookExtension.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "transferHook": TransferHookInstruction.update.serialize(),
      "transferHookProgramId": transferHookProgramId
    };
  }
}
