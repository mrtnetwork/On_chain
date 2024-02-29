import 'package:on_chain/solana/src/instructions/metaplex/nft_packs/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/instructions/metaplex/nft_packs/types/types/add_card_to_pack.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexNFTPacksAddCardToPackLayout
    extends MetaplexNFTPacksProgramLayout {
  final AddCardToPack addCardToPack;
  const MetaplexNFTPacksAddCardToPackLayout({required this.addCardToPack});

  factory MetaplexNFTPacksAddCardToPackLayout.fromBuffer(List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexNFTPacksProgramInstruction.addCardToPack.insturction);
    return MetaplexNFTPacksAddCardToPackLayout(
        addCardToPack: AddCardToPack.fromJson(decode["addCardToPack"]));
  }

  static final Structure _layout = LayoutUtils.struct(
      [LayoutUtils.u8("instruction"), AddCardToPack.staticLayout]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction =>
      MetaplexNFTPacksProgramInstruction.addCardToPack.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"addCardToPack": addCardToPack.serialize()};
  }
}
