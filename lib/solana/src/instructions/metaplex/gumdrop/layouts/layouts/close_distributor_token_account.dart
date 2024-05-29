import 'package:on_chain/solana/src/instructions/metaplex/gumdrop/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

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

  /// StructLayout layout definition.
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.blob(8, property: "instruction"),
    LayoutConst.u8(property: "bump"),
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  List<int> get instruction => MetaplexGumdropProgramInstruction
      .closeDistributorTokenAccount.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"bump": bump};
  }
}
