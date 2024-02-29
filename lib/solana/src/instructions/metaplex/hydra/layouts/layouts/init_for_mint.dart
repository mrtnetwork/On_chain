import 'package:on_chain/solana/src/instructions/metaplex/hydra/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexHydraInitForMintLayout extends MetaplexHydraProgramLayout {
  final int bumpSeed;
  const MetaplexHydraInitForMintLayout({required this.bumpSeed});

  factory MetaplexHydraInitForMintLayout.fromBuffer(List<int> data) {
    final decode = MetaplexHydraProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexHydraProgramInstruction.processInitForMint.insturction);
    return MetaplexHydraInitForMintLayout(bumpSeed: decode["bumpSeed"]);
  }

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    LayoutUtils.u8("bumpSeed")
  ]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexHydraProgramInstruction.processInitForMint.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"bumpSeed": bumpSeed};
  }
}
