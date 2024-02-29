import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class FreezeTokenPayment extends LayoutSerializable {
  final BigInt amount;
  final SolAddress mint;
  final SolAddress destinationAta;

  const FreezeTokenPayment({
    required this.amount,
    required this.mint,
    required this.destinationAta,
  });
  factory FreezeTokenPayment.fromJson(Map<String, dynamic> json) {
    return FreezeTokenPayment(
        amount: json["amount"],
        mint: json["mint"],
        destinationAta: json["destinationAta"]);
  }

  static final Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.u64("amount"),
    LayoutUtils.publicKey("mint"),
    LayoutUtils.publicKey("destinationAta")
  ], "freezeTokenPayment");

  @override
  Structure get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {"destinationAta": destinationAta, "amount": amount, "mint": mint};
  }

  @override
  String toString() {
    return "FreezeTokenPayment${serialize()}";
  }
}
