import 'package:on_chain/solana/src/instructions/metaplex/token_entangler/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

class MetaplexTokenEntanglerCreateEntangledPairLayout
    extends MetaplexTokenEntanglerProgramLayout {
  final int bump;
  final int reverseBump;
  final int tokenAEscrowBump;
  final int tokenBEscrowBump;
  final BigInt price;
  final bool paysEveryTime;
  const MetaplexTokenEntanglerCreateEntangledPairLayout(
      {required this.bump,
      required this.reverseBump,
      required this.tokenAEscrowBump,
      required this.tokenBEscrowBump,
      required this.price,
      required this.paysEveryTime});

  factory MetaplexTokenEntanglerCreateEntangledPairLayout.fromBuffer(
      List<int> data) {
    final decode = MetaplexTokenEntanglerProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexTokenEntanglerProgramInstruction
            .createEntangledPair.insturction);
    return MetaplexTokenEntanglerCreateEntangledPairLayout(
        bump: decode["bump"],
        reverseBump: decode["reverseBump"],
        tokenAEscrowBump: decode["tokenAEscrowBump"],
        tokenBEscrowBump: decode["tokenBEscrowBump"],
        price: decode["price"],
        paysEveryTime: decode["paysEveryTime"]);
  }

  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.blob(8, property: "instruction"),
    LayoutConst.u8(property: "bump"),
    LayoutConst.u8(property: "tokenAEscrowBump"),
    LayoutConst.u8(property: "reverseBump"),
    LayoutConst.u8(property: "tokenBEscrowBump"),
    LayoutConst.u64(property: "price"),
    LayoutConst.boolean(property: "paysEveryTime"),
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexTokenEntanglerProgramInstruction.createEntangledPair.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "bump": bump,
      "reverseBump": reverseBump,
      "tokenAEscrowBump": tokenAEscrowBump,
      "tokenBEscrowBump": tokenBEscrowBump,
      "price": price,
      "paysEveryTime": paysEveryTime,
    };
  }
}
