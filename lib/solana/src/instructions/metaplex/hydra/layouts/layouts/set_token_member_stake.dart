import 'package:on_chain/solana/src/instructions/metaplex/hydra/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

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
    return MetaplexHydraSetTokenMemberStakeLayout(shares: decode['shares']);
  }

  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.blob(8, property: 'instruction'),
    LayoutConst.u64(property: 'shares')
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexHydraProgramInstruction get instruction =>
      MetaplexHydraProgramInstruction.processSetTokenMemberStake;

  @override
  Map<String, dynamic> serialize() {
    return {'shares': shares};
  }
}
