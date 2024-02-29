import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/rpc/core/rpc.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';
import 'package:on_chain/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Subscribe to an account to receive notifications when the lamports or data for a given account public key changes
/// https://solana.com/docs/rpc/websocket/accountsubscribe
class SolanaRPCAccountSubscribeInfo extends SolanaRPCRequest<int> {
  const SolanaRPCAccountSubscribeInfo(
      {required this.account,
      Commitment? commitment,
      SolanaRPCEncoding? encoding = SolanaRPCEncoding.base64})
      : super(commitment: commitment, encoding: encoding);

  /// accountSubscribe
  @override
  String get method => SolanaSubscribeRpcMethods.accountSubscribe.value;

  /// Pubkey of account to query, as base-58 encoded string
  final SolAddress account;

  @override
  List<dynamic> toJson() {
    return [
      account.address,
      SolanaRPCUtils.createConfig([
        commitment?.toJson(),
        encoding?.toJson(),
      ])
    ];
  }

  @override
  int onResonse(result) {
    return result;
  }
}
