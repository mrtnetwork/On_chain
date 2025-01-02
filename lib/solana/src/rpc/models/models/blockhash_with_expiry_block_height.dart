import 'package:on_chain/solana/src/address/sol_address.dart';

class BlockhashWithExpiryBlockHeight {
  final SolAddress blockhash;
  final int lastValidBlockHeight;
  const BlockhashWithExpiryBlockHeight(
      {required this.blockhash, required this.lastValidBlockHeight});
  factory BlockhashWithExpiryBlockHeight.fromJson(Map<String, dynamic> json) {
    return BlockhashWithExpiryBlockHeight(
        blockhash: SolAddress.unchecked(json['blockhash']),
        lastValidBlockHeight: json['lastValidBlockHeight']);
  }
}
