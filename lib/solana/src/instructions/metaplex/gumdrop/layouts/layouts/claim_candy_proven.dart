import 'package:on_chain/solana/src/instructions/metaplex/gumdrop/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

class MetaplexGumdropClaimCandyProvenLayout
    extends MetaplexGumdropProgramLayout {
  final int walletBump;
  final int claimBump;
  final BigInt index;
  const MetaplexGumdropClaimCandyProvenLayout(
      {required this.walletBump, required this.claimBump, required this.index});

  factory MetaplexGumdropClaimCandyProvenLayout.fromBuffer(List<int> data) {
    final decode = MetaplexGumdropProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexGumdropProgramInstruction.claimCandyProven.insturction);
    return MetaplexGumdropClaimCandyProvenLayout(
        walletBump: decode["walletBump"],
        claimBump: decode["claimBump"],
        index: decode["index"]);
  }

  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.blob(8, property: "instruction"),
    LayoutConst.u8(property: "walletBump"),
    LayoutConst.u8(property: "claimBump"),
    LayoutConst.u64(property: "index")
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexGumdropProgramInstruction get instruction =>
      MetaplexGumdropProgramInstruction.claimCandyProven;

  @override
  Map<String, dynamic> serialize() {
    return {"walletBump": walletBump, "claimBump": claimBump, "index": index};
  }
}
