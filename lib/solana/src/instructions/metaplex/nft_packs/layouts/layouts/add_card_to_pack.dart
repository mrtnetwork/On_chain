import 'package:on_chain/solana/src/instructions/metaplex/nft_packs/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/instructions/metaplex/nft_packs/types/types/add_card_to_pack.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

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
        addCardToPack: AddCardToPack.fromJson(decode['addCardToPack']));
  }

  static StructLayout get _layout => LayoutConst.struct(
      [LayoutConst.u8(property: 'instruction'), AddCardToPack.staticLayout]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexNFTPacksProgramInstruction get instruction =>
      MetaplexNFTPacksProgramInstruction.addCardToPack;

  @override
  Map<String, dynamic> serialize() {
    return {'addCardToPack': addCardToPack.serialize()};
  }
}
