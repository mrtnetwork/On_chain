import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class TokenBurn extends LayoutSerializable {
  final BigInt amount;
  final SolAddress mint;

  const TokenBurn({required this.amount, required this.mint});
  factory TokenBurn.fromJson(Map<String, dynamic> json) {
    return TokenBurn(amount: json["amount"], mint: json["mint"]);
  }

  static final Structure staticLayout = LayoutUtils.struct(
      [LayoutUtils.u64("amount"), LayoutUtils.publicKey("mint")], "tokenBurn");

  @override
  Structure get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {"mint": mint, "amount": amount};
  }

  @override
  String toString() {
    return "TokenBurn${serialize()}";
  }
}
