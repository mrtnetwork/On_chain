import 'package:on_chain/solana/src/instructions/metaplex/nft_packs/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class MetaplexNFTPacksTransferPackAuthorityLayout
    extends MetaplexNFTPacksProgramLayout {
  const MetaplexNFTPacksTransferPackAuthorityLayout();

  factory MetaplexNFTPacksTransferPackAuthorityLayout.fromBuffer(
      List<int> data) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexNFTPacksProgramInstruction
            .transferPackAuthority.insturction);
    return const MetaplexNFTPacksTransferPackAuthorityLayout();
  }

  static StructLayout get _layout =>
      LayoutConst.struct([LayoutConst.u8(property: 'instruction')]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexNFTPacksProgramInstruction get instruction =>
      MetaplexNFTPacksProgramInstruction.transferPackAuthority;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
