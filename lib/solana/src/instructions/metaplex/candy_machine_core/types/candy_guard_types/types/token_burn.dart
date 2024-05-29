import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class TokenBurn extends LayoutSerializable {
  final BigInt amount;
  final SolAddress mint;

  const TokenBurn({required this.amount, required this.mint});
  factory TokenBurn.fromJson(Map<String, dynamic> json) {
    return TokenBurn(amount: json["amount"], mint: json["mint"]);
  }

  static final StructLayout staticLayout = LayoutConst.struct([
    LayoutConst.u64(property: "amount"),
    SolanaLayoutUtils.publicKey("mint")
  ], property: "tokenBurn");

  @override
  StructLayout get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {"mint": mint, "amount": amount};
  }

  @override
  String toString() {
    return "TokenBurn${serialize()}";
  }
}
