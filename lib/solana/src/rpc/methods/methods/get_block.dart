import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';
import 'package:on_chain/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Returns identity and transaction information about a confirmed block in the ledger
/// https://solana.com/docs/rpc/http/getblock
class SolanaRequestGetBlock
    extends SolanaRequest<VersionedBlockResponse, Map<String, dynamic>> {
  const SolanaRequestGetBlock(
      {required this.slot,
      this.transactionDetails = RPCTransactionDetails.full,
      this.maxSupportedTransactionVersion = 0,
      this.rewards,
      super.commitment,
      super.encoding});

  /// getBlock
  @override
  String get method => SolanaRequestMethods.getBlock.value;

  /// slot number, as u64 integer
  final int slot;

  /// level of transaction detail to return
  final RPCTransactionDetails? transactionDetails;

  /// the max transaction version to return in responses.
  final int? maxSupportedTransactionVersion;

  /// whether to populate the rewards array. If parameter not provided, the default includes rewards.
  final bool? rewards;

  @override
  List<dynamic> toJson() {
    return [
      slot,
      SolanaRequestUtils.createConfig([
        commitment?.toJson(),
        encoding?.toJson(),
        transactionDetails?.toJson(),
        {'maxSupportedTransactionVersion': maxSupportedTransactionVersion},
        {'rewards': rewards},
      ]),
    ];
  }

  @override
  VersionedBlockResponse onResonse(Map<String, dynamic> result) {
    return VersionedBlockResponse.fromJson(result);
  }
}
