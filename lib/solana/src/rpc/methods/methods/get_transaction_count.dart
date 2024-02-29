import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';
import 'package:on_chain/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Returns the current Transaction count from the ledger
/// https://solana.com/docs/rpc/http/gettransactioncount
class SolanaRPCGetTransactionCount extends SolanaRPCRequest<int> {
  const SolanaRPCGetTransactionCount(
      {Commitment? commitment, MinContextSlot? minContextSlot})
      : super(commitment: commitment, minContextSlot: minContextSlot);

  /// getTransactionCount
  @override
  String get method => SolanaRPCMethods.getTransactionCount.value;

  @override
  List<dynamic> toJson() {
    return [
      SolanaRPCUtils.createConfig(
          [commitment?.toJson(), minContextSlot?.toJson()])
    ];
  }
}
