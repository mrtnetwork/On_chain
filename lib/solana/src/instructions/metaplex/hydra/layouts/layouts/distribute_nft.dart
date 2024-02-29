import 'package:on_chain/solana/src/instructions/metaplex/hydra/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexHydraDistributeNftLayout extends MetaplexHydraProgramLayout {
  final bool distributeForMint;
  const MetaplexHydraDistributeNftLayout({required this.distributeForMint});

  factory MetaplexHydraDistributeNftLayout.fromBuffer(List<int> data) {
    final decode = MetaplexHydraProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexHydraProgramInstruction.processDistributeNft.insturction);
    return MetaplexHydraDistributeNftLayout(
        distributeForMint: decode["distributeForMint"]);
  }

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    LayoutUtils.boolean(property: "distributeForMint"),
  ]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexHydraProgramInstruction.processDistributeNft.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"distributeForMint": distributeForMint};
  }
}
