import 'package:on_chain/solana/src/instructions/metaplex/nft_packs/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class MetaplexNFTPacksClaimPackLayout extends MetaplexNFTPacksProgramLayout {
  final int index;
  const MetaplexNFTPacksClaimPackLayout({required this.index});

  factory MetaplexNFTPacksClaimPackLayout.fromBuffer(List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexNFTPacksProgramInstruction.claimPack.insturction);
    return MetaplexNFTPacksClaimPackLayout(index: decode['index']);
  }

  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: 'instruction'),
    LayoutConst.u32(property: 'index')
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexNFTPacksProgramInstruction get instruction =>
      MetaplexNFTPacksProgramInstruction.claimPack;

  @override
  Map<String, dynamic> serialize() {
    return {'index': index};
  }
}
