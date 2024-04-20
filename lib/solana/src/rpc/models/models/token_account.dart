import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/instructions.dart';
import 'package:on_chain/solana/src/rpc/models/models/account_info.dart';

class TokenAccountResponse {
  final SolAddress pubkey;
  final SolanaAccountInfo account;
  final SolanaTokenAccount tokenAccount;
  const TokenAccountResponse(
      {required this.pubkey,
      required this.account,
      required this.tokenAccount});
  factory TokenAccountResponse.fromJson(Map<String, dynamic> json) {
    final account = SolanaAccountInfo.fromJson(json["account"]);
    final tokenAccount = SolanaTokenAccount.fromBuffer(
        data: account.toBytesData(), address: account.owner);
    return TokenAccountResponse(
        pubkey: SolAddress.uncheckCurve(json["pubkey"]),
        account: account,
        tokenAccount: tokenAccount);
  }

  Map<String, dynamic> toJson() {
    return {
      "pubkey": pubkey.address,
      "account": account.toJson(),
      "token_account": tokenAccount.serialize()
    };
  }

  @override
  String toString() {
    return "TokenAccountResponse{${toJson()}}";
  }
}
