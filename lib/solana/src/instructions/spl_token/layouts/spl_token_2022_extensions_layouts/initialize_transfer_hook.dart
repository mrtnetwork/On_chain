import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

/// Initialize a new mint with a transfer hook program layout.
class SPLToken2022InitializeTransferHookLayout extends SPLTokenProgramLayout {
  /// The public key for the account that can update the program id
  final SolAddress authority;

  /// The program id that performs logic during transfers
  final SolAddress transferHookProgramId;

  SPLToken2022InitializeTransferHookLayout(
      {required this.authority, required this.transferHookProgramId});

  factory SPLToken2022InitializeTransferHookLayout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction: SPLTokenProgramInstruction.transferHookExtension.insturction,
    );
    return SPLToken2022InitializeTransferHookLayout(
        authority: decode['authority'],
        transferHookProgramId: decode['transferHookProgramId']);
  }

  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: 'instruction'),
    LayoutConst.wrap(TransferHookInstruction.staticLayout,
        property: 'transferHook'),
    SolanaLayoutUtils.publicKey('authority'),
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
      'transferHook': TransferHookInstruction.initialize.serialize(),
      'authority': authority,
      'transferHookProgramId': transferHookProgramId
    };
  }
}
