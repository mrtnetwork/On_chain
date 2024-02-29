import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';
import 'package:on_chain/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Returns whether a blockhash is still valid or not.
/// https://solana.com/docs/rpc/http/isblockhashvalid
class SolanaRPCIsBlockhashValid extends SolanaRPCRequest<bool> {
  const SolanaRPCIsBlockhashValid(
      {required this.blockhash,
      Commitment? commitment,
      MinContextSlot? minContextSlot})
      : super(commitment: commitment);

  /// isBlockhashValid
  @override
  String get method => SolanaRPCMethods.isBlockhashValid.value;

  /// the blockhash of the block to evauluate, as base-58 encoded string
  final String blockhash;

  @override
  List<dynamic> toJson() {
    return [
      blockhash,
      SolanaRPCUtils.createConfig(
          [commitment?.toJson(), minContextSlot?.toJson()]),
    ];
  }

  @override
  bool onResonse(result) {
    return result;
  }
}
