import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/token_lending/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

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
  static final Structure _layout = LayoutUtils.struct(
      [LayoutUtils.u8("instruction"), LayoutUtils.publicKey("newOwner")]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction =>
      TokenLendingProgramInstruction.setLendingMarketOwner.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"newOwner": newOwner};
  }
}
