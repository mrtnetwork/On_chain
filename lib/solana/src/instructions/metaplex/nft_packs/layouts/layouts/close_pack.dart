import 'package:on_chain/solana/src/instructions/metaplex/nft_packs/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexNFTPacksClosePackLayout extends MetaplexNFTPacksProgramLayout {
  const MetaplexNFTPacksClosePackLayout();

  factory MetaplexNFTPacksClosePackLayout.fromBuffer(List<int> data) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexNFTPacksProgramInstruction.closePack.insturction);
    return MetaplexNFTPacksClosePackLayout();
  }

  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.u8("instruction")]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction =>
      MetaplexNFTPacksProgramInstruction.closePack.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
