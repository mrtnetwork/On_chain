import 'package:blockchain_utils/utils/utils.dart';
import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';
import 'package:on_chain/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Get the fee the network will charge for a particular Message
/// https://solana.com/docs/rpc/http/getfeeformessage
class SolanaRequestGetFeeForMessage extends SolanaRequest<BigInt?, dynamic> {
  const SolanaRequestGetFeeForMessage(
      {required this.encodedMessage, super.commitment, super.minContextSlot});

  /// getFeeForMessage
  @override
  String get method => SolanaRequestMethods.getFeeForMessage.value;

  /// Base-64 encoded Message
  final String encodedMessage;
  @override
  List<dynamic> toJson() {
    return [
      encodedMessage,
      SolanaRequestUtils.createConfig([
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
