import 'package:on_chain/solana/src/instructions/metaplex/hydra/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexHydraAddMemberNftLayout extends MetaplexHydraProgramLayout {
  final BigInt shares;
  const MetaplexHydraAddMemberNftLayout({required this.shares});

  factory MetaplexHydraAddMemberNftLayout.fromBuffer(List<int> data) {
    final decode = MetaplexHydraProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexHydraProgramInstruction.processAddMemberNft.insturction);
    return MetaplexHydraAddMemberNftLayout(shares: decode["shares"]);
  }

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    LayoutUtils.u64("shares"),
  ]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexHydraProgramInstruction.processAddMemberNft.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"shares": shares};
  }
}
