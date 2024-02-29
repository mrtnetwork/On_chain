import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';
import 'package:on_chain/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Returns the total supply of an SPL Token type.
/// https://solana.com/docs/rpc/http/gettokensupply
class SolanaRPCGetTokenSupply extends SolanaRPCRequest<TokenAmoutResponse> {
  const SolanaRPCGetTokenSupply({required this.account, Commitment? commitment})
      : super(commitment: commitment);

  /// getTokenSupply
  @override
  String get method => SolanaRPCMethods.getTokenSupply.value;

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
  TokenAmoutResponse onResonse(result) {
    return TokenAmoutResponse.fromJson(result);
  }
}
