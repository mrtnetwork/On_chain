import 'package:on_chain/solana/src/instructions/metaplex/nft_packs/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexNFTPacksClaimPackLayout extends MetaplexNFTPacksProgramLayout {
  final int index;
  const MetaplexNFTPacksClaimPackLayout({required this.index});

  factory MetaplexNFTPacksClaimPackLayout.fromBuffer(List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexNFTPacksProgramInstruction.claimPack.insturction);
    return MetaplexNFTPacksClaimPackLayout(index: decode["index"]);
  }

  static final Structure _layout = LayoutUtils.struct(
      [LayoutUtils.u8("instruction"), LayoutUtils.u32("index")]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction =>
      MetaplexNFTPacksProgramInstruction.claimPack.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"index": index};
  }
}
