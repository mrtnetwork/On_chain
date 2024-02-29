import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';
import 'package:on_chain/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Returns the stake minimum delegation, in lamports.
/// https://solana.com/docs/rpc/http/getstakeminimumdelegation
class SolanaRPCGetStakeMinimumDelegation extends SolanaRPCRequest<BigInt> {
  const SolanaRPCGetStakeMinimumDelegation({
    Commitment? commitment,
  }) : super(commitment: commitment);

  /// getStakeMinimumDelegation
  @override
  String get method => SolanaRPCMethods.getStakeMinimumDelegation.value;

  @override
  List<dynamic> toJson() {
    return [
      SolanaRPCUtils.createConfig([commitment?.toJson()])
    ];
  }

  @override
  BigInt onResonse(result) {
    return BigintUtils.parse(result);
  }
}
