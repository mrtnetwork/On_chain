import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class Token2022Payment extends BorshLayoutSerializable {
  final BigInt amount;
  final SolAddress mint;
  final SolAddress destinationAta;

  const Token2022Payment(
      {required this.amount, required this.mint, required this.destinationAta});
  factory Token2022Payment.fromJson(Map<String, dynamic> json) {
    return Token2022Payment(
        amount: json['amount'],
        mint: json['mint'],
        destinationAta: json['destinationAta']);
  }

  static StructLayout get staticLayout => LayoutConst.struct([
        LayoutConst.u64(property: 'amount'),
        SolanaLayoutUtils.publicKey('mint'),
        SolanaLayoutUtils.publicKey('destinationAta')
      ], property: 'token2022Payment');

  @override
  StructLayout get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {'mint': mint, 'amount': amount, 'destinationAta': destinationAta};
  }

  @override
  String toString() {
    return 'Token2022Payment${serialize()}';
  }
}
