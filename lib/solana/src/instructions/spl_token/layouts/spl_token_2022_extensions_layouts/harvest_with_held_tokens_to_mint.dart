import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

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

  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: "instruction"),
    LayoutConst.u8(property: "transferFee"),
  ]);

  @override
  StructLayout get layout => _layout;

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
