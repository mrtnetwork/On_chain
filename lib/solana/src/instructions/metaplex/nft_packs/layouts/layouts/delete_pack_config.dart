import 'package:on_chain/solana/src/instructions/metaplex/nft_packs/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class MetaplexNFTPacksDeletePackConfigLayout
    extends MetaplexNFTPacksProgramLayout {
  const MetaplexNFTPacksDeletePackConfigLayout();

  factory MetaplexNFTPacksDeletePackConfigLayout.fromBuffer(List<int> data) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexNFTPacksProgramInstruction.deletePackConfig.insturction);
    return const MetaplexNFTPacksDeletePackConfigLayout();
  }

  static StructLayout get _layout =>
      LayoutConst.struct([LayoutConst.u8(property: 'instruction')]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexNFTPacksProgramInstruction get instruction =>
      MetaplexNFTPacksProgramInstruction.deletePackConfig;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
