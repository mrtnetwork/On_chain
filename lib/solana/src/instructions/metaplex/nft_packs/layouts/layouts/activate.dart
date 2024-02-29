import 'package:on_chain/solana/src/instructions/metaplex/nft_packs/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexNFTPacksActivateLayout extends MetaplexNFTPacksProgramLayout {
  const MetaplexNFTPacksActivateLayout();

  factory MetaplexNFTPacksActivateLayout.fromBuffer(List<int> data) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexNFTPacksProgramInstruction.activate.insturction);
    return MetaplexNFTPacksActivateLayout();
  }

  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.u8("instruction")]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction =>
      MetaplexNFTPacksProgramInstruction.activate.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
