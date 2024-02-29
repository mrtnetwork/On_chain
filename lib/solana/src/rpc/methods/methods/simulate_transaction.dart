import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';
import 'package:on_chain/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Simulate sending a transaction
/// https://solana.com/docs/rpc/http/simulatetransaction
class SolanaRPCSimulateTransaction
    extends SolanaRPCRequest<Map<String, dynamic>> {
  const SolanaRPCSimulateTransaction({
    required this.encodedTransaction,
    this.replaceRecentBlockhash,
    this.accounts,
    this.sigVerify,
    this.innerInstructions,
    Commitment? commitment = Commitment.finalized,
    MinContextSlot? minContextSlot,
    SolanaRPCEncoding? encoding = SolanaRPCEncoding.base58,
  }) : super(
            commitment: commitment,
            encoding: encoding,
            minContextSlot: minContextSlot);

  /// simulateTransaction
  @override
  String get method => SolanaRPCMethods.simulateTransaction.value;

  /// Transaction, as an encoded string.
  /// The transaction must have a valid blockhash, but is not required to be signed.
  final String encodedTransaction;

  /// if true the transaction signatures will be verified (conflicts with replaceRecentBlockhash)
  final bool? sigVerify;

  /// if true the transaction recent blockhash will be replaced with the most recent blockhash. (conflicts with sigVerify)
  final bool? replaceRecentBlockhash;

  /// If true the response will include inner instructions.
  /// These inner instructions will be jsonParsed where possible, otherwise json.
  final bool? innerInstructions;

  /// Accounts configuration object
  final RPCAccountConfig? accounts;

  @override
  List<dynamic> toJson() {
    return [
      encodedTransaction,
      SolanaRPCUtils.createConfig([
        commitment?.toJson(),
        {"sigVerify": sigVerify},
        {"replaceRecentBlockhash": replaceRecentBlockhash},
        minContextSlot?.toJson(),
        encoding?.toJson(),
        {"innerInstructions": innerInstructions},
        accounts?.toJson()
      ])
    ];
  }
}
