import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

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

  static final StructLayout staticLayout = LayoutConst.struct([
    LayoutConst.u64(property: "amount"),
    SolanaLayoutUtils.publicKey("mint"),
    SolanaLayoutUtils.publicKey("destinationAta"),
  ], property: "tokenPayment");

  @override
  StructLayout get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {"destinationAta": destinationAta, "mint": mint, "amount": amount};
  }

  @override
  String toString() {
    return "TokenPayment${serialize()}";
  }
}
