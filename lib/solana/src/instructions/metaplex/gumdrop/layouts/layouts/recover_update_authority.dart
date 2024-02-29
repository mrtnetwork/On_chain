import 'package:on_chain/solana/src/instructions/metaplex/gumdrop/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexGumdropRecoverUpdateAuthorityLayout
    extends MetaplexGumdropProgramLayout {
  final int walletBump;
  final int bump;
  const MetaplexGumdropRecoverUpdateAuthorityLayout(
      {required this.walletBump, required this.bump});

  factory MetaplexGumdropRecoverUpdateAuthorityLayout.fromBuffer(
      List<int> data) {
    final decode = MetaplexGumdropProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexGumdropProgramInstruction
            .recoverUpdateAuthority.insturction);
    return MetaplexGumdropRecoverUpdateAuthorityLayout(
        walletBump: decode["walletBump"], bump: decode["bump"]);
  }

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    LayoutUtils.u8("bump"),
    LayoutUtils.u8("walletBump"),
  ]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexGumdropProgramInstruction.recoverUpdateAuthority.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"bump": bump, "walletBump": walletBump};
  }
}
