import 'package:on_chain/solana/src/address/sol_address.dart';

class TokenAccountBalancePair {
  const TokenAccountBalancePair(
      {required this.amount,
      required this.decimals,
      required this.address,
      this.uiAmount,
      this.uiAmountString});
  factory TokenAccountBalancePair.fromJson(Map<String, dynamic> json) {
    return TokenAccountBalancePair(
        amount: json['amount'],
        address: SolAddress.uncheckCurve(json['address']),
        decimals: json['decimals'],
        uiAmount: json['uiAmount'],
        uiAmountString: json['uiAmountString']);
  }

  /// Address of the token account
  final SolAddress address;

  /// Raw amount of tokens as string ignoring decimals
  final String amount;

  /// Number of decimals configured for token's mint
  final int decimals;

  /// Token amount as float, accounts for decimals
  final double? uiAmount;

  /// Token amount as string, accounts for decimals
  final String? uiAmountString;
}
