import 'package:blockchain_utils/numbers/bigint_utils.dart';
import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';
import 'package:on_chain/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Get the fee the network will charge for a particular Message
/// https://solana.com/docs/rpc/http/getfeeformessage
class SolanaRPCGetFeeForMessage extends SolanaRPCRequest<BigInt?> {
  const SolanaRPCGetFeeForMessage(
      {required this.encodedMessage,
      Commitment? commitment,
      MinContextSlot? minContextSlot})
      : super(commitment: commitment, minContextSlot: minContextSlot);

  /// getFeeForMessage
  @override
  String get method => SolanaRPCMethods.getFeeForMessage.value;

  /// Base-64 encoded Message
  final String encodedMessage;
  @override
  List<dynamic> toJson() {
    return [
      encodedMessage,
      SolanaRPCUtils.createConfig([
        commitment?.toJson(),
        minContextSlot?.toJson(),
      ]),
    ];
  }

  @override
  BigInt? onResonse(result) {
    return BigintUtils.tryParse(result);
  }
}
