import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';
import 'package:on_chain/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Returns the lamport balance of the account of provided Pubkey
/// https://solana.com/docs/rpc/http/getbalance
class SolanaRPCGetBalance extends SolanaRPCRequest<BigInt> {
  const SolanaRPCGetBalance(
      {required this.account,
      Commitment? commitment,
      MinContextSlot? minContextSlot})
      : super(commitment: commitment, minContextSlot: minContextSlot);

  /// Pubkey of account to query, as base-58 encoded string
  final SolAddress account;

  /// getBalance
  @override
  String get method => SolanaRPCMethods.getBalance.value;

  @override
  List<dynamic> toJson() {
    return [
      account.address,
      SolanaRPCUtils.createConfig(
          [commitment?.toJson(), minContextSlot?.toJson()])
    ];
  }

  @override
  BigInt onResonse(result) {
    return BigInt.parse(result.toString());
  }
}
