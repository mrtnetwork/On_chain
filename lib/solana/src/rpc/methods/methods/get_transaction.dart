import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';
import 'package:on_chain/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Returns transaction details for a confirmed transaction
/// https://solana.com/docs/rpc/http/gettransaction
class SolanaRPCGetTransaction
    extends SolanaRPCRequest<VersionedTransactionResponse> {
  const SolanaRPCGetTransaction(
      {required this.transactionSignature,
      this.maxSupportedTransactionVersion,
      Commitment? commitment,
      SolanaRPCEncoding? encoding = SolanaRPCEncoding.base64})
      : super(commitment: commitment);

  /// getTransaction
  @override
  String get method => SolanaRPCMethods.getTransaction.value;

  /// Transaction signature, as base-58 encoded string
  final String transactionSignature;

  /// Set the max transaction version to return in responses.
  /// If the requested transaction is a higher version, an error will be returned.
  /// If this parameter is omitted, only legacy transactions will be returned,
  /// and any versioned transaction will prompt the error.
  final int? maxSupportedTransactionVersion;

  @override
  List<dynamic> toJson() {
    return [
      transactionSignature,
      commitment?.toJson(),
      SolanaRPCUtils.createConfig([
        commitment?.toJson(),
        {"maxSupportedTransactionVersion": maxSupportedTransactionVersion},
        encoding?.toJson(),
      ]),
    ];
  }

  @override
  VersionedTransactionResponse onResonse(result) {
    return VersionedTransactionResponse.fromJson(result);
  }
}
