import 'package:on_chain/solana/src/instructions/metaplex/hydra/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexHydraSetTokenMemberStakeLayout
    extends MetaplexHydraProgramLayout {
  final BigInt shares;
  const MetaplexHydraSetTokenMemberStakeLayout({required this.shares});

  factory MetaplexHydraSetTokenMemberStakeLayout.fromBuffer(List<int> data) {
    final decode = MetaplexHydraProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexHydraProgramInstruction
            .processSetTokenMemberStake.insturction);
    return MetaplexHydraSetTokenMemberStakeLayout(shares: decode["shares"]);
  }

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    LayoutUtils.u64("shares")
  ]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexHydraProgramInstruction.processSetTokenMemberStake.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"shares": shares};
  }
}
