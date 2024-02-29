import 'package:on_chain/solana/src/instructions/metaplex/nft_packs/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexNFTPacksDeactivateLayout extends MetaplexNFTPacksProgramLayout {
  const MetaplexNFTPacksDeactivateLayout();

  factory MetaplexNFTPacksDeactivateLayout.fromBuffer(List<int> data) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexNFTPacksProgramInstruction.deactivate.insturction);
    return MetaplexNFTPacksDeactivateLayout();
  }

  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.u8("instruction")]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction =>
      MetaplexNFTPacksProgramInstruction.deactivate.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
