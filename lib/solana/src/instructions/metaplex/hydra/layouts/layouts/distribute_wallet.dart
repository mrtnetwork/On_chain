import 'package:on_chain/solana/src/instructions/metaplex/hydra/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexHydraDistributeWalletLayout extends MetaplexHydraProgramLayout {
  final bool distributeForMint;
  const MetaplexHydraDistributeWalletLayout({required this.distributeForMint});

  factory MetaplexHydraDistributeWalletLayout.fromBuffer(List<int> data) {
    final decode = MetaplexHydraProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexHydraProgramInstruction
            .processDistributeWallet.insturction);
    return MetaplexHydraDistributeWalletLayout(
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
      MetaplexHydraProgramInstruction.processDistributeWallet.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"distributeForMint": distributeForMint};
  }
}
