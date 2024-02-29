import 'package:on_chain/solana/src/instructions/metaplex/hydra/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexHydraTransferSharesLayout extends MetaplexHydraProgramLayout {
  final BigInt shares;
  const MetaplexHydraTransferSharesLayout({required this.shares});

  factory MetaplexHydraTransferSharesLayout.fromBuffer(List<int> data) {
    final decode = MetaplexHydraProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexHydraProgramInstruction.processTransferShares.insturction);
    return MetaplexHydraTransferSharesLayout(shares: decode["shares"]);
  }

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    LayoutUtils.u64("shares")
  ]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexHydraProgramInstruction.processTransferShares.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"shares": shares};
  }
}
