import 'package:on_chain/solana/src/instructions/metaplex/token_entangler/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

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
        price: decode['price'], paysEveryTime: decode['paysEveryTime']);
  }

  static StructLayout get _layout => LayoutConst.struct([
        LayoutConst.blob(8, property: 'instruction'),
        LayoutConst.u64(property: 'price'),
        LayoutConst.boolean(property: 'paysEveryTime'),
      ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexTokenEntanglerProgramInstruction get instruction =>
      MetaplexTokenEntanglerProgramInstruction.updateEntangledPair;

  @override
  Map<String, dynamic> serialize() {
    return {'paysEveryTime': paysEveryTime, 'price': price};
  }
}
