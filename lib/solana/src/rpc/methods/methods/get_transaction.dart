import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';
import 'package:on_chain/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Returns transaction details for a confirmed transaction
/// https://solana.com/docs/rpc/http/gettransaction
class SolanaRequestGetTransaction
    extends SolanaRequest<VersionedTransactionResponse, Map<String, dynamic>> {
  const SolanaRequestGetTransaction(
      {required this.transactionSignature,
      this.maxSupportedTransactionVersion,
      super.commitment,
      SolanaRequestEncoding? encoding = SolanaRequestEncoding.base64});

  /// getTransaction
  @override
  String get method => SolanaRequestMethods.getTransaction.value;

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
      SolanaRequestUtils.createConfig([
        commitment?.toJson(),
        {'maxSupportedTransactionVersion': maxSupportedTransactionVersion},
        encoding?.toJson(),
      ]),
    ];
  }

  @override
  VersionedTransactionResponse onResonse(Map<String, dynamic> result) {
    return VersionedTransactionResponse.fromJson(result);
  }
}
