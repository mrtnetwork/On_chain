// Manages the layout structure for the SPL token approve checked operation.
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// Update the interest rate layout.
class SPLToken2022InterestBearingMintUpdateRateLayout
    extends SPLTokenProgramLayout {
  /// update rate
  final int rate;
  SPLToken2022InterestBearingMintUpdateRateLayout({required this.rate});

  static StructLayout get _layout => LayoutConst.struct([
        LayoutConst.u8(property: 'instruction'),
        LayoutConst.wrap(InterestBearingMintInstruction.staticLayout,
            property: 'interestBearingMint'),
        LayoutConst.u16(property: 'rate'),
      ]);

  factory SPLToken2022InterestBearingMintUpdateRateLayout.fromBuffer(
      List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: bytes,
        instruction: SPLTokenProgramInstruction
            .interestBearingMintExtension.insturction);
    return SPLToken2022InterestBearingMintUpdateRateLayout(
        rate: decode['rate']);
  }

  @override
  StructLayout get layout => _layout;

  @override
  final SPLTokenProgramInstruction instruction =
      SPLTokenProgramInstruction.interestBearingMintExtension;

  @override
  Map<String, dynamic> serialize() {
    return {
      'interestBearingMint':
          InterestBearingMintInstruction.updateRate.serialize(),
      'rate': rate,
    };
  }
}
