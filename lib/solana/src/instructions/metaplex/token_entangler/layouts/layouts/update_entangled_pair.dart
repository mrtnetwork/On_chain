import 'package:on_chain/solana/src/instructions/metaplex/token_entangler/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexTokenEntanglerUpdateEntangledPairLayout
    extends MetaplexTokenEntanglerProgramLayout {
  final BigInt price;
  final bool paysEveryTime;
  const MetaplexTokenEntanglerUpdateEntangledPairLayout(
      {required this.price, required this.paysEveryTime});

  factory MetaplexTokenEntanglerUpdateEntangledPairLayout.fromBuffer(
      List<int> data) {
    final decode = MetaplexTokenEntanglerProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexTokenEntanglerProgramInstruction
            .updateEntangledPair.insturction);
    return MetaplexTokenEntanglerUpdateEntangledPairLayout(
        price: decode["price"], paysEveryTime: decode["paysEveryTime"]);
  }

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    LayoutUtils.u64("price"),
    LayoutUtils.boolean(property: "paysEveryTime"),
  ]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexTokenEntanglerProgramInstruction.updateEntangledPair.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"paysEveryTime": paysEveryTime, "price": price};
  }
}
