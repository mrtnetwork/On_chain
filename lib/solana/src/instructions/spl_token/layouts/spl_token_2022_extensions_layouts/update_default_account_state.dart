// Manages the layout structure for the SPL token approve checked operation.
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/instructions/spl_token/types/types.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// Update the default state for new Accounts. Only supported for mints that
/// include the [DefaultAccountState] extension.
class SPLToken2022UpdateDefaultAccountStateLayout
    extends SPLTokenProgramLayout {
  final AccountState accountState;
  SPLToken2022UpdateDefaultAccountStateLayout({required this.accountState});

  static StructLayout get _layout => LayoutConst.struct([
        LayoutConst.u8(property: 'instruction'),
        LayoutConst.wrap(DefaultAccountStateInstruction.staticLayout,
            property: 'defaultAccountState'),
        LayoutConst.wrap(AccountState.staticLayout, property: 'accountState'),
      ]);

  factory SPLToken2022UpdateDefaultAccountStateLayout.fromBuffer(
      List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: bytes,
        instruction: SPLTokenProgramInstruction
            .defaultAccountStateExtension.insturction);
    return SPLToken2022UpdateDefaultAccountStateLayout(
        accountState: AccountState.fromJson(decode['accountState']));
  }

  @override
  StructLayout get layout => _layout;

  @override
  final SPLTokenProgramInstruction instruction =
      SPLTokenProgramInstruction.defaultAccountStateExtension;

  @override
  Map<String, dynamic> serialize() {
    return {
      'defaultAccountState': DefaultAccountStateInstruction.update.serialize(),
      'accountState': accountState.serialize()
    };
  }
}
