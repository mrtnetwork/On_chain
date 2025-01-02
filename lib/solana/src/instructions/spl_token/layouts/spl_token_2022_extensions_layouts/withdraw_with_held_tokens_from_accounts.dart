import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

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
        numTokenAccounts: decode['numTokenAccounts']);
  }

  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: 'instruction'),
    LayoutConst.u8(property: 'transferFee'),
    LayoutConst.u8(property: 'numTokenAccounts'),
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  final SPLTokenProgramInstruction instruction =
      SPLTokenProgramInstruction.transferFeeExtension;

  @override
  Map<String, dynamic> serialize() {
    return {
      'transferFee': TransferFeeInstructionInstruction
          .withdrawWithheldTokensFromAccounts.value,
      'numTokenAccounts': numTokenAccounts
    };
  }
}
