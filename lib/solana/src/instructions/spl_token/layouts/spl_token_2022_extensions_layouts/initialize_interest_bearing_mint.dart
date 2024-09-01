import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/instructions.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

/// Initialize a new mint with interest accrual layout.
class SPLToken2022InterestBearingMintInitializeLayout
    extends SPLTokenProgramLayout {
  /// The initial interest rate
  final int rate;

  /// The public key for the account that can update the rate
  final SolAddress rateAuthority;
  SPLToken2022InterestBearingMintInitializeLayout(
      {required this.rate, required this.rateAuthority});

  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: "instruction"),
    LayoutConst.wrap(InterestBearingMintInstruction.staticLayout,
        property: "interestBearingMint"),
    SolanaLayoutUtils.publicKey("rateAuthority"),
    LayoutConst.u16(property: "rate"),
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
  StructLayout get layout => _layout;

  @override
  final SPLTokenProgramInstruction instruction =
      SPLTokenProgramInstruction.interestBearingMintExtension;

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
