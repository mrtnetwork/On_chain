import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';
import 'package:on_chain/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Returns the token balance of an SPL Token account.
/// https://solana.com/docs/rpc/http/gettokenaccountbalance
class SolanaRequestGetTokenAccountBalance
    extends SolanaRequest<TokenAmoutResponse, Map<String, dynamic>> {
  const SolanaRequestGetTokenAccountBalance({
    required this.account,
    super.commitment,
  });

  /// getTokenAccountBalance
  @override
  String get method => SolanaRequestMethods.getTokenAccountBalance.value;

  /// Pubkey of Token account to query, as base-58 encoded string
  final SolAddress account;

  @override
  List<dynamic> toJson() {
    return [
      account.address,
      SolanaRequestUtils.createConfig([commitment?.toJson()])
    ];
  }

  @override
  TokenAmoutResponse onResonse(Map<String, dynamic> result) {
    return TokenAmoutResponse.fromJson(result);
  }
}
