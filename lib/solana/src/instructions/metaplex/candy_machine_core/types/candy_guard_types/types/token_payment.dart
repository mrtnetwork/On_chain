import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class TokenPayment extends LayoutSerializable {
  final BigInt amount;
  final SolAddress mint;
  final SolAddress destinationAta;

  const TokenPayment(
      {required this.amount, required this.mint, required this.destinationAta});
  factory TokenPayment.fromJson(Map<String, dynamic> json) {
    return TokenPayment(
        amount: json["amount"],
        mint: json["mint"],
        destinationAta: json["destinationAta"]);
  }

  static final Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.u64("amount"),
    LayoutUtils.publicKey("mint"),
    LayoutUtils.publicKey("destinationAta"),
  ], "tokenPayment");

  @override
  Structure get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {"destinationAta": destinationAta, "mint": mint, "amount": amount};
  }

  @override
  String toString() {
    return "TokenPayment${serialize()}";
  }
}
