import 'package:on_chain/solana/src/rpc/core/rpc.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';
import 'package:on_chain/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Subscribe to receive notification anytime a new block is confirmed or finalized.
/// https://solana.com/docs/rpc/websocket/blocksubscribe
class SolanaRPCBlockSubscribe extends SolanaRPCRequest<int> {
  const SolanaRPCBlockSubscribe(
      {required this.filter,
      this.transactionDetails,
      this.showRewards,
      this.maxSupportedTransactionVersion,
      Commitment? commitment,
      SolanaRPCEncoding? encoding = SolanaRPCEncoding.base64})
      : super(commitment: commitment, encoding: encoding);

  /// blockSubscribe
  @override
  String get method => SolanaSubscribeRpcMethods.blockSubscribe.value;

  /// level of transaction detail to return
  final BlockSubscribeTransactionDetails? transactionDetails;

  /// filter criteria for the logs to receive results by account type
  final SubscribeBlockFilter filter;

  /// the max transaction version to return in responses.
  final bool? maxSupportedTransactionVersion;

  /// whether to populate the rewards array. If parameter not provided, the default includes rewards.
  final bool? showRewards;

  @override
  List<dynamic> toJson() {
    return [
      filter.toJson(),
      SolanaRPCUtils.createConfig([
        commitment?.toJson(),
        encoding?.toJson(),
        transactionDetails?.toJson(),
        {"maxSupportedTransactionVersion": maxSupportedTransactionVersion},
        {"showRewards": showRewards}
      ])
    ];
  }

  @override
  int onResonse(result) {
    return result;
  }
}
