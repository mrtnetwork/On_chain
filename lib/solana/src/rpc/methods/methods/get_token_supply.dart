import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';
import 'package:on_chain/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Returns the total supply of an SPL Token type.
/// https://solana.com/docs/rpc/http/gettokensupply
class SolanaRequestGetTokenSupply
    extends SolanaRequest<TokenAmoutResponse, Map<String, dynamic>> {
  const SolanaRequestGetTokenSupply({required this.account, super.commitment});

  /// getTokenSupply
  @override
  String get method => SolanaRequestMethods.getTokenSupply.value;

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
  TokenAmoutResponse onResonse(Map<String, dynamic> result) {
    return TokenAmoutResponse.fromJson(result);
  }
}
