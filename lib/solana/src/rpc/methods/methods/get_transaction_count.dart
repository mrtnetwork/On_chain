import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';
import 'package:on_chain/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Returns the current Transaction count from the ledger
/// https://solana.com/docs/rpc/http/gettransactioncount
class SolanaRequestGetTransactionCount extends SolanaRequest<int, int> {
  const SolanaRequestGetTransactionCount(
      {super.commitment, super.minContextSlot});

  /// getTransactionCount
  @override
  String get method => SolanaRequestMethods.getTransactionCount.value;

  @override
  List<dynamic> toJson() {
    return [
      SolanaRequestUtils.createConfig(
          [commitment?.toJson(), minContextSlot?.toJson()])
    ];
  }
}
