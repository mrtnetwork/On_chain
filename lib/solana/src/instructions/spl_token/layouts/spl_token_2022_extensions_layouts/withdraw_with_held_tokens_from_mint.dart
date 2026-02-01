import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class SPLToken2022WithdrawWithheldTokensFromMintLayout
    extends SPLTokenProgramLayout {
  SPLToken2022WithdrawWithheldTokensFromMintLayout();

  factory SPLToken2022WithdrawWithheldTokensFromMintLayout.fromBuffer(
      List<int> bytes) {
    ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction: SPLTokenProgramInstruction.transferFeeExtension.insturction,
    );
    return SPLToken2022WithdrawWithheldTokensFromMintLayout();
  }

  static StructLayout get _layout => LayoutConst.struct([
        LayoutConst.u8(property: 'instruction'),
        LayoutConst.u8(property: 'transferFee'),
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
          .withdrawWithheldTokensFromMint.value,
    };
  }
}
