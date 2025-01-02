import 'package:on_chain/solana/src/rpc/core/rpc.dart';
import 'package:on_chain/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Subscribe to receive a notification when the transaction with the given
/// signature reaches the specified commitment level.
/// https://solana.com/docs/rpc/websocket/signaturesubscribe
class SolanaRequestSignatureSubscribe extends SolanaRequest<int, int> {
  const SolanaRequestSignatureSubscribe(
      {required this.transactionSignature,
      super.commitment,
      this.enableReceivedNotification});

  /// transaction signature, as base-58 encoded string
  final String transactionSignature;

  /// Whether or not to subscribe for notifications when signatures are received by the RPC,
  /// in addition to when they are processed.
  final bool? enableReceivedNotification;

  /// signatureSubscribe
  @override
  String get method => SolanaSubscribeRpcMethods.signatureSubscribe.value;

  @override
  List<dynamic> toJson() {
    return [
      transactionSignature,
      SolanaRequestUtils.createConfig([
        commitment?.toJson(),
        {'enableReceivedNotification': enableReceivedNotification}
      ])
    ];
  }
}
