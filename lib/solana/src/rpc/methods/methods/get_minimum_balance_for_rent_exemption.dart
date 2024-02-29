import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';
import 'package:on_chain/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Returns minimum balance required to make account rent exempt.
class SolanaRPCGetMinimumBalanceForRentExemption
    extends SolanaRPCRequest<BigInt> {
  const SolanaRPCGetMinimumBalanceForRentExemption(
      {required this.size, Commitment? commitment = Commitment.finalized})
      : super(commitment: commitment);

  /// getMinimumBalanceForRentExemption
  @override
  String get method => SolanaRPCMethods.getMinimumBalanceForRentExemption.value;

  /// the Account's data length
  final int size;
  @override
  List<dynamic> toJson() {
    return [
      size,
      SolanaRPCUtils.createConfig([commitment?.toJson()])
    ];
  }

  @override
  BigInt onResonse(result) {
    return BigInt.from(result);
  }
}
