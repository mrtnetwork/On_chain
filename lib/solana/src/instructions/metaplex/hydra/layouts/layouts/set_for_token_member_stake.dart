import 'package:on_chain/solana/src/instructions/metaplex/hydra/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexHydraSetForTokenMemberStakeLayout
    extends MetaplexHydraProgramLayout {
  final BigInt shares;
  const MetaplexHydraSetForTokenMemberStakeLayout({required this.shares});

  factory MetaplexHydraSetForTokenMemberStakeLayout.fromBuffer(List<int> data) {
    final decode = MetaplexHydraProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexHydraProgramInstruction
            .processSetForTokenMemberStake.insturction);
    return MetaplexHydraSetForTokenMemberStakeLayout(shares: decode["shares"]);
  }

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    LayoutUtils.u64("shares")
  ]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexHydraProgramInstruction.processSetForTokenMemberStake.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"shares": shares};
  }
}
