import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';

import 'package:on_chain/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Requests an airdrop of lamports to a Pubkey
/// https://solana.com/docs/rpc/http/requestairdrop
class SolanaRPCRequestAirdrop extends SolanaRPCRequest<String> {
  const SolanaRPCRequestAirdrop(
      {required this.account, required this.lamports, Commitment? commitment});

  /// requestAirdrop
  @override
  String get method => SolanaRPCMethods.requestAirdrop.value;

  /// Pubkey of account to receive lamports, as a base-58 encoded string
  final SolAddress account;

  /// lamports to airdrop, as a "u64"
  final int lamports;

  @override
  List<dynamic> toJson() {
    return [
      account.address,
      lamports,
      SolanaRPCUtils.createConfig([commitment?.toJson()])
    ];
  }
}
