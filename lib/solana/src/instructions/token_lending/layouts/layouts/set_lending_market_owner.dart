import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/token_lending/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

/// Sets the new owner of a lending market layout.
class TokenLendingSetLendingMarketOwnerLayout
    extends TokenLendingProgramLayout {
  /// The new owner
  final SolAddress newOwner;
  const TokenLendingSetLendingMarketOwnerLayout({required this.newOwner});

  factory TokenLendingSetLendingMarketOwnerLayout.fromBuffer(List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            TokenLendingProgramInstruction.setLendingMarketOwner.insturction);
    return TokenLendingSetLendingMarketOwnerLayout(newOwner: decode["owner"]);
  }
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: "instruction"),
    SolanaLayoutUtils.publicKey("newOwner")
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  TokenLendingProgramInstruction get instruction =>
      TokenLendingProgramInstruction.setLendingMarketOwner;

  @override
  Map<String, dynamic> serialize() {
    return {"newOwner": newOwner};
  }
}
