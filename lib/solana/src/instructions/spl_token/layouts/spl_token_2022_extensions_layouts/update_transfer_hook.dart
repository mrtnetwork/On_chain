import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

/// Update the transfer hook program id layout.
class SPLToken2022UpdateTransferHookLayout extends SPLTokenProgramLayout {
  /// The program id that performs logic during transfers
  final SolAddress transferHookProgramId;

  SPLToken2022UpdateTransferHookLayout({required this.transferHookProgramId});

  factory SPLToken2022UpdateTransferHookLayout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction: SPLTokenProgramInstruction.transferHookExtension.insturction,
    );
    return SPLToken2022UpdateTransferHookLayout(
        transferHookProgramId: decode['transferHookProgramId']);
  }

  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: 'instruction'),
    LayoutConst.wrap(TransferHookInstruction.staticLayout,
        property: 'transferHook'),
    SolanaLayoutUtils.publicKey('transferHookProgramId')
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  final SPLTokenProgramInstruction instruction =
      SPLTokenProgramInstruction.transferHookExtension;

  @override
  Map<String, dynamic> serialize() {
    return {
      'transferHook': TransferHookInstruction.update.serialize(),
      'transferHookProgramId': transferHookProgramId
    };
  }
}
