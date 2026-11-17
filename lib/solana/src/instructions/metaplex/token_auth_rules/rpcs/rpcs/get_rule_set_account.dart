import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_auth_rules/accounts/accounts.dart';
import 'package:on_chain/solana/src/rpc/rpc.dart';

/// Retrieves the Token Authorization Rules RuleSet PDA info and
/// deserializes the [TokenAuthRulesRuleSetAccount] from its data.
class SolanaRPCGetTokenAuthRulesRuleSetAccount
    extends
        SolanaRequest<TokenAuthRulesRuleSetAccount?, Map<String, dynamic>?> {
  const SolanaRPCGetTokenAuthRulesRuleSetAccount({
    required this.account,
    super.commitment,
    super.minContextSlot,
  });

  @override
  String get method => SolanaRequestMethods.getAccountInfo.value;
  final SolAddress account;

  @override
  List<dynamic> toJson() {
    return [
      account.address,
      SolanaRequestUtils.createConfig([
        commitment?.toJson(),
        SolanaRequestEncoding.base64.toJson(),
        minContextSlot?.toJson(),
      ]),
    ];
  }

  @override
  TokenAuthRulesRuleSetAccount? onResponse(Map<String, dynamic>? result) {
    if (result == null) return null;
    final accountInfo = SolanaAccountInfo.fromJson(result);
    return TokenAuthRulesRuleSetAccount.fromBuffer(accountInfo.toBytesData());
  }
}
