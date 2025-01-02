import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';
import 'package:on_chain/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Returns the stake minimum delegation, in lamports.
/// https://solana.com/docs/rpc/http/getstakeminimumdelegation
class SolanaRequestGetStakeMinimumDelegation
    extends SolanaRequest<BigInt, Object> {
  const SolanaRequestGetStakeMinimumDelegation({
    super.commitment,
  });

  /// getStakeMinimumDelegation
  @override
  String get method => SolanaRequestMethods.getStakeMinimumDelegation.value;

  @override
  List<dynamic> toJson() {
    return [
      SolanaRequestUtils.createConfig([commitment?.toJson()])
    ];
  }

  @override
  BigInt onResonse(result) {
    return BigintUtils.parse(result);
  }
}
