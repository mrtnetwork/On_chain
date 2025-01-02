import 'package:blockchain_utils/utils/utils.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';
import 'package:on_chain/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Returns the lamport balance of the account of provided Pubkey
/// https://solana.com/docs/rpc/http/getbalance
class SolanaRequestGetBalance extends SolanaRequest<BigInt, dynamic> {
  const SolanaRequestGetBalance(
      {required this.account, super.commitment, super.minContextSlot});

  /// Pubkey of account to query, as base-58 encoded string
  final SolAddress account;

  /// getBalance
  @override
  String get method => SolanaRequestMethods.getBalance.value;

  @override
  List<dynamic> toJson() {
    return [
      account.address,
      SolanaRequestUtils.createConfig(
          [commitment?.toJson(), minContextSlot?.toJson()])
    ];
  }

  @override
  BigInt onResonse(dynamic result) {
    return BigintUtils.parse(result);
  }
}
