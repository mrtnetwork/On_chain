import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/token_lending/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Initializes a new lending market layout
class TokenLendingInitLendingMarketLayout extends TokenLendingProgramLayout {
  /// Owner authority which can add new reserves
  final SolAddress owner;

  /// Currency market prices are quoted in
  /// e.g. "USD" null padded
  /// (`*b"USD\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
  /// `) or SPL token mint pubkey
  final List<int> quoteCurrency;
  TokenLendingInitLendingMarketLayout._(
      {required this.owner, required List<int> quoteCurrency})
      : quoteCurrency = BytesUtils.toBytes(quoteCurrency, unmodifiable: true);
  factory TokenLendingInitLendingMarketLayout(
      {required SolAddress owner, required List<int> quoteCurrency}) {
    if (quoteCurrency.length != 32) {
      throw MessageException("quoteCurrency must not exceed 32 bytes.");
    }
    return TokenLendingInitLendingMarketLayout._(
        owner: owner, quoteCurrency: quoteCurrency);
  }
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8("instruction"),
    LayoutUtils.publicKey("owner"),
    LayoutUtils.blob(32, property: "quoteCurrency"),
  ]);

  factory TokenLendingInitLendingMarketLayout.fromBuffer(List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            TokenLendingProgramInstruction.initLendingMarket.insturction);
    return TokenLendingInitLendingMarketLayout(
        quoteCurrency: decode["quoteCurrency"], owner: decode["owner"]);
  }

  @override
  Structure get layout => _layout;

  @override
  int get instruction =>
      TokenLendingProgramInstruction.initLendingMarket.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"owner": owner, "quoteCurrency": quoteCurrency};
  }
}
