import 'package:on_chain/solana/src/instructions/metaplex/nft_packs/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class MetaplexNFTPacksActivateLayout extends MetaplexNFTPacksProgramLayout {
  const MetaplexNFTPacksActivateLayout();

  factory MetaplexNFTPacksActivateLayout.fromBuffer(List<int> data) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexNFTPacksProgramInstruction.activate.insturction);
    return const MetaplexNFTPacksActivateLayout();
  }

  static final StructLayout _layout =
      LayoutConst.struct([LayoutConst.u8(property: "instruction")]);

  @override
  StructLayout get layout => _layout;

  @override
  int get instruction =>
      MetaplexNFTPacksProgramInstruction.activate.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
