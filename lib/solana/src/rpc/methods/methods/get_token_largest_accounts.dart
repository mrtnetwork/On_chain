import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';
import 'package:on_chain/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Returns the 20 largest accounts of a particular SPL Token type.
/// https://solana.com/docs/rpc/http/gettokenlargestaccounts
class SolanaRequestGetTokenLargestAccounts
    extends SolanaRequest<List<TokenAccountBalancePair>, List> {
  const SolanaRequestGetTokenLargestAccounts(
      {required this.account, super.commitment});

  /// getTokenLargestAccounts
  @override
  String get method => SolanaRequestMethods.getTokenLargestAccounts.value;

  /// Pubkey of the token Mint to query, as base-58 encoded string
  final SolAddress account;

  @override
  List<dynamic> toJson() {
    return [
      account.address,
      SolanaRequestUtils.createConfig([commitment?.toJson()])
    ];
  }

  @override
  List<TokenAccountBalancePair> onResonse(List result) {
    return result.map((e) => TokenAccountBalancePair.fromJson(e)).toList();
  }
}
