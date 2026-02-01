import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class FreezeTokenPayment extends BorshLayoutSerializable {
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
        amount: json['amount'],
        mint: json['mint'],
        destinationAta: json['destinationAta']);
  }

  static StructLayout get staticLayout => LayoutConst.struct([
        LayoutConst.u64(property: 'amount'),
        SolanaLayoutUtils.publicKey('mint'),
        SolanaLayoutUtils.publicKey('destinationAta')
      ], property: 'freezeTokenPayment');

  @override
  StructLayout get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {'destinationAta': destinationAta, 'amount': amount, 'mint': mint};
  }

  @override
  String toString() {
    return 'FreezeTokenPayment${serialize()}';
  }
}
