import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/instructions.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Initialize a new mint with interest accrual layout.
class SPLToken2022InterestBearingMintInitializeLayout
    extends SPLTokenProgramLayout {
  /// The initial interest rate
  final int rate;

  /// The public key for the account that can update the rate
  final SolAddress rateAuthority;
  SPLToken2022InterestBearingMintInitializeLayout(
      {required this.rate, required this.rateAuthority});

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8("instruction"),
    LayoutUtils.wrap(InterestBearingMintInstruction.staticLayout,
        property: "interestBearingMint"),
    LayoutUtils.publicKey("rateAuthority"),
    LayoutUtils.u16("rate"),
  ]);

  factory SPLToken2022InterestBearingMintInitializeLayout.fromBuffer(
      List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: bytes,
        instruction: SPLTokenProgramInstruction
            .interestBearingMintExtension.insturction);
    return SPLToken2022InterestBearingMintInitializeLayout(
        rate: decode["rate"], rateAuthority: decode["rateAuthority"]);
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
          InterestBearingMintInstruction.initialize.serialize(),
      "rate": rate,
      "rateAuthority": rateAuthority
    };
  }
}
