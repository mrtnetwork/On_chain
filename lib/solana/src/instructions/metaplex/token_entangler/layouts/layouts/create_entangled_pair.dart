import 'package:on_chain/solana/src/instructions/metaplex/token_entangler/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

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

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    LayoutUtils.u8("bump"),
    LayoutUtils.u8("tokenAEscrowBump"),
    LayoutUtils.u8("reverseBump"),
    LayoutUtils.u8("tokenBEscrowBump"),
    LayoutUtils.u64("price"),
    LayoutUtils.boolean(property: "paysEveryTime"),
  ]);

  @override
  Structure get layout => _layout;

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
