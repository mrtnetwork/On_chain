import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class Token2022Payment extends LayoutSerializable {
  final BigInt amount;
  final SolAddress mint;
  final SolAddress destinationAta;

  const Token2022Payment(
      {required this.amount, required this.mint, required this.destinationAta});
  factory Token2022Payment.fromJson(Map<String, dynamic> json) {
    return Token2022Payment(
        amount: json["amount"],
        mint: json["mint"],
        destinationAta: json["destinationAta"]);
  }

  static final Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.u64("amount"),
    LayoutUtils.publicKey("mint"),
    LayoutUtils.publicKey("destinationAta")
  ], "token2022Payment");

  @override
  Structure get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {"mint": mint, "amount": amount, "destinationAta": destinationAta};
  }

  @override
  String toString() {
    return "Token2022Payment${serialize()}";
  }
}
