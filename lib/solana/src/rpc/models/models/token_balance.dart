import 'package:on_chain/solana/src/address/sol_address.dart';

import 'token_amount_response.dart';

class TokenBalance {
  final int accountIndex;
  final SolAddress mint;
  final SolAddress? owner;
  final TokenAmoutResponse uiTokenAmount;
  const TokenBalance(
      {required this.accountIndex,
      required this.mint,
      required this.owner,
      required this.uiTokenAmount});
  factory TokenBalance.fromJson(Map<String, dynamic> json) {
    return TokenBalance(
        accountIndex: json['accountIndex'],
        mint: SolAddress.uncheckCurve(json['mint']),
        owner: json['owner'] == null
            ? null
            : SolAddress.uncheckCurve(json['owner']),
        uiTokenAmount: TokenAmoutResponse.fromJson(json['uiTokenAmount']));
  }
}
