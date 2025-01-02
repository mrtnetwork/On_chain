import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/rpc/core/rpc.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';
import 'package:on_chain/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Subscribe to an account to receive notifications when the lamports or data for a given account public key changes
/// https://solana.com/docs/rpc/websocket/accountsubscribe
class SolanaRequestAccountSubscribeInfo extends SolanaRequest<int, int> {
  const SolanaRequestAccountSubscribeInfo(
      {required this.account,
      super.commitment,
      super.encoding = SolanaRequestEncoding.base64});

  /// accountSubscribe
  @override
  String get method => SolanaSubscribeRpcMethods.accountSubscribe.value;

  /// Pubkey of account to query, as base-58 encoded string
  final SolAddress account;

  @override
  List<dynamic> toJson() {
    return [
      account.address,
      SolanaRequestUtils.createConfig([
        commitment?.toJson(),
        encoding?.toJson(),
      ])
    ];
  }
}
