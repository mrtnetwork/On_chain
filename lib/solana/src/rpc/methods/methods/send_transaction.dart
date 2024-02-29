import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';
import 'package:on_chain/solana/src/rpc/utils/solana_rpc_utils.dart';

/// The returned signature is the first signature in the transaction, which is used to identify the transaction (transaction id).
/// This identifier can be easily extracted from the transaction data before submission.
/// https://solana.com/docs/rpc/http/sendtransaction
class SolanaRPCSendTransaction extends SolanaRPCRequest<String> {
  const SolanaRPCSendTransaction({
    required this.encodedTransaction,
    this.maxRetries,
    this.skipPreflight = false,
    Commitment? commitment = Commitment.finalized,
    SolanaRPCEncoding? encoding = SolanaRPCEncoding.base58,
    MinContextSlot? minContextSlot,
  }) : super(
            commitment: commitment,
            encoding: encoding,
            minContextSlot: minContextSlot);

  /// sendtransaction
  @override
  String get method => SolanaRPCMethods.sendTransaction.value;

  /// Fully-signed Transaction, as encoded string.
  final String encodedTransaction;

  /// skip the preflight transaction checks
  final bool skipPreflight;

  /// Maximum number of times for the RPC node to retry sending the transaction to the leader.
  /// If this parameter not provided, the RPC node will retry the transaction until it is
  /// finalized or until the blockhash expires.
  final int? maxRetries;

  @override
  List<dynamic> toJson() {
    return [
      encodedTransaction,
      SolanaRPCUtils.createConfig([
        encoding?.toJson(),
        {"skipPreflight": skipPreflight},
        commitment?.toJson(true),
        {"maxRetries": maxRetries},
        minContextSlot?.toJson()
      ]),
    ];
  }
}
