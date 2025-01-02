import 'package:on_chain/solana/src/instructions/metaplex/hydra/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

class MetaplexHydraTransferSharesLayout extends MetaplexHydraProgramLayout {
  final BigInt shares;
  const MetaplexHydraTransferSharesLayout({required this.shares});

  factory MetaplexHydraTransferSharesLayout.fromBuffer(List<int> data) {
    final decode = MetaplexHydraProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexHydraProgramInstruction.processTransferShares.insturction);
    return MetaplexHydraTransferSharesLayout(shares: decode['shares']);
  }

  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.blob(8, property: 'instruction'),
    LayoutConst.u64(property: 'shares')
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexHydraProgramInstruction get instruction =>
      MetaplexHydraProgramInstruction.processTransferShares;

  @override
  Map<String, dynamic> serialize() {
    return {'shares': shares};
  }
}
