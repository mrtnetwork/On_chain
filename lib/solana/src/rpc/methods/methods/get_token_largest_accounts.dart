import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';
import 'package:on_chain/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Returns the 20 largest accounts of a particular SPL Token type.
/// https://solana.com/docs/rpc/http/gettokenlargestaccounts
class SolanaRPCGetTokenLargestAccounts
    extends SolanaRPCRequest<List<TokenAccountBalancePair>> {
  const SolanaRPCGetTokenLargestAccounts(
      {required this.account, Commitment? commitment})
      : super(commitment: commitment);

  /// getTokenLargestAccounts
  @override
  String get method => SolanaRPCMethods.getTokenLargestAccounts.value;

  /// Pubkey of the token Mint to query, as base-58 encoded string
  final SolAddress account;

  @override
  List<dynamic> toJson() {
    return [
      account.address,
      SolanaRPCUtils.createConfig([commitment?.toJson()])
    ];
  }

  @override
  List<TokenAccountBalancePair> onResonse(result) {
    return (result as List)
        .map((e) => TokenAccountBalancePair.fromJson(e))
        .toList();
  }
}
