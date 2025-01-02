import 'package:on_chain/solana/src/instructions/metaplex/hydra/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

class MetaplexHydraDistributeTokenLayout extends MetaplexHydraProgramLayout {
  final bool distributeForMint;
  const MetaplexHydraDistributeTokenLayout({required this.distributeForMint});

  factory MetaplexHydraDistributeTokenLayout.fromBuffer(List<int> data) {
    final decode = MetaplexHydraProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexHydraProgramInstruction.processDistributeToken.insturction);
    return MetaplexHydraDistributeTokenLayout(
        distributeForMint: decode['distributeForMint']);
  }

  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.blob(8, property: 'instruction'),
    LayoutConst.boolean(property: 'distributeForMint'),
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexHydraProgramInstruction get instruction =>
      MetaplexHydraProgramInstruction.processDistributeToken;

  @override
  Map<String, dynamic> serialize() {
    return {'distributeForMint': distributeForMint};
  }
}
