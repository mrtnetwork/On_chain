import 'package:on_chain/solana/src/instructions/metaplex/gumdrop/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexGumdropCloseDistributorTokenAccountLayout
    extends MetaplexGumdropProgramLayout {
  final int bump;
  const MetaplexGumdropCloseDistributorTokenAccountLayout({required this.bump});

  factory MetaplexGumdropCloseDistributorTokenAccountLayout.fromBuffer(
      List<int> data) {
    final decode = MetaplexGumdropProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexGumdropProgramInstruction
            .closeDistributorTokenAccount.insturction);
    return MetaplexGumdropCloseDistributorTokenAccountLayout(
        bump: decode["bump"]);
  }

  /// Structure layout definition.
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    LayoutUtils.u8("bump"),
  ]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction => MetaplexGumdropProgramInstruction
      .closeDistributorTokenAccount.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"bump": bump};
  }
}
