import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Transfer all withheld tokens to an account layout.
class SPLToken2022WithdrawWithheldTokensFromAccountsLayout
    extends SPLTokenProgramLayout {
  /// Number of token accounts harvested
  final int numTokenAccounts;
  SPLToken2022WithdrawWithheldTokensFromAccountsLayout(
      {required this.numTokenAccounts});

  factory SPLToken2022WithdrawWithheldTokensFromAccountsLayout.fromBuffer(
      List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction: SPLTokenProgramInstruction.transferFeeExtension.insturction,
    );
    return SPLToken2022WithdrawWithheldTokensFromAccountsLayout(
        numTokenAccounts: decode["numTokenAccounts"]);
  }

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8("instruction"),
    LayoutUtils.u8("transferFee"),
    LayoutUtils.u8("numTokenAccounts"),
  ]);

  @override
  Structure get layout => _layout;

  @override
  final int instruction =
      SPLTokenProgramInstruction.transferFeeExtension.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "transferFee": TransferFeeInstructionInstruction
          .withdrawWithheldTokensFromAccounts.value,
      "numTokenAccounts": numTokenAccounts
    };
  }
}
