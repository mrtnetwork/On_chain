import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/gumdrop/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexGumdropNewDistributorLayout extends MetaplexGumdropProgramLayout {
  final int bump;
  final SolAddress temporal;
  final List<int> root;
  MetaplexGumdropNewDistributorLayout(
      {required this.bump, required this.temporal, required List<int> root})
      : root = List<int>.unmodifiable(root);

  factory MetaplexGumdropNewDistributorLayout.fromBuffer(List<int> data) {
    final decode = MetaplexGumdropProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexGumdropProgramInstruction.newDistributor.insturction);
    return MetaplexGumdropNewDistributorLayout(
        bump: decode["bump"],
        temporal: decode["temporal"],
        root: decode["root"]);
  }

  /// Structure layout definition.
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    LayoutUtils.u8("bump"),
    LayoutUtils.blob(32, property: "root"),
    LayoutUtils.publicKey("temporal"),
  ]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexGumdropProgramInstruction.newDistributor.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"bump": bump, "root": root, "temporal": temporal};
  }
}
