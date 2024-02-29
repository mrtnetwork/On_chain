import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Permissionless instruction to transfer all withheld tokens to the mint layout.
class SPLToken2022HarvestWithheldTokensToMintLayout
    extends SPLTokenProgramLayout {
  SPLToken2022HarvestWithheldTokensToMintLayout();

  factory SPLToken2022HarvestWithheldTokensToMintLayout.fromBuffer(
      List<int> bytes) {
    ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction: SPLTokenProgramInstruction.transferFeeExtension.insturction,
    );
    return SPLToken2022HarvestWithheldTokensToMintLayout();
  }

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8("instruction"),
    LayoutUtils.u8("transferFee"),
  ]);

  @override
  Structure get layout => _layout;

  @override
  final int instruction =
      SPLTokenProgramInstruction.transferFeeExtension.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "transferFee":
          TransferFeeInstructionInstruction.harvestWithheldTokensToMint.value,
    };
  }
}
