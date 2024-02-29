// Manages the layout structure for the SPL token approve checked operation.
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Update the interest rate layout.
class SPLToken2022InterestBearingMintUpdateRateLayout
    extends SPLTokenProgramLayout {
  /// update rate
  final int rate;
  SPLToken2022InterestBearingMintUpdateRateLayout({required this.rate});

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8("instruction"),
    LayoutUtils.wrap(InterestBearingMintInstruction.staticLayout,
        property: "interestBearingMint"),
    LayoutUtils.u16("rate"),
  ]);

  factory SPLToken2022InterestBearingMintUpdateRateLayout.fromBuffer(
      List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: bytes,
        instruction: SPLTokenProgramInstruction
            .interestBearingMintExtension.insturction);
    return SPLToken2022InterestBearingMintUpdateRateLayout(
        rate: decode["rate"]);
  }

  @override
  Structure get layout => _layout;

  @override
  final int instruction =
      SPLTokenProgramInstruction.interestBearingMintExtension.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "interestBearingMint":
          InterestBearingMintInstruction.updateRate.serialize(),
      "rate": rate,
    };
  }
}
