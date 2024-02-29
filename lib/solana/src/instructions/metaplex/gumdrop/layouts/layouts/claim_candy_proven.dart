import 'package:on_chain/solana/src/instructions/metaplex/gumdrop/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

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

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    LayoutUtils.u8("walletBump"),
    LayoutUtils.u8("claimBump"),
    LayoutUtils.u64("index")
  ]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexGumdropProgramInstruction.claimCandyProven.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"walletBump": walletBump, "claimBump": claimBump, "index": index};
  }
}
