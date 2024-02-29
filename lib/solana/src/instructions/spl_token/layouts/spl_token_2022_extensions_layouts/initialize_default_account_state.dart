// Manages the layout structure for the SPL token approve checked operation.
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/instructions/spl_token/types/types.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Initialize a new mint with the default state for new Accounts layout.
class SPLToken2022InitializeDefaultAccountStateLayout
    extends SPLTokenProgramLayout {
  /// account state
  final AccountState accountState;
  SPLToken2022InitializeDefaultAccountStateLayout({required this.accountState});

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8("instruction"),
    LayoutUtils.wrap(DefaultAccountStateInstruction.staticLayout,
        property: "defaultAccountState"),
    LayoutUtils.wrap(AccountState.staticLayout, property: "accountState"),
  ]);

  factory SPLToken2022InitializeDefaultAccountStateLayout.fromBuffer(
      List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: bytes,
        instruction: SPLTokenProgramInstruction
            .defaultAccountStateExtension.insturction);
    return SPLToken2022InitializeDefaultAccountStateLayout(
        accountState: AccountState.fromJson(decode["accountState"]));
  }

  @override
  Structure get layout => _layout;

  @override
  final int instruction =
      SPLTokenProgramInstruction.defaultAccountStateExtension.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "defaultAccountState":
          DefaultAccountStateInstruction.initialize.serialize(),
      "accountState": accountState.serialize()
    };
  }
}
