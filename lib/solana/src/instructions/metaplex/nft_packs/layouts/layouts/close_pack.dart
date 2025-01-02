import 'package:on_chain/solana/src/instructions/metaplex/nft_packs/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class MetaplexNFTPacksClosePackLayout extends MetaplexNFTPacksProgramLayout {
  const MetaplexNFTPacksClosePackLayout();

  factory MetaplexNFTPacksClosePackLayout.fromBuffer(List<int> data) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexNFTPacksProgramInstruction.closePack.insturction);
    return const MetaplexNFTPacksClosePackLayout();
  }

  static final StructLayout _layout =
      LayoutConst.struct([LayoutConst.u8(property: 'instruction')]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexNFTPacksProgramInstruction get instruction =>
      MetaplexNFTPacksProgramInstruction.closePack;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
