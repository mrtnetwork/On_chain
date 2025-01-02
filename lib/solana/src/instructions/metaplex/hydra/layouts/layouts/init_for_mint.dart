import 'package:on_chain/solana/src/instructions/metaplex/hydra/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

class MetaplexHydraInitForMintLayout extends MetaplexHydraProgramLayout {
  final int bumpSeed;
  const MetaplexHydraInitForMintLayout({required this.bumpSeed});

  factory MetaplexHydraInitForMintLayout.fromBuffer(List<int> data) {
    final decode = MetaplexHydraProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexHydraProgramInstruction.processInitForMint.insturction);
    return MetaplexHydraInitForMintLayout(bumpSeed: decode['bumpSeed']);
  }

  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.blob(8, property: 'instruction'),
    LayoutConst.u8(property: 'bumpSeed')
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexHydraProgramInstruction get instruction =>
      MetaplexHydraProgramInstruction.processInitForMint;

  @override
  Map<String, dynamic> serialize() {
    return {'bumpSeed': bumpSeed};
  }
}
