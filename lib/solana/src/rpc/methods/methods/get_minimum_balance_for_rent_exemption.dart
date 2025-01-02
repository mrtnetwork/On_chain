import 'package:blockchain_utils/utils/utils.dart';
import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';
import 'package:on_chain/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Returns minimum balance required to make account rent exempt.
class SolanaRequestGetMinimumBalanceForRentExemption
    extends SolanaRequest<BigInt, Object> {
  const SolanaRequestGetMinimumBalanceForRentExemption(
      {required this.size, super.commitment = Commitment.finalized});

  /// getMinimumBalanceForRentExemption
  @override
  String get method =>
      SolanaRequestMethods.getMinimumBalanceForRentExemption.value;

  /// the Account's data length
  final int size;
  @override
  List<dynamic> toJson() {
    return [
      size,
      SolanaRequestUtils.createConfig([commitment?.toJson()])
    ];
  }

  @override
  BigInt onResonse(result) {
    return BigintUtils.parse(result);
  }
}
