import 'package:on_chain/solana/src/instructions/metaplex/hydra/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/encoding/encoding.dart';

class MetaplexHydraDistributeNftLayout extends MetaplexHydraProgramLayout {
  final bool distributeForMint;
  const MetaplexHydraDistributeNftLayout({required this.distributeForMint});

  factory MetaplexHydraDistributeNftLayout.fromBuffer(List<int> data) {
    final decode = MetaplexHydraProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: data,
      instruction:
          MetaplexHydraProgramInstruction.processDistributeNft.instruction,
    );
    return MetaplexHydraDistributeNftLayout(
      distributeForMint: decode['distributeForMint'],
    );
  }

  static StructLayout get _layout => LayoutConst.struct([
    LayoutConst.blob(8, property: 'instruction'),
    LayoutConst.boolean(property: 'distributeForMint'),
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexHydraProgramInstruction get instruction =>
      MetaplexHydraProgramInstruction.processDistributeNft;

  @override
  Map<String, dynamic> serialize() {
    return {'distributeForMint': distributeForMint};
  }
}
